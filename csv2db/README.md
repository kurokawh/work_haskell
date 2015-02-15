csv2db
=====
parse CSV files and store all data into DB.

--------------------------------------
parse CSV file(s) from 2nd args, and store all data into TARGET_DB.

usage:
-----
  csv2db --dbopt XXX --schema SCHEMA_DEF_FILE TARGET_DB CSV_FILE [CSV_FILE ...]

arguments:
-----
* TARGET_DB
	sqlite db file name.
* CSV_FILE
	specify one ore more csv files.
	one file must be specified at the minimum.
	
-schema SCHEMA_DE_FILE:
	specify table name.
	specify field name & field type for each column.
		- default filed name: c1, c2, ...
		- default field type: VARCHAR
-dbopt XXX
	default db is sqlite.
	PostgreSQL, MySQL, etc. will be supported in the future.

explanation:
-----
TBD
