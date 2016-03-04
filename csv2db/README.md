csv2db
=====

Usage:
-----
csv2db [OPTIONS] TARGET_DB CSV_FILE ...
  parse csv/bz2 files and store all data into DB.
or
csv2db [OPTIONS] TARGET_DB -r TARGET_DIR/CSV_FILE ...
  parse all csv/bz2 files under listed TARGET_DIRs

Common flags:
  -d --dbopt=TARGET_DB_TYPE  specify DB type. default DB is 'sqlite'.
                             'postgresql', 'mysql' & etc. may be supported in
                             the future.
  -s --schema=SCHEMA_INDEX   specify table name. specify predefined schema
                             index such as 'd12', 'd13', etc. default is
                             'normal' which stores all values as string.
  -r --recursive             iterate specified directories recursively.
  -? --help                  Display help message
  -V --version               Print version information


Arguments:
-----
* TARGET_DB
	specify file name for sqlite. this is the mandatory argument.
* CSV_FILE
	specify one ore more csv files.
	bt2 archived files can be specified (extracted automatically).
	one file must be specified at the minimum.
* TARGET_DIR
        specify one ore more directories or csv files.
	one file or directory must be specified at the minimum.


ToDo:
----
* switch csv & tsv (TAB separated)  
  - currenty tsv is default and csv is cannot be specified by option
* schema operation
  - dynamic schema definition.
* add option to check/exclude extention name
* verbose output mode
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
