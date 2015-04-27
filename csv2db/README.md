csv2db
=====

usage:
-----
The csv2db program

csv2db [OPTIONS] TARGET_DB CSV_FILES...
  parse csv/bz2 files and store all data into DB.
or
csv2db [OPTIONS] TARGET_DB -r RECURSIVE_DIR
  parse all csv/bz2 files under RECURSIVE_DIR.

Common flags:
  -d --dbopt=TARGET_DB_TYPE     specify DB type. default DB is 'sqlite'.
                                'postgresql', 'mysql' & etc. may be supported
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
* optimization
  - It seems that lazy evaluation does not work as intended.
    I expect that parsing is skipped if filename already exists in DB.
* switch csv & tsv (TAB separated)  
  - currenty tsv is default and csv is cannot be specified by option
* verbose output
  - verbose option does not change behavior now. recompilation is needed...


How to Build:
-----
1. install Hskell Platform
2. cabal install cabal-install
3. cabal install --only-dependencies
4. cabal build
   * output
       csv2db is built under dist directory.
       After modifying source files repository, just do 4. to build csv2db.
