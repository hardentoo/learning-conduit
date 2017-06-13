#!/usr/bin/env stack
{-
  stack script --resolver lts-8.12
    --package conduit-combinators
    --
    -Wall -fwarn-tabs -fno-warn-type-defaults
-}
import Conduit
import Data.Void

source :: ConduitM () () IO ()
source = do
  liftIO $ putStrLn "Source 1"
  yield ()
  liftIO $ putStrLn "Source 2"

sink :: ConduitM () Data.Void.Void IO ()
sink = do
  liftIO $ putStrLn "Sink 1"
  _ <- await
  liftIO $ putStrLn "Sink 2"

main :: IO ()
main = runConduit $ source .| sink
