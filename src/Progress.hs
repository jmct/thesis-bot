module Progress ( readTimeVal
                , mkReport
                , defaultReport
                , Report(..)
                ) where

import Control.Applicative
import Data.Csv
import Data.Time.Format
import Data.Time.Clock
import Data.Time.Clock.POSIX
import Paths_progress (getDataFileName)
import qualified Data.ByteString.Lazy as BL (readFile)
import qualified Data.Text.IO as T (readFile)
import qualified Data.Text.Lazy.IO as T (writeFile)
import qualified Data.Vector as V
import Text.Hastache
import Text.Hastache.Context

-- | Takes the time-format string (as used by 'parseTimeM'), and the string to parse
pTime :: String -> String -> Maybe Int
pTime format = fmap (round . (*1000) . utcTimeToPOSIXSeconds) . parseTimeM False defaultTimeLocale format

-- | Parse the (time, val) pairs from the given file and the appropriate time
-- format string
readTimeVal :: FilePath -> String -> IO (Either String (V.Vector (Maybe Int, Int)))
readTimeVal file format = do
    rawData <- BL.readFile file
    return $ (fmap . V.map) (\(a, b) -> (pTime format a, b)) $ decode NoHeader rawData

-- | Structure for holding the data we'd like to report and the title + subtitle
-- for the report
data Report = Report { dat :: [(Int, Int)]
                     , title :: String
                     , subtitle :: String
                     }

defaultReport = Report [] "Title" "Subtitle"

-- | Render the given time-series 'Report' to the given output file
mkReport :: Report -> FilePath -> IO ()
mkReport rep outFile = do
    templates <- getDataFileName "templates"
    template <- T.readFile $ templates ++ "/report.tpl"
    hastacheStr defaultConfig template (mkStrContext context) >>= T.writeFile outFile
  where
    context "subtitle" = MuVariable $ subtitle rep
    context "title"    = MuVariable $ title rep
    context _          = MuNothing
