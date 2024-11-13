package main

import (
	"context"
	"log"
	"sync"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/service/dynamodb"
)

var awsConfigOnce sync.Once
var awsConfig aws.Config
var DynamoClient *dynamodb.Client

func getAwsConfig() *app {
	awsConfigOnce.Do(func() {
		var err error
		awsConfig, err = config.LoadDefaultConfig(context.TODO())

		if err != nil {
			log.Println("Error Occured While AWS Configuration", err)
			panic(err)
		}
		DynamoClient = dynamodb.NewFromConfig(awsConfig)

	})
	return &app{
		dynamoClient: DynamoClient,
	}

}
