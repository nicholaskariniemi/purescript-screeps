-- | Corresponds to the Screeps API [StructureLab](http://support.screeps.com/hc/en-us/articles/208436195-StructureLab)
module Screeps.Lab where

import Control.Monad.Eff (Eff)
import Data.Maybe (Maybe)

import Screeps.Effects    (CMD)
import Screeps.FFI        (runThisEffFn1, runThisEffFn2, unsafeField)
import Screeps.Refillable (class Refillable)
import Screeps.Structure  (fromAnyStructure)
import Screeps.Types      --(Creep, Lab, AnyStructure)
import Screeps.ReturnCode (ReturnCode)

foreign import data Lab        :: *
instance objectLab       ::      RoomObject Lab where
instance ownedLab              :: Owned Lab where
instance structuralLab   ::     Structural Lab where
instance refillableLab   ::     Refillable Lab where
instance structureLab          ::      Structure Lab where
  _structureType _ = structure_lab

cooldown :: Lab -> Int
cooldown = unsafeField "cooldown"

mineralAmount :: Lab -> Int
mineralAmount = unsafeField "mineralAmount"

mineralType :: Lab -> String
mineralType = unsafeField "mineralType"

mineralCapacity :: Lab -> Int
mineralCapacity = unsafeField "mineralCapacity"

boostCreep :: forall e. Lab -> Creep -> Eff (cmd :: CMD | e) ReturnCode
boostCreep = runThisEffFn1 "boostCreep"

boostCreep' :: forall e. Lab -> Creep -> Int -> Eff (cmd :: CMD | e) ReturnCode
boostCreep' lab creep bodyPartsCount = runThisEffFn2 "boostCreep" lab creep bodyPartsCount

runReaction :: forall e. Lab -> Lab -> Lab -> Eff (cmd :: CMD | e) ReturnCode
runReaction lab lab1 lab2 = runThisEffFn2 "runReaction" lab lab1 lab2

toLab :: AnyStructure -> Maybe Lab
toLab = fromAnyStructure
