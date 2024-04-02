import io
import json
import os
import typing
import sys
import zlib


def generate_ged(gej):
    with io.BytesIO() as ged:

        def write_int(i):
            ged.write(i.to_bytes(4, "little", signed=True))

        def write_string(s):
            write_int(len(s))
            ged.write(s.encode("utf-8"))

        ged.write(b"\xbc\02\0\0\0\0\0\0")
        write_string(gej["name"])
        write_string(gej["folder"])
        write_string(gej["version"])
        write_string(gej["author"])
        write_string(gej["date"])
        write_string(gej["license"])
        write_string(gej["description"])
        write_string(gej["helpfile"])
        write_int(gej["hidden"])
        write_int(len(gej["dependencies"]))
        for d in gej["dependencies"]:
            write_string(d)
        write_int(len(gej["files"]))
        for fi in gej["files"]:
            write_int(700)
            write_string(fi["filename"])
            write_string(fi["origname"])
            write_int(fi["kind"])
            write_string(fi["init"])
            write_string(fi["final"])
            write_int(len(fi["functions"]))
            for fu in fi["functions"]:
                write_int(700)
                write_string(fu["name"])
                write_string(fu["extname"])
                write_int(fu["calltype"])
                write_string(fu["helpline"])
                write_int(fu["hidden"])
                write_int(len(fu["argtypes"]) if fu["argtypes"] is not None else -1)
                for i in range(17):
                    write_int(
                        fu["argtypes"][i]
                        if fu["argtypes"] and i < len(fu["argtypes"])
                        else 0
                    )
                write_int(fu["returntype"])
            write_int(len(fi["constants"]))
            for c in fi["constants"]:
                write_int(700)
                write_string(c["name"])
                write_string(c["value"])
                write_int(c["hidden"])
        return bytearray(ged.getvalue())


def read_int(f):
    return int.from_bytes(f.read(4), byteorder="little")


def skip_int(f):
    f.seek(4, 1)


def read_string(f):
    return f.read(read_int(f))


def skip_string(f):
    f.seek(read_int(f), 1)


def read_ext_file(f):
    skip_int(f)
    skip_string(f)
    origname = read_string(f)
    kind = read_int(f)
    skip_string(f)
    skip_string(f)
    for _ in range(read_int(f)):
        skip_function(f)
    for _ in range(read_int(f)):
        skip_constant(f)
    return (origname, kind)


def skip_function(f):
    skip_int(f)
    skip_string(f)
    skip_string(f)
    skip_int(f)
    skip_string(f)
    skip_int(f)
    skip_int(f)
    for _ in range(17):
        skip_int(f)
    skip_int(f)


def skip_constant(f):
    skip_int(f)
    skip_string(f)
    skip_string(f)
    skip_int(f)


def copy_file(f, path):
    with open(path, "rb") as g:
        dat = zlib.compress(g.read())
    f.write(len(dat).to_bytes(4, "little"))
    f.write(dat)


def parse_ged(ged: typing.BinaryIO):
    # collect extension name, help file, and name/kind of every file
    skip_int(ged)
    skip_int(ged)
    name = read_string(ged).decode()
    for _ in range(6):
        skip_string(ged)
    help_file = read_string(ged).decode()
    ged.seek(4, 1)
    for _ in range(read_int(ged)):
        skip_string(ged)
    files = [read_ext_file(ged) for _ in range(read_int(ged))]
    return (name, help_file, files)


def generate_swap_table(seed):
    a = 6 + (seed % 250)
    b = seed // 250
    table = (list(range(0, 256)), list(range(0, 256)))
    for i in range(1, 10001):
        j = 1 + ((i * a + b) % 254)
        table[0][j], table[0][j + 1] = table[0][j + 1], table[0][j]
    for i in range(1, 256):
        table[1][table[0][i]] = i
    return table


def build_gex(ged_path: str) -> bytes:
    old_dir = os.getcwd()
    if os.path.dirname(ged_path) != "":
        os.chdir(os.path.dirname(ged_path))
        ged_path = os.path.basename(ged_path)
    # load ged
    if ged_path.endswith(".ged"):
        with open(ged_path, "rb") as f:
            ged = bytearray(f.read())
        with io.BytesIO(ged) as f:
            _, help_file, files = parse_ged(f)
    else:
        with open(ged_path) as f:
            gej = json.load(f)
        ged = generate_ged(gej)
        help_file = gej["helpfile"]
        files = [(fi["origname"], fi["kind"]) for fi in gej["files"]]
    # this dword marks it as either a project or an installed extension (either .gex or appdata)
    ged[4] = 0
    # encryption init
    seed = 0
    table = generate_swap_table(seed)
    with io.BytesIO() as out:
        # write out all files
        out.write(b"\x91\xd5\x12\x00\xbd\x02\x00\x00")
        out.write(seed.to_bytes(4, "little"))
        out.write(ged)
        if help_file != "":
            copy_file(out, help_file)
        for f in files:
            copy_file(out, f[0])
        # encrypt
        with out.getbuffer() as view:
            for i in range(13, len(view)):
                view[i] = table[0][view[i]]
        # cleanup
        os.chdir(old_dir)
        return out.getvalue()


def install_gex(install_path: str, gex: bytes):
    seed = int.from_bytes(gex[8:12], "little")
    table = generate_swap_table(seed)
    with io.BytesIO(bytes([gex[12]]) + bytes(table[1][b] for b in gex[13:])) as ged:
        # mark as installed extension
        with ged.getbuffer() as view:
            view[4] = 0
        name, help_file, files = parse_ged(ged)
        ged_len = ged.tell()
        ged.seek(0)
        with open(os.path.join(install_path, name + ".ged"), "wb") as f:
            f.write(ged.read(ged_len))
        if help_file:
            help_len = int.from_bytes(ged.read(4), byteorder="little")
            with open(os.path.join(install_path, help_file), "wb") as f:
                f.write(zlib.decompress(ged.read(help_len)))
        with io.BytesIO() as dat:
            dat.write(seed.to_bytes(4, "little"))
            for _, file_kind in files:
                file_len = int.from_bytes(ged.read(4), byteorder="little")
                if file_kind == 3:
                    ged.seek(file_len, 1)
                else:
                    dat.write(file_len.to_bytes(4, byteorder="little"))
                    dat.write(ged.read(file_len))
            with dat.getbuffer() as view:
                for i in range(5, len(view)):
                    view[i] = table[0][view[i]]
            with open(os.path.join(install_path, name + ".dat"), "wb") as f:
                f.write(dat.getvalue())


def main():
    gex = build_gex(sys.argv[1])
    with open(sys.argv[1][:-1] + "x", "wb") as f:
        f.write(gex)
    if "--noinstall" not in sys.argv:
        extensions_path = os.path.join(
            os.path.expandvars("%LOCALAPPDATA%"), "GameMaker8.2", "extensions"
        )
        install_gex(extensions_path, gex)


if __name__ == "__main__":
    main()
