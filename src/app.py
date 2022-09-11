import os
import logging
import sys

__author__ = "Andy B"

logger = logging.getLogger()
logger.setLevel(logging.DEBUG)
logger.addHandler(logging.StreamHandler(stream=sys.stdout))


def handler(event, context) -> None:
    name = os.getenv("LAMBDA_NAME")
    logger.info(f"This is a test by {name}.")


if __name__ == "__main__":
    handler(None, None)
