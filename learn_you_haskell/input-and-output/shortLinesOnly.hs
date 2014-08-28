-- run: shortLinesOnly < shortLinesOnly.hs

-- test
-- short
-- line
-- this line is not shown because length is more than 10.

main = do  
    contents <- getContents  
    putStr (shortLinesOnly contents)  
  
shortLinesOnly :: String -> String  
shortLinesOnly input =   
    let allLines = lines input  
        shortLines = filter (\line -> length line < 10) allLines  
        result = unlines shortLines  
    in  result  
