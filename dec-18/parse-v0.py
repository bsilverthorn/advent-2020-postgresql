import re
import sys
import csv

def yield_inputs(input_path):
    for line in open(input_path):
        yield {
            "formula": line.strip()
                #[::-1]
                # .translate(str.maketrans("()", ")("))
                .replace("(", "( ")
                .replace(")", " )")
        }


def main(input_path):
    inputs = list(yield_inputs(input_path))
    writer = csv.DictWriter(sys.stdout, inputs[0].keys())

    writer.writeheader()
    writer.writerows(inputs)

if __name__ == "__main__":
    main(*sys.argv[1:])
