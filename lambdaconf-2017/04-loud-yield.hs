#!/usr/bin/env stack
{-
  stack script --resolver lts-8.12
    --package conduit-combinators
    --
    -Wall -fwarn-tabs -fno-warn-type-defaults
-}
{-# LANGUAGE ExistentialQuantification #-}

import Conduit

loudYield :: forall i. Int -> ConduitM i Int IO ()
loudYield x = do
  liftIO $ putStrLn $ "yielding: " ++ show x
  yield x

loudSinkNull :: forall o. ConduitM Int o IO ()
loudSinkNull = mapM_C $ \x -> putStrLn $ "awaited: " ++ show x

main :: IO ()
main = runConduit $ mapM_ loudYield [1 .. 3] .| loudSinkNull
