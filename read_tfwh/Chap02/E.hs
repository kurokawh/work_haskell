

head' ys
    | null ys   = Nothing
    | otherwise = Just (head ys)

first p = head' . filter p

{--
  where
    head' ys
    | null ys   = Nothing
    | otherwise = Just (head ys)
--}
