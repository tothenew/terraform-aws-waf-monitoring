import os
import json
import logging
from elasticsearch import Elasticsearch
import datetime
import uuid

logger = logging.getLogger()
logger.setLevel(logging.INFO)


def lambda_handler(event, context):
    sqs_url = os.environ["SQS_URL"]
    elastic_host = os.environ["ELASTIC_HOST"]
    prefix_index_name = "waf-log-service-"
    date = datetime.datetime.now().date()
    if 'Records' in event:
        for record in event['Records']:
            body = json.loads(record["body"])
            logger.info(json.dumps(body))

            user_client_ip = ""
            x_forwarded_for = ""
            x_forwarded_for_first = ""

            logger.info(body["action"])
            logger.info(body["httpRequest"]["uri"])
            logger.info(body["httpRequest"]["clientIp"])
            for obj in body["httpRequest"]["headers"]:
                if "User-Client-Ip" == obj["name"]:
                    user_client_ip = obj["value"]
                elif "X-Forwarded-For" == obj["name"]:
                    x_forwarded_for_first = obj["value"].split(",")[0]
                    x_forwarded_for = obj["value"]
            logger.info(user_client_ip)
            logger.info(x_forwarded_for)

            es = Elasticsearch([{'host': elastic_host, 'port': "9200"}])
            logger.info(prefix_index_name + str(date) + ' created')
            esdata = {
                "timestamp": datetime.datetime.now(),
                "user_client_ip": user_client_ip,
                "x_forwarded_for_first": x_forwarded_for_first,
                "x_forwarded_for": x_forwarded_for,
                "request_action": body["action"],
                "request_uri": body["httpRequest"]["uri"],
                "client_ip": body["httpRequest"]["clientIp"]
            }
            es.index(index=prefix_index_name + str(date), id=uuid.uuid4(), body=esdata)
