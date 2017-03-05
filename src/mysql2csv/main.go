package mysql2csv

import (
	"flag"
)

func M2c_main() {
	versionFlag := flag.Bool("v", false, "Print version")
	helpFlag := flag.Bool("h", false, "Print help")

	flag.Parse()

	if *versionFlag {
		Version()
	}
	if *helpFlag {
		Usage()
	}
	
}

	
