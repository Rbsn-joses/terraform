import json

def lambda_handler(event, context):
    return {
        'statusCode': 200,
        'body': json.dumps('Olá do AWS Lambda criado com Terraform!')
    }
