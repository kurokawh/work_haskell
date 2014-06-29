{-
usage: random_pick LIST_FILE_1 [LIST_FILE_2 ...]
       read items from each LIST_FILE line by line and select and show 1 item randomly.
arguments:
        list_file       item defined text. describe 1 item on each line.
                        if line begins with "--", then that line is ignored (commented out).
-}

import System.Random
import System.Environment   
import Control.Monad(when)


readItems :: String -> IO [String]
readItems fileName = do  
    contents <- readFile fileName  
    let items = lines contents  
        validItems = zipWith (\n line -> show n ++ " - " ++ line) [0..] items  
    return validItems


{-
pickUpElement :: StdGen -> [String] -> String
pickUpElement gen array = do  
    let (randNumber, newGen) = randomR (0, (length array) - 1) gen :: (Int, StdGen)  
    putStr "selected num "  
    putStr randNumber
    putStr "element: "
    putStr array !! randNumber
    return array !! randNumber
-}

main = do
    args <- getArgs  
    mapM printItemFromFile args

printItemFromFile :: String -> IO ()
printItemFromFile fileName = do
    items <- readItems fileName
--    gen <- getStdGen  
    gen <- newStdGen  
    putStr "item: "
    putStr (retItemFromArray gen items)
    putStr "\n"

retItemFromArray :: StdGen -> [String] -> String
retItemFromArray gen items = do  
    let (randNumber, newGen) = randomR (0, (length items) - 1) gen :: (Int, StdGen)  
    item <- items !! randNumber
    return item


