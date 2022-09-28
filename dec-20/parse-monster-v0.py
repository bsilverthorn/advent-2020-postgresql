import re
import sys
import csv


def yield_inputs(input_path):
    input_lines = map(str.rstrip, open(input_path))

    for (i, line) in enumerate(input_lines):
        for (j, char) in enumerate(line):
            if char == '#':
                yield {
                    "rd": i,
                    "cd": j,
                }


def main(input_path):
    inputs = list(yield_inputs(input_path))
    writer = csv.DictWriter(sys.stdout, inputs[0].keys())

    writer.writeheader()
    writer.writerows(inputs)

if __name__ == "__main__":
    main(*sys.argv[1:])
