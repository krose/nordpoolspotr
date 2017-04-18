
## Changes to 0.1.0

* The wrapper now returns tzone == "CET" as this is what the API does.
* Test to check if the data.frame is parsed correctly and that there are DST issues that are not fixed.
* A few minor changes to the README.
* The warnings that came when parsing the prices, due to empty extra rows, are suppressed as
  these rows are removed later in the script.

