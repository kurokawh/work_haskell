import qualified Data.Set as Set 
import Data.List -- nub

text1 = "I just had an anime dream. Anime... Reality... Are they so different?"  
text2 = "The old man left his garbage can out and now his trash is all over my lawn!"  

set1 = Set.fromList text1  
-- fromList " .?AIRadefhijlmnorstuy"  
set2 = Set.fromList text2  
-- fromList " !Tabcdefghilmnorstuvwy"  

is1 = Set.intersection set1 set2  
-- fromList " adefhilmnorstuy"  

d1 = Set.difference set1 set2  
-- fromList ".?AIRj"  
d2 = Set.difference set2 set1  
-- fromList "!Tbcgvw"  

u1 = Set.union set1 set2  
-- fromList " !.?AIRTabcdefghijlmnorstuvwy"  


-- null, size, member, empty, singleton, insert and delete 
n1 = Set.null Set.empty  
-- True  
n2 = Set.null $ Set.fromList [3,4,5,5,4,3]  
-- False  
s1 = Set.size $ Set.fromList [3,4,5,3,4,5]  
-- 3  
sgl = Set.singleton 9  
-- fromList [9]  
ist1 = Set.insert 4 $ Set.fromList [9,3,8,1]  
-- fromList [1,3,4,8,9]  
ist2 = Set.insert 8 $ Set.fromList [5..10]  
-- fromList [5,6,7,8,9,10]  
del1 = Set.delete 4 $ Set.fromList [3,4,5,4,3,4,5]  
-- fromList [3,5]  


-- isSubsetOf
iso1 = Set.fromList [2,3,4] `Set.isSubsetOf` Set.fromList [1,2,3,4,5]  
-- True  
iso2 = Set.fromList [1,2,3,4,5] `Set.isSubsetOf` Set.fromList [1,2,3,4,5]  
-- True  
iso3 = Set.fromList [1,2,3,4,5] `Set.isProperSubsetOf` Set.fromList [1,2,3,4,5]  
-- False  
iso4 = Set.fromList [2,3,4,8] `Set.isSubsetOf` Set.fromList [1,2,3,4,5]  
-- False  


-- map & filter
f1 = Set.filter odd $ Set.fromList [3,4,5,6,7,2,3,4]  
-- fromList [3,5,7]  
m1 = Set.map (+1) $ Set.fromList [3,4,5,6,7,2,3,4]  
-- fromList [3,4,5,6,7,8]  


-- toList
setNub xs = Set.toList $ Set.fromList xs  
nu1 = setNub "HEY WHATS CRACKALACKIN"  
-- " ACEHIKLNRSTWY"  
nu2 = nub "HEY WHATS CRACKALACKIN"  
-- "HEY WATSCRKLIN"  
