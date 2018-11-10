{-# LANGUAGE DeriveGeneric #-}

-- | This module contains the data types
--   which represent the state of the game
module Model where

import           GHC.Generics
import           Graphics.Gloss

data Spaceship = Spaceship
  { speed                        :: Int
  , health                       :: HealthPoints
  , weapons                      :: [Weapon]
  , spaceshipPositionInformation :: PositionInformation
  }

data Player = Player
  { playerSpaceship :: Spaceship
  , score           :: ScorePoints
  , comboMultiplier :: Int
  , comboTime       :: Seconds
  }

data Enemy = Enemy
  { bounty               :: ScorePoints
  , enemyCollisionDamage :: DamagePoints
  , enemySpaceship       :: Spaceship
  }

data Obstacle = Obstacle
  { bonusPoints                 :: ScorePoints
  , obstacleCollisionDamage     :: DamagePoints
  , obstacleHealth              :: HealthPoints
  , obstaclePositionInformation :: PositionInformation
  }

data Item
  = WeaponItem { weaponItem         :: Weapon
               , weaponItemLocation :: Coordinate }
  | PowerUp { bonusHealth     :: HealthPoints
            , powerUpLocation :: Coordinate }

data Weapon
  = Pistol { bullet          :: Bullet
           , active          :: Bool
           , lastShotAtFrame :: Int
           , reloadTime      :: Int }
  | Laser { bullet          :: Bullet
          , active          :: Bool
          , lastShotAtFrame :: Int
          , reloadTime      :: Int}
  | Bazooka { bullet          :: Bullet
            , reloadTime      :: Int
            , active          :: Bool
            , lastShotAtFrame :: Int }

data Bullet = Bullet
  { damage                    :: DamagePoints
  , hit                       :: Bool
  , bulletPositionInformation :: PositionInformation
  }

data PositionInformation = PositionInformation
  { location    :: Coordinate
  , destination :: Coordinate
  }

data State = Menu | Playing | GameOver | GameWin
  deriving (Eq)

newtype DamagePoints =
  DamagePoints Int
  deriving (Eq)

newtype HealthPoints =
  HealthPoints Int
  deriving (Eq)

newtype ScorePoints =
  ScorePoints Int
  deriving (Eq)

newtype Seconds =
  Seconds Int
  deriving (Eq)

data World = World
  { player    :: Player
  , enemies   :: [Enemy]
  , obstacles :: [Obstacle]
  , bullets   :: [Bullet]
  , level     :: Level
  , camera    :: Camera
  , keyboard  :: Keyboard
  , iteration :: Int
  , state     :: State
  , scores    :: IO (Either String [Score])
  }

data Keyboard = Keyboard
  { upKey    :: Bool
  , downKey  :: Bool
  , leftKey  :: Bool
  , rightKey :: Bool
  , shootKey :: Bool
  , pauseKey :: Bool
  , enterKey :: Bool
  }  deriving (Show)

data Camera = Camera
  { upperLeftCorner  :: Coordinate
  , upperRightCorner :: Coordinate
  , lowerLeftCorner  :: Coordinate
  , lowerRightCorner :: Coordinate
  }

newtype Level =
  Level [Spawn]

newtype Spawn =
  Spawn (Placeable, Coordinate)

-- spawn moet bevatten: enemy, frame waarop enemy moet spawnen, spawn coordinaten

data Placeable
  = PlaceableSpaceship Spaceship
  | PlaceableItem Item
  | PlaceableObstacle Obstacle

data Coordinate = Coordinate
  { x :: Float
  , y :: Float
  }

class Locatable a where
  nextLocation :: a -> a

data Images = Images
  { playerImage   :: Picture
  , enemyImage    :: Picture
  , obstacleImage :: Picture
  }

newtype Scores = Scores
  { unScore :: [Score]
  } deriving (Show)
-- [Score {playerName = "David", playerScore = 1100},Score {playerName = "Paul", playerScore = 1042},Score {playerName = "Dank Pronk", playerScore = 999},Score {playerName = "player4", playerScore = 0},Score {playerName = "player5", playerScore = 0},Score {playerName = "player6", playerScore = 0},Score {playerName = "player7", playerScore = 0},Score {playerName = "player8", playerScore = 0},Score {playerName = "player9", playerScore = 0},Score {playerName = "player10", playerScore = 0}]

data Score = Score
  { playerName  :: String
  , playerScore :: Int
  } deriving (Generic, Show)