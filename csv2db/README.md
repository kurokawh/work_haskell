csv2db
=====

usage:
-----
csv2db [OPTIONS] TARGET_DB [CSV_FILES]
  parse CSV files and store all data into DB.

Common flags:
  -d --dbopt=TARGET_DB_TYPE    specify db type. default db is sqlite.
                               PostgreSQL, MySQL, etc. will be supported in the
                               future.
  -s --schema=SCHEMA_DEF_FILE  specify table name. specify field name & field
                               type for each column. - default filed name: c1,
                               c2, ... - default field type: VARCHAR.
  -? --help                    Display help message
  -V --version                 Print version information

arguments:
-----
* TARGET_DB
	specify file name for sqlite.
* CSV_FILES
	specify one ore more csv files.
	one file must be specified at the minimum.
	

explanation:
-----
TBD


ToDo:
----
* bz2 support
* directory (recursive) support
* schema operation
  - column name
  - convert hex (no 0x) to int
  - enum conversion
* switch csv & tsv (TAB separated)  
