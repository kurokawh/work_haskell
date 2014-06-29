random_pick
=====
random_pick uses following functions.
- randomR, newStdGen
- readFile, lines
- getArgs
- mapM, zipWith

usage: random_pick LIST_FILE_1 [LIST_FILE_2 ...]
  read items from each LIST_FILE line by line and select and show 1 item randomly.
  arguments:
  * list_file
  item defined text. describe 1 item on each line.
  if line begins with "--", then that line is ignored (commented out).
