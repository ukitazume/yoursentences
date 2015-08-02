package main

import "os"

import "github.com/gin-gonic/gin"

func main() {
	router := gin.Default()

	router.GET("/status", func(c *gin.Context) {
		c.String(200, "ok")
	})

	router.GET("/test", func(c *gin.Context) {
		c.Writer.Header().Set("Access-Control-Allow-Origin", "*")
		c.JSON(200, gin.H{
			"id":      2,
			"message": "message 1",
		})
	})

	router.Run(":" + getPort())
}

func getPort() string {
	listenPort := "8080"
	envPort := os.Getenv("PORT")
	if envPort != "" {
		listenPort = envPort
	}
	return listenPort
}
