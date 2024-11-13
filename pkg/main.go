package main

import (
	"fmt"

	"github.com/aws/aws-lambda-go/lambda"
	ginadapter "github.com/awslabs/aws-lambda-go-api-proxy/gin"
)

func main() {
	app := getAwsConfig()
	app = setUpRouter(app)
	ginLambda := ginadapter.New(app.router)
	lambda.Start(ginLambda.Proxy)
	//app.router.Run("localhost:8080")

	fmt.Println(app)
}
