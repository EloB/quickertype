// Code generated from JSON Schema using quicktype. DO NOT EDIT.
// To parse and unparse this JSON data, add this code to your project and do:
//
//    topLevel, err := UnmarshalTopLevel(bytes)
//    bytes, err = topLevel.Marshal()

package main

import "encoding/json"

func UnmarshalTopLevel(data []byte) (TopLevel, error) {
	var r TopLevel
	err := json.Unmarshal(data, &r)
	return r, err
}

func (r *TopLevel) Marshal() ([]byte, error) {
	return json.Marshal(r)
}

type TopLevel struct {
	Children []TopLevelChild   `json:"children"`
	Flags    GetSignatureFlags `json:"flags"`
	Groups   []Group           `json:"groups"`
	ID       int64             `json:"id"`
	Kind     int64             `json:"kind"`
	Name     string            `json:"name"`
}

type TopLevelChild struct {
	Children     []PurpleChild       `json:"children"`
	Comment      *IndecentComment    `json:"comment,omitempty"`
	Flags        PurpleFlags         `json:"flags"`
	Groups       []Group             `json:"groups"`
	ID           int64               `json:"id"`
	Kind         int64               `json:"kind"`
	KindString   TentacledKindString `json:"kindString"`
	Name         string              `json:"name"`
	OriginalName string              `json:"originalName"`
	Sources      []Source            `json:"sources"`
}

type PurpleChild struct {
	Children         *[]FluffyChild          `json:"children,omitempty"`
	Comment          *StickyComment          `json:"comment,omitempty"`
	DefaultValue     *string                 `json:"defaultValue,omitempty"`
	ExtendedBy       *[]ExtendedBy           `json:"extendedBy,omitempty"`
	ExtendedTypes    *[]ExtendedBy           `json:"extendedTypes,omitempty"`
	Flags            IndecentFlags           `json:"flags"`
	Groups           *[]Group                `json:"groups,omitempty"`
	ID               int64                   `json:"id"`
	ImplementedBy    *[]ExtendedBy           `json:"implementedBy,omitempty"`
	ImplementedTypes *[]ExtendedBy           `json:"implementedTypes,omitempty"`
	Kind             int64                   `json:"kind"`
	KindString       FluffyKindString        `json:"kindString"`
	Name             string                  `json:"name"`
	Signatures       *[]StickySignature      `json:"signatures,omitempty"`
	Sources          []Source                `json:"sources"`
	Type             *MagentaType            `json:"type,omitempty"`
	TypeParameter    *[]TypeParameterElement `json:"typeParameter,omitempty"`
}

type FluffyChild struct {
	Children         *[]TentacledChild  `json:"children,omitempty"`
	Comment          *StickyComment     `json:"comment,omitempty"`
	DefaultValue     *string            `json:"defaultValue,omitempty"`
	Flags            StickyFlags        `json:"flags"`
	GetSignature     *GetSignature      `json:"getSignature,omitempty"`
	Groups           *[]Group           `json:"groups,omitempty"`
	ID               int64              `json:"id"`
	ImplementationOf *ExtendedBy        `json:"implementationOf,omitempty"`
	InheritedFrom    *ExtendedBy        `json:"inheritedFrom,omitempty"`
	Kind             int64              `json:"kind"`
	KindString       PurpleKindString   `json:"kindString"`
	Name             string             `json:"name"`
	Overwrites       *ExtendedBy        `json:"overwrites,omitempty"`
	SetSignature     *GetSignature      `json:"setSignature,omitempty"`
	Signatures       *[]FluffySignature `json:"signatures,omitempty"`
	Sources          []Source           `json:"sources"`
	Type             *IndigoType        `json:"type,omitempty"`
}

type TentacledChild struct {
	Comment      *PurpleComment     `json:"comment,omitempty"`
	DefaultValue *string            `json:"defaultValue,omitempty"`
	Flags        PurpleFlags        `json:"flags"`
	ID           int64              `json:"id"`
	Kind         int64              `json:"kind"`
	KindString   PurpleKindString   `json:"kindString"`
	Name         string             `json:"name"`
	Signatures   *[]PurpleSignature `json:"signatures,omitempty"`
	Sources      []Source           `json:"sources"`
	Type         *TypeElement       `json:"type,omitempty"`
}

type PurpleComment struct {
	ShortText string `json:"shortText"`
}

type PurpleFlags struct {
	IsExported *bool `json:"isExported,omitempty"`
}

type PurpleSignature struct {
	Comment    *PurpleComment      `json:"comment,omitempty"`
	Flags      GetSignatureFlags   `json:"flags"`
	ID         int64               `json:"id"`
	Kind       int64               `json:"kind"`
	KindString SignatureKindString `json:"kindString"`
	Name       string              `json:"name"`
	Parameters []GetSignature      `json:"parameters"`
	Type       TentacledType       `json:"type"`
}

type GetSignatureFlags struct {
}

type GetSignatureType struct {
	Declaration *GetSignature `json:"declaration,omitempty"`
	ElementType *ElementType  `json:"elementType,omitempty"`
	Name        *Name         `json:"name,omitempty"`
	Type        TypeEnum      `json:"type"`
}

type IndexSignatureElement struct {
	Flags      GetSignatureFlags `json:"flags"`
	ID         int64             `json:"id"`
	Kind       int64             `json:"kind"`
	KindString string            `json:"kindString"`
	Name       string            `json:"name"`
	Parameters *[]GetSignature   `json:"parameters,omitempty"`
	Type       PurpleType        `json:"type"`
}

type PurpleType struct {
	Declaration *GetSignature `json:"declaration,omitempty"`
	Name        *Name         `json:"name,omitempty"`
	Type        TypeEnum      `json:"type"`
}

type GetSignatureChild struct {
	Comment    *FluffyComment   `json:"comment,omitempty"`
	Flags      FluffyFlags      `json:"flags"`
	ID         int64            `json:"id"`
	Kind       int64            `json:"kind"`
	KindString PurpleKindString `json:"kindString"`
	Name       string           `json:"name"`
	Sources    []Source         `json:"sources"`
	Type       PurpleType       `json:"type"`
}

type GetSignature struct {
	Children      *[]GetSignatureChild     `json:"children,omitempty"`
	Comment       *GetSignatureComment     `json:"comment,omitempty"`
	DefaultValue  *string                  `json:"defaultValue,omitempty"`
	Flags         GetSignatureFlags        `json:"flags"`
	Groups        *[]Group                 `json:"groups,omitempty"`
	ID            int64                    `json:"id"`
	Kind          int64                    `json:"kind"`
	KindString    string                   `json:"kindString"`
	Name          string                   `json:"name"`
	Parameters    *[]GetSignatureParameter `json:"parameters,omitempty"`
	Signatures    *[]IndexSignatureElement `json:"signatures,omitempty"`
	Sources       *[]Source                `json:"sources,omitempty"`
	Type          *GetSignatureType        `json:"type,omitempty"`
	TypeParameter *[]GetSignature          `json:"typeParameter,omitempty"`
}

type ElementType struct {
	Name Name     `json:"name"`
	Type TypeEnum `json:"type"`
}

type FluffyComment struct {
	Text string `json:"text"`
}

type FluffyFlags struct {
	IsOptional *bool `json:"isOptional,omitempty"`
}

type Source struct {
	Character int64    `json:"character"`
	FileName  FileName `json:"fileName"`
	Line      int64    `json:"line"`
}

type GetSignatureComment struct {
	Returns   *string `json:"returns,omitempty"`
	ShortText *string `json:"shortText,omitempty"`
	Text      *string `json:"text,omitempty"`
}

type Group struct {
	Children []int64 `json:"children"`
	Kind     int64   `json:"kind"`
	Title    string  `json:"title"`
}

type GetSignatureParameter struct {
	Comment    *TentacledComment   `json:"comment,omitempty"`
	Flags      TentacledFlags      `json:"flags"`
	ID         int64               `json:"id"`
	Kind       int64               `json:"kind"`
	KindString ParameterKindString `json:"kindString"`
	Name       string              `json:"name"`
	Type       FluffyType          `json:"type"`
}

type TentacledComment struct {
	ShortText *string `json:"shortText,omitempty"`
	Text      *string `json:"text,omitempty"`
}

type TentacledFlags struct {
	IsOptional *bool `json:"isOptional,omitempty"`
	IsREST     *bool `json:"isRest,omitempty"`
}

type FluffyType struct {
	ElementType   *ElementType   `json:"elementType,omitempty"`
	Name          *Name          `json:"name,omitempty"`
	Type          TypeEnum       `json:"type"`
	TypeArguments *[]ElementType `json:"typeArguments,omitempty"`
}

type TentacledType struct {
	Declaration *PurpleDeclaration `json:"declaration,omitempty"`
	Name        *Name              `json:"name,omitempty"`
	Type        TypeEnum           `json:"type"`
}

type PurpleDeclaration struct {
	Children   []GetSignature    `json:"children"`
	Flags      GetSignatureFlags `json:"flags"`
	Groups     []Group           `json:"groups"`
	ID         int64             `json:"id"`
	Kind       int64             `json:"kind"`
	KindString string            `json:"kindString"`
	Name       string            `json:"name"`
}

type TypeElement struct {
	Declaration   *GetSignature  `json:"declaration,omitempty"`
	ElementType   *ElementType   `json:"elementType,omitempty"`
	Name          *Name          `json:"name,omitempty"`
	Type          TypeEnum       `json:"type"`
	TypeArguments *[]ElementType `json:"typeArguments,omitempty"`
}

type StickyComment struct {
	Returns   *string `json:"returns,omitempty"`
	ShortText *string `json:"shortText,omitempty"`
	Tags      *[]Tag  `json:"tags,omitempty"`
	Text      *string `json:"text,omitempty"`
}

type Tag struct {
	Tag  string `json:"tag"`
	Text string `json:"text"`
}

type StickyFlags struct {
	IsAbstract            *bool `json:"isAbstract,omitempty"`
	IsConstructorProperty *bool `json:"isConstructorProperty,omitempty"`
	IsExported            *bool `json:"isExported,omitempty"`
	IsPrivate             *bool `json:"isPrivate,omitempty"`
	IsProtected           *bool `json:"isProtected,omitempty"`
	IsPublic              *bool `json:"isPublic,omitempty"`
	IsStatic              *bool `json:"isStatic,omitempty"`
}

type ExtendedBy struct {
	Constraint    *ExtendedBy   `json:"constraint,omitempty"`
	ID            *int64        `json:"id,omitempty"`
	Name          string        `json:"name"`
	Type          TypeEnum      `json:"type"`
	TypeArguments *[]ExtendedBy `json:"typeArguments,omitempty"`
}

type FluffySignature struct {
	Comment          *StickyComment      `json:"comment,omitempty"`
	Flags            IndigoFlags         `json:"flags"`
	ID               int64               `json:"id"`
	ImplementationOf *ExtendedBy         `json:"implementationOf,omitempty"`
	InheritedFrom    *ExtendedBy         `json:"inheritedFrom,omitempty"`
	Kind             int64               `json:"kind"`
	KindString       SignatureKindString `json:"kindString"`
	Name             string              `json:"name"`
	Overwrites       *ExtendedBy         `json:"overwrites,omitempty"`
	Parameters       *[]PurpleParameter  `json:"parameters,omitempty"`
	Type             ExtendedBy          `json:"type"`
	TypeParameter    *[]GetSignature     `json:"typeParameter,omitempty"`
}

type IndigoFlags struct {
	IsPrivate   *bool `json:"isPrivate,omitempty"`
	IsProtected *bool `json:"isProtected,omitempty"`
}

type PurpleParameter struct {
	Comment    *TentacledComment   `json:"comment,omitempty"`
	Flags      GetSignatureFlags   `json:"flags"`
	ID         int64               `json:"id"`
	Kind       int64               `json:"kind"`
	KindString ParameterKindString `json:"kindString"`
	Name       string              `json:"name"`
	Type       StickyType          `json:"type"`
}

type StickyType struct {
	Constraint    *ExtendedBy    `json:"constraint,omitempty"`
	Declaration   *GetSignature  `json:"declaration,omitempty"`
	ElementType   *ElementType   `json:"elementType,omitempty"`
	Elements      *[]ExtendedBy  `json:"elements,omitempty"`
	ID            *int64         `json:"id,omitempty"`
	Name          *string        `json:"name,omitempty"`
	Type          TypeEnum       `json:"type"`
	TypeArguments *[]ElementType `json:"typeArguments,omitempty"`
}

type IndigoType struct {
	Constraint    *ExtendedBy           `json:"constraint,omitempty"`
	Declaration   *FluffyDeclaration    `json:"declaration,omitempty"`
	ElementType   *ExtendedBy           `json:"elementType,omitempty"`
	Elements      *[]ElementType        `json:"elements,omitempty"`
	ID            *int64                `json:"id,omitempty"`
	Name          *string               `json:"name,omitempty"`
	Type          TypeEnum              `json:"type"`
	TypeArguments *[]PurpleTypeArgument `json:"typeArguments,omitempty"`
	Types         *[]TypeElement        `json:"types,omitempty"`
}

type FluffyDeclaration struct {
	Children       *[]StickyChild        `json:"children,omitempty"`
	Flags          GetSignatureFlags     `json:"flags"`
	Groups         *[]Group              `json:"groups,omitempty"`
	ID             int64                 `json:"id"`
	IndexSignature *IndexSignature       `json:"indexSignature,omitempty"`
	Kind           int64                 `json:"kind"`
	KindString     string                `json:"kindString"`
	Name           string                `json:"name"`
	Signatures     *[]TentacledSignature `json:"signatures,omitempty"`
	Sources        []Source              `json:"sources"`
}

type StickyChild struct {
	Comment    *FluffyComment   `json:"comment,omitempty"`
	Flags      FluffyFlags      `json:"flags"`
	ID         int64            `json:"id"`
	Kind       int64            `json:"kind"`
	KindString PurpleKindString `json:"kindString"`
	Name       string           `json:"name"`
	Sources    []Source         `json:"sources"`
	Type       IndecentType     `json:"type"`
}

type IndecentType struct {
	Declaration *GetSignature  `json:"declaration,omitempty"`
	Elements    *[]ElementType `json:"elements,omitempty"`
	Name        *Name          `json:"name,omitempty"`
	Type        TypeEnum       `json:"type"`
}

type IndexSignature struct {
	Flags      GetSignatureFlags `json:"flags"`
	ID         int64             `json:"id"`
	Kind       int64             `json:"kind"`
	KindString string            `json:"kindString"`
	Name       string            `json:"name"`
	Parameters []GetSignature    `json:"parameters"`
	Type       HilariousType     `json:"type"`
}

type HilariousType struct {
	Declaration GetSignature `json:"declaration"`
	Type        TypeEnum     `json:"type"`
}

type TentacledSignature struct {
	Comment    *IndigoComment      `json:"comment,omitempty"`
	Flags      GetSignatureFlags   `json:"flags"`
	ID         int64               `json:"id"`
	Kind       int64               `json:"kind"`
	KindString SignatureKindString `json:"kindString"`
	Name       string              `json:"name"`
	Parameters *[]FluffyParameter  `json:"parameters,omitempty"`
	Type       ExtendedBy          `json:"type"`
}

type IndigoComment struct {
	Returns   string `json:"returns"`
	ShortText string `json:"shortText"`
}

type FluffyParameter struct {
	Comment    *FluffyComment `json:"comment,omitempty"`
	Flags      FluffyFlags    `json:"flags"`
	ID         int64          `json:"id"`
	Kind       int64          `json:"kind"`
	KindString string         `json:"kindString"`
	Name       string         `json:"name"`
	Sources    *[]Source      `json:"sources,omitempty"`
	Type       ElementType    `json:"type"`
}

type PurpleTypeArgument struct {
	Operator string      `json:"operator"`
	Target   ElementType `json:"target"`
	Type     string      `json:"type"`
}

type IndecentFlags struct {
	HasExportAssignment *bool `json:"hasExportAssignment,omitempty"`
	IsAbstract          *bool `json:"isAbstract,omitempty"`
	IsConst             *bool `json:"isConst,omitempty"`
	IsExported          *bool `json:"isExported,omitempty"`
	IsLet               *bool `json:"isLet,omitempty"`
	IsPrivate           *bool `json:"isPrivate,omitempty"`
	IsProtected         *bool `json:"isProtected,omitempty"`
}

type StickySignature struct {
	Comment       StickyComment         `json:"comment"`
	Flags         IndigoFlags           `json:"flags"`
	ID            int64                 `json:"id"`
	Kind          int64                 `json:"kind"`
	KindString    SignatureKindString   `json:"kindString"`
	Name          string                `json:"name"`
	Parameters    *[]TentacledParameter `json:"parameters,omitempty"`
	Type          CunningType           `json:"type"`
	TypeParameter *[]GetSignature       `json:"typeParameter,omitempty"`
}

type TentacledParameter struct {
	Comment      *TentacledComment   `json:"comment,omitempty"`
	DefaultValue *string             `json:"defaultValue,omitempty"`
	Flags        TentacledFlags      `json:"flags"`
	ID           int64               `json:"id"`
	Kind         int64               `json:"kind"`
	KindString   ParameterKindString `json:"kindString"`
	Name         string              `json:"name"`
	OriginalName *string             `json:"originalName,omitempty"`
	Type         AmbitiousType       `json:"type"`
}

type AmbitiousType struct {
	Declaration   *TentacledDeclaration `json:"declaration,omitempty"`
	ElementType   *ElementType          `json:"elementType,omitempty"`
	ID            *int64                `json:"id,omitempty"`
	Name          *string               `json:"name,omitempty"`
	Type          TypeEnum              `json:"type"`
	TypeArguments *[]ElementType        `json:"typeArguments,omitempty"`
}

type TentacledDeclaration struct {
	Children       *[]IndigoChild         `json:"children,omitempty"`
	Flags          GetSignatureFlags      `json:"flags"`
	Groups         *[]Group               `json:"groups,omitempty"`
	ID             int64                  `json:"id"`
	IndexSignature *IndexSignatureElement `json:"indexSignature,omitempty"`
	Kind           int64                  `json:"kind"`
	KindString     string                 `json:"kindString"`
	Name           string                 `json:"name"`
	Signatures     *[]GetSignature        `json:"signatures,omitempty"`
	Sources        []Source               `json:"sources"`
}

type IndigoChild struct {
	Comment      FluffyComment    `json:"comment"`
	DefaultValue *string          `json:"defaultValue,omitempty"`
	Flags        FluffyFlags      `json:"flags"`
	ID           int64            `json:"id"`
	Kind         int64            `json:"kind"`
	KindString   PurpleKindString `json:"kindString"`
	Name         string           `json:"name"`
	Sources      []Source         `json:"sources"`
	Type         IndecentType     `json:"type"`
}

type CunningType struct {
	Declaration   *PurpleDeclaration `json:"declaration,omitempty"`
	ID            *int64             `json:"id,omitempty"`
	Name          *Name              `json:"name,omitempty"`
	Type          TypeEnum           `json:"type"`
	TypeArguments *[]ElementType     `json:"typeArguments,omitempty"`
}

type MagentaType struct {
	Declaration   *StickyDeclaration    `json:"declaration,omitempty"`
	ElementType   *ElementType          `json:"elementType,omitempty"`
	Elements      *[]ExtendedBy         `json:"elements,omitempty"`
	ID            *int64                `json:"id,omitempty"`
	Name          *string               `json:"name,omitempty"`
	Type          TypeEnum              `json:"type"`
	TypeArguments *[]FluffyTypeArgument `json:"typeArguments,omitempty"`
	Types         *[]ExtendedBy         `json:"types,omitempty"`
	Value         *string               `json:"value,omitempty"`
}

type StickyDeclaration struct {
	Children   *[]IndecentChild  `json:"children,omitempty"`
	Flags      GetSignatureFlags `json:"flags"`
	Groups     *[]Group          `json:"groups,omitempty"`
	ID         int64             `json:"id"`
	Kind       int64             `json:"kind"`
	KindString string            `json:"kindString"`
	Name       string            `json:"name"`
	Signatures []GetSignature    `json:"signatures"`
	Sources    []Source          `json:"sources"`
}

type IndecentChild struct {
	Flags      FluffyFlags      `json:"flags"`
	ID         int64            `json:"id"`
	Kind       int64            `json:"kind"`
	KindString PurpleKindString `json:"kindString"`
	Name       string           `json:"name"`
	Sources    []Source         `json:"sources"`
	Type       FriskyType       `json:"type"`
}

type FriskyType struct {
	Declaration *IndigoDeclaration `json:"declaration,omitempty"`
	Name        *Name              `json:"name,omitempty"`
	Type        TypeEnum           `json:"type"`
}

type IndigoDeclaration struct {
	Children   *[]GetSignature   `json:"children,omitempty"`
	Flags      GetSignatureFlags `json:"flags"`
	Groups     *[]Group          `json:"groups,omitempty"`
	ID         int64             `json:"id"`
	Kind       int64             `json:"kind"`
	KindString string            `json:"kindString"`
	Name       string            `json:"name"`
	Signatures *[]GetSignature   `json:"signatures,omitempty"`
	Sources    []Source          `json:"sources"`
}

type FluffyTypeArgument struct {
	Type  TypeEnum      `json:"type"`
	Types []ElementType `json:"types"`
}

type TypeParameterElement struct {
	Comment    *PurpleComment    `json:"comment,omitempty"`
	Flags      GetSignatureFlags `json:"flags"`
	ID         int64             `json:"id"`
	Kind       int64             `json:"kind"`
	KindString string            `json:"kindString"`
	Name       string            `json:"name"`
	Type       *MischievousType  `json:"type,omitempty"`
}

type MischievousType struct {
	ID       *int64       `json:"id,omitempty"`
	Name     *Name        `json:"name,omitempty"`
	Operator *string      `json:"operator,omitempty"`
	Target   *ElementType `json:"target,omitempty"`
	Type     string       `json:"type"`
}

type IndecentComment struct {
	ShortText string `json:"shortText"`
	Tags      *[]Tag `json:"tags,omitempty"`
}

type PurpleKindString string

const (
	PurpleVariable      PurpleKindString = "Variable"
	PurpleFunction      PurpleKindString = "Function"
	Property            PurpleKindString = "Property"
	Method              PurpleKindString = "Method"
	Constructor         PurpleKindString = "Constructor"
	Accessor            PurpleKindString = "Accessor"
	EnumerationMember   PurpleKindString = "Enumeration member"
	PurpleModule        PurpleKindString = "Module"
	PurpleObjectLiteral PurpleKindString = "Object literal"
)

type invalidPurpleKindString string
func (x invalidPurpleKindString) Error() string { return "invalid PurpleKindString: " + string(x) }

func (x *PurpleKindString) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch PurpleKindString(value) {
	case PurpleVariable, PurpleFunction, Property, Method, Constructor, Accessor, EnumerationMember, PurpleModule, PurpleObjectLiteral: *x = PurpleKindString(value); return nil
	}
	return invalidPurpleKindString(value)
}

type SignatureKindString string

const (
	CallSignature        SignatureKindString = "Call signature"
	ConstructorSignature SignatureKindString = "Constructor signature"
)

type invalidSignatureKindString string
func (x invalidSignatureKindString) Error() string { return "invalid SignatureKindString: " + string(x) }

func (x *SignatureKindString) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch SignatureKindString(value) {
	case CallSignature, ConstructorSignature: *x = SignatureKindString(value); return nil
	}
	return invalidSignatureKindString(value)
}

type Name string

const (
	String    Name = "string"
	Number    Name = "number"
	Void      Name = "void"
	T         Name = "T"
	Boolean   Name = "boolean"
	BaseClass Name = "BaseClass"
	Any       Name = "any"
	Array     Name = "Array"
	MyNumber  Name = "MyNumber"
)

type invalidName string
func (x invalidName) Error() string { return "invalid Name: " + string(x) }

func (x *Name) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Name(value) {
	case String, Number, Void, T, Boolean, BaseClass, Any, Array, MyNumber: *x = Name(value); return nil
	}
	return invalidName(value)
}

type TypeEnum string

const (
	Intrinsic     TypeEnum = "intrinsic"
	Reflection    TypeEnum = "reflection"
	TypeArray     TypeEnum = "array"
	Reference     TypeEnum = "reference"
	TypeParameter TypeEnum = "typeParameter"
	Tuple         TypeEnum = "tuple"
	Union         TypeEnum = "union"
	StringLiteral TypeEnum = "stringLiteral"
)

type invalidTypeEnum string
func (x invalidTypeEnum) Error() string { return "invalid TypeEnum: " + string(x) }

func (x *TypeEnum) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch TypeEnum(value) {
	case Intrinsic, Reflection, TypeArray, Reference, TypeParameter, Tuple, Union, StringLiteral: *x = TypeEnum(value); return nil
	}
	return invalidTypeEnum(value)
}

type FileName string

const (
	ModulesTs       FileName = "modules.ts"
	ClassesTs       FileName = "classes.ts"
	FlattenedTs     FileName = "flattened.ts"
	AccessTs        FileName = "access.ts"
	DefaultExportTs FileName = "default-export.ts"
	EnumerationsTs  FileName = "enumerations.ts"
	FunctionsTs     FileName = "functions.ts"
	GenericsTs      FileName = "generics.ts"
	SingleExportTs  FileName = "single-export.ts"
	Typescript13Ts  FileName = "typescript-1.3.ts"
	Typescript14Ts  FileName = "typescript-1.4.ts"
	Typescript15Ts  FileName = "typescript-1.5.ts"
	VariablesTs     FileName = "variables.ts"
)

type invalidFileName string
func (x invalidFileName) Error() string { return "invalid FileName: " + string(x) }

func (x *FileName) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch FileName(value) {
	case ModulesTs, ClassesTs, FlattenedTs, AccessTs, DefaultExportTs, EnumerationsTs, FunctionsTs, GenericsTs, SingleExportTs, Typescript13Ts, Typescript14Ts, Typescript15Ts, VariablesTs: *x = FileName(value); return nil
	}
	return invalidFileName(value)
}

type ParameterKindString string

const (
	Parameter ParameterKindString = "Parameter"
)

type invalidParameterKindString string
func (x invalidParameterKindString) Error() string { return "invalid ParameterKindString: " + string(x) }

func (x *ParameterKindString) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch ParameterKindString(value) {
	case Parameter: *x = ParameterKindString(value); return nil
	}
	return invalidParameterKindString(value)
}

type FluffyKindString string

const (
	FluffyModule        FluffyKindString = "Module"
	Class               FluffyKindString = "Class"
	FluffyVariable      FluffyKindString = "Variable"
	FluffyFunction      FluffyKindString = "Function"
	Interface           FluffyKindString = "Interface"
	Enumeration         FluffyKindString = "Enumeration"
	FluffyObjectLiteral FluffyKindString = "Object literal"
	TypeAlias           FluffyKindString = "Type alias"
)

type invalidFluffyKindString string
func (x invalidFluffyKindString) Error() string { return "invalid FluffyKindString: " + string(x) }

func (x *FluffyKindString) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch FluffyKindString(value) {
	case FluffyModule, Class, FluffyVariable, FluffyFunction, Interface, Enumeration, FluffyObjectLiteral, TypeAlias: *x = FluffyKindString(value); return nil
	}
	return invalidFluffyKindString(value)
}

type TentacledKindString string

const (
	ExternalModule TentacledKindString = "External module"
)

type invalidTentacledKindString string
func (x invalidTentacledKindString) Error() string { return "invalid TentacledKindString: " + string(x) }

func (x *TentacledKindString) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch TentacledKindString(value) {
	case ExternalModule: *x = TentacledKindString(value); return nil
	}
	return invalidTentacledKindString(value)
}
