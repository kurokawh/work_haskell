import System.Environment

str_list = ["Zero", "First", "Second", "Third"]
str_list2 = ["Zero", "One", "Two", "Three"]

decstr_to_int decstr = read decstr :: Int

index_to_str :: Int -> [String] -> String
index_to_str index list = list !! index

sindex_to_str :: String -> [String] -> String
sindex_to_str index list = list !! (decstr_to_int index)

main = do
  (arg:_) <- getArgs
  putStrLn  ("arg: " ++ arg)
  putStrLn  ("out1: " ++ (sindex_to_str arg str_list))
  putStrLn  ("out2: " ++ (sindex_to_str arg str_list2))
