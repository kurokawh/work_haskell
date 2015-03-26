csv2db
=====

usage:
-----
csv2db [OPTIONS] TARGET_DB [CSV_FILES]
  parse csv/bz2 files and store all data into DB.
or
csv2db [OPTIONS] TARGET_DB -r RECURSIVE_DIR
  parse all csv/bz2 files under RECURSIVE_DIR

Common flags:
  -d --dbopt=TARGET_DB_TYPE     specify db type. default db is 'sqlite'.
                                'postgresql', 'mysql' & etc. will be supported
                                in the future.
  -s --schema=SCHEMA_DEF_FILE   specify table name. specify field name &
                                field type for each column. - default filed
                                name: c1, c2, ... - default field type:
                                VARCHAR.
  -r --recursive=RECURSIVE_DIR  specify directory to iterate all files
                                recursively.
  -? --help                     Display help message
  -V --version                  Print version information

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
* directory (recursive) support
* schema operation
  - column name
  - convert hex (no 0x) to int
  - enum conversion
* switch csv & tsv (TAB separated)  


How to Build:
-----
1. install Hskell Platform
2. cabal install cabal-install
3. cabal install --only-dependencies
4. cabal build
* output
  Then csv2db is built in dist directory.
  After modifying repository, just do 4. cabal build.
