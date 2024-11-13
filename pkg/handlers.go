package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"net/http"

	"github.com/gin-gonic/gin"
)

func putEnterprise(client *app) gin.HandlerFunc {
	return func(c *gin.Context) {
		var newEnterprise Enterprise
		body, err := ioutil.ReadAll(c.Request.Body)
		if err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": "Failed to read body"})
			return
		}
		if err := json.Unmarshal(body, &newEnterprise); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": "Failed to parse JSON"})
			return
		}
		err = putEnterpriseToDynamoDB(newEnterprise, client)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to create enterprise"})
			return
		}
		c.JSON(http.StatusAccepted, gin.H{"message": "Enterprise created successfully", "data": newEnterprise})
	}
}

func getEnterprise(client *app) gin.HandlerFunc {
	return func(c *gin.Context) {
		var Id string
		Id = c.Query("enterpriseID")
		fmt.Println(Id)

		Enterprise, err := readItem(Id, client)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to get enterprise"})
			return
		}
		c.JSON(http.StatusAccepted, gin.H{"message": "Enterprise Fetched successfully", "data": Enterprise})

	}
}

func deleteEnterprise(client *app) gin.HandlerFunc {
	return func(c *gin.Context) {
		var Id string
		Id = c.Query("enterpriseID")
		err := deleteIten(Id, client)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to get delete Enterprise"})
			return
		}
		c.JSON(http.StatusAccepted, gin.H{"message": "Enterprise Deleted successfully"})

	}
}
