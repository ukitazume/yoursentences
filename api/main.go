package main

import "github.com/gin-gonic/gin"

func main() {
	router := gin.Default()

	router.GET("/status", func(c *gin.Context) {
		c.String(200, "ok")
	})

	router.GET("/test.json", func(c *gin.Context) {
		c.JSON(200, gin.H{
			"id":      2,
			"message": "message 1",
		})
	})
	router.Run(":8080")
}
