package mysql2csv

import (
	"flag"
)

// M2Cmain is the main entrypoint for the utility.
func M2Cmain() {
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
