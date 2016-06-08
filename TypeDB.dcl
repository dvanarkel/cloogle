definition module TypeDB

// Standard libraries
from StdOverloaded import class <, class zero
from StdClass import class Ord

from Data.Map import ::Map
from Data.Maybe import ::Maybe

from GenEq import generic gEq

// CleanTypeUnifier
from Type import ::Type, ::TypeVar, ::TVAssignment, ::TypeDef, class print(..)

:: TypeDB
instance zero TypeDB
derive gEq TypeDB

:: FunctionLocation = FL Library Module FunctionName
instance print FunctionLocation

:: TypeExtras = { te_priority :: Maybe TE_Priority }
:: TE_Priority = LeftAssoc Int | RightAssoc Int | NoAssoc Int
instance print TE_Priority

:: ExtendedType = ET Type TypeExtras

:: ClassLocation = CL Library Module Class

:: Library :== String
:: Module :== String
:: FunctionName :== String
:: Class :== String

:: TypeLocation = TL Library Module TypeName

:: TypeName :== String

getFunction :: FunctionLocation TypeDB -> Maybe ExtendedType
putFunction :: FunctionLocation ExtendedType TypeDB -> TypeDB
putFunctions :: [(FunctionLocation, ExtendedType)] TypeDB -> TypeDB
findFunction :: FunctionName TypeDB -> [(FunctionLocation, ExtendedType)]
findFunction` :: (FunctionLocation ExtendedType -> Bool) TypeDB
		-> [(FunctionLocation, ExtendedType)]
findFunction`` :: [(FunctionLocation ExtendedType -> Bool)] TypeDB
		-> [(FunctionLocation, ExtendedType)]

getInstances :: Class TypeDB -> [Type]
putInstance :: Class Type TypeDB -> TypeDB
putInstances :: Class [Type] TypeDB -> TypeDB
putInstancess :: [(Class, [Type])] TypeDB -> TypeDB

getClass :: ClassLocation TypeDB -> Maybe ([TypeVar],[(FunctionName,ExtendedType)])
putClass :: ClassLocation [TypeVar] [(FunctionName, ExtendedType)] TypeDB -> TypeDB
putClasses :: [(ClassLocation, [TypeVar], [(FunctionName, ExtendedType)])] TypeDB -> TypeDB
findClass :: Class TypeDB -> [(ClassLocation, [TypeVar], [(FunctionName, ExtendedType)])]
findClass` :: (ClassLocation [TypeVar] [(FunctionName,ExtendedType)] -> Bool) TypeDB
		-> [(ClassLocation, [TypeVar], [(FunctionName, ExtendedType)])]

findClassMembers` :: (ClassLocation [TypeVar] FunctionName ExtendedType -> Bool) TypeDB
		-> [(ClassLocation, [TypeVar], FunctionName, ExtendedType)]
findClassMembers`` :: [ClassLocation [TypeVar] FunctionName ExtendedType -> Bool]
		TypeDB -> [(ClassLocation, [TypeVar], FunctionName, ExtendedType)]

getType :: TypeLocation TypeDB -> Maybe TypeDef
putType :: TypeLocation TypeDef TypeDB -> TypeDB
putTypes :: [(TypeLocation, TypeDef)] TypeDB -> TypeDB
findType :: TypeName TypeDB -> [(TypeLocation, TypeDef)]
findType` :: (TypeLocation TypeDef -> Bool) TypeDB
		-> [(TypeLocation, TypeDef)]

searchExact :: Type TypeDB -> [(FunctionLocation, ExtendedType)]
searchUnifiable :: Type TypeDB
        -> [(FunctionLocation, ExtendedType, [TVAssignment], [TVAssignment])]

newDb :: TypeDB
openDb :: *File -> *(Maybe TypeDB, *File)
saveDb :: TypeDB *File -> *File
