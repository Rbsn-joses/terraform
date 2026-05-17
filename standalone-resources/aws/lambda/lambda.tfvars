
lambdas = {
    teste-1 = {
        function_name        = "minha-funcao-lambda"
        runtime              = "python3.8"
        handler              = "lambda_function.lambda_handler"
        role_name            = "lambda-role"
        iam_service_principal = "lambda.amazonaws.com"
        archive_type         = "zip"
        source_path          = "teste-lambda-function.py"
        output_path          = "lambda_function.zip"
    }
    teste-2 = {
        function_name        = "minha-funcao-lambda-2"
        runtime              = "python3.8"
        handler              = "teste-lambda-function-2.lambda_handler"
        role_name            = "lambda-role-2"
        iam_service_principal = "lambda.amazonaws.com"
        archive_type         = "zip"
        source_path          = "teste-lambda-function-2.py"
        output_path          = "lambda_function_2.zip"
    }
}


ambiente = "dev"