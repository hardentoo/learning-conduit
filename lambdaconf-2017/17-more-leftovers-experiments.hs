#!/usr/bin/env stack
{-
  stack --resolver lts-8.12 script
    --package conduit-combinators
    --package unordered-containers
    --
    -Wall -fwarn-tabs -fno-warn-type-defaults
-}
import Conduit

awaitly :: ConduitM Int o IO ()
awaitly = do
  optItem <- await
  case optItem of
    Nothing -> liftIO $ putStrLn "done"
    Just item -> do
      liftIO $ putStrLn $ "leftover " ++ show item
      leftover item

putStringC :: Show a => [Char] -> ConduitM a o IO ()
putStringC msg = mapM_C $ \item -> putStrLn $ msg ++ " " ++ show item

main :: IO ()
main =
  runConduit $
  yieldMany [1 .. 10 :: Int]
  .| do
    mapC id .| awaitly
    putStringC "First"
  .| do
    leftover "One"
    leftover "Two"
    leftover "Three"
    putStringC "Second"
