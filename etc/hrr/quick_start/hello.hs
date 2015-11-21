import Data.Int (Int32)
import Database.Relational.Query

hello :: Relation () (Int32, String)
hello = relation $ return (value 0 >< value "Hello")

main :: IO ()
main = putStrLn $ show hello ++ ";"
