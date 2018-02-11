#!/usr/bin/env runghc

import System.Environment

main = do
        buff <- getEnv "LANG"
        putStrLn buff

-- http://capm-network.com/?tag=Haskell-%E7%92%B0%E5%A2%83%E5%A4%89%E6%95%B0%E3%81%AE%E5%80%A4%E3%82%92%E5%8F%96%E5%BE%97%E3%81%99%E3%82%8B
