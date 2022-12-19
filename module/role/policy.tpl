{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "SQS",
            "Effect": "Allow",
            "Action": [
                "sqs:SendMessage",
                "sqs:ReceiveMessage",
                "sqs:DeleteMessage",
                "sqs:GetQueueAttributes"
            ],
            "Resource": [
                "arn:aws:sqs:${region_name}:${account_id}:${sqs_name}"
            ]
        },
        {
            "Sid": "S3Data",
           "Effect": "Allow",
           "Action": [
               "s3:GetObject"
           ],
           "Resource": [
              "arn:aws:s3:::${bucket_name}/AWSLogs/${account_id}/WAFLogs/${region_name}/${web_acl_name}/*"
           ]
         }
    ]
}