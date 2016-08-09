module Screeps.Flag where

import Control.Monad.Eff (Eff)

import Screeps.Types
import Screeps.FFI (runThisEffFn0, runThisEffFn1, runThisEffFn2, unsafeField)

color :: Flag -> Color
color = unsafeField "color"

memory :: forall a. Flag -> a
memory = unsafeField "memory"

name :: Flag -> String
name = unsafeField "name"

secondaryColor :: Flag -> Color
secondaryColor = unsafeField "secondaryColor"

remove :: forall e. Flag -> Eff (cmd :: CMD | e) ReturnCode
remove = runThisEffFn0 "remove"

setColor :: forall e. Flag -> Color -> Eff (cmd :: CMD | e) ReturnCode
setColor = runThisEffFn1 "setColor"

setColor' :: forall e. Flag -> Color -> Color -> Eff (cmd :: CMD | e) ReturnCode
setColor' = runThisEffFn2 "setColor"

setPosition :: forall e. Flag -> Int -> Int -> Eff (cmd :: CMD | e) ReturnCode
setPosition flag x y = runThisEffFn2 "setPosition" flag x y

setPosition' :: forall e. Flag -> RoomPosition -> Eff (cmd :: CMD | e) ReturnCode
setPosition' = runThisEffFn1 "setPosition"
