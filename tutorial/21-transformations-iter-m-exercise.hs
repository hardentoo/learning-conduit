#!/usr/bin/env stack
-- stack script --resolver lts-8.12 --package conduit-combinators

{-# LANGUAGE ExtendedDefaultRules #-}

import Conduit

myIterMC :: Monad m => (a -> m ()) -> ConduitM a a m ()
myIterMC f = mapMC (\a -> f a >> return a)

main :: IO ()
main = do
  result <- runConduit $ yieldMany [1..10] .| myIterMC print .| sumC
  print result
