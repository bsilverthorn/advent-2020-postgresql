import re
import sys
import csv

FOOD_PATTERN = re.compile(
    r"(?P<ingredients>(\w+ +)+)\(contains (?P<allergens>(\w+[, ]*)+)\)"
)


def yield_inputs(input_path):
    for line in open(input_path):
        food = FOOD_PATTERN.match(line).groupdict()

        yield {
            "ingredients": "{" + ",".join(food["ingredients"].split()) + "}",
            "allergens": "{" + food["allergens"] + "}",
        }


def main(input_path):
    inputs = list(yield_inputs(input_path))
    writer = csv.DictWriter(sys.stdout, inputs[0].keys())

    writer.writeheader()
    writer.writerows(inputs)

if __name__ == "__main__":
    main(*sys.argv[1:])
