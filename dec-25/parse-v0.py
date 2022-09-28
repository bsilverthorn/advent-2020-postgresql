import sys
import csv


def yield_inputs(input_path):
    for (i, line) in enumerate(open(input_path)):
        yield {
            "device": i + 1,
            "public_key": line.strip(),
        }


def main(input_path):
    inputs = list(yield_inputs(input_path))
    writer = csv.DictWriter(sys.stdout, inputs[0].keys())

    writer.writeheader()
    writer.writerows(inputs)

if __name__ == "__main__":
    main(*sys.argv[1:])
