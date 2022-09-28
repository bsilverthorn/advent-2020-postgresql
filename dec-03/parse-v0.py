import re
import sys
import csv


def yield_inputs(input_path):
    for (y, row) in enumerate(open(input_path)):
        for (x, letter) in enumerate(row.strip()):
            yield (x, y, letter)


def main(input_path):
    csv_writer = csv.writer(sys.stdout)

    csv_writer.writerow(["x", "y", "c"])
    csv_writer.writerows(yield_inputs(input_path))

if __name__ == "__main__":
    main(*sys.argv[1:])
