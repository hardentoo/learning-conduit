#!/usr/bin/env stack
-- stack script --resolver lts-8.12 --package conduit-combinators

{-# LANGUAGE ExtendedDefaultRules #-}

import Conduit

main :: IO ()
main = putStr $ runConduitPure
     $ yieldMany [1..10 :: Int]
    .| mapC show
    .| unlinesC
    .| foldC
