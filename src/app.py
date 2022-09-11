import os
import logging
import sys

__author__ = "Andy B"

logging.basicConfig(stream=sys.stdout, level=logging.DEBUG)


def handler(event, context) -> None:
    name = os.getenv("LAMBDA_NAME")
    logging.info("This is a test by {name}.")
