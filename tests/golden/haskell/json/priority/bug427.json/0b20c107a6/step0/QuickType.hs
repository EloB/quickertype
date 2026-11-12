{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , QuickTypeChild (..)
    , PurpleChild (..)
    , MagentaType (..)
    , StickyDeclaration (..)
    , IndecentChild (..)
    , FriskyType (..)
    , IndigoDeclaration (..)
    , IndexSignatureElement (..)
    , GetSignatureType (..)
    , PurpleType (..)
    , GetSignatureChild (..)
    , GetSignature (..)
    , GetSignatureFlags (..)
    , ElementType (..)
    , FluffyComment (..)
    , FluffyFlags (..)
    , Source (..)
    , GetSignatureComment (..)
    , Group (..)
    , GetSignatureParameter (..)
    , TentacledComment (..)
    , TentacledFlags (..)
    , FluffyType (..)
    , ExtendedBy (..)
    , FluffyTypeArgument (..)
    , FluffyChild (..)
    , IndigoType (..)
    , FluffyDeclaration (..)
    , StickyChild (..)
    , IndecentType (..)
    , IndexSignature (..)
    , HilariousType (..)
    , TentacledSignature (..)
    , IndigoComment (..)
    , FluffyParameter (..)
    , PurpleTypeArgument (..)
    , TypeElement (..)
    , TentacledChild (..)
    , PurpleComment (..)
    , PurpleFlags (..)
    , PurpleSignature (..)
    , TentacledType (..)
    , PurpleDeclaration (..)
    , StickyComment (..)
    , Tag (..)
    , StickyFlags (..)
    , FluffySignature (..)
    , IndigoFlags (..)
    , PurpleParameter (..)
    , StickyType (..)
    , IndecentFlags (..)
    , StickySignature (..)
    , TentacledParameter (..)
    , AmbitiousType (..)
    , TentacledDeclaration (..)
    , IndigoChild (..)
    , CunningType (..)
    , TypeParameter (..)
    , MischievousType (..)
    , IndecentComment (..)
    , TypeEnum (..)
    , Name (..)
    , PurpleKindString (..)
    , FileName (..)
    , ParameterKindString (..)
    , SignatureKindString (..)
    , FluffyKindString (..)
    , TentacledKindString (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { childrenQuickType :: [QuickTypeChild]
    , flagsQuickType :: GetSignatureFlags
    , groupsQuickType :: [Group]
    , kindQuickType :: Int
    , nameQuickType :: Text
    , quickTypeIDQuickType :: Int
    } deriving (Show)

data QuickTypeChild = QuickTypeChild
    { childIDQuickTypeChild :: Int
    , childrenQuickTypeChild :: [PurpleChild]
    , commentQuickTypeChild :: Maybe IndecentComment
    , flagsQuickTypeChild :: PurpleFlags
    , groupsQuickTypeChild :: [Group]
    , kindQuickTypeChild :: Int
    , kindStringQuickTypeChild :: TentacledKindString
    , nameQuickTypeChild :: Text
    , originalNameQuickTypeChild :: Text
    , sourcesQuickTypeChild :: [Source]
    } deriving (Show)

data PurpleChild = PurpleChild
    { childIDPurpleChild :: Int
    , childTypePurpleChild :: Maybe MagentaType
    , childrenPurpleChild :: Maybe ([FluffyChild])
    , commentPurpleChild :: Maybe StickyComment
    , defaultValuePurpleChild :: Maybe Text
    , extendedByPurpleChild :: Maybe ([ExtendedBy])
    , extendedTypesPurpleChild :: Maybe ([ExtendedBy])
    , flagsPurpleChild :: IndecentFlags
    , groupsPurpleChild :: Maybe ([Group])
    , implementedByPurpleChild :: Maybe ([ExtendedBy])
    , implementedTypesPurpleChild :: Maybe ([ExtendedBy])
    , kindPurpleChild :: Int
    , kindStringPurpleChild :: FluffyKindString
    , namePurpleChild :: Text
    , signaturesPurpleChild :: Maybe ([StickySignature])
    , sourcesPurpleChild :: [Source]
    , typeParameterPurpleChild :: Maybe ([TypeParameter])
    } deriving (Show)

data MagentaType = MagentaType
    { declarationMagentaType :: Maybe StickyDeclaration
    , elementTypeMagentaType :: Maybe ElementType
    , elementsMagentaType :: Maybe ([ExtendedBy])
    , nameMagentaType :: Maybe Text
    , typeArgumentsMagentaType :: Maybe ([FluffyTypeArgument])
    , typeIDMagentaType :: Maybe Int
    , typeTypeMagentaType :: TypeEnum
    , typesMagentaType :: Maybe ([ExtendedBy])
    , valueMagentaType :: Maybe Text
    } deriving (Show)

data StickyDeclaration = StickyDeclaration
    { childrenStickyDeclaration :: Maybe ([IndecentChild])
    , declarationIDStickyDeclaration :: Int
    , flagsStickyDeclaration :: GetSignatureFlags
    , groupsStickyDeclaration :: Maybe ([Group])
    , kindStickyDeclaration :: Int
    , kindStringStickyDeclaration :: Text
    , nameStickyDeclaration :: Text
    , signaturesStickyDeclaration :: [GetSignature]
    , sourcesStickyDeclaration :: [Source]
    } deriving (Show)

data IndecentChild = IndecentChild
    { childIDIndecentChild :: Int
    , childTypeIndecentChild :: FriskyType
    , flagsIndecentChild :: FluffyFlags
    , kindIndecentChild :: Int
    , kindStringIndecentChild :: PurpleKindString
    , nameIndecentChild :: Text
    , sourcesIndecentChild :: [Source]
    } deriving (Show)

data FriskyType = FriskyType
    { declarationFriskyType :: Maybe IndigoDeclaration
    , nameFriskyType :: Maybe Name
    , typeTypeFriskyType :: TypeEnum
    } deriving (Show)

data IndigoDeclaration = IndigoDeclaration
    { childrenIndigoDeclaration :: Maybe ([GetSignature])
    , declarationIDIndigoDeclaration :: Int
    , flagsIndigoDeclaration :: GetSignatureFlags
    , groupsIndigoDeclaration :: Maybe ([Group])
    , kindIndigoDeclaration :: Int
    , kindStringIndigoDeclaration :: Text
    , nameIndigoDeclaration :: Text
    , signaturesIndigoDeclaration :: Maybe ([GetSignature])
    , sourcesIndigoDeclaration :: [Source]
    } deriving (Show)

data IndexSignatureElement = IndexSignatureElement
    { flagsIndexSignatureElement :: GetSignatureFlags
    , kindIndexSignatureElement :: Int
    , kindStringIndexSignatureElement :: Text
    , nameIndexSignatureElement :: Text
    , parametersIndexSignatureElement :: Maybe ([GetSignature])
    , signatureIDIndexSignatureElement :: Int
    , signatureTypeIndexSignatureElement :: PurpleType
    } deriving (Show)

data GetSignatureType = GetSignatureType
    { declarationGetSignatureType :: Maybe GetSignature
    , elementTypeGetSignatureType :: Maybe ElementType
    , nameGetSignatureType :: Maybe Name
    , typeTypeGetSignatureType :: TypeEnum
    } deriving (Show)

data PurpleType = PurpleType
    { declarationPurpleType :: Maybe GetSignature
    , namePurpleType :: Maybe Name
    , typeTypePurpleType :: TypeEnum
    } deriving (Show)

data GetSignatureChild = GetSignatureChild
    { childIDGetSignatureChild :: Int
    , childTypeGetSignatureChild :: PurpleType
    , commentGetSignatureChild :: Maybe FluffyComment
    , flagsGetSignatureChild :: FluffyFlags
    , kindGetSignatureChild :: Int
    , kindStringGetSignatureChild :: PurpleKindString
    , nameGetSignatureChild :: Text
    , sourcesGetSignatureChild :: [Source]
    } deriving (Show)

data GetSignature = GetSignature
    { childrenGetSignature :: Maybe ([GetSignatureChild])
    , commentGetSignature :: Maybe GetSignatureComment
    , defaultValueGetSignature :: Maybe Text
    , flagsGetSignature :: GetSignatureFlags
    , getSignatureIDGetSignature :: Int
    , getSignatureTypeGetSignature :: Maybe GetSignatureType
    , groupsGetSignature :: Maybe ([Group])
    , kindGetSignature :: Int
    , kindStringGetSignature :: Text
    , nameGetSignature :: Text
    , parametersGetSignature :: Maybe ([GetSignatureParameter])
    , signaturesGetSignature :: Maybe ([IndexSignatureElement])
    , sourcesGetSignature :: Maybe ([Source])
    , typeParameterGetSignature :: Maybe ([GetSignature])
    } deriving (Show)

data GetSignatureFlags = GetSignatureFlags
    {
    } deriving (Show)

data ElementType = ElementType
    { elementTypeTypeElementType :: TypeEnum
    , nameElementType :: Name
    } deriving (Show)

data TypeEnum
    = IntrinsicTypeEnum
    | ReflectionTypeEnum
    | ArrayTypeEnum
    | ReferenceTypeEnum
    | TypeParameterTypeEnum
    | TupleTypeEnum
    | UnionTypeEnum
    | StringLiteralTypeEnum
    deriving (Show)

data Name
    = StringName
    | NumberName
    | VoidName
    | TName
    | BooleanName
    | BaseClassName
    | AnyName
    | ArrayName
    | MyNumberName
    deriving (Show)

data FluffyComment = FluffyComment
    { commentTextFluffyComment :: Text
    } deriving (Show)

data FluffyFlags = FluffyFlags
    { isOptionalFluffyFlags :: Maybe Bool
    } deriving (Show)

data PurpleKindString
    = VariablePurpleKindString
    | FunctionPurpleKindString
    | PropertyPurpleKindString
    | MethodPurpleKindString
    | ConstructorPurpleKindString
    | AccessorPurpleKindString
    | EnumerationMemberPurpleKindString
    | ModulePurpleKindString
    | ObjectLiteralPurpleKindString
    deriving (Show)

data Source = Source
    { characterSource :: Int
    , fileNameSource :: FileName
    , lineSource :: Int
    } deriving (Show)

data FileName
    = ModulesTsFileName
    | ClassesTsFileName
    | FlattenedTsFileName
    | AccessTsFileName
    | DefaultExportTsFileName
    | EnumerationsTsFileName
    | FunctionsTsFileName
    | GenericsTsFileName
    | SingleExportTsFileName
    | Typescript13TsFileName
    | Typescript14TsFileName
    | Typescript15TsFileName
    | VariablesTsFileName
    deriving (Show)

data GetSignatureComment = GetSignatureComment
    { commentTextGetSignatureComment :: Maybe Text
    , returnsGetSignatureComment :: Maybe Text
    , shortTextGetSignatureComment :: Maybe Text
    } deriving (Show)

data Group = Group
    { childrenGroup :: [Int]
    , kindGroup :: Int
    , titleGroup :: Text
    } deriving (Show)

data GetSignatureParameter = GetSignatureParameter
    { commentGetSignatureParameter :: Maybe TentacledComment
    , flagsGetSignatureParameter :: TentacledFlags
    , kindGetSignatureParameter :: Int
    , kindStringGetSignatureParameter :: ParameterKindString
    , nameGetSignatureParameter :: Text
    , parameterIDGetSignatureParameter :: Int
    , parameterTypeGetSignatureParameter :: FluffyType
    } deriving (Show)

data TentacledComment = TentacledComment
    { commentTextTentacledComment :: Maybe Text
    , shortTextTentacledComment :: Maybe Text
    } deriving (Show)

data TentacledFlags = TentacledFlags
    { isOptionalTentacledFlags :: Maybe Bool
    , isRESTTentacledFlags :: Maybe Bool
    } deriving (Show)

data ParameterKindString
    = ParameterParameterKindString
    deriving (Show)

data FluffyType = FluffyType
    { elementTypeFluffyType :: Maybe ElementType
    , nameFluffyType :: Maybe Name
    , typeArgumentsFluffyType :: Maybe ([ElementType])
    , typeTypeFluffyType :: TypeEnum
    } deriving (Show)

data ExtendedBy = ExtendedBy
    { constraintExtendedBy :: Maybe ExtendedBy
    , extendedByIDExtendedBy :: Maybe Int
    , extendedByTypeExtendedBy :: TypeEnum
    , nameExtendedBy :: Text
    , typeArgumentsExtendedBy :: Maybe ([ExtendedBy])
    } deriving (Show)

data FluffyTypeArgument = FluffyTypeArgument
    { typeArgumentTypeFluffyTypeArgument :: TypeEnum
    , typesFluffyTypeArgument :: [ElementType]
    } deriving (Show)

data FluffyChild = FluffyChild
    { childIDFluffyChild :: Int
    , childTypeFluffyChild :: Maybe IndigoType
    , childrenFluffyChild :: Maybe ([TentacledChild])
    , commentFluffyChild :: Maybe StickyComment
    , defaultValueFluffyChild :: Maybe Text
    , flagsFluffyChild :: StickyFlags
    , getSignatureFluffyChild :: Maybe GetSignature
    , groupsFluffyChild :: Maybe ([Group])
    , implementationOfFluffyChild :: Maybe ExtendedBy
    , inheritedFromFluffyChild :: Maybe ExtendedBy
    , kindFluffyChild :: Int
    , kindStringFluffyChild :: PurpleKindString
    , nameFluffyChild :: Text
    , overwritesFluffyChild :: Maybe ExtendedBy
    , setSignatureFluffyChild :: Maybe GetSignature
    , signaturesFluffyChild :: Maybe ([FluffySignature])
    , sourcesFluffyChild :: [Source]
    } deriving (Show)

data IndigoType = IndigoType
    { constraintIndigoType :: Maybe ExtendedBy
    , declarationIndigoType :: Maybe FluffyDeclaration
    , elementTypeIndigoType :: Maybe ExtendedBy
    , elementsIndigoType :: Maybe ([ElementType])
    , nameIndigoType :: Maybe Text
    , typeArgumentsIndigoType :: Maybe ([PurpleTypeArgument])
    , typeIDIndigoType :: Maybe Int
    , typeTypeIndigoType :: TypeEnum
    , typesIndigoType :: Maybe ([TypeElement])
    } deriving (Show)

data FluffyDeclaration = FluffyDeclaration
    { childrenFluffyDeclaration :: Maybe ([StickyChild])
    , declarationIDFluffyDeclaration :: Int
    , flagsFluffyDeclaration :: GetSignatureFlags
    , groupsFluffyDeclaration :: Maybe ([Group])
    , indexSignatureFluffyDeclaration :: Maybe IndexSignature
    , kindFluffyDeclaration :: Int
    , kindStringFluffyDeclaration :: Text
    , nameFluffyDeclaration :: Text
    , signaturesFluffyDeclaration :: Maybe ([TentacledSignature])
    , sourcesFluffyDeclaration :: [Source]
    } deriving (Show)

data StickyChild = StickyChild
    { childIDStickyChild :: Int
    , childTypeStickyChild :: IndecentType
    , commentStickyChild :: Maybe FluffyComment
    , flagsStickyChild :: FluffyFlags
    , kindStickyChild :: Int
    , kindStringStickyChild :: PurpleKindString
    , nameStickyChild :: Text
    , sourcesStickyChild :: [Source]
    } deriving (Show)

data IndecentType = IndecentType
    { declarationIndecentType :: Maybe GetSignature
    , elementsIndecentType :: Maybe ([ElementType])
    , nameIndecentType :: Maybe Name
    , typeTypeIndecentType :: TypeEnum
    } deriving (Show)

data IndexSignature = IndexSignature
    { flagsIndexSignature :: GetSignatureFlags
    , indexSignatureIDIndexSignature :: Int
    , indexSignatureTypeIndexSignature :: HilariousType
    , kindIndexSignature :: Int
    , kindStringIndexSignature :: Text
    , nameIndexSignature :: Text
    , parametersIndexSignature :: [GetSignature]
    } deriving (Show)

data HilariousType = HilariousType
    { declarationHilariousType :: GetSignature
    , typeTypeHilariousType :: TypeEnum
    } deriving (Show)

data TentacledSignature = TentacledSignature
    { commentTentacledSignature :: Maybe IndigoComment
    , flagsTentacledSignature :: GetSignatureFlags
    , kindTentacledSignature :: Int
    , kindStringTentacledSignature :: SignatureKindString
    , nameTentacledSignature :: Text
    , parametersTentacledSignature :: Maybe ([FluffyParameter])
    , signatureIDTentacledSignature :: Int
    , signatureTypeTentacledSignature :: ExtendedBy
    } deriving (Show)

data IndigoComment = IndigoComment
    { returnsIndigoComment :: Text
    , shortTextIndigoComment :: Text
    } deriving (Show)

data SignatureKindString
    = CallSignatureSignatureKindString
    | ConstructorSignatureSignatureKindString
    deriving (Show)

data FluffyParameter = FluffyParameter
    { commentFluffyParameter :: Maybe FluffyComment
    , flagsFluffyParameter :: FluffyFlags
    , kindFluffyParameter :: Int
    , kindStringFluffyParameter :: Text
    , nameFluffyParameter :: Text
    , parameterIDFluffyParameter :: Int
    , parameterTypeFluffyParameter :: ElementType
    , sourcesFluffyParameter :: Maybe ([Source])
    } deriving (Show)

data PurpleTypeArgument = PurpleTypeArgument
    { operatorPurpleTypeArgument :: Text
    , targetPurpleTypeArgument :: ElementType
    , typeArgumentTypePurpleTypeArgument :: Text
    } deriving (Show)

data TypeElement = TypeElement
    { declarationTypeElement :: Maybe GetSignature
    , elementTypeTypeElement :: Maybe ElementType
    , nameTypeElement :: Maybe Name
    , typeArgumentsTypeElement :: Maybe ([ElementType])
    , typeTypeTypeElement :: TypeEnum
    } deriving (Show)

data TentacledChild = TentacledChild
    { childIDTentacledChild :: Int
    , childTypeTentacledChild :: Maybe TypeElement
    , commentTentacledChild :: Maybe PurpleComment
    , defaultValueTentacledChild :: Maybe Text
    , flagsTentacledChild :: PurpleFlags
    , kindTentacledChild :: Int
    , kindStringTentacledChild :: PurpleKindString
    , nameTentacledChild :: Text
    , signaturesTentacledChild :: Maybe ([PurpleSignature])
    , sourcesTentacledChild :: [Source]
    } deriving (Show)

data PurpleComment = PurpleComment
    { shortTextPurpleComment :: Text
    } deriving (Show)

data PurpleFlags = PurpleFlags
    { isExportedPurpleFlags :: Maybe Bool
    } deriving (Show)

data PurpleSignature = PurpleSignature
    { commentPurpleSignature :: Maybe PurpleComment
    , flagsPurpleSignature :: GetSignatureFlags
    , kindPurpleSignature :: Int
    , kindStringPurpleSignature :: SignatureKindString
    , namePurpleSignature :: Text
    , parametersPurpleSignature :: [GetSignature]
    , signatureIDPurpleSignature :: Int
    , signatureTypePurpleSignature :: TentacledType
    } deriving (Show)

data TentacledType = TentacledType
    { declarationTentacledType :: Maybe PurpleDeclaration
    , nameTentacledType :: Maybe Name
    , typeTypeTentacledType :: TypeEnum
    } deriving (Show)

data PurpleDeclaration = PurpleDeclaration
    { childrenPurpleDeclaration :: [GetSignature]
    , declarationIDPurpleDeclaration :: Int
    , flagsPurpleDeclaration :: GetSignatureFlags
    , groupsPurpleDeclaration :: [Group]
    , kindPurpleDeclaration :: Int
    , kindStringPurpleDeclaration :: Text
    , namePurpleDeclaration :: Text
    } deriving (Show)

data StickyComment = StickyComment
    { commentTextStickyComment :: Maybe Text
    , returnsStickyComment :: Maybe Text
    , shortTextStickyComment :: Maybe Text
    , tagsStickyComment :: Maybe ([Tag])
    } deriving (Show)

data Tag = Tag
    { tagTag :: Text
    , tagTextTag :: Text
    } deriving (Show)

data StickyFlags = StickyFlags
    { isAbstractStickyFlags :: Maybe Bool
    , isConstructorPropertyStickyFlags :: Maybe Bool
    , isExportedStickyFlags :: Maybe Bool
    , isPrivateStickyFlags :: Maybe Bool
    , isProtectedStickyFlags :: Maybe Bool
    , isPublicStickyFlags :: Maybe Bool
    , isStaticStickyFlags :: Maybe Bool
    } deriving (Show)

data FluffySignature = FluffySignature
    { commentFluffySignature :: Maybe StickyComment
    , flagsFluffySignature :: IndigoFlags
    , implementationOfFluffySignature :: Maybe ExtendedBy
    , inheritedFromFluffySignature :: Maybe ExtendedBy
    , kindFluffySignature :: Int
    , kindStringFluffySignature :: SignatureKindString
    , nameFluffySignature :: Text
    , overwritesFluffySignature :: Maybe ExtendedBy
    , parametersFluffySignature :: Maybe ([PurpleParameter])
    , signatureIDFluffySignature :: Int
    , signatureTypeFluffySignature :: ExtendedBy
    , typeParameterFluffySignature :: Maybe ([GetSignature])
    } deriving (Show)

data IndigoFlags = IndigoFlags
    { isPrivateIndigoFlags :: Maybe Bool
    , isProtectedIndigoFlags :: Maybe Bool
    } deriving (Show)

data PurpleParameter = PurpleParameter
    { commentPurpleParameter :: Maybe TentacledComment
    , flagsPurpleParameter :: GetSignatureFlags
    , kindPurpleParameter :: Int
    , kindStringPurpleParameter :: ParameterKindString
    , namePurpleParameter :: Text
    , parameterIDPurpleParameter :: Int
    , parameterTypePurpleParameter :: StickyType
    } deriving (Show)

data StickyType = StickyType
    { constraintStickyType :: Maybe ExtendedBy
    , declarationStickyType :: Maybe GetSignature
    , elementTypeStickyType :: Maybe ElementType
    , elementsStickyType :: Maybe ([ExtendedBy])
    , nameStickyType :: Maybe Text
    , typeArgumentsStickyType :: Maybe ([ElementType])
    , typeIDStickyType :: Maybe Int
    , typeTypeStickyType :: TypeEnum
    } deriving (Show)

data IndecentFlags = IndecentFlags
    { hasExportAssignmentIndecentFlags :: Maybe Bool
    , isAbstractIndecentFlags :: Maybe Bool
    , isConstIndecentFlags :: Maybe Bool
    , isExportedIndecentFlags :: Maybe Bool
    , isLetIndecentFlags :: Maybe Bool
    , isPrivateIndecentFlags :: Maybe Bool
    , isProtectedIndecentFlags :: Maybe Bool
    } deriving (Show)

data FluffyKindString
    = ModuleFluffyKindString
    | ClassFluffyKindString
    | VariableFluffyKindString
    | FunctionFluffyKindString
    | InterfaceFluffyKindString
    | EnumerationFluffyKindString
    | ObjectLiteralFluffyKindString
    | TypeAliasFluffyKindString
    deriving (Show)

data StickySignature = StickySignature
    { commentStickySignature :: StickyComment
    , flagsStickySignature :: IndigoFlags
    , kindStickySignature :: Int
    , kindStringStickySignature :: SignatureKindString
    , nameStickySignature :: Text
    , parametersStickySignature :: Maybe ([TentacledParameter])
    , signatureIDStickySignature :: Int
    , signatureTypeStickySignature :: CunningType
    , typeParameterStickySignature :: Maybe ([GetSignature])
    } deriving (Show)

data TentacledParameter = TentacledParameter
    { commentTentacledParameter :: Maybe TentacledComment
    , defaultValueTentacledParameter :: Maybe Text
    , flagsTentacledParameter :: TentacledFlags
    , kindTentacledParameter :: Int
    , kindStringTentacledParameter :: ParameterKindString
    , nameTentacledParameter :: Text
    , originalNameTentacledParameter :: Maybe Text
    , parameterIDTentacledParameter :: Int
    , parameterTypeTentacledParameter :: AmbitiousType
    } deriving (Show)

data AmbitiousType = AmbitiousType
    { declarationAmbitiousType :: Maybe TentacledDeclaration
    , elementTypeAmbitiousType :: Maybe ElementType
    , nameAmbitiousType :: Maybe Text
    , typeArgumentsAmbitiousType :: Maybe ([ElementType])
    , typeIDAmbitiousType :: Maybe Int
    , typeTypeAmbitiousType :: TypeEnum
    } deriving (Show)

data TentacledDeclaration = TentacledDeclaration
    { childrenTentacledDeclaration :: Maybe ([IndigoChild])
    , declarationIDTentacledDeclaration :: Int
    , flagsTentacledDeclaration :: GetSignatureFlags
    , groupsTentacledDeclaration :: Maybe ([Group])
    , indexSignatureTentacledDeclaration :: Maybe IndexSignatureElement
    , kindTentacledDeclaration :: Int
    , kindStringTentacledDeclaration :: Text
    , nameTentacledDeclaration :: Text
    , signaturesTentacledDeclaration :: Maybe ([GetSignature])
    , sourcesTentacledDeclaration :: [Source]
    } deriving (Show)

data IndigoChild = IndigoChild
    { childIDIndigoChild :: Int
    , childTypeIndigoChild :: IndecentType
    , commentIndigoChild :: FluffyComment
    , defaultValueIndigoChild :: Maybe Text
    , flagsIndigoChild :: FluffyFlags
    , kindIndigoChild :: Int
    , kindStringIndigoChild :: PurpleKindString
    , nameIndigoChild :: Text
    , sourcesIndigoChild :: [Source]
    } deriving (Show)

data CunningType = CunningType
    { declarationCunningType :: Maybe PurpleDeclaration
    , nameCunningType :: Maybe Name
    , typeArgumentsCunningType :: Maybe ([ElementType])
    , typeIDCunningType :: Maybe Int
    , typeTypeCunningType :: TypeEnum
    } deriving (Show)

data TypeParameter = TypeParameter
    { commentTypeParameter :: Maybe PurpleComment
    , flagsTypeParameter :: GetSignatureFlags
    , kindTypeParameter :: Int
    , kindStringTypeParameter :: Text
    , nameTypeParameter :: Text
    , typeParameterIDTypeParameter :: Int
    , typeParameterTypeTypeParameter :: Maybe MischievousType
    } deriving (Show)

data MischievousType = MischievousType
    { nameMischievousType :: Maybe Name
    , operatorMischievousType :: Maybe Text
    , targetMischievousType :: Maybe ElementType
    , typeIDMischievousType :: Maybe Int
    , typeTypeMischievousType :: Text
    } deriving (Show)

data IndecentComment = IndecentComment
    { shortTextIndecentComment :: Text
    , tagsIndecentComment :: Maybe ([Tag])
    } deriving (Show)

data TentacledKindString
    = ExternalModuleTentacledKindString
    deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType childrenQuickType flagsQuickType groupsQuickType kindQuickType nameQuickType quickTypeIDQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "children" .= childrenQuickType
        , Just $ "flags" .= flagsQuickType
        , Just $ "groups" .= groupsQuickType
        , Just $ "kind" .= kindQuickType
        , Just $ "name" .= nameQuickType
        , Just $ "id" .= quickTypeIDQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "children"
        <*> v .: "flags"
        <*> v .: "groups"
        <*> v .: "kind"
        <*> v .: "name"
        <*> v .: "id"

instance ToJSON QuickTypeChild where
    toJSON (QuickTypeChild childIDQuickTypeChild childrenQuickTypeChild commentQuickTypeChild flagsQuickTypeChild groupsQuickTypeChild kindQuickTypeChild kindStringQuickTypeChild nameQuickTypeChild originalNameQuickTypeChild sourcesQuickTypeChild) =
        object $ foldMap (maybe [] pure)
        [ Just $ "id" .= childIDQuickTypeChild
        , Just $ "children" .= childrenQuickTypeChild
        , ("comment" .=) <$> commentQuickTypeChild
        , Just $ "flags" .= flagsQuickTypeChild
        , Just $ "groups" .= groupsQuickTypeChild
        , Just $ "kind" .= kindQuickTypeChild
        , Just $ "kindString" .= kindStringQuickTypeChild
        , Just $ "name" .= nameQuickTypeChild
        , Just $ "originalName" .= originalNameQuickTypeChild
        , Just $ "sources" .= sourcesQuickTypeChild
        ]

instance FromJSON QuickTypeChild where
    parseJSON (Object v) = QuickTypeChild
        <$> v .: "id"
        <*> v .: "children"
        <*> v .:! "comment"
        <*> v .: "flags"
        <*> v .: "groups"
        <*> v .: "kind"
        <*> v .: "kindString"
        <*> v .: "name"
        <*> v .: "originalName"
        <*> v .: "sources"

instance ToJSON PurpleChild where
    toJSON (PurpleChild childIDPurpleChild childTypePurpleChild childrenPurpleChild commentPurpleChild defaultValuePurpleChild extendedByPurpleChild extendedTypesPurpleChild flagsPurpleChild groupsPurpleChild implementedByPurpleChild implementedTypesPurpleChild kindPurpleChild kindStringPurpleChild namePurpleChild signaturesPurpleChild sourcesPurpleChild typeParameterPurpleChild) =
        object $ foldMap (maybe [] pure)
        [ Just $ "id" .= childIDPurpleChild
        , ("type" .=) <$> childTypePurpleChild
        , ("children" .=) <$> childrenPurpleChild
        , ("comment" .=) <$> commentPurpleChild
        , ("defaultValue" .=) <$> defaultValuePurpleChild
        , ("extendedBy" .=) <$> extendedByPurpleChild
        , ("extendedTypes" .=) <$> extendedTypesPurpleChild
        , Just $ "flags" .= flagsPurpleChild
        , ("groups" .=) <$> groupsPurpleChild
        , ("implementedBy" .=) <$> implementedByPurpleChild
        , ("implementedTypes" .=) <$> implementedTypesPurpleChild
        , Just $ "kind" .= kindPurpleChild
        , Just $ "kindString" .= kindStringPurpleChild
        , Just $ "name" .= namePurpleChild
        , ("signatures" .=) <$> signaturesPurpleChild
        , Just $ "sources" .= sourcesPurpleChild
        , ("typeParameter" .=) <$> typeParameterPurpleChild
        ]

instance FromJSON PurpleChild where
    parseJSON (Object v) = PurpleChild
        <$> v .: "id"
        <*> v .:! "type"
        <*> v .:! "children"
        <*> v .:! "comment"
        <*> v .:! "defaultValue"
        <*> v .:! "extendedBy"
        <*> v .:! "extendedTypes"
        <*> v .: "flags"
        <*> v .:! "groups"
        <*> v .:! "implementedBy"
        <*> v .:! "implementedTypes"
        <*> v .: "kind"
        <*> v .: "kindString"
        <*> v .: "name"
        <*> v .:! "signatures"
        <*> v .: "sources"
        <*> v .:! "typeParameter"

instance ToJSON MagentaType where
    toJSON (MagentaType declarationMagentaType elementTypeMagentaType elementsMagentaType nameMagentaType typeArgumentsMagentaType typeIDMagentaType typeTypeMagentaType typesMagentaType valueMagentaType) =
        object $ foldMap (maybe [] pure)
        [ ("declaration" .=) <$> declarationMagentaType
        , ("elementType" .=) <$> elementTypeMagentaType
        , ("elements" .=) <$> elementsMagentaType
        , ("name" .=) <$> nameMagentaType
        , ("typeArguments" .=) <$> typeArgumentsMagentaType
        , ("id" .=) <$> typeIDMagentaType
        , Just $ "type" .= typeTypeMagentaType
        , ("types" .=) <$> typesMagentaType
        , ("value" .=) <$> valueMagentaType
        ]

instance FromJSON MagentaType where
    parseJSON (Object v) = MagentaType
        <$> v .:! "declaration"
        <*> v .:! "elementType"
        <*> v .:! "elements"
        <*> v .:! "name"
        <*> v .:! "typeArguments"
        <*> v .:! "id"
        <*> v .: "type"
        <*> v .:! "types"
        <*> v .:! "value"

instance ToJSON StickyDeclaration where
    toJSON (StickyDeclaration childrenStickyDeclaration declarationIDStickyDeclaration flagsStickyDeclaration groupsStickyDeclaration kindStickyDeclaration kindStringStickyDeclaration nameStickyDeclaration signaturesStickyDeclaration sourcesStickyDeclaration) =
        object $ foldMap (maybe [] pure)
        [ ("children" .=) <$> childrenStickyDeclaration
        , Just $ "id" .= declarationIDStickyDeclaration
        , Just $ "flags" .= flagsStickyDeclaration
        , ("groups" .=) <$> groupsStickyDeclaration
        , Just $ "kind" .= kindStickyDeclaration
        , Just $ "kindString" .= kindStringStickyDeclaration
        , Just $ "name" .= nameStickyDeclaration
        , Just $ "signatures" .= signaturesStickyDeclaration
        , Just $ "sources" .= sourcesStickyDeclaration
        ]

instance FromJSON StickyDeclaration where
    parseJSON (Object v) = StickyDeclaration
        <$> v .:! "children"
        <*> v .: "id"
        <*> v .: "flags"
        <*> v .:! "groups"
        <*> v .: "kind"
        <*> v .: "kindString"
        <*> v .: "name"
        <*> v .: "signatures"
        <*> v .: "sources"

instance ToJSON IndecentChild where
    toJSON (IndecentChild childIDIndecentChild childTypeIndecentChild flagsIndecentChild kindIndecentChild kindStringIndecentChild nameIndecentChild sourcesIndecentChild) =
        object $ foldMap (maybe [] pure)
        [ Just $ "id" .= childIDIndecentChild
        , Just $ "type" .= childTypeIndecentChild
        , Just $ "flags" .= flagsIndecentChild
        , Just $ "kind" .= kindIndecentChild
        , Just $ "kindString" .= kindStringIndecentChild
        , Just $ "name" .= nameIndecentChild
        , Just $ "sources" .= sourcesIndecentChild
        ]

instance FromJSON IndecentChild where
    parseJSON (Object v) = IndecentChild
        <$> v .: "id"
        <*> v .: "type"
        <*> v .: "flags"
        <*> v .: "kind"
        <*> v .: "kindString"
        <*> v .: "name"
        <*> v .: "sources"

instance ToJSON FriskyType where
    toJSON (FriskyType declarationFriskyType nameFriskyType typeTypeFriskyType) =
        object $ foldMap (maybe [] pure)
        [ ("declaration" .=) <$> declarationFriskyType
        , ("name" .=) <$> nameFriskyType
        , Just $ "type" .= typeTypeFriskyType
        ]

instance FromJSON FriskyType where
    parseJSON (Object v) = FriskyType
        <$> v .:! "declaration"
        <*> v .:! "name"
        <*> v .: "type"

instance ToJSON IndigoDeclaration where
    toJSON (IndigoDeclaration childrenIndigoDeclaration declarationIDIndigoDeclaration flagsIndigoDeclaration groupsIndigoDeclaration kindIndigoDeclaration kindStringIndigoDeclaration nameIndigoDeclaration signaturesIndigoDeclaration sourcesIndigoDeclaration) =
        object $ foldMap (maybe [] pure)
        [ ("children" .=) <$> childrenIndigoDeclaration
        , Just $ "id" .= declarationIDIndigoDeclaration
        , Just $ "flags" .= flagsIndigoDeclaration
        , ("groups" .=) <$> groupsIndigoDeclaration
        , Just $ "kind" .= kindIndigoDeclaration
        , Just $ "kindString" .= kindStringIndigoDeclaration
        , Just $ "name" .= nameIndigoDeclaration
        , ("signatures" .=) <$> signaturesIndigoDeclaration
        , Just $ "sources" .= sourcesIndigoDeclaration
        ]

instance FromJSON IndigoDeclaration where
    parseJSON (Object v) = IndigoDeclaration
        <$> v .:! "children"
        <*> v .: "id"
        <*> v .: "flags"
        <*> v .:! "groups"
        <*> v .: "kind"
        <*> v .: "kindString"
        <*> v .: "name"
        <*> v .:! "signatures"
        <*> v .: "sources"

instance ToJSON IndexSignatureElement where
    toJSON (IndexSignatureElement flagsIndexSignatureElement kindIndexSignatureElement kindStringIndexSignatureElement nameIndexSignatureElement parametersIndexSignatureElement signatureIDIndexSignatureElement signatureTypeIndexSignatureElement) =
        object $ foldMap (maybe [] pure)
        [ Just $ "flags" .= flagsIndexSignatureElement
        , Just $ "kind" .= kindIndexSignatureElement
        , Just $ "kindString" .= kindStringIndexSignatureElement
        , Just $ "name" .= nameIndexSignatureElement
        , ("parameters" .=) <$> parametersIndexSignatureElement
        , Just $ "id" .= signatureIDIndexSignatureElement
        , Just $ "type" .= signatureTypeIndexSignatureElement
        ]

instance FromJSON IndexSignatureElement where
    parseJSON (Object v) = IndexSignatureElement
        <$> v .: "flags"
        <*> v .: "kind"
        <*> v .: "kindString"
        <*> v .: "name"
        <*> v .:! "parameters"
        <*> v .: "id"
        <*> v .: "type"

instance ToJSON GetSignatureType where
    toJSON (GetSignatureType declarationGetSignatureType elementTypeGetSignatureType nameGetSignatureType typeTypeGetSignatureType) =
        object $ foldMap (maybe [] pure)
        [ ("declaration" .=) <$> declarationGetSignatureType
        , ("elementType" .=) <$> elementTypeGetSignatureType
        , ("name" .=) <$> nameGetSignatureType
        , Just $ "type" .= typeTypeGetSignatureType
        ]

instance FromJSON GetSignatureType where
    parseJSON (Object v) = GetSignatureType
        <$> v .:! "declaration"
        <*> v .:! "elementType"
        <*> v .:! "name"
        <*> v .: "type"

instance ToJSON PurpleType where
    toJSON (PurpleType declarationPurpleType namePurpleType typeTypePurpleType) =
        object $ foldMap (maybe [] pure)
        [ ("declaration" .=) <$> declarationPurpleType
        , ("name" .=) <$> namePurpleType
        , Just $ "type" .= typeTypePurpleType
        ]

instance FromJSON PurpleType where
    parseJSON (Object v) = PurpleType
        <$> v .:! "declaration"
        <*> v .:! "name"
        <*> v .: "type"

instance ToJSON GetSignatureChild where
    toJSON (GetSignatureChild childIDGetSignatureChild childTypeGetSignatureChild commentGetSignatureChild flagsGetSignatureChild kindGetSignatureChild kindStringGetSignatureChild nameGetSignatureChild sourcesGetSignatureChild) =
        object $ foldMap (maybe [] pure)
        [ Just $ "id" .= childIDGetSignatureChild
        , Just $ "type" .= childTypeGetSignatureChild
        , ("comment" .=) <$> commentGetSignatureChild
        , Just $ "flags" .= flagsGetSignatureChild
        , Just $ "kind" .= kindGetSignatureChild
        , Just $ "kindString" .= kindStringGetSignatureChild
        , Just $ "name" .= nameGetSignatureChild
        , Just $ "sources" .= sourcesGetSignatureChild
        ]

instance FromJSON GetSignatureChild where
    parseJSON (Object v) = GetSignatureChild
        <$> v .: "id"
        <*> v .: "type"
        <*> v .:! "comment"
        <*> v .: "flags"
        <*> v .: "kind"
        <*> v .: "kindString"
        <*> v .: "name"
        <*> v .: "sources"

instance ToJSON GetSignature where
    toJSON (GetSignature childrenGetSignature commentGetSignature defaultValueGetSignature flagsGetSignature getSignatureIDGetSignature getSignatureTypeGetSignature groupsGetSignature kindGetSignature kindStringGetSignature nameGetSignature parametersGetSignature signaturesGetSignature sourcesGetSignature typeParameterGetSignature) =
        object $ foldMap (maybe [] pure)
        [ ("children" .=) <$> childrenGetSignature
        , ("comment" .=) <$> commentGetSignature
        , ("defaultValue" .=) <$> defaultValueGetSignature
        , Just $ "flags" .= flagsGetSignature
        , Just $ "id" .= getSignatureIDGetSignature
        , ("type" .=) <$> getSignatureTypeGetSignature
        , ("groups" .=) <$> groupsGetSignature
        , Just $ "kind" .= kindGetSignature
        , Just $ "kindString" .= kindStringGetSignature
        , Just $ "name" .= nameGetSignature
        , ("parameters" .=) <$> parametersGetSignature
        , ("signatures" .=) <$> signaturesGetSignature
        , ("sources" .=) <$> sourcesGetSignature
        , ("typeParameter" .=) <$> typeParameterGetSignature
        ]

instance FromJSON GetSignature where
    parseJSON (Object v) = GetSignature
        <$> v .:! "children"
        <*> v .:! "comment"
        <*> v .:! "defaultValue"
        <*> v .: "flags"
        <*> v .: "id"
        <*> v .:! "type"
        <*> v .:! "groups"
        <*> v .: "kind"
        <*> v .: "kindString"
        <*> v .: "name"
        <*> v .:! "parameters"
        <*> v .:! "signatures"
        <*> v .:! "sources"
        <*> v .:! "typeParameter"

instance ToJSON GetSignatureFlags where
    toJSON = \_ -> emptyObject

instance FromJSON GetSignatureFlags where
    parseJSON (Object _) = return GetSignatureFlags

instance ToJSON ElementType where
    toJSON (ElementType elementTypeTypeElementType nameElementType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "type" .= elementTypeTypeElementType
        , Just $ "name" .= nameElementType
        ]

instance FromJSON ElementType where
    parseJSON (Object v) = ElementType
        <$> v .: "type"
        <*> v .: "name"

instance ToJSON TypeEnum where
    toJSON IntrinsicTypeEnum = "intrinsic"
    toJSON ReflectionTypeEnum = "reflection"
    toJSON ArrayTypeEnum = "array"
    toJSON ReferenceTypeEnum = "reference"
    toJSON TypeParameterTypeEnum = "typeParameter"
    toJSON TupleTypeEnum = "tuple"
    toJSON UnionTypeEnum = "union"
    toJSON StringLiteralTypeEnum = "stringLiteral"

instance FromJSON TypeEnum where
    parseJSON = withText "TypeEnum" parseText
        where
            parseText "intrinsic" = return IntrinsicTypeEnum
            parseText "reflection" = return ReflectionTypeEnum
            parseText "array" = return ArrayTypeEnum
            parseText "reference" = return ReferenceTypeEnum
            parseText "typeParameter" = return TypeParameterTypeEnum
            parseText "tuple" = return TupleTypeEnum
            parseText "union" = return UnionTypeEnum
            parseText "stringLiteral" = return StringLiteralTypeEnum

instance ToJSON Name where
    toJSON StringName = "string"
    toJSON NumberName = "number"
    toJSON VoidName = "void"
    toJSON TName = "T"
    toJSON BooleanName = "boolean"
    toJSON BaseClassName = "BaseClass"
    toJSON AnyName = "any"
    toJSON ArrayName = "Array"
    toJSON MyNumberName = "MyNumber"

instance FromJSON Name where
    parseJSON = withText "Name" parseText
        where
            parseText "string" = return StringName
            parseText "number" = return NumberName
            parseText "void" = return VoidName
            parseText "T" = return TName
            parseText "boolean" = return BooleanName
            parseText "BaseClass" = return BaseClassName
            parseText "any" = return AnyName
            parseText "Array" = return ArrayName
            parseText "MyNumber" = return MyNumberName

instance ToJSON FluffyComment where
    toJSON (FluffyComment commentTextFluffyComment) =
        object $ foldMap (maybe [] pure)
        [ Just $ "text" .= commentTextFluffyComment
        ]

instance FromJSON FluffyComment where
    parseJSON (Object v) = FluffyComment
        <$> v .: "text"

instance ToJSON FluffyFlags where
    toJSON (FluffyFlags isOptionalFluffyFlags) =
        object $ foldMap (maybe [] pure)
        [ ("isOptional" .=) <$> isOptionalFluffyFlags
        ]

instance FromJSON FluffyFlags where
    parseJSON (Object v) = FluffyFlags
        <$> v .:! "isOptional"

instance ToJSON PurpleKindString where
    toJSON VariablePurpleKindString = "Variable"
    toJSON FunctionPurpleKindString = "Function"
    toJSON PropertyPurpleKindString = "Property"
    toJSON MethodPurpleKindString = "Method"
    toJSON ConstructorPurpleKindString = "Constructor"
    toJSON AccessorPurpleKindString = "Accessor"
    toJSON EnumerationMemberPurpleKindString = "Enumeration member"
    toJSON ModulePurpleKindString = "Module"
    toJSON ObjectLiteralPurpleKindString = "Object literal"

instance FromJSON PurpleKindString where
    parseJSON = withText "PurpleKindString" parseText
        where
            parseText "Variable" = return VariablePurpleKindString
            parseText "Function" = return FunctionPurpleKindString
            parseText "Property" = return PropertyPurpleKindString
            parseText "Method" = return MethodPurpleKindString
            parseText "Constructor" = return ConstructorPurpleKindString
            parseText "Accessor" = return AccessorPurpleKindString
            parseText "Enumeration member" = return EnumerationMemberPurpleKindString
            parseText "Module" = return ModulePurpleKindString
            parseText "Object literal" = return ObjectLiteralPurpleKindString

instance ToJSON Source where
    toJSON (Source characterSource fileNameSource lineSource) =
        object $ foldMap (maybe [] pure)
        [ Just $ "character" .= characterSource
        , Just $ "fileName" .= fileNameSource
        , Just $ "line" .= lineSource
        ]

instance FromJSON Source where
    parseJSON (Object v) = Source
        <$> v .: "character"
        <*> v .: "fileName"
        <*> v .: "line"

instance ToJSON FileName where
    toJSON ModulesTsFileName = "modules.ts"
    toJSON ClassesTsFileName = "classes.ts"
    toJSON FlattenedTsFileName = "flattened.ts"
    toJSON AccessTsFileName = "access.ts"
    toJSON DefaultExportTsFileName = "default-export.ts"
    toJSON EnumerationsTsFileName = "enumerations.ts"
    toJSON FunctionsTsFileName = "functions.ts"
    toJSON GenericsTsFileName = "generics.ts"
    toJSON SingleExportTsFileName = "single-export.ts"
    toJSON Typescript13TsFileName = "typescript-1.3.ts"
    toJSON Typescript14TsFileName = "typescript-1.4.ts"
    toJSON Typescript15TsFileName = "typescript-1.5.ts"
    toJSON VariablesTsFileName = "variables.ts"

instance FromJSON FileName where
    parseJSON = withText "FileName" parseText
        where
            parseText "modules.ts" = return ModulesTsFileName
            parseText "classes.ts" = return ClassesTsFileName
            parseText "flattened.ts" = return FlattenedTsFileName
            parseText "access.ts" = return AccessTsFileName
            parseText "default-export.ts" = return DefaultExportTsFileName
            parseText "enumerations.ts" = return EnumerationsTsFileName
            parseText "functions.ts" = return FunctionsTsFileName
            parseText "generics.ts" = return GenericsTsFileName
            parseText "single-export.ts" = return SingleExportTsFileName
            parseText "typescript-1.3.ts" = return Typescript13TsFileName
            parseText "typescript-1.4.ts" = return Typescript14TsFileName
            parseText "typescript-1.5.ts" = return Typescript15TsFileName
            parseText "variables.ts" = return VariablesTsFileName

instance ToJSON GetSignatureComment where
    toJSON (GetSignatureComment commentTextGetSignatureComment returnsGetSignatureComment shortTextGetSignatureComment) =
        object $ foldMap (maybe [] pure)
        [ ("text" .=) <$> commentTextGetSignatureComment
        , ("returns" .=) <$> returnsGetSignatureComment
        , ("shortText" .=) <$> shortTextGetSignatureComment
        ]

instance FromJSON GetSignatureComment where
    parseJSON (Object v) = GetSignatureComment
        <$> v .:! "text"
        <*> v .:! "returns"
        <*> v .:! "shortText"

instance ToJSON Group where
    toJSON (Group childrenGroup kindGroup titleGroup) =
        object $ foldMap (maybe [] pure)
        [ Just $ "children" .= childrenGroup
        , Just $ "kind" .= kindGroup
        , Just $ "title" .= titleGroup
        ]

instance FromJSON Group where
    parseJSON (Object v) = Group
        <$> v .: "children"
        <*> v .: "kind"
        <*> v .: "title"

instance ToJSON GetSignatureParameter where
    toJSON (GetSignatureParameter commentGetSignatureParameter flagsGetSignatureParameter kindGetSignatureParameter kindStringGetSignatureParameter nameGetSignatureParameter parameterIDGetSignatureParameter parameterTypeGetSignatureParameter) =
        object $ foldMap (maybe [] pure)
        [ ("comment" .=) <$> commentGetSignatureParameter
        , Just $ "flags" .= flagsGetSignatureParameter
        , Just $ "kind" .= kindGetSignatureParameter
        , Just $ "kindString" .= kindStringGetSignatureParameter
        , Just $ "name" .= nameGetSignatureParameter
        , Just $ "id" .= parameterIDGetSignatureParameter
        , Just $ "type" .= parameterTypeGetSignatureParameter
        ]

instance FromJSON GetSignatureParameter where
    parseJSON (Object v) = GetSignatureParameter
        <$> v .:! "comment"
        <*> v .: "flags"
        <*> v .: "kind"
        <*> v .: "kindString"
        <*> v .: "name"
        <*> v .: "id"
        <*> v .: "type"

instance ToJSON TentacledComment where
    toJSON (TentacledComment commentTextTentacledComment shortTextTentacledComment) =
        object $ foldMap (maybe [] pure)
        [ ("text" .=) <$> commentTextTentacledComment
        , ("shortText" .=) <$> shortTextTentacledComment
        ]

instance FromJSON TentacledComment where
    parseJSON (Object v) = TentacledComment
        <$> v .:! "text"
        <*> v .:! "shortText"

instance ToJSON TentacledFlags where
    toJSON (TentacledFlags isOptionalTentacledFlags isRESTTentacledFlags) =
        object $ foldMap (maybe [] pure)
        [ ("isOptional" .=) <$> isOptionalTentacledFlags
        , ("isRest" .=) <$> isRESTTentacledFlags
        ]

instance FromJSON TentacledFlags where
    parseJSON (Object v) = TentacledFlags
        <$> v .:! "isOptional"
        <*> v .:! "isRest"

instance ToJSON ParameterKindString where
    toJSON ParameterParameterKindString = "Parameter"

instance FromJSON ParameterKindString where
    parseJSON = withText "ParameterKindString" parseText
        where
            parseText "Parameter" = return ParameterParameterKindString

instance ToJSON FluffyType where
    toJSON (FluffyType elementTypeFluffyType nameFluffyType typeArgumentsFluffyType typeTypeFluffyType) =
        object $ foldMap (maybe [] pure)
        [ ("elementType" .=) <$> elementTypeFluffyType
        , ("name" .=) <$> nameFluffyType
        , ("typeArguments" .=) <$> typeArgumentsFluffyType
        , Just $ "type" .= typeTypeFluffyType
        ]

instance FromJSON FluffyType where
    parseJSON (Object v) = FluffyType
        <$> v .:! "elementType"
        <*> v .:! "name"
        <*> v .:! "typeArguments"
        <*> v .: "type"

instance ToJSON ExtendedBy where
    toJSON (ExtendedBy constraintExtendedBy extendedByIDExtendedBy extendedByTypeExtendedBy nameExtendedBy typeArgumentsExtendedBy) =
        object $ foldMap (maybe [] pure)
        [ ("constraint" .=) <$> constraintExtendedBy
        , ("id" .=) <$> extendedByIDExtendedBy
        , Just $ "type" .= extendedByTypeExtendedBy
        , Just $ "name" .= nameExtendedBy
        , ("typeArguments" .=) <$> typeArgumentsExtendedBy
        ]

instance FromJSON ExtendedBy where
    parseJSON (Object v) = ExtendedBy
        <$> v .:! "constraint"
        <*> v .:! "id"
        <*> v .: "type"
        <*> v .: "name"
        <*> v .:! "typeArguments"

instance ToJSON FluffyTypeArgument where
    toJSON (FluffyTypeArgument typeArgumentTypeFluffyTypeArgument typesFluffyTypeArgument) =
        object $ foldMap (maybe [] pure)
        [ Just $ "type" .= typeArgumentTypeFluffyTypeArgument
        , Just $ "types" .= typesFluffyTypeArgument
        ]

instance FromJSON FluffyTypeArgument where
    parseJSON (Object v) = FluffyTypeArgument
        <$> v .: "type"
        <*> v .: "types"

instance ToJSON FluffyChild where
    toJSON (FluffyChild childIDFluffyChild childTypeFluffyChild childrenFluffyChild commentFluffyChild defaultValueFluffyChild flagsFluffyChild getSignatureFluffyChild groupsFluffyChild implementationOfFluffyChild inheritedFromFluffyChild kindFluffyChild kindStringFluffyChild nameFluffyChild overwritesFluffyChild setSignatureFluffyChild signaturesFluffyChild sourcesFluffyChild) =
        object $ foldMap (maybe [] pure)
        [ Just $ "id" .= childIDFluffyChild
        , ("type" .=) <$> childTypeFluffyChild
        , ("children" .=) <$> childrenFluffyChild
        , ("comment" .=) <$> commentFluffyChild
        , ("defaultValue" .=) <$> defaultValueFluffyChild
        , Just $ "flags" .= flagsFluffyChild
        , ("getSignature" .=) <$> getSignatureFluffyChild
        , ("groups" .=) <$> groupsFluffyChild
        , ("implementationOf" .=) <$> implementationOfFluffyChild
        , ("inheritedFrom" .=) <$> inheritedFromFluffyChild
        , Just $ "kind" .= kindFluffyChild
        , Just $ "kindString" .= kindStringFluffyChild
        , Just $ "name" .= nameFluffyChild
        , ("overwrites" .=) <$> overwritesFluffyChild
        , ("setSignature" .=) <$> setSignatureFluffyChild
        , ("signatures" .=) <$> signaturesFluffyChild
        , Just $ "sources" .= sourcesFluffyChild
        ]

instance FromJSON FluffyChild where
    parseJSON (Object v) = FluffyChild
        <$> v .: "id"
        <*> v .:! "type"
        <*> v .:! "children"
        <*> v .:! "comment"
        <*> v .:! "defaultValue"
        <*> v .: "flags"
        <*> v .:! "getSignature"
        <*> v .:! "groups"
        <*> v .:! "implementationOf"
        <*> v .:! "inheritedFrom"
        <*> v .: "kind"
        <*> v .: "kindString"
        <*> v .: "name"
        <*> v .:! "overwrites"
        <*> v .:! "setSignature"
        <*> v .:! "signatures"
        <*> v .: "sources"

instance ToJSON IndigoType where
    toJSON (IndigoType constraintIndigoType declarationIndigoType elementTypeIndigoType elementsIndigoType nameIndigoType typeArgumentsIndigoType typeIDIndigoType typeTypeIndigoType typesIndigoType) =
        object $ foldMap (maybe [] pure)
        [ ("constraint" .=) <$> constraintIndigoType
        , ("declaration" .=) <$> declarationIndigoType
        , ("elementType" .=) <$> elementTypeIndigoType
        , ("elements" .=) <$> elementsIndigoType
        , ("name" .=) <$> nameIndigoType
        , ("typeArguments" .=) <$> typeArgumentsIndigoType
        , ("id" .=) <$> typeIDIndigoType
        , Just $ "type" .= typeTypeIndigoType
        , ("types" .=) <$> typesIndigoType
        ]

instance FromJSON IndigoType where
    parseJSON (Object v) = IndigoType
        <$> v .:! "constraint"
        <*> v .:! "declaration"
        <*> v .:! "elementType"
        <*> v .:! "elements"
        <*> v .:! "name"
        <*> v .:! "typeArguments"
        <*> v .:! "id"
        <*> v .: "type"
        <*> v .:! "types"

instance ToJSON FluffyDeclaration where
    toJSON (FluffyDeclaration childrenFluffyDeclaration declarationIDFluffyDeclaration flagsFluffyDeclaration groupsFluffyDeclaration indexSignatureFluffyDeclaration kindFluffyDeclaration kindStringFluffyDeclaration nameFluffyDeclaration signaturesFluffyDeclaration sourcesFluffyDeclaration) =
        object $ foldMap (maybe [] pure)
        [ ("children" .=) <$> childrenFluffyDeclaration
        , Just $ "id" .= declarationIDFluffyDeclaration
        , Just $ "flags" .= flagsFluffyDeclaration
        , ("groups" .=) <$> groupsFluffyDeclaration
        , ("indexSignature" .=) <$> indexSignatureFluffyDeclaration
        , Just $ "kind" .= kindFluffyDeclaration
        , Just $ "kindString" .= kindStringFluffyDeclaration
        , Just $ "name" .= nameFluffyDeclaration
        , ("signatures" .=) <$> signaturesFluffyDeclaration
        , Just $ "sources" .= sourcesFluffyDeclaration
        ]

instance FromJSON FluffyDeclaration where
    parseJSON (Object v) = FluffyDeclaration
        <$> v .:! "children"
        <*> v .: "id"
        <*> v .: "flags"
        <*> v .:! "groups"
        <*> v .:! "indexSignature"
        <*> v .: "kind"
        <*> v .: "kindString"
        <*> v .: "name"
        <*> v .:! "signatures"
        <*> v .: "sources"

instance ToJSON StickyChild where
    toJSON (StickyChild childIDStickyChild childTypeStickyChild commentStickyChild flagsStickyChild kindStickyChild kindStringStickyChild nameStickyChild sourcesStickyChild) =
        object $ foldMap (maybe [] pure)
        [ Just $ "id" .= childIDStickyChild
        , Just $ "type" .= childTypeStickyChild
        , ("comment" .=) <$> commentStickyChild
        , Just $ "flags" .= flagsStickyChild
        , Just $ "kind" .= kindStickyChild
        , Just $ "kindString" .= kindStringStickyChild
        , Just $ "name" .= nameStickyChild
        , Just $ "sources" .= sourcesStickyChild
        ]

instance FromJSON StickyChild where
    parseJSON (Object v) = StickyChild
        <$> v .: "id"
        <*> v .: "type"
        <*> v .:! "comment"
        <*> v .: "flags"
        <*> v .: "kind"
        <*> v .: "kindString"
        <*> v .: "name"
        <*> v .: "sources"

instance ToJSON IndecentType where
    toJSON (IndecentType declarationIndecentType elementsIndecentType nameIndecentType typeTypeIndecentType) =
        object $ foldMap (maybe [] pure)
        [ ("declaration" .=) <$> declarationIndecentType
        , ("elements" .=) <$> elementsIndecentType
        , ("name" .=) <$> nameIndecentType
        , Just $ "type" .= typeTypeIndecentType
        ]

instance FromJSON IndecentType where
    parseJSON (Object v) = IndecentType
        <$> v .:! "declaration"
        <*> v .:! "elements"
        <*> v .:! "name"
        <*> v .: "type"

instance ToJSON IndexSignature where
    toJSON (IndexSignature flagsIndexSignature indexSignatureIDIndexSignature indexSignatureTypeIndexSignature kindIndexSignature kindStringIndexSignature nameIndexSignature parametersIndexSignature) =
        object $ foldMap (maybe [] pure)
        [ Just $ "flags" .= flagsIndexSignature
        , Just $ "id" .= indexSignatureIDIndexSignature
        , Just $ "type" .= indexSignatureTypeIndexSignature
        , Just $ "kind" .= kindIndexSignature
        , Just $ "kindString" .= kindStringIndexSignature
        , Just $ "name" .= nameIndexSignature
        , Just $ "parameters" .= parametersIndexSignature
        ]

instance FromJSON IndexSignature where
    parseJSON (Object v) = IndexSignature
        <$> v .: "flags"
        <*> v .: "id"
        <*> v .: "type"
        <*> v .: "kind"
        <*> v .: "kindString"
        <*> v .: "name"
        <*> v .: "parameters"

instance ToJSON HilariousType where
    toJSON (HilariousType declarationHilariousType typeTypeHilariousType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "declaration" .= declarationHilariousType
        , Just $ "type" .= typeTypeHilariousType
        ]

instance FromJSON HilariousType where
    parseJSON (Object v) = HilariousType
        <$> v .: "declaration"
        <*> v .: "type"

instance ToJSON TentacledSignature where
    toJSON (TentacledSignature commentTentacledSignature flagsTentacledSignature kindTentacledSignature kindStringTentacledSignature nameTentacledSignature parametersTentacledSignature signatureIDTentacledSignature signatureTypeTentacledSignature) =
        object $ foldMap (maybe [] pure)
        [ ("comment" .=) <$> commentTentacledSignature
        , Just $ "flags" .= flagsTentacledSignature
        , Just $ "kind" .= kindTentacledSignature
        , Just $ "kindString" .= kindStringTentacledSignature
        , Just $ "name" .= nameTentacledSignature
        , ("parameters" .=) <$> parametersTentacledSignature
        , Just $ "id" .= signatureIDTentacledSignature
        , Just $ "type" .= signatureTypeTentacledSignature
        ]

instance FromJSON TentacledSignature where
    parseJSON (Object v) = TentacledSignature
        <$> v .:! "comment"
        <*> v .: "flags"
        <*> v .: "kind"
        <*> v .: "kindString"
        <*> v .: "name"
        <*> v .:! "parameters"
        <*> v .: "id"
        <*> v .: "type"

instance ToJSON IndigoComment where
    toJSON (IndigoComment returnsIndigoComment shortTextIndigoComment) =
        object $ foldMap (maybe [] pure)
        [ Just $ "returns" .= returnsIndigoComment
        , Just $ "shortText" .= shortTextIndigoComment
        ]

instance FromJSON IndigoComment where
    parseJSON (Object v) = IndigoComment
        <$> v .: "returns"
        <*> v .: "shortText"

instance ToJSON SignatureKindString where
    toJSON CallSignatureSignatureKindString = "Call signature"
    toJSON ConstructorSignatureSignatureKindString = "Constructor signature"

instance FromJSON SignatureKindString where
    parseJSON = withText "SignatureKindString" parseText
        where
            parseText "Call signature" = return CallSignatureSignatureKindString
            parseText "Constructor signature" = return ConstructorSignatureSignatureKindString

instance ToJSON FluffyParameter where
    toJSON (FluffyParameter commentFluffyParameter flagsFluffyParameter kindFluffyParameter kindStringFluffyParameter nameFluffyParameter parameterIDFluffyParameter parameterTypeFluffyParameter sourcesFluffyParameter) =
        object $ foldMap (maybe [] pure)
        [ ("comment" .=) <$> commentFluffyParameter
        , Just $ "flags" .= flagsFluffyParameter
        , Just $ "kind" .= kindFluffyParameter
        , Just $ "kindString" .= kindStringFluffyParameter
        , Just $ "name" .= nameFluffyParameter
        , Just $ "id" .= parameterIDFluffyParameter
        , Just $ "type" .= parameterTypeFluffyParameter
        , ("sources" .=) <$> sourcesFluffyParameter
        ]

instance FromJSON FluffyParameter where
    parseJSON (Object v) = FluffyParameter
        <$> v .:! "comment"
        <*> v .: "flags"
        <*> v .: "kind"
        <*> v .: "kindString"
        <*> v .: "name"
        <*> v .: "id"
        <*> v .: "type"
        <*> v .:! "sources"

instance ToJSON PurpleTypeArgument where
    toJSON (PurpleTypeArgument operatorPurpleTypeArgument targetPurpleTypeArgument typeArgumentTypePurpleTypeArgument) =
        object $ foldMap (maybe [] pure)
        [ Just $ "operator" .= operatorPurpleTypeArgument
        , Just $ "target" .= targetPurpleTypeArgument
        , Just $ "type" .= typeArgumentTypePurpleTypeArgument
        ]

instance FromJSON PurpleTypeArgument where
    parseJSON (Object v) = PurpleTypeArgument
        <$> v .: "operator"
        <*> v .: "target"
        <*> v .: "type"

instance ToJSON TypeElement where
    toJSON (TypeElement declarationTypeElement elementTypeTypeElement nameTypeElement typeArgumentsTypeElement typeTypeTypeElement) =
        object $ foldMap (maybe [] pure)
        [ ("declaration" .=) <$> declarationTypeElement
        , ("elementType" .=) <$> elementTypeTypeElement
        , ("name" .=) <$> nameTypeElement
        , ("typeArguments" .=) <$> typeArgumentsTypeElement
        , Just $ "type" .= typeTypeTypeElement
        ]

instance FromJSON TypeElement where
    parseJSON (Object v) = TypeElement
        <$> v .:! "declaration"
        <*> v .:! "elementType"
        <*> v .:! "name"
        <*> v .:! "typeArguments"
        <*> v .: "type"

instance ToJSON TentacledChild where
    toJSON (TentacledChild childIDTentacledChild childTypeTentacledChild commentTentacledChild defaultValueTentacledChild flagsTentacledChild kindTentacledChild kindStringTentacledChild nameTentacledChild signaturesTentacledChild sourcesTentacledChild) =
        object $ foldMap (maybe [] pure)
        [ Just $ "id" .= childIDTentacledChild
        , ("type" .=) <$> childTypeTentacledChild
        , ("comment" .=) <$> commentTentacledChild
        , ("defaultValue" .=) <$> defaultValueTentacledChild
        , Just $ "flags" .= flagsTentacledChild
        , Just $ "kind" .= kindTentacledChild
        , Just $ "kindString" .= kindStringTentacledChild
        , Just $ "name" .= nameTentacledChild
        , ("signatures" .=) <$> signaturesTentacledChild
        , Just $ "sources" .= sourcesTentacledChild
        ]

instance FromJSON TentacledChild where
    parseJSON (Object v) = TentacledChild
        <$> v .: "id"
        <*> v .:! "type"
        <*> v .:! "comment"
        <*> v .:! "defaultValue"
        <*> v .: "flags"
        <*> v .: "kind"
        <*> v .: "kindString"
        <*> v .: "name"
        <*> v .:! "signatures"
        <*> v .: "sources"

instance ToJSON PurpleComment where
    toJSON (PurpleComment shortTextPurpleComment) =
        object $ foldMap (maybe [] pure)
        [ Just $ "shortText" .= shortTextPurpleComment
        ]

instance FromJSON PurpleComment where
    parseJSON (Object v) = PurpleComment
        <$> v .: "shortText"

instance ToJSON PurpleFlags where
    toJSON (PurpleFlags isExportedPurpleFlags) =
        object $ foldMap (maybe [] pure)
        [ ("isExported" .=) <$> isExportedPurpleFlags
        ]

instance FromJSON PurpleFlags where
    parseJSON (Object v) = PurpleFlags
        <$> v .:! "isExported"

instance ToJSON PurpleSignature where
    toJSON (PurpleSignature commentPurpleSignature flagsPurpleSignature kindPurpleSignature kindStringPurpleSignature namePurpleSignature parametersPurpleSignature signatureIDPurpleSignature signatureTypePurpleSignature) =
        object $ foldMap (maybe [] pure)
        [ ("comment" .=) <$> commentPurpleSignature
        , Just $ "flags" .= flagsPurpleSignature
        , Just $ "kind" .= kindPurpleSignature
        , Just $ "kindString" .= kindStringPurpleSignature
        , Just $ "name" .= namePurpleSignature
        , Just $ "parameters" .= parametersPurpleSignature
        , Just $ "id" .= signatureIDPurpleSignature
        , Just $ "type" .= signatureTypePurpleSignature
        ]

instance FromJSON PurpleSignature where
    parseJSON (Object v) = PurpleSignature
        <$> v .:! "comment"
        <*> v .: "flags"
        <*> v .: "kind"
        <*> v .: "kindString"
        <*> v .: "name"
        <*> v .: "parameters"
        <*> v .: "id"
        <*> v .: "type"

instance ToJSON TentacledType where
    toJSON (TentacledType declarationTentacledType nameTentacledType typeTypeTentacledType) =
        object $ foldMap (maybe [] pure)
        [ ("declaration" .=) <$> declarationTentacledType
        , ("name" .=) <$> nameTentacledType
        , Just $ "type" .= typeTypeTentacledType
        ]

instance FromJSON TentacledType where
    parseJSON (Object v) = TentacledType
        <$> v .:! "declaration"
        <*> v .:! "name"
        <*> v .: "type"

instance ToJSON PurpleDeclaration where
    toJSON (PurpleDeclaration childrenPurpleDeclaration declarationIDPurpleDeclaration flagsPurpleDeclaration groupsPurpleDeclaration kindPurpleDeclaration kindStringPurpleDeclaration namePurpleDeclaration) =
        object $ foldMap (maybe [] pure)
        [ Just $ "children" .= childrenPurpleDeclaration
        , Just $ "id" .= declarationIDPurpleDeclaration
        , Just $ "flags" .= flagsPurpleDeclaration
        , Just $ "groups" .= groupsPurpleDeclaration
        , Just $ "kind" .= kindPurpleDeclaration
        , Just $ "kindString" .= kindStringPurpleDeclaration
        , Just $ "name" .= namePurpleDeclaration
        ]

instance FromJSON PurpleDeclaration where
    parseJSON (Object v) = PurpleDeclaration
        <$> v .: "children"
        <*> v .: "id"
        <*> v .: "flags"
        <*> v .: "groups"
        <*> v .: "kind"
        <*> v .: "kindString"
        <*> v .: "name"

instance ToJSON StickyComment where
    toJSON (StickyComment commentTextStickyComment returnsStickyComment shortTextStickyComment tagsStickyComment) =
        object $ foldMap (maybe [] pure)
        [ ("text" .=) <$> commentTextStickyComment
        , ("returns" .=) <$> returnsStickyComment
        , ("shortText" .=) <$> shortTextStickyComment
        , ("tags" .=) <$> tagsStickyComment
        ]

instance FromJSON StickyComment where
    parseJSON (Object v) = StickyComment
        <$> v .:! "text"
        <*> v .:! "returns"
        <*> v .:! "shortText"
        <*> v .:! "tags"

instance ToJSON Tag where
    toJSON (Tag tagTag tagTextTag) =
        object $ foldMap (maybe [] pure)
        [ Just $ "tag" .= tagTag
        , Just $ "text" .= tagTextTag
        ]

instance FromJSON Tag where
    parseJSON (Object v) = Tag
        <$> v .: "tag"
        <*> v .: "text"

instance ToJSON StickyFlags where
    toJSON (StickyFlags isAbstractStickyFlags isConstructorPropertyStickyFlags isExportedStickyFlags isPrivateStickyFlags isProtectedStickyFlags isPublicStickyFlags isStaticStickyFlags) =
        object $ foldMap (maybe [] pure)
        [ ("isAbstract" .=) <$> isAbstractStickyFlags
        , ("isConstructorProperty" .=) <$> isConstructorPropertyStickyFlags
        , ("isExported" .=) <$> isExportedStickyFlags
        , ("isPrivate" .=) <$> isPrivateStickyFlags
        , ("isProtected" .=) <$> isProtectedStickyFlags
        , ("isPublic" .=) <$> isPublicStickyFlags
        , ("isStatic" .=) <$> isStaticStickyFlags
        ]

instance FromJSON StickyFlags where
    parseJSON (Object v) = StickyFlags
        <$> v .:! "isAbstract"
        <*> v .:! "isConstructorProperty"
        <*> v .:! "isExported"
        <*> v .:! "isPrivate"
        <*> v .:! "isProtected"
        <*> v .:! "isPublic"
        <*> v .:! "isStatic"

instance ToJSON FluffySignature where
    toJSON (FluffySignature commentFluffySignature flagsFluffySignature implementationOfFluffySignature inheritedFromFluffySignature kindFluffySignature kindStringFluffySignature nameFluffySignature overwritesFluffySignature parametersFluffySignature signatureIDFluffySignature signatureTypeFluffySignature typeParameterFluffySignature) =
        object $ foldMap (maybe [] pure)
        [ ("comment" .=) <$> commentFluffySignature
        , Just $ "flags" .= flagsFluffySignature
        , ("implementationOf" .=) <$> implementationOfFluffySignature
        , ("inheritedFrom" .=) <$> inheritedFromFluffySignature
        , Just $ "kind" .= kindFluffySignature
        , Just $ "kindString" .= kindStringFluffySignature
        , Just $ "name" .= nameFluffySignature
        , ("overwrites" .=) <$> overwritesFluffySignature
        , ("parameters" .=) <$> parametersFluffySignature
        , Just $ "id" .= signatureIDFluffySignature
        , Just $ "type" .= signatureTypeFluffySignature
        , ("typeParameter" .=) <$> typeParameterFluffySignature
        ]

instance FromJSON FluffySignature where
    parseJSON (Object v) = FluffySignature
        <$> v .:! "comment"
        <*> v .: "flags"
        <*> v .:! "implementationOf"
        <*> v .:! "inheritedFrom"
        <*> v .: "kind"
        <*> v .: "kindString"
        <*> v .: "name"
        <*> v .:! "overwrites"
        <*> v .:! "parameters"
        <*> v .: "id"
        <*> v .: "type"
        <*> v .:! "typeParameter"

instance ToJSON IndigoFlags where
    toJSON (IndigoFlags isPrivateIndigoFlags isProtectedIndigoFlags) =
        object $ foldMap (maybe [] pure)
        [ ("isPrivate" .=) <$> isPrivateIndigoFlags
        , ("isProtected" .=) <$> isProtectedIndigoFlags
        ]

instance FromJSON IndigoFlags where
    parseJSON (Object v) = IndigoFlags
        <$> v .:! "isPrivate"
        <*> v .:! "isProtected"

instance ToJSON PurpleParameter where
    toJSON (PurpleParameter commentPurpleParameter flagsPurpleParameter kindPurpleParameter kindStringPurpleParameter namePurpleParameter parameterIDPurpleParameter parameterTypePurpleParameter) =
        object $ foldMap (maybe [] pure)
        [ ("comment" .=) <$> commentPurpleParameter
        , Just $ "flags" .= flagsPurpleParameter
        , Just $ "kind" .= kindPurpleParameter
        , Just $ "kindString" .= kindStringPurpleParameter
        , Just $ "name" .= namePurpleParameter
        , Just $ "id" .= parameterIDPurpleParameter
        , Just $ "type" .= parameterTypePurpleParameter
        ]

instance FromJSON PurpleParameter where
    parseJSON (Object v) = PurpleParameter
        <$> v .:! "comment"
        <*> v .: "flags"
        <*> v .: "kind"
        <*> v .: "kindString"
        <*> v .: "name"
        <*> v .: "id"
        <*> v .: "type"

instance ToJSON StickyType where
    toJSON (StickyType constraintStickyType declarationStickyType elementTypeStickyType elementsStickyType nameStickyType typeArgumentsStickyType typeIDStickyType typeTypeStickyType) =
        object $ foldMap (maybe [] pure)
        [ ("constraint" .=) <$> constraintStickyType
        , ("declaration" .=) <$> declarationStickyType
        , ("elementType" .=) <$> elementTypeStickyType
        , ("elements" .=) <$> elementsStickyType
        , ("name" .=) <$> nameStickyType
        , ("typeArguments" .=) <$> typeArgumentsStickyType
        , ("id" .=) <$> typeIDStickyType
        , Just $ "type" .= typeTypeStickyType
        ]

instance FromJSON StickyType where
    parseJSON (Object v) = StickyType
        <$> v .:! "constraint"
        <*> v .:! "declaration"
        <*> v .:! "elementType"
        <*> v .:! "elements"
        <*> v .:! "name"
        <*> v .:! "typeArguments"
        <*> v .:! "id"
        <*> v .: "type"

instance ToJSON IndecentFlags where
    toJSON (IndecentFlags hasExportAssignmentIndecentFlags isAbstractIndecentFlags isConstIndecentFlags isExportedIndecentFlags isLetIndecentFlags isPrivateIndecentFlags isProtectedIndecentFlags) =
        object $ foldMap (maybe [] pure)
        [ ("hasExportAssignment" .=) <$> hasExportAssignmentIndecentFlags
        , ("isAbstract" .=) <$> isAbstractIndecentFlags
        , ("isConst" .=) <$> isConstIndecentFlags
        , ("isExported" .=) <$> isExportedIndecentFlags
        , ("isLet" .=) <$> isLetIndecentFlags
        , ("isPrivate" .=) <$> isPrivateIndecentFlags
        , ("isProtected" .=) <$> isProtectedIndecentFlags
        ]

instance FromJSON IndecentFlags where
    parseJSON (Object v) = IndecentFlags
        <$> v .:! "hasExportAssignment"
        <*> v .:! "isAbstract"
        <*> v .:! "isConst"
        <*> v .:! "isExported"
        <*> v .:! "isLet"
        <*> v .:! "isPrivate"
        <*> v .:! "isProtected"

instance ToJSON FluffyKindString where
    toJSON ModuleFluffyKindString = "Module"
    toJSON ClassFluffyKindString = "Class"
    toJSON VariableFluffyKindString = "Variable"
    toJSON FunctionFluffyKindString = "Function"
    toJSON InterfaceFluffyKindString = "Interface"
    toJSON EnumerationFluffyKindString = "Enumeration"
    toJSON ObjectLiteralFluffyKindString = "Object literal"
    toJSON TypeAliasFluffyKindString = "Type alias"

instance FromJSON FluffyKindString where
    parseJSON = withText "FluffyKindString" parseText
        where
            parseText "Module" = return ModuleFluffyKindString
            parseText "Class" = return ClassFluffyKindString
            parseText "Variable" = return VariableFluffyKindString
            parseText "Function" = return FunctionFluffyKindString
            parseText "Interface" = return InterfaceFluffyKindString
            parseText "Enumeration" = return EnumerationFluffyKindString
            parseText "Object literal" = return ObjectLiteralFluffyKindString
            parseText "Type alias" = return TypeAliasFluffyKindString

instance ToJSON StickySignature where
    toJSON (StickySignature commentStickySignature flagsStickySignature kindStickySignature kindStringStickySignature nameStickySignature parametersStickySignature signatureIDStickySignature signatureTypeStickySignature typeParameterStickySignature) =
        object $ foldMap (maybe [] pure)
        [ Just $ "comment" .= commentStickySignature
        , Just $ "flags" .= flagsStickySignature
        , Just $ "kind" .= kindStickySignature
        , Just $ "kindString" .= kindStringStickySignature
        , Just $ "name" .= nameStickySignature
        , ("parameters" .=) <$> parametersStickySignature
        , Just $ "id" .= signatureIDStickySignature
        , Just $ "type" .= signatureTypeStickySignature
        , ("typeParameter" .=) <$> typeParameterStickySignature
        ]

instance FromJSON StickySignature where
    parseJSON (Object v) = StickySignature
        <$> v .: "comment"
        <*> v .: "flags"
        <*> v .: "kind"
        <*> v .: "kindString"
        <*> v .: "name"
        <*> v .:! "parameters"
        <*> v .: "id"
        <*> v .: "type"
        <*> v .:! "typeParameter"

instance ToJSON TentacledParameter where
    toJSON (TentacledParameter commentTentacledParameter defaultValueTentacledParameter flagsTentacledParameter kindTentacledParameter kindStringTentacledParameter nameTentacledParameter originalNameTentacledParameter parameterIDTentacledParameter parameterTypeTentacledParameter) =
        object $ foldMap (maybe [] pure)
        [ ("comment" .=) <$> commentTentacledParameter
        , ("defaultValue" .=) <$> defaultValueTentacledParameter
        , Just $ "flags" .= flagsTentacledParameter
        , Just $ "kind" .= kindTentacledParameter
        , Just $ "kindString" .= kindStringTentacledParameter
        , Just $ "name" .= nameTentacledParameter
        , ("originalName" .=) <$> originalNameTentacledParameter
        , Just $ "id" .= parameterIDTentacledParameter
        , Just $ "type" .= parameterTypeTentacledParameter
        ]

instance FromJSON TentacledParameter where
    parseJSON (Object v) = TentacledParameter
        <$> v .:! "comment"
        <*> v .:! "defaultValue"
        <*> v .: "flags"
        <*> v .: "kind"
        <*> v .: "kindString"
        <*> v .: "name"
        <*> v .:! "originalName"
        <*> v .: "id"
        <*> v .: "type"

instance ToJSON AmbitiousType where
    toJSON (AmbitiousType declarationAmbitiousType elementTypeAmbitiousType nameAmbitiousType typeArgumentsAmbitiousType typeIDAmbitiousType typeTypeAmbitiousType) =
        object $ foldMap (maybe [] pure)
        [ ("declaration" .=) <$> declarationAmbitiousType
        , ("elementType" .=) <$> elementTypeAmbitiousType
        , ("name" .=) <$> nameAmbitiousType
        , ("typeArguments" .=) <$> typeArgumentsAmbitiousType
        , ("id" .=) <$> typeIDAmbitiousType
        , Just $ "type" .= typeTypeAmbitiousType
        ]

instance FromJSON AmbitiousType where
    parseJSON (Object v) = AmbitiousType
        <$> v .:! "declaration"
        <*> v .:! "elementType"
        <*> v .:! "name"
        <*> v .:! "typeArguments"
        <*> v .:! "id"
        <*> v .: "type"

instance ToJSON TentacledDeclaration where
    toJSON (TentacledDeclaration childrenTentacledDeclaration declarationIDTentacledDeclaration flagsTentacledDeclaration groupsTentacledDeclaration indexSignatureTentacledDeclaration kindTentacledDeclaration kindStringTentacledDeclaration nameTentacledDeclaration signaturesTentacledDeclaration sourcesTentacledDeclaration) =
        object $ foldMap (maybe [] pure)
        [ ("children" .=) <$> childrenTentacledDeclaration
        , Just $ "id" .= declarationIDTentacledDeclaration
        , Just $ "flags" .= flagsTentacledDeclaration
        , ("groups" .=) <$> groupsTentacledDeclaration
        , ("indexSignature" .=) <$> indexSignatureTentacledDeclaration
        , Just $ "kind" .= kindTentacledDeclaration
        , Just $ "kindString" .= kindStringTentacledDeclaration
        , Just $ "name" .= nameTentacledDeclaration
        , ("signatures" .=) <$> signaturesTentacledDeclaration
        , Just $ "sources" .= sourcesTentacledDeclaration
        ]

instance FromJSON TentacledDeclaration where
    parseJSON (Object v) = TentacledDeclaration
        <$> v .:! "children"
        <*> v .: "id"
        <*> v .: "flags"
        <*> v .:! "groups"
        <*> v .:! "indexSignature"
        <*> v .: "kind"
        <*> v .: "kindString"
        <*> v .: "name"
        <*> v .:! "signatures"
        <*> v .: "sources"

instance ToJSON IndigoChild where
    toJSON (IndigoChild childIDIndigoChild childTypeIndigoChild commentIndigoChild defaultValueIndigoChild flagsIndigoChild kindIndigoChild kindStringIndigoChild nameIndigoChild sourcesIndigoChild) =
        object $ foldMap (maybe [] pure)
        [ Just $ "id" .= childIDIndigoChild
        , Just $ "type" .= childTypeIndigoChild
        , Just $ "comment" .= commentIndigoChild
        , ("defaultValue" .=) <$> defaultValueIndigoChild
        , Just $ "flags" .= flagsIndigoChild
        , Just $ "kind" .= kindIndigoChild
        , Just $ "kindString" .= kindStringIndigoChild
        , Just $ "name" .= nameIndigoChild
        , Just $ "sources" .= sourcesIndigoChild
        ]

instance FromJSON IndigoChild where
    parseJSON (Object v) = IndigoChild
        <$> v .: "id"
        <*> v .: "type"
        <*> v .: "comment"
        <*> v .:! "defaultValue"
        <*> v .: "flags"
        <*> v .: "kind"
        <*> v .: "kindString"
        <*> v .: "name"
        <*> v .: "sources"

instance ToJSON CunningType where
    toJSON (CunningType declarationCunningType nameCunningType typeArgumentsCunningType typeIDCunningType typeTypeCunningType) =
        object $ foldMap (maybe [] pure)
        [ ("declaration" .=) <$> declarationCunningType
        , ("name" .=) <$> nameCunningType
        , ("typeArguments" .=) <$> typeArgumentsCunningType
        , ("id" .=) <$> typeIDCunningType
        , Just $ "type" .= typeTypeCunningType
        ]

instance FromJSON CunningType where
    parseJSON (Object v) = CunningType
        <$> v .:! "declaration"
        <*> v .:! "name"
        <*> v .:! "typeArguments"
        <*> v .:! "id"
        <*> v .: "type"

instance ToJSON TypeParameter where
    toJSON (TypeParameter commentTypeParameter flagsTypeParameter kindTypeParameter kindStringTypeParameter nameTypeParameter typeParameterIDTypeParameter typeParameterTypeTypeParameter) =
        object $ foldMap (maybe [] pure)
        [ ("comment" .=) <$> commentTypeParameter
        , Just $ "flags" .= flagsTypeParameter
        , Just $ "kind" .= kindTypeParameter
        , Just $ "kindString" .= kindStringTypeParameter
        , Just $ "name" .= nameTypeParameter
        , Just $ "id" .= typeParameterIDTypeParameter
        , ("type" .=) <$> typeParameterTypeTypeParameter
        ]

instance FromJSON TypeParameter where
    parseJSON (Object v) = TypeParameter
        <$> v .:! "comment"
        <*> v .: "flags"
        <*> v .: "kind"
        <*> v .: "kindString"
        <*> v .: "name"
        <*> v .: "id"
        <*> v .:! "type"

instance ToJSON MischievousType where
    toJSON (MischievousType nameMischievousType operatorMischievousType targetMischievousType typeIDMischievousType typeTypeMischievousType) =
        object $ foldMap (maybe [] pure)
        [ ("name" .=) <$> nameMischievousType
        , ("operator" .=) <$> operatorMischievousType
        , ("target" .=) <$> targetMischievousType
        , ("id" .=) <$> typeIDMischievousType
        , Just $ "type" .= typeTypeMischievousType
        ]

instance FromJSON MischievousType where
    parseJSON (Object v) = MischievousType
        <$> v .:! "name"
        <*> v .:! "operator"
        <*> v .:! "target"
        <*> v .:! "id"
        <*> v .: "type"

instance ToJSON IndecentComment where
    toJSON (IndecentComment shortTextIndecentComment tagsIndecentComment) =
        object $ foldMap (maybe [] pure)
        [ Just $ "shortText" .= shortTextIndecentComment
        , ("tags" .=) <$> tagsIndecentComment
        ]

instance FromJSON IndecentComment where
    parseJSON (Object v) = IndecentComment
        <$> v .: "shortText"
        <*> v .:! "tags"

instance ToJSON TentacledKindString where
    toJSON ExternalModuleTentacledKindString = "External module"

instance FromJSON TentacledKindString where
    parseJSON = withText "TentacledKindString" parseText
        where
            parseText "External module" = return ExternalModuleTentacledKindString
