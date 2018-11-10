module Json where

import Model (Score, Scores)
import           Data.Aeson
import qualified Data.ByteString.Lazy             as BS


instance ToJSON Score where
  toEncoding = genericToEncoding defaultOptions

instance FromJSON Score

scoreFile :: FilePath
scoreFile = "scores.json"

getJSON :: IO BS.ByteString
getJSON = BS.readFile scoreFile

-- TODO add type here
writeJSON s = BS.writeFile scoreFile (encode s)

-- loadJSON :: Maybe JSON
loadJSON :: IO (Either String [Score])
loadJSON = eitherDecode <$> getJSON
