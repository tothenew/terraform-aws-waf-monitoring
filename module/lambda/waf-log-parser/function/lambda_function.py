import boto3
import os
from urllib.parse import unquote
import gzip


def lambda_handler(event, context):
    s3_client = boto3.client('s3')
    sqs_client = boto3.client('sqs')
    s3 = boto3.resource('s3')
    sqs_url = os.environ["SQS_URL"]
    for record in event['Records']:
        bucket = record['s3']['bucket']['name']
        key = unquote(record['s3']['object']['key'])
        print("Bucket: " + str(bucket))
        print("Key: " + str(key))
        object = key.split('/')[4]
        print("File: " + str(object))
        object_l = s3.Object(str(bucket), str(key))
        print(object_l.content_length)
        # downloading file to a tmp folder
        directory_to_extract_to = "/tmp/"
        path_to_gzip_file = directory_to_extract_to + object

        s3_client.download_file(bucket, key, path_to_gzip_file)
        print("File Downloaded: " + str(path_to_gzip_file))
        with gzip.open(path_to_gzip_file, "rt") as fp:
            line = fp.readline().strip()
            while line:
                print(line)
                sqs_client.send_message(QueueUrl=sqs_url,
                                        MessageBody=line)
                line = fp.readline().strip()
                print("Successfully pushed into SQS")
        os.remove(path_to_gzip_file)
