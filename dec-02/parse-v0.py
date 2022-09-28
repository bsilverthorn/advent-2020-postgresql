import re
import sys
import csv

LINE_PATTERN = re.compile(
    "(?P<lmin>\d+)-(?P<lmax>\d+)"
    " (?P<letter>[a-z]):"
    " (?P<passtext>[a-z]+)"
)


def yield_inputs(input_path):
    for line in open(input_path):
        yield LINE_PATTERN.match(line).groupdict()


def main(input_path):
    inputs = list(yield_inputs(input_path))
    writer = csv.DictWriter(sys.stdout, inputs[0].keys())

    writer.writeheader()
    writer.writerows(inputs)

if __name__ == "__main__":
    main(*sys.argv[1:])
