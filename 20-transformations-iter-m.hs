#!/usr/bin/env stack
-- stack script --resolver lts-8.12 --package conduit-combinators

{-# LANGUAGE ExtendedDefaultRules #-}

import Conduit

main :: IO ()
main = do
  result <- runConduit $ yieldMany [1..10] .| iterMC print .| sumC
  print result
