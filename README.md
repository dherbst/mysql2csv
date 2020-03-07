[![Go Report Card](https://goreportcard.com/badge/github.com/dherbst/mysql2csv)](https://goreportcard.com/report/github.com/dherbst/mysql2csv)

# mysql2csv
This project helps convert the mysql text result format to csv.  This is necessary if you need to run queries on mysql on Amazon RDS, which does not allow the `SELECT ... INTO ... OUTFILE` syntax because there isn't access to (disc) storage on the server.   Instead you can either copy and paste, or use the `tee` command to save the query output to your local machine and run this command to convert the mysql text output format to csv.

## Usage

    cat queryresult.txt | mysql2csv > result.csv

## Design

The grammar for a mysql result looks roughly like this

    LINE       ::= <LEFT-PIPE><TEXT><RIGHT-PIPE>
    TEXT       ::= <TEXT><MID-PIPE><TEXT>|<CHARS>
    CHARS      ::= [utf-8 character set]
    LEFT-PIPE  ::= "| "
    RIGHT-PIPE ::= " |"
    MID-PIPE   ::= " | "
