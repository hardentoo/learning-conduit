#!/usr/bin/env stack
-- stack script --resolver lts-8.12 --package conduit-combinators

{-# LANGUAGE ExtendedDefaultRules #-}
{-# LANGUAGE OverloadedStrings #-}

import Conduit

evenM :: Int -> IO Bool
evenM i = do
  let isEven = even i
  print (i, isEven)
  return isEven

main :: IO ()
main = runConduit
   $ yieldMany [1..10]
  .| filterMC evenM
  .| printC
