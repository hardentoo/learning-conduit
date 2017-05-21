#!/usr/bin/env stack
-- stack script --resolver lts-8.12 --package conduit-combinators -- -Wall -fwarn-tabs

{-# LANGUAGE ExtendedDefaultRules #-}

import Conduit

main :: IO ()
main = do
  putStrLn "List version:"
  print $ take 10 [1..]
  putStrLn ""
  putStrLn "Conduit version:"
  print $ runConduitPure $ yieldMany [1..] .| takeC 10 .| sinkList
