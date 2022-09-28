import sys
import csv


def yield_inputs(input_path):
    decks_raw = open(input_path).read().split("\n\n")

    for deck_raw in decks_raw:
        (player, cards_raw) = deck_raw.split(":")

        yield {
            "player": player,
            "cards": "{" + ",".join(cards_raw.split()) + "}"
        }


def main(input_path):
    inputs = list(yield_inputs(input_path))
    writer = csv.DictWriter(sys.stdout, inputs[0].keys())

    writer.writeheader()
    writer.writerows(inputs)

if __name__ == "__main__":
    main(*sys.argv[1:])
