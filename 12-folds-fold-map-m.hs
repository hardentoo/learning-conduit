#!/usr/bin/env stack
-- stack script --resolver lts-8.12 --package conduit-combinators

{-# LANGUAGE ExtendedDefaultRules #-}

import Conduit
import Data.Monoid (Product (..))

magic :: Int -> IO (Product Int)
magic i = do
    putStrLn $ "Doing magic on " ++ show i
    return $ Product i

main :: IO ()
main = do
    Product res <- runConduit $ yieldMany [1..10] .| foldMapMC magic
    print res
