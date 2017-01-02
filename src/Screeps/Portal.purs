-- | Corresponds to the Screeps API [StructurePortal](http://support.screeps.com/hc/en-us/articles/208647345-StructurePortal)
module Screeps.Portal where

import Data.Argonaut.Encode (class EncodeJson, encodeJson)
import Data.Argonaut.Decode (class DecodeJson, decodeJson)
import Data.Maybe (Maybe)

import Screeps.Decays (class Decays)
import Screeps.FFI (unsafeField, instanceOf)
import Screeps.Id
import Screeps.Structure (fromAnyStructure)
import Screeps.Types --(AnyStructure, structure_portal)
import Screeps.RoomPosition.Type (RoomPosition)

foreign import data Portal :: *
instance objectPortal      :: RoomObject Portal
instance ownedPortal       :: Owned      Portal
instance structuralPortal  :: Structural Portal
instance portalDecays      :: Decays     Portal
instance portalHasId       :: HasId      Portal where
  validate = instanceOf "StructurePortal"
instance encodePortal      :: EncodeJson Portal where encodeJson = encodeJsonWithId
instance decodePortal      :: DecodeJson Portal where decodeJson = decodeJsonWithId
instance structurePortal   :: Structure  Portal where
  _structureType _ = structure_portal

destination :: Portal -> RoomPosition
destination = unsafeField "destination"

toPortal :: AnyStructure -> Maybe Portal
toPortal = fromAnyStructure
