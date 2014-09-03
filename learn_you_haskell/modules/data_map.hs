import qualified Data.Map as Map  

phoneBook =   
    [("betty","555-2938")  
    ,("bonnie","452-2928")  
    ,("patsy","493-2928")  
    ,("lucille","205-2928")  
    ,("wendy","939-8282")  
    ,("penny","853-2492")  
    ]  

findKey_ :: (Eq k) => k -> [(k,v)] -> v  
findKey_ key xs = snd . head . filter (\(k,v) -> key == k) $ xs  

findKey :: (Eq k) => k -> [(k,v)] -> Maybe v  
findKey key [] = Nothing  
findKey key ((k,v):xs) = if key == k  
                          then Just v  
                          else findKey key xs  

findKey_fold :: (Eq k) => k -> [(k,v)] -> Maybe v  
findKey_fold key = foldr (\(k,v) acc -> if key == k then Just v else acc) Nothing  

f1 = findKey "penny" phoneBook  
-- Just "853-2492"  
f2 = findKey "betty" phoneBook  
-- Just "555-2938"  
f3 =  findKey "wilma" phoneBook  
-- Nothing  



-- The fromList function takes an association list (in the form of a list) 
-- and returns a map with the same associations.
-- Map.fromList :: (Ord k) => [(k, v)] -> Map.Map k v  
fl1 = Map.fromList [("betty","555-2938"),("bonnie","452-2928"),("lucille","205-2928")]  
-- fromList [("betty","555-2938"),("bonnie","452-2928"),("lucille","205-2928")]  
fl2 = Map.fromList [(1,2),(3,4),(3,2),(5,5)]  
-- fromList [(1,2),(3,2),(5,5)]  


-- empty represents an empty map. It takes no arguments, it just returns an empty map.
em = Map.empty  
-- fromList []  

-- insert takes a key, a value and a map and returns a new map that's 
-- just like the old one, only with the key and value inserted.
ist1 = Map.empty  
-- fromList []  
ist2 = Map.insert 3 100 Map.empty  
-- fromList [(3,100)]  
ist3 = Map.insert 5 600 (Map.insert 4 200 ( Map.insert 3 100  Map.empty))  
-- fromList [(3,100),(4,200),(5,600)]  
ist4 = Map.insert 5 600 . Map.insert 4 200 . Map.insert 3 100 $ Map.empty  
-- fromList [(3,100),(4,200),(5,600)]  

-- We can implement our own fromList by using the empty map, insert and a fold.
fromList' :: (Ord k) => [(k,v)] -> Map.Map k v  
fromList' = foldr (\(k,v) acc -> Map.insert k v acc) Map.empty  
