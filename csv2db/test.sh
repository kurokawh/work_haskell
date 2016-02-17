#!/bin/bash

# clean up
rm x.db

# OK with -r
dist/build/csv2db/csv2db x.db -r test test2
rm x.db

# OK without -r
dist/build/csv2db/csv2db x.db test/input.txt test2/input2.txt test2/test3/input3.txt
rm x.db


# NG with -r
#dist/build/csv2db/csv2db x.db -r test/input.txt test2/input2.txt test2/test3/input3.txt
# NG without -r
dist/build/csv2db/csv2db x.db test test2
