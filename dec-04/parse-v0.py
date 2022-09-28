import re
import sys
import csv


def yield_inputs(input_path):
    for passport in open(input_path).read().split("\n\n"):
        yield dict(f.split(":") for f in passport.split())


def main(input_path):
    writer = csv.DictWriter(
        sys.stdout,
        ["ecl", "pid", "eyr", "hcl", "byr", "iyr", "cid", "hgt"]
    )

    writer.writeheader()
    writer.writerows(yield_inputs(input_path))

if __name__ == "__main__":
    main(*sys.argv[1:])
