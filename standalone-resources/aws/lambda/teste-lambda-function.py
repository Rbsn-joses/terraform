import json

def lambda_handler(event, context):
    return {
        'statusCode': 200,
        'body': json.dumps('criando lambda terraform  com função 1!')
    }
