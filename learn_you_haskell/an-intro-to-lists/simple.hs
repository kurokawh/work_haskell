import System.Environment   
import Data.List  
  
main = do  
     putStrLn ("hello" ++ " world!")
     putStrLn ('A' : " SMALL CAT.")

     let array = [1, 2, 3, 4]  
     putStrLn (show array)
     putStrLn (show (array !! 1))
