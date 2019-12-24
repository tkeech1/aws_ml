# aws_ml

This repo creates an repeatable ML workflow on AWS. 

**The following environment variables need to be set locally:**
```
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
AWS_REGION
```

**1) Create an S3 backend for the Terraform configuration.**

```
make create-backend
```

To remove this bucket run:

```
make destroy-backend
```

**2) Run the workflow:**
  1) Create an S3 bucket to store data
  2) Create a Kinesis Firehose stream to load data to S3
  3) Create a Glue table to read data from S3
  4) Create a Kinesis Analytics application to query the S3 data and push the results to a results S3 bucket
  5) Produce data to the data S3 bucket

```
make apply start-kinesis-analytics produce-to-firehose start-glue-crawler
```


