module Main where

import qualified Data.Map as Map
import Data.Map (Map)
import Data.Time.Clock
import Data.Time.Format
import qualified Data.ByteString.Char8 as BS -- for strict readFile :(
import Control.Monad
import System.Environment
import System.Directory
import System.Locale (defaultTimeLocale)
import System.FilePath

data Activity = Activity 
  { running :: Bool
  , start   :: UTCTime
  , stored  :: [(UTCTime, UTCTime)]
  } deriving (Show, Read)

type Activities = Map String Activity

readActivities :: IO (Map String Activity)
readActivities = do
  home <- getUserDocumentsDirectory
  let path = home </> "activities.txt"
  e <- doesFileExist path
  if e
     then do  
       p <- getPermissions path
       when (not (readable p && writable p)) (do
         error ("unable to open " ++ path ++ "for reading and writing"))
       read `fmap` BS.unpack `fmap` BS.readFile path
     else return Map.empty

writeActivities :: Map String Activity -> IO ()
writeActivities m = do
  d <- getUserDocumentsDirectory
  writeFile (d </> "activities.txt") (show m)

startActivity :: UTCTime -> Activities -> String -> IO Activities
startActivity now as n = do
  putStrLn ("starting: " ++ n)
  return $
    if n `Map.member` as
      then 
        if running (as Map.! n)
          then Map.adjust (\a@(Activity _ _ ss) -> Activity True now ((start a, now):ss)) n as
          else Map.adjust (\(Activity _ _ ss) -> Activity True now ss) n as
      else Map.insert n (Activity True now []) as
      
stopActivity :: UTCTime -> Activities -> String -> IO Activities
stopActivity now as n =
  if n `Map.member` as && running (as Map.! n) 
    then do 
      putStrLn ("stopping: " ++ n)
      return $ Map.adjust (\a@(Activity _ t ss) -> Activity False t ((start a, now):ss)) n as
    else return as

deleteActivity :: Activities -> String -> IO Activities
deleteActivity as n = do
  putStrLn ("deleting: " ++ n)
  return $ Map.delete n as

showActivity :: UTCTime -> Activities -> String -> IO Activities
showActivity now as n = do
  case Map.lookup n as of
    Nothing -> putStrLn ("unknown activity: " ++ n)
    Just x  -> do
      when (running x) (do
        putStrLn ("\n*** ongoing since " ++
                  formatTime defaultTimeLocale "%x %T" (start x) ++ " (" ++ show (round (diffUTCTime now (start x))) ++ "s ago)\n"))
      let tab1 = "|---+-------------------+-------------------+------------|"
      putStrLn tab1
      putStrLn   "| n | start             | end               | diff (sec) |"
      putStrLn tab1
      forM_ (zip [1..] (stored x)) $ \(i,(s,e)) -> do
        let duration = show (round (diffUTCTime e s))
            formatS  = formatTime defaultTimeLocale "%x %T" s
            formatE  = formatTime defaultTimeLocale "%x %T" e
        putStrLn ("| " ++ show i ++ " | " ++ formatS ++ " | " ++ formatE ++ " | " ++ duration ++ replicate (11 - length duration) ' ' ++ "|")
      putStrLn tab1
  return as

main :: IO ()
main = do
  args <- getArgs
  when (length args /= 2)
    (error "wrong number of arguments")
  
  let (cmd:n:[]) = args
  now <- getCurrentTime
  as  <- readActivities

  new <- case cmd of
    "start"  -> startActivity  now as n
    "stop"   -> stopActivity   now as n
    "delete" -> deleteActivity     as n
    "show"   -> showActivity   now as n
    _        -> error "failed to parse arguments"

  writeActivities new
