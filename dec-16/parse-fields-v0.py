import re
import sys
import csv

FIELD_PATTERN = re.compile(
    r"(?P<name>[\w ]+):"
    r" (?P<llb>\d+)-(?P<lub>\d+)"
    r" or (?P<rlb>\d+)-(?P<rub>\d+)"
)


def yield_inputs(input_path):
    for line in open(input_path):
        if line.strip() == "":
            break

        groups = FIELD_PATTERN.match(line).groupdict()

        for lr in "lr":
            yield {
                "name": groups["name"],
                "lower": groups[lr + "lb"],
                "upper": groups[lr + "ub"]
            }


def main(input_path):
    inputs = list(yield_inputs(input_path))
    writer = csv.DictWriter(sys.stdout, inputs[0].keys())

    writer.writeheader()
    writer.writerows(inputs)

if __name__ == "__main__":
    main(*sys.argv[1:])
