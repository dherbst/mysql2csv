package mysql2csv

import (
	"fmt"
)

var (
	gitsha string
	version string
)

func Usage() {
	fmt.Println("\nUsage: cat file.mysql | mysql2csv\n")
}

func Version() {
	fmt.Printf("mysql2csv version %v %v\n", version, gitsha)
}

