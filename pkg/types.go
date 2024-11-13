package main

import (
	"github.com/aws/aws-sdk-go-v2/service/dynamodb"
	"github.com/gin-gonic/gin"
)

type app struct {
	dynamoClient *dynamodb.Client
	router       *gin.Engine
}

type Enterprise struct {
	Id     string
	Name   string
	Status bool
}
