{-
LTMT Part 3: The Monad Cookbook
http://softwaresimply.blogspot.jp/2014/12/ltmt-part-3-monad-cookbook.html
-}

main = do
    lineList <- lines $ readFile "myfile.txt"
    -- ... do something with lineList here
    putStrLn (head lineList)

{-
* solution: 1
    contents <- readFile "myfile.txt"
    let lineList = lines contents
-}

{-
* solution: 2
    lineList <- liftM lines (readFile "myfile.txt")
 -}
