module Screeps.Terminal where

import Control.Monad.Eff (Eff)

import Screeps.Types
import Screeps.FFI (runThisEffFn3, runThisEffFn4, unsafeField)

store :: Terminal -> Store
store = unsafeField "store"

storeGet :: Store -> ResourceType -> Int
storeGet s (ResourceType res) = unsafeField res s

storeCapacity :: Terminal -> Int
storeCapacity = unsafeField "storeCapacity"

send :: forall e. Terminal -> ResourceType -> Int -> String -> Eff ( cmd :: CMD | e) ReturnCode
send term res amount destRoomName = runThisEffFn3 "send" term res amount destRoomName

send' :: forall e. Terminal -> ResourceType -> Int -> String -> String -> Eff ( cmd :: CMD | e) ReturnCode
send' term res amount destRoomName description = runThisEffFn4 "send" term res amount destRoomName description
