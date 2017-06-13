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

pipeN :: (Show a, MonadIO m) => Int -> ConduitM a a m ()
pipeN 0 = pure ()
pipeN n = do
  mx <- await
  case mx of
    Nothing -> liftIO $ putStrLn "done!"
    (Just x) -> do
      liftIO . putStrLn $ "received " ++ show x
      yield x -- pass downstream
      pipeN (n - 1)

main :: IO ()
main = runConduit $ source .| pipeN 3 .| printC
