import json
import os
import logging
import sys

from datetime import datetime

__author__ = "Andy B"

logger = logging.getLogger()
logger.setLevel(logging.DEBUG)
logger.addHandler(logging.StreamHandler(stream=sys.stdout))


def handler(event, context) -> str:
    lambda_name = os.getenv("LAMBDA_NAME")
    logger.info(f"This is a test by {lambda_name}.")
    logger.info(f"event: {event}.")

    return json.dumps({
        "body": {
            "date": datetime.now().strftime("%Y-%m-%d"),
            "message": "Hello, World!",
            "name": lambda_name,
        },
        "statusCode": 200,
    })
