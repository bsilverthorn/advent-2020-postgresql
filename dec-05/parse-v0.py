import re
import sys
import csv


def yield_inputs(input_path):
    for seat in open(input_path).read().split():
        yield {"seat": seat}


def main(input_path):
    writer = csv.DictWriter(
        sys.stdout,
        ["seat"]
    )

    writer.writeheader()
    writer.writerows(yield_inputs(input_path))

if __name__ == "__main__":
    main(*sys.argv[1:])
