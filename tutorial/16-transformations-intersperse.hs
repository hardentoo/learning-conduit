#!/usr/bin/env stack
-- stack script --resolver lts-8.12 --package conduit-combinators

{-# LANGUAGE ExtendedDefaultRules #-}

import Conduit

main :: IO ()
main = runConduit
  $ yieldMany [1..10] .| intersperseC 0 .| takeC 10 .| mapM_C print
