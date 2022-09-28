import re
import sys
import csv

def yield_inputs(input_path):
    for (y, line) in enumerate(open(input_path)):
        for (x, char) in enumerate(line.strip()):
            if char == "#":
                yield {"x": x, "y": y}


def main(input_path):
    inputs = list(yield_inputs(input_path))
    writer = csv.DictWriter(sys.stdout, inputs[0].keys())

    writer.writeheader()
    writer.writerows(inputs)

if __name__ == "__main__":
    main(*sys.argv[1:])
