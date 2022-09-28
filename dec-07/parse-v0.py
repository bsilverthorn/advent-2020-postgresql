import re
import sys
import csv


def yield_inputs(input_path):
    lines = open(input_path).read().splitlines()

    for line in lines:
        (container, contained_raw) = line.split(" bags contain ")

        if contained_raw == "no other bags.":
            continue

        for bag_raw in contained_raw.strip(".").split(", "):
            parts = bag_raw.split()

            yield {
                "outer": container,
                "qty": int(parts[0]),
                "inner": " ".join(parts[1:-1])
            }


def main(input_path):
    inputs = list(yield_inputs(input_path))
    writer = csv.DictWriter(sys.stdout, inputs[0].keys())

    writer.writeheader()
    writer.writerows(inputs)

if __name__ == "__main__":
    main(*sys.argv[1:])
