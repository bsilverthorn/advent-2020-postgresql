import re
import sys
import csv


def yield_inputs(input_path):
    lines = open(input_path).read().splitlines()

    for (i, line) in enumerate(lines):
        yield {"joltage": int(line)}


def main(input_path):
    inputs = list(yield_inputs(input_path))
    writer = csv.DictWriter(sys.stdout, inputs[0].keys())

    writer.writeheader()
    writer.writerows(inputs)

if __name__ == "__main__":
    main(*sys.argv[1:])
