import sys
import csv


def main(input_path):
    input_text = open(input_path).read().strip()
    inputs = [
        {"turn": t + 1, "number": n}
        for (t, n) in enumerate(input_text.split(","))
    ]
    writer = csv.DictWriter(sys.stdout, inputs[0].keys())

    writer.writeheader()
    writer.writerows(inputs)

if __name__ == "__main__":
    main(*sys.argv[1:])
