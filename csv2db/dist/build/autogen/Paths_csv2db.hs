module Paths_csv2db (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch


version :: Version
version = Version {versionBranch = [0,1,0,0], versionTags = []}
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/kurokawa/Library/Haskell/ghc-7.6.3/lib/csv2db-0.1.0.0/bin"
libdir     = "/Users/kurokawa/Library/Haskell/ghc-7.6.3/lib/csv2db-0.1.0.0/lib"
datadir    = "/Users/kurokawa/Library/Haskell/ghc-7.6.3/lib/csv2db-0.1.0.0/share"
libexecdir = "/Users/kurokawa/Library/Haskell/ghc-7.6.3/lib/csv2db-0.1.0.0/libexec"
sysconfdir = "/Users/kurokawa/Library/Haskell/ghc-7.6.3/lib/csv2db-0.1.0.0/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "csv2db_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "csv2db_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "csv2db_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "csv2db_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "csv2db_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
