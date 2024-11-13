package main

import (
	"github.com/gin-gonic/gin"
)

func setUpRouter(client *app) *app {
	router := gin.Default()
	router.Use(gin.Recovery())
	router.GET("/getenterprise", getEnterprise(client))
	router.POST("/putenterprise", putEnterprise(client))
	router.DELETE("/deleteenterprise", deleteEnterprise(client))
	return &app{
		router: router,
	}

}
