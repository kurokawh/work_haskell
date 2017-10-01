import Data.Char

capitalize :: String -> String
capitalize = unwords . map cap . words
  where cap xxs = [toUpper (head xxs)] ++ tail xxs
