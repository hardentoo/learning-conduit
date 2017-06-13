#!/usr/bin/env stack
-- stack script --resolver lts-8.12 --package conduit-combinators

{-# LANGUAGE ExtendedDefaultRules #-}

import Conduit
import Data.Monoid (Product (..))

magic :: Int -> Int -> IO Int
magic total i = do
  putStrLn $ "Doing magic on " ++ show i
  return $! total * i

main :: IO ()
main = do
  res <- runConduit $ yieldMany [1..10] .| foldMC magic 1
  print res
