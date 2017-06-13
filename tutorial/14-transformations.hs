#!/usr/bin/env stack
-- stack script --resolver lts-8.12 --package conduit-combinators

{-# LANGUAGE ExtendedDefaultRules #-}

import Conduit

main :: IO ()
main = runConduit $ yieldMany [1..10] .| mapC (* 2) .| mapM_C print
