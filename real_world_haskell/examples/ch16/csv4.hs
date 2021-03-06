import Text.ParserCombinators.Parsec

csvFile = endBy line eol
line = sepBy cell (char ',')
cell = many (noneOf ",\n\r")

{-- snippet eol --}
-- This function is not correct!
eol = string "\n\r" <|> string "\n"
{-- /snippet eol --}

parseCSV :: String -> Either ParseError [[String]]
parseCSV input = parse csvFile "(unknown)" input
