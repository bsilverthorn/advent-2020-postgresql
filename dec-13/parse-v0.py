import re
import sys
import csv


def yield_inputs(input_path):
    lines = open(input_path).read().splitlines()
    (arrival, buses) = lines

    for (i, bus) in enumerate(buses.split(",")):
        yield {
            "i": i,
            "arrival": int(arrival),
            "bus": None if bus == "x" else int(bus)
        }


def main(input_path):
    inputs = list(yield_inputs(input_path))
    writer = csv.DictWriter(sys.stdout, inputs[0].keys())

    writer.writeheader()
    writer.writerows(inputs)

if __name__ == "__main__":
    main(*sys.argv[1:])
