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
source = liftIO $ putStrLn "Entered the source"

sink :: ConduitM () Data.Void.Void IO ()
sink = liftIO $ putStrLn "Entered the sink"

main :: IO ()
main = runConduit $ source .| sink
