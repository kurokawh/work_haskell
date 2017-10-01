data List a = Nil | Snoc (List a) a deriving Show

-- [1,2,3] -> Snoc (Snoc (Snoc Nil 1) 2) 3)
toList :: [a] -> List a
toList xs = _toList (reverse xs)
_toList [] = Nil
_toList (x:xs) = Snoc (_toList xs) x

fromList :: List a -> [a]
fromList xs = reverse $ _fromList xs
_fromList Nil = []
_fromList (Snoc (xs) x) = x : _fromList xs


listHead :: List a -> a
listHead (Snoc Nil a) = a
listHead (Snoc a b) = listHead a


listLast :: List a -> a
listLast (Snoc a b) = b
