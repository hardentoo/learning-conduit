#!/usr/bin/env stack
-- stack script --resolver lts-8.12 --package conduit-combinators

{-# LANGUAGE ExtendedDefaultRules #-}

import Conduit

sink :: Monad m => ConduitM Int o m (String, Int)
sink = (,) <$> (takeC 5 .| mapC show .| foldC) <*> sumC

main :: IO ()
main = do
  print $ runConduitPure $ yieldMany [1..10] .| sink
