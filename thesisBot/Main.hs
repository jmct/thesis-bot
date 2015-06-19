module Main where

import Progress
import qualified Data.Vector as V
import System.Environment
import Data.Maybe (catMaybes)

liftMaybe :: (Maybe a, b) -> Maybe (a, b)
liftMaybe (Nothing, _) = Nothing
liftMaybe (Just a, b)  = Just (a, b)

myReport = Report [] "Writing Progress" "José's Thesis: Progress Report"

main = do
    [inF, outF] <- getArgs
    res <- readTimeVal inF "%F %T"
    case res of
        Left s -> putStrLn s
        Right v -> let myData = catMaybes $ fmap liftMaybe $ V.toList v
                   in mkReport (myReport { dat = myData }) outF
