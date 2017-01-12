-- | Corresponds to the Screeps API [RoomObject](http://support.screeps.com/hc/en-us/articles/208435305-RoomObject)
module Screeps.RoomObject where

import Control.Category
import Control.Monad
import Control.Monad.Eff
import Control.Monad.Eff.Exception
import Control.Monad.Eff.Unsafe (unsafePerformEff)
import Data.Argonaut.Decode.Class
import Data.Argonaut.Encode.Class
import Data.Either
import Data.Function (($))
import Data.Maybe
import Data.Monoid
import Data.Show
import Data.StrMap as StrMap

import Screeps.FFI (unsafeField, toMaybe, NullOrUndefined)
import Screeps.Names
import Screeps.RoomPosition.Type (RoomPosition)

foreign import data Room :: *

instance showRoom :: Show Room where
  show = show <<< name

-- | Any `RoomObject` with a location, and room containing it. 
class RoomObject     a

name :: Room -> RoomName
name = unsafeField "name"

instance encodeJson :: EncodeJson Room where
  encodeJson = encodeJson <<< name

foreign import lookupRoom :: forall e. RoomName -> Eff e (NullOrUndefined Room)

instance decodeJson :: DecodeJson Room where
  decodeJson           json = do
    name <- decodeJson json
    case unsafePerformEff $ try $ map toMaybe $ lookupRoom name of
         Left   err      -> Left  $ "Cannot access the room: " <> show name
                                 <> " because of: "            <> show err
         Right (Nothing) -> Left  $ "Cannot access room: "     <> show name
         Right (Just r ) -> Right   r

foreign import data AnyRoomObject :: *

instance anyRoomObject :: RoomObject AnyRoomObject

room :: forall a. RoomObject a => a -> Room
room = unsafeField "room"

pos :: forall a. RoomObject a => a -> RoomPosition
pos = unsafeField "pos"
