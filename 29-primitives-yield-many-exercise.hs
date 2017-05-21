#!/usr/bin/env stack
-- stack script --resolver lts-8.12 --package conduit-combinators

{-# LANGUAGE ExtendedDefaultRules #-}

import Conduit

myYieldMany :: Foldable t => t a -> ConduitM () a IO ()
myYieldMany = foldr f initial
  where
    f a acc = yield a >> acc
    initial = return ()

main :: IO ()
main = runConduit $ myYieldMany [1..3] .| mapM_C print
