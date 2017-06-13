#!/usr/bin/env stack
{-
  stack script --resolver lts-8.12
    --package conduit-combinators
    --
    -Wall -fwarn-tabs -fno-warn-type-defaults
-}
{-# language Rank2Types #-}

import Conduit
import Data.Void

-- type Producer (m :: * -> *) o = forall i. ConduitM i o m ()

loudYield :: Int -> ConduitM i Int IO ()
loudYield x = do
  liftIO $ putStrLn $ "yielding: " ++ show x
  yield x

-- The above is just like having a "Producer". Producer is just a type alias.
loudYield' :: Int -> Producer IO Int
loudYield' = loudYield

loudYield'' :: Int -> Source IO Int
loudYield'' = loudYield

loudSinkNull :: ConduitM Int Void IO ()
loudSinkNull = mapM_C $ \x ->
  putStrLn $ "awaited: " ++ show x

loudSinkNull' :: Sink Int IO ()
loudSinkNull' = loudSinkNull

main :: IO ()
main = runConduit $
  do { loudYield 1; loudYield' 2; loudYield'' 3 } .|
  loudSinkNull
