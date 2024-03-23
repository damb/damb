#! /usr/bin/env python3

import json
import subprocess
import sys

from pathlib import Path

_COMPILE_COMMANDS_JSON = "compile_commands.json"


def main():
    """
    Creates a top-level `compile_commands.json` file and resolves symlinks.
    """

    try:
        path_build_space = Path(
            subprocess.check_output(["catkin", "locate", "-b"])
            .decode()
            .strip()
        )
    except subprocess.CalledProcessError:
        sys.exit(2)

    rv = []
    for p in path_build_space.glob(f"**/{_COMPILE_COMMANDS_JSON}"):
        with open(p) as ifs:
            for obj in json.load(ifs):
                cmd = []
                for token in obj["command"].split(" "):
                    if token.startswith("-I"):
                        cmd.append(f"-I{Path(token[2:]).resolve()}")
                    else:
                        cmd.append(token)

                obj["command"] = " ".join(cmd)
                obj["file"] = str(Path(obj["file"]).resolve())

                rv.append(obj)

    with open(path_build_space.parent / _COMPILE_COMMANDS_JSON, "w") as ofs:
        json.dump(rv, ofs, indent=2)


if __name__ == "__main__":
    main()
