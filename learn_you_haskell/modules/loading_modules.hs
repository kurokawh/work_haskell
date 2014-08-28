import Data.List   -- load all functions in Data.List
-- import Data.List (nub, sort)   -- load only nub & sort from Data.List
-- import Data.List hiding (nub)  -- load all except nub

  
numUniques :: (Eq a) => [a] -> Int  
numUniques = length . nub  
-- nub  remove duplication of element.


-- ghci> :m + Data.List  
-- ghci> :m + Data.List Data.Map Data.Set 

