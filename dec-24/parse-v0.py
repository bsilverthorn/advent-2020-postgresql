import sys
import csv


def yield_inputs(input_path):
    neighbors = ["se", "sw", "ne", "nw", "e", "w"]

    for line in map(str.strip, open(input_path)):
        munged = line

        for neighbor in neighbors:
            munged = munged.replace(neighbor, neighbor + " ")

        directions = munged.strip().split()

        yield {"directions": "{" + ",".join(directions) + "}"}


def main(input_path):
    inputs = list(yield_inputs(input_path))
    writer = csv.DictWriter(sys.stdout, inputs[0].keys())

    writer.writeheader()
    writer.writerows(inputs)

if __name__ == "__main__":
    main(*sys.argv[1:])
