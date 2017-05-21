#!/usr/bin/env stack
-- stack script --resolver lts-8.12 --package conduit-combinators

{-# LANGUAGE ExtendedDefaultRules #-}

import Conduit

magic :: Int -> IO Int
magic x = do
    putStrLn $ "I'm doing magic with " ++ show x
    return $ x * 2

main :: IO ()
main = do
    let go [] = return ()
        go (x:xs) = do
            y <- magic x
            if y < 18
                then do
                    print y
                    go xs
                else return ()

    go $ take 10 [1..]
