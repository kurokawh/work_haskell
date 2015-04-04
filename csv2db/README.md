csv2db
=====

usage:
-----
csv2db [OPTIONS] TARGET_DB CSV_FILES...
  parse csv/bz2 files and store all data into DB.
or
csv2db [OPTIONS] TARGET_DB -r RECURSIVE_DIR
  parse all csv/bz2 files under RECURSIVE_DIR

Common flags:
  -d --dbopt=TARGET_DB_TYPE     specify db type. default db is 'sqlite'.
                                'postgresql', 'mysql' & etc. will be supported
                                in the future.
  -s --schema=SCHEMA_INDEX      specify table name. specify predefined schema
                                index such as 'd12', 'd13', etc. default is
                                'normal' which stores all values as string.
  -r --recursive=RECURSIVE_DIR  specify directory to iterate all files in it
                                recursively.
  -? --help                     Display help message
  -V --version                  Print version information

arguments:
-----
* TARGET_DB
	specify file name for sqlite. this is the mandatory argument.
* CSV_FILES
	specify one ore more csv files.
	one file must be specified at the minimum.
	

explanation:
-----
TBD


ToDo:
----
* schema operation
  - column name
  - convert hex (no 0x) to int
  - enum conversion
* avoid dupulicated insertion (by checking filename)
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
