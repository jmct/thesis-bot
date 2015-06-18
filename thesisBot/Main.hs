module Main where

import Progress
import qualified Data.Vector as V
import System.Environment
import Data.Maybe (catMaybes)

liftMaybe :: (Maybe a, b) -> Maybe (a, b)
liftMaybe (Nothing, _) = Nothing
liftMaybe (Just a, b)  = Just (a, b)

main = do
    [f] <- getArgs
    res <- readTimeVal f "%F %T"
    case res of
        Left s -> putStrLn s
        Right v -> putStr $ unlines $ fmap show $ catMaybes $ fmap liftMaybe $ V.toList v
