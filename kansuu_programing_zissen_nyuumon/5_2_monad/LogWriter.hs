import Control.Monad.Writer

-- record s as log.
logging :: String -> Writer [String] ()
logging s = tell [s]

-- calculate nth fibonatti num with log
fibWithLog :: Int -> Writer [String] Int
fibWithLog n = do
  logging ("fibWithLog" ++ show n)
  case n of
    0 -> return 1
    1 -> return 1
    n -> do
      a <- fibWithLog (n-2)
      b <- fibWithLog (n-1)
      return (a+b)

{-
*Main> runWriter (fibWithLog 0)
(1,["fibWithLog0"])
*Main> runWriter (fibWithLog 1)
(1,["fibWithLog1"])
*Main> runWriter (fibWithLog 2)
(2,["fibWithLog2","fibWithLog0","fibWithLog1"])
*Main> runWriter (fibWithLog 3)
(3,["fibWithLog3","fibWithLog1","fibWithLog2","fibWithLog0","fibWithLog1"])
*Main> runWriter (fibWithLog 4)
(5,["fibWithLog4","fibWithLog2","fibWithLog0","fibWithLog1","fibWithLog3","fibWithLog1","fibWithLog2","fibWithLog0","fibWithLog1"])
-}
