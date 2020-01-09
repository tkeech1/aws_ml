
# create an IAM role for glue
resource "aws_iam_role" "sagemaker_role" {
  name               = "sagemaker_role-${var.environment}"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "sagemaker.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# SageMaker IAM policy
resource "aws_iam_policy" "sagemaker_policy" {
  name        = "sagemaker_policy-${var.environment}"
  path        = "/"
  description = "IAM policy for SageMaker"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
    {
        "Effect": "Allow",
        "Action": [
            "cloudwatch:PutMetricData"
        ],
        "Resource": [
            "*"
        ]
    },
    {
        "Effect": "Allow",
        "Action": [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents"
        ],
        "Resource": [
            "arn:aws:logs:*:*:/sagemaker/*"
        ]
    },
    {
        "Sid": "",
        "Effect": "Allow",
        "Action": [
            "s3:ListBucket",
            "s3:GetObject"
        ],
        "Resource": [
          "arn:aws:s3:::${local.data_bucket_name}",
          "arn:aws:s3:::${local.data_bucket_name}/*"
        ]
    },
    {
        "Sid": "",
        "Effect": "Allow",
        "Action": [
            "s3:ListBucket",
            "s3:PutObject"
        ],
        "Resource": [
          "arn:aws:s3:::${local.model_bucket_name}",
          "arn:aws:s3:::${local.model_bucket_name}/*"
        ]
    }
  ]
}
EOF
}

# attaches the policy to the role
resource "aws_iam_role_policy_attachment" "sagemaker_policy_attachment" {
  role       = "${aws_iam_role.sagemaker_role.name}"
  policy_arn = "${aws_iam_policy.sagemaker_policy.arn}"
}