import boto3
import logging
from botocore.exceptions import ClientError


def main():
    """Exercise Kinesis Firehose methods"""

    # Assign these values before running the program
    # If the specified IAM role does not exist, it will be created
    firehose_name = 'AWSMLFirehose-dev'

    # Set up logging
    logging.basicConfig(level=logging.DEBUG,
                        format='%(levelname)s: %(asctime)s: %(message)s')

    # Put records into the Firehose stream
    test_data_file = 'data/test_data.json'
    firehose_client = boto3.client('firehose')
    with open(test_data_file, 'r') as f:
        logging.info('Putting 20 records into the Firehose one at a time')
        for i in range(20):
            # Read a record of test data
            line = next(f)

            # Put the record into the Firehose stream
            try:
                firehose_client.put_record(DeliveryStreamName=firehose_name,
                                           Record={'Data': line})
            except ClientError as e:
                logging.error(e)
                exit(1)

        # Put 200 records in a batch
        logging.info('Putting 200 records into the Firehose in a batch')
        batch = [{'Data': next(f)} for x in range(200)]  # Read 200 records

        # Put the batch into the Firehose stream
        try:
            result = firehose_client.put_record_batch(DeliveryStreamName=firehose_name,
                                                      Records=batch)
        except ClientError as e:
            logging.error(e)
            exit(1)

        # Did any records in the batch not get processed?
        num_failures = result['FailedPutCount']
        '''
        # Test: Simulate a failed record
        num_failures = 1
        failed_rec_index = 3
        result['RequestResponses'][failed_rec_index]['ErrorCode'] = 404
        '''
        if num_failures:
            # Resend failed records
            logging.info(f'Resending {num_failures} failed records')
            rec_index = 0
            for record in result['RequestResponses']:
                if 'ErrorCode' in record:
                    # Resend the record
                    firehose_client.put_record(DeliveryStreamName=firehose_name,
                                               Record=batch[rec_index])

                    # Stop if all failed records have been resent
                    num_failures -= 1
                    if not num_failures:
                        break
                rec_index += 1
    logging.info('Test data sent to Firehose stream')


if __name__ == '__main__':
    main()
