#!/usr/bin/env stack
-- stack script --resolver lts-8.12 --package conduit-combinators

{-# LANGUAGE ExtendedDefaultRules #-}

import Conduit

main :: IO ()
main = print $ runConduitPure $ yieldMany [1..100 :: Int] .| foldlC (+) 0
