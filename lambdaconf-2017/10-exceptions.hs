#!/usr/bin/env stack
{-
  stack script --resolver lts-8.12
    --package conduit-combinators
    --
    -Wall -fwarn-tabs -fno-warn-type-defaults
-}
import Conduit

source :: ConduitM i Int IO ()
source = do
  liftIO $ putStrLn "acquire a resource"
  mapM_ (\x -> yieldOr x (finally x)) [1 .. 100]
  where
    finally x = putStrLn $ "cleaning up after: " ++ show x

main :: IO ()
main = runConduit $ source .| takeC 2 .| (printC >> undefined)
