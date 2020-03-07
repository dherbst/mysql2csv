package mysql2csv

import (
	"fmt"
)

var (
	// Gitsha is the git sha this binary was built with.
	gitsha string
	// Version is release version of this command.
	version string
)

// Usage explains how to call this utility.
func Usage() {
	fmt.Println("\nUsage: cat file.mysql | mysql2csv")
}

// Version prints the version for this utility, including the sha the code was built from.
func VersionCommand() {
	fmt.Printf("mysql2csv version %v %v\n", version, gitsha)
}
