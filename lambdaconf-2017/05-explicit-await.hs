#!/usr/bin/env stack
{-
  stack script --resolver lts-8.12
    --package conduit-combinators
    --
    -Wall -fwarn-tabs -fno-warn-type-defaults
-}
import Conduit
import Data.Void

loudYield :: Int -> ConduitM i Int IO ()
loudYield x = do
  liftIO $ putStrLn $ "yielding: " ++ show x
  yield x

loudSinkNull :: ConduitM Int Void IO ()
loudSinkNull = loop
  where
    loop = do
      liftIO $ putStrLn "calling await"
      mx <- await
      case mx of
        Nothing -> liftIO $ putStrLn "all done!"
        Just x -> do
          liftIO $ putStrLn $ "received: " ++ show x
          loop

main :: IO ()
main = runConduit $
  mapM_ loudYield [1..3] .|
  loudSinkNull
