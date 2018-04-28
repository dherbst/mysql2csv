package mysql2csv

import (
	"fmt"
)

var (
	gitsha  string
	version string
)

// Usage explains how to call this utility.
func Usage() {
	fmt.Println("\nUsage: cat file.mysql | mysql2csv")
}

// Version prints the version for this utility, including the sha the code was built from.
func Version() {
	fmt.Printf("mysql2csv version %v %v\n", version, gitsha)
}
