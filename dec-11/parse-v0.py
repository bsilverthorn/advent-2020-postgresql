import re
import sys
import csv


def yield_inputs(input_path):
    lines = open(input_path).read().splitlines()

    for (y, line) in enumerate(lines):
        for (x, spot) in enumerate(line):
            yield {"x": x, "y": y, "spot": spot, "n": 0}


def main(input_path):
    inputs = list(yield_inputs(input_path))
    writer = csv.DictWriter(sys.stdout, inputs[0].keys())

    writer.writeheader()
    writer.writerows(inputs)

if __name__ == "__main__":
    main(*sys.argv[1:])
