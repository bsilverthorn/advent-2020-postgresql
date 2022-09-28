import re
import sys
import csv

RULE_PATTERN = re.compile("(?P<number>\d+): (?P<symbols>.+)")


def yield_inputs(input_path):
    for line in map(str.strip, open(input_path)):
        groups = RULE_PATTERN.match(line).groupdict()

        yield {
            "number": groups["number"],
            "symbols": "".join(
                f" {s} " for s in groups["symbols"].replace('"', "").split()
            )
        }


def main(input_path):
    inputs = list(yield_inputs(input_path))
    writer = csv.DictWriter(sys.stdout, inputs[0].keys())

    writer.writeheader()
    writer.writerows(inputs)

if __name__ == "__main__":
    main(*sys.argv[1:])
