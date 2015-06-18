module Progress ( readTimeVal
                , mkReport
                ) where

import Control.Applicative
import Data.Csv
import Data.Vector
import Data.Time.Format
import Data.Time.Clock
import Data.Time.Clock.POSIX
import qualified Data.ByteString.Lazy as BL
import qualified Data.Vector as V

-- Takes the time-format string, and the string to parse
pTime :: String -> String -> Maybe POSIXTime
pTime format = fmap utcTimeToPOSIXSeconds . parseTimeM False defaultTimeLocale format

-- Parse the (time, val) pairs from the given file and the appropriate time
-- format string
readTimeVal :: FilePath -> String -> IO (Either String (Vector (Maybe POSIXTime, Int)))
readTimeVal file format = do
    rawData <- BL.readFile file
    return $ (fmap . V.map) (\(a, b) -> (pTime format a, b)) $ decode NoHeader rawData

mkReport = undefined
