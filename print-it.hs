#!/usr/bin/env stack
-- stack script --resolver lts-8.12 --package conduit-combinators

{-# LANGUAGE ExtendedDefaultRules #-}

import Conduit

main :: IO ()
main = do
    putStrLn "List version:"
    mapM_ print $ takeWhile (< 18) $ map (* 2) $ take 10 [1..]
    putStrLn ""
    putStrLn "Conduit version:"
    runConduit
          $ yieldMany [1..]
         .| takeC 10
         .| mapC (* 2)
         .| takeWhileC (< 18)
         .| mapM_C print
