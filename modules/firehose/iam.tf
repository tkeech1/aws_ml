resource "aws_iam_role" "role" {
  name               = "${local.firehose_full_name}-Role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "firehose.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "policy" {
  name        = "${local.firehose_full_name}-Policy"
  path        = "/"
  description = "IAM policy"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [    
    {
        "Sid": "",
        "Effect": "Allow",
        "Action": [
          "s3:ListBucket"
        ],
        "Resource": [
          "${var.destination_bucket}"          
        ]
    },
    {
        "Sid": "",
        "Effect": "Allow",
        "Action": [
          "s3:*Object" 
        ],
        "Resource": [
          "${var.destination_bucket}/*"
        ]
    }
  ]
}
EOF
}

/*,
    { 
      "Action": [
        "cloudwatch:*"
      ],
      "Effect": "Allow",
      "Resource": "*"      
    }
    */

# attaches the policy to the role
resource "aws_iam_role_policy_attachment" "policy_attachment" {
  role       = "${aws_iam_role.role.name}"
  policy_arn = "${aws_iam_policy.policy.arn}"
}
