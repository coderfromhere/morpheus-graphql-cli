{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE TypeFamilies #-}

-- generated by 'Morpheus' CLI
module Simple (rootResolver) where

import  GHC.Generics  (Generic)
import  Data.Morpheus.Kind  (SCALAR, ENUM, INPUT_OBJECT, OBJECT, UNION)
import  Data.Morpheus.Types  (GQLRootResolver(..), toMutResolver, IORes, IOMutRes, IOSubRes, Event(..), SubRootRes, GQLType(..), GQLScalar(..), ScalarValue(..))
import  Data.Text  (Text)

rootResolver :: GQLRootResolver IO () () Query () ()
rootResolver =
  GQLRootResolver
    { queryResolver = resolveQuery
  ,  mutationResolver = return ()
  ,  subscriptionResolver = return ()
    }




---- GQL Query ------------------------------- 
data Query = Query 
    { deity :: ArgDeity -> IORes Deity
  ,  character :: ArgCharacter -> IORes Character
    }
 deriving (Generic)

data ArgDeity = ArgDeity 
    { name :: Maybe [Maybe [Maybe [[Maybe [Text]]]]]
  ,  mythology :: Maybe Realm
    }
 deriving (Generic)

data ArgCharacter = ArgCharacter 
    { characterID :: Text
  ,  age :: Maybe Int
    }
 deriving (Generic)

instance GQLType Query where
  type KIND Query = OBJECT



resolveQuery :: IORes Query
resolveQuery = return Query 
    { deity = const resolveDeity
  ,  character = const resolveCharacter
    }




---- GQL Deity ------------------------------- 
data Deity = Deity 
    { fullName :: () -> IORes Text
  ,  power :: () -> IORes (Maybe Power)
    }
 deriving (Generic)

instance GQLType Deity where
  type KIND Deity = OBJECT



resolveDeity :: IORes Deity
resolveDeity = return Deity 
    { fullName = const $ return ""
  ,  power = const $ return Nothing
    }




---- GQL City ------------------------------- 
data City = 
  Athens
  | Ithaca
  | Sparta
  | Troy deriving (Generic)

instance GQLType City where
  type KIND City = ENUM



resolveCity :: IORes City
resolveCity = return Athens 



---- GQL Power ------------------------------- 
data Power = Power Int Int

instance GQLType Power where
  type KIND Power = SCALAR

instance GQLScalar  Power where
  parseValue _ = pure (Power 0 0 )
  serialize (Power x y ) = Int (x + y)



resolvePower :: IORes Power
resolvePower = return $ Power 0 0



---- GQL Creature ------------------------------- 
data Creature = Creature 
    { name :: () -> IORes Text
  ,  realm :: () -> IORes City
  ,  immortality :: () -> IORes Boolean
    }
 deriving (Generic)

instance GQLType Creature where
  type KIND Creature = OBJECT



resolveCreature :: IORes Creature
resolveCreature = return Creature 
    { name = const $ return ""
  ,  realm = const resolveCity
  ,  immortality = const resolveBoolean
    }




---- GQL Character ------------------------------- 
data Character = 
  Character_CREATURE Creature
  | Character_DEITY Deity deriving (Generic)

instance GQLType Character where
  type KIND Character = UNION



resolveCharacter :: IORes Character
resolveCharacter = Character_CREATURE  <$> resolveCreature