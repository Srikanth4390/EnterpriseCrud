package main

import (
	"context"
	"fmt"
	"log"

	"github.com/aws/aws-sdk-go-v2/feature/dynamodb/attributevalue"
	"github.com/aws/aws-sdk-go-v2/service/dynamodb"
	"github.com/aws/aws-sdk-go-v2/service/dynamodb/types"
	"github.com/aws/aws-sdk-go/aws"
)

func putEnterpriseToDynamoDB(enterprise Enterprise, app *app) error {
	item := map[string]types.AttributeValue{
		"ID":     &types.AttributeValueMemberS{Value: enterprise.Id},
		"Name":   &types.AttributeValueMemberS{Value: enterprise.Name},
		"Status": &types.AttributeValueMemberBOOL{Value: enterprise.Status},
	}
	input := &dynamodb.PutItemInput{
		TableName: aws.String("Enterprises"),
		Item:      item,
	}
	_, err := app.dynamoClient.PutItem(context.TODO(), input)
	if err != nil {
		log.Printf("Failed to put item in DynamoDB: %v", err)
		return err
	}

	return nil
}

func readItem(id string, app *app) (Enterprise, error) {
	var getEnterprise Enterprise
	key := map[string]types.AttributeValue{
		"ID": &types.AttributeValueMemberS{Value: id},
	}
	input := &dynamodb.GetItemInput{
		TableName: aws.String("Enterprises"),
		Key:       key,
	}
	resp, err := app.dynamoClient.GetItem(context.TODO(), input)
	if err != nil {
		log.Printf("Failed to get item, %v", err)
		return getEnterprise, err
	}
	if resp.Item == nil {
		fmt.Println("Item not found")
		return getEnterprise, err
	}
	err = attributevalue.UnmarshalMap(resp.Item, &getEnterprise)
	if err != nil {
		log.Fatalf("failed to unmarshal DynamoDB item: %v", err)
	}
	return getEnterprise, err
}

func deleteIten(id string, app *app) error {
	tableName := "Enterprises"
	key := map[string]types.AttributeValue{
		"ID": &types.AttributeValueMemberS{Value: id},
	}
	input := &dynamodb.DeleteItemInput{
		TableName: &tableName,
		Key:       key,
	}
	_, err := app.dynamoClient.DeleteItem(context.TODO(), input)
	if err != nil {
		log.Fatalf("unable to delete item, %v", err)
		return err
	}
	return err
}
