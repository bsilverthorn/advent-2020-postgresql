import re
import sys
import csv


def yield_inputs(input_path):
    raw_groups = open(input_path).read().split("\n\n")

    for (i, raw_group) in enumerate(raw_groups):
        for (j, answered) in enumerate(raw_group.split()):
            for q in answered:
                yield {"group": i, "person": j, "answered": q}


def main(input_path):
    inputs = list(yield_inputs(input_path))
    writer = csv.DictWriter(sys.stdout, inputs[0].keys())

    writer.writeheader()
    writer.writerows(inputs)

if __name__ == "__main__":
    main(*sys.argv[1:])
