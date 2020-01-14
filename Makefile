# AWS
AWS_ACCESS_KEY_ID?=AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY?=AWS_SECRET_ACCESS_KEY
AWS_REGION?=AWS_REGION
ENVIRONMENT?=dev
#ENVIRONMENT?=ENVIRONMENT

test-env:
	echo "environment is ${ENVIRONMENT}"

create-backend:
	cd s3_state && terraform init; terraform fmt; terraform apply -auto-approve;

destroy-backend:
	cd s3_state && terraform init; terraform destroy -auto-approve

plan:
	terraform init; terraform validate; terraform plan -var="environment=${ENVIRONMENT}"

apply:
	terraform init; terraform fmt; terraform apply -auto-approve -var="environment=${ENVIRONMENT}"

destroy:
	terraform init; terraform destroy -auto-approve -var="environment=${ENVIRONMENT}"

start-kinesis-analytics:
	~/.local/bin/aws kinesisanalytics start-application --application-name ticker_app-dev --input-configurations Id=1.1,InputStartingPositionConfiguration={InputStartingPosition=LAST_STOPPED_POINT}

produce-to-firehose:
	sleep 120
	python code/test.py

start-glue-crawler:
	~/.local/bin/aws glue start-crawler --name ticker_crawler-dev

start:
	/home/tk/.local/bin/jupyter-lab --ip=0.0.0.0 &
	/home/tk/.local/bin/voila &
