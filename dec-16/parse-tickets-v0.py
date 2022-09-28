import re
import sys
import csv


def yield_inputs(input_path):
    whose = None

    for (i, line) in enumerate(map(str.strip, open(input_path))):
        if line == "":
            whose = None
        elif whose is not None:
            for (j, value) in enumerate(line.split(",")):
                yield {
                    "whose": whose,
                    "ticket": i,
                    "position": j,
                    "value": value
                }
        elif line in {"your ticket:", "nearby tickets:"}:
            (whose, _) = line.split()


def main(input_path):
    inputs = list(yield_inputs(input_path))
    writer = csv.DictWriter(sys.stdout, inputs[0].keys())

    writer.writeheader()
    writer.writerows(inputs)

if __name__ == "__main__":
    main(*sys.argv[1:])
