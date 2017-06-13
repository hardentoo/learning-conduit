#!/usr/bin/env stack
-- stack script --resolver lts-8.12 --package conduit-combinators

{-# LANGUAGE ExtendedDefaultRules #-}

import Conduit

main :: IO ()
main = runConduit 
   $ yieldMany (map (replicate 2) [1..5])
  .| concatC
  .| mapM_C print
