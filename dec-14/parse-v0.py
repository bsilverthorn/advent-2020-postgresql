import re
import sys
import csv

from enum import Enum


class CommandType(Enum):
    MASK = re.compile(r"mask = (?P<value>[01X]{36})")
    MEM = re.compile(r"mem\[(?P<addr>\d+)\] = (?P<value>\d+)")

    @classmethod
    def match(cls, string):
        for cmd_type in cls:
            result = cmd_type.value.match(string)

            if result is not None:
                return (cmd_type, result.groupdict())

        raise ValueError("no pattern matches input", string)


def yield_inputs(input_path):
    lines = open(input_path).read().splitlines()
    cmds = map(CommandType.match, lines)

    for (cmd_type, cmd_args) in cmds:
        yield {
            "cmd_type": cmd_type.name,
            "value": cmd_args["value"],
            "addr": cmd_args.get("addr"),
        }


def main(input_path):
    inputs = list(yield_inputs(input_path))
    writer = csv.DictWriter(sys.stdout, inputs[0].keys())

    writer.writeheader()
    writer.writerows(inputs)

if __name__ == "__main__":
    main(*sys.argv[1:])
