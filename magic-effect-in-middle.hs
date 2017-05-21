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
  putStrLn "Was:"
  print $ takeWhile (< 18) $ map (* 2) $ take 10 [1..]

  putStrLn "List version:"
  mapM magic (take 10 [1..]) >>= mapM_ print . takeWhile (< 18)
  putStrLn ""

  putStrLn "Conduit version:"
  runConduit
	  $ yieldMany [1..]
	 .| takeC 10
	 .| mapMC magic
	 .| takeWhileC (< 18)
	 .| mapM_C print
