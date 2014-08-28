import System.Random  

{- 
  output 20 characters randomly.
-}
  
main = do  
    gen <- getStdGen  
    putStr $ take 20 (randomRs ('a','z') gen)  
    putStr "\n"
