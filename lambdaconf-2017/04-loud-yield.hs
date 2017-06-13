#!/usr/bin/env stack
{-
  stack script --resolver lts-8.12
    --package conduit-combinators
    --
    -Wall -fwarn-tabs -fno-warn-type-defaults
-}

import Conduit

loudYield :: Int -> ConduitM i Int IO ()
loudYield x = do
  liftIO $ putStrLn $ "yielding: " ++ show x
  yield x

loudSinkNull :: ConduitM Int o IO ()
loudSinkNull = mapM_C $ \x -> putStrLn $ "awaited: " ++ show x

main :: IO ()
main = runConduit $
  do { loudYield 1; loudYield 2; loudYield 3 } .|
  loudSinkNull
