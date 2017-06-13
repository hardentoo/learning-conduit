#!/usr/bin/env stack
{-
  stack script --resolver lts-8.12
    --package conduit-combinators
    --
    -Wall -fwarn-tabs -fno-warn-type-defaults
-}
import Conduit

main :: IO ()
main
  -- Create a source file
 = do
  writeFile "input.txt" "This is a test."
  runConduitRes $ sourceFile "input.txt" .| sinkFile "output.txt"
