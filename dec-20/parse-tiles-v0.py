import re
import sys
import csv

HEADER_PATTERN = re.compile("Tile (?P<id>\d+):")


def yield_inputs(input_path):
    input_lines = map(str.strip, open(input_path))

    for line in input_lines:
        header = HEADER_PATTERN.match(line).groupdict()
        rows = []

        for line in input_lines:
            if line == "":
                break

            rows.append(line)

        yield {
            "id": header["id"],
            "top": rows[0],
            "bottom": rows[-1],
            "left": "".join(r[0] for r in rows),
            "right": "".join(r[-1] for r in rows),
            "block": "{" + ",".join("{" + ",".join(r) + "}" for r in rows) + "}",
        }


def main(input_path):
    inputs = list(yield_inputs(input_path))
    writer = csv.DictWriter(sys.stdout, inputs[0].keys())

    writer.writeheader()
    writer.writerows(inputs)

if __name__ == "__main__":
    main(*sys.argv[1:])
