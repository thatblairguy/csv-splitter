# csv-splitter

Quick and dirty script to split a comma-separated value file into multiple smaller files. The very first line is assumed to
contain column headers and is copied as the first row of each output file.

**NOTE:** This script assumes that each record is represented by *exactly* one
line in the in the .CSV file. There is no handling for line-breaks.

To execute, run

	powershell .\csv-splitter.ps1 -fileName <INPUT>.csv 

where:

 `<INPUT>` is the file being split.

To adjust the number of lines in the output files, edit the $maxLines variable on line 6.


Based on answers to https://stackoverflow.com/q/1001776
