{-# LANGUAGE DeriveDataTypeable #-}
import System.Console.CmdArgs

data Sample = Sample {
      hello :: String
} deriving (Show, Data, Typeable)

sample = Sample {
           hello = def &= help "World argument" &= opt "world"}
         &= summary "This is a sample of CmdArgs."

main = print =<< cmdArgs sample
