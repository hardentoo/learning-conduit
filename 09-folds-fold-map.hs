#!/usr/bin/env stack
-- stack script --resolver lts-8.12 --package conduit-combinators

{-# LANGUAGE ExtendedDefaultRules #-}

import Conduit
import Data.Monoid (Sum (..))

main :: IO ()
main = print . getSum . runConduitPure $
  yieldMany [1..100 :: Int] .| foldMapC Sum
