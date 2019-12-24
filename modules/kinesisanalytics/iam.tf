resource "aws_iam_role" "kinesisanalytics" {
  name               = "${local.kinesis_analytics_application_name}-Role"
  path               = "/"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "kinesisanalytics.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "firehose" {
  name = "${local.kinesis_analytics_application_name}-Role"
  path = "/"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "",
            "Effect": "Allow",
            "Action": [
                "firehose:Get*",
                "firehose:List*",
                "firehose:Describe*"
            ],
            "Resource": ["${var.kinesis_firehose_arn}"]
        },
        {
            "Sid": "",
            "Effect": "Allow",
            "Action": [
                "firehose:Get*",
                "firehose:List*",
                "firehose:Describe*",
                "firehose:Put*"
            ],
            "Resource": ["${var.output_stream_arn}"]
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "kinesis_analytics_kinesis_stream" {
  role       = "${aws_iam_role.kinesisanalytics.name}"
  policy_arn = "${aws_iam_policy.firehose.arn}"
}

