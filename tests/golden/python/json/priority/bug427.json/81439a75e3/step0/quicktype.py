from dataclasses import dataclass
from typing import Any, TypeVar, Type, Callable, cast
from enum import Enum


T = TypeVar("T")
EnumT = TypeVar("EnumT", bound=Enum)


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def from_bool(x: Any) -> bool:
    assert isinstance(x, bool)
    return x


def from_none(x: Any) -> Any:
    assert x is None
    return x


def from_union(fs, x):
    for f in fs:
        try:
            return f(x)
        except:
            pass
    assert False


def to_enum(c: Type[EnumT], x: Any) -> EnumT:
    assert isinstance(x, c)
    return x.value


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


@dataclass
class PurpleComment:
    short_text: str

    @staticmethod
    def from_dict(obj: Any) -> 'PurpleComment':
        assert isinstance(obj, dict)
        short_text = from_str(obj["shortText"])
        return PurpleComment(short_text)

    def to_dict(self) -> dict:
        result: dict = {}
        result["shortText"] = from_str(self.short_text)
        return result


@dataclass
class PurpleFlags:
    is_exported: bool | None

    @staticmethod
    def from_dict(obj: Any) -> 'PurpleFlags':
        assert isinstance(obj, dict)
        is_exported = from_union([from_bool, from_none], obj.get("isExported"))
        return PurpleFlags(is_exported)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.is_exported is not None:
            result["isExported"] = from_union([from_bool, from_none], self.is_exported)
        return result


class PurpleKindString(Enum):
    VARIABLE = "Variable"
    FUNCTION = "Function"
    PROPERTY = "Property"
    METHOD = "Method"
    CONSTRUCTOR = "Constructor"
    ACCESSOR = "Accessor"
    ENUMERATION_MEMBER = "Enumeration member"
    MODULE = "Module"
    OBJECT_LITERAL = "Object literal"


@dataclass
class GetSignatureFlags:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'GetSignatureFlags':
        assert isinstance(obj, dict)
        return GetSignatureFlags()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


class SignatureKindString(Enum):
    CALL_SIGNATURE = "Call signature"
    CONSTRUCTOR_SIGNATURE = "Constructor signature"


class Name(Enum):
    STRING = "string"
    NUMBER = "number"
    VOID = "void"
    T = "T"
    BOOLEAN = "boolean"
    BASE_CLASS = "BaseClass"
    ANY = "any"
    ARRAY = "Array"
    MY_NUMBER = "MyNumber"


class TypeEnum(Enum):
    INTRINSIC = "intrinsic"
    REFLECTION = "reflection"
    ARRAY = "array"
    REFERENCE = "reference"
    TYPE_PARAMETER = "typeParameter"
    TUPLE = "tuple"
    UNION = "union"
    STRING_LITERAL = "stringLiteral"


@dataclass
class ElementType:
    name: Name
    type: TypeEnum

    @staticmethod
    def from_dict(obj: Any) -> 'ElementType':
        assert isinstance(obj, dict)
        name = Name(obj["name"])
        type = TypeEnum(obj["type"])
        return ElementType(name, type)

    def to_dict(self) -> dict:
        result: dict = {}
        result["name"] = to_enum(Name, self.name)
        result["type"] = to_enum(TypeEnum, self.type)
        return result


@dataclass
class FluffyComment:
    text: str

    @staticmethod
    def from_dict(obj: Any) -> 'FluffyComment':
        assert isinstance(obj, dict)
        text = from_str(obj["text"])
        return FluffyComment(text)

    def to_dict(self) -> dict:
        result: dict = {}
        result["text"] = from_str(self.text)
        return result


@dataclass
class FluffyFlags:
    is_optional: bool | None

    @staticmethod
    def from_dict(obj: Any) -> 'FluffyFlags':
        assert isinstance(obj, dict)
        is_optional = from_union([from_bool, from_none], obj.get("isOptional"))
        return FluffyFlags(is_optional)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.is_optional is not None:
            result["isOptional"] = from_union([from_bool, from_none], self.is_optional)
        return result


class FileName(Enum):
    MODULES_TS = "modules.ts"
    CLASSES_TS = "classes.ts"
    FLATTENED_TS = "flattened.ts"
    ACCESS_TS = "access.ts"
    DEFAULT_EXPORT_TS = "default-export.ts"
    ENUMERATIONS_TS = "enumerations.ts"
    FUNCTIONS_TS = "functions.ts"
    GENERICS_TS = "generics.ts"
    SINGLE_EXPORT_TS = "single-export.ts"
    TYPESCRIPT_13_TS = "typescript-1.3.ts"
    TYPESCRIPT_14_TS = "typescript-1.4.ts"
    TYPESCRIPT_15_TS = "typescript-1.5.ts"
    VARIABLES_TS = "variables.ts"


@dataclass
class Source:
    character: int
    file_name: FileName
    line: int

    @staticmethod
    def from_dict(obj: Any) -> 'Source':
        assert isinstance(obj, dict)
        character = from_int(obj["character"])
        file_name = FileName(obj["fileName"])
        line = from_int(obj["line"])
        return Source(character, file_name, line)

    def to_dict(self) -> dict:
        result: dict = {}
        result["character"] = from_int(self.character)
        result["fileName"] = to_enum(FileName, self.file_name)
        result["line"] = from_int(self.line)
        return result


@dataclass
class GetSignatureComment:
    returns: str | None
    short_text: str | None
    text: str | None

    @staticmethod
    def from_dict(obj: Any) -> 'GetSignatureComment':
        assert isinstance(obj, dict)
        returns = from_union([from_none, from_str], obj.get("returns"))
        short_text = from_union([from_none, from_str], obj.get("shortText"))
        text = from_union([from_none, from_str], obj.get("text"))
        return GetSignatureComment(returns, short_text, text)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.returns is not None:
            result["returns"] = from_union([from_none, from_str], self.returns)
        if self.short_text is not None:
            result["shortText"] = from_union([from_none, from_str], self.short_text)
        if self.text is not None:
            result["text"] = from_union([from_none, from_str], self.text)
        return result


@dataclass
class Group:
    children: list[int]
    kind: int
    title: str

    @staticmethod
    def from_dict(obj: Any) -> 'Group':
        assert isinstance(obj, dict)
        children = from_list(from_int, obj["children"])
        kind = from_int(obj["kind"])
        title = from_str(obj["title"])
        return Group(children, kind, title)

    def to_dict(self) -> dict:
        result: dict = {}
        result["children"] = from_list(from_int, self.children)
        result["kind"] = from_int(self.kind)
        result["title"] = from_str(self.title)
        return result


@dataclass
class TentacledComment:
    short_text: str | None
    text: str | None

    @staticmethod
    def from_dict(obj: Any) -> 'TentacledComment':
        assert isinstance(obj, dict)
        short_text = from_union([from_none, from_str], obj.get("shortText"))
        text = from_union([from_none, from_str], obj.get("text"))
        return TentacledComment(short_text, text)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.short_text is not None:
            result["shortText"] = from_union([from_none, from_str], self.short_text)
        if self.text is not None:
            result["text"] = from_union([from_none, from_str], self.text)
        return result


@dataclass
class TentacledFlags:
    is_optional: bool | None
    is_rest: bool | None

    @staticmethod
    def from_dict(obj: Any) -> 'TentacledFlags':
        assert isinstance(obj, dict)
        is_optional = from_union([from_bool, from_none], obj.get("isOptional"))
        is_rest = from_union([from_bool, from_none], obj.get("isRest"))
        return TentacledFlags(is_optional, is_rest)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.is_optional is not None:
            result["isOptional"] = from_union([from_bool, from_none], self.is_optional)
        if self.is_rest is not None:
            result["isRest"] = from_union([from_bool, from_none], self.is_rest)
        return result


class ParameterKindString(Enum):
    PARAMETER = "Parameter"


@dataclass
class FluffyType:
    type: TypeEnum
    element_type: ElementType | None
    name: Name | None
    type_arguments: list[ElementType] | None

    @staticmethod
    def from_dict(obj: Any) -> 'FluffyType':
        assert isinstance(obj, dict)
        type = TypeEnum(obj["type"])
        element_type = from_union([ElementType.from_dict, from_none], obj.get("elementType"))
        name = from_union([Name, from_none], obj.get("name"))
        type_arguments = from_union([lambda x: from_list(ElementType.from_dict, x), from_none], obj.get("typeArguments"))
        return FluffyType(type, element_type, name, type_arguments)

    def to_dict(self) -> dict:
        result: dict = {}
        result["type"] = to_enum(TypeEnum, self.type)
        if self.element_type is not None:
            result["elementType"] = from_union([lambda x: to_class(ElementType, x), from_none], self.element_type)
        if self.name is not None:
            result["name"] = from_union([lambda x: to_enum(Name, x), from_none], self.name)
        if self.type_arguments is not None:
            result["typeArguments"] = from_union([lambda x: from_list(lambda x: to_class(ElementType, x), x), from_none], self.type_arguments)
        return result


@dataclass
class GetSignatureParameter:
    flags: TentacledFlags
    id: int
    kind: int
    kind_string: ParameterKindString
    name: str
    type: FluffyType
    comment: TentacledComment | None

    @staticmethod
    def from_dict(obj: Any) -> 'GetSignatureParameter':
        assert isinstance(obj, dict)
        flags = TentacledFlags.from_dict(obj["flags"])
        id = from_int(obj["id"])
        kind = from_int(obj["kind"])
        kind_string = ParameterKindString(obj["kindString"])
        name = from_str(obj["name"])
        type = FluffyType.from_dict(obj["type"])
        comment = from_union([TentacledComment.from_dict, from_none], obj.get("comment"))
        return GetSignatureParameter(flags, id, kind, kind_string, name, type, comment)

    def to_dict(self) -> dict:
        result: dict = {}
        result["flags"] = to_class(TentacledFlags, self.flags)
        result["id"] = from_int(self.id)
        result["kind"] = from_int(self.kind)
        result["kindString"] = to_enum(ParameterKindString, self.kind_string)
        result["name"] = from_str(self.name)
        result["type"] = to_class(FluffyType, self.type)
        if self.comment is not None:
            result["comment"] = from_union([lambda x: to_class(TentacledComment, x), from_none], self.comment)
        return result


@dataclass
class GetSignatureType:
    type: TypeEnum
    declaration: 'GetSignature | None'
    element_type: ElementType | None
    name: Name | None

    @staticmethod
    def from_dict(obj: Any) -> 'GetSignatureType':
        assert isinstance(obj, dict)
        type = TypeEnum(obj["type"])
        declaration = from_union([GetSignature.from_dict, from_none], obj.get("declaration"))
        element_type = from_union([ElementType.from_dict, from_none], obj.get("elementType"))
        name = from_union([Name, from_none], obj.get("name"))
        return GetSignatureType(type, declaration, element_type, name)

    def to_dict(self) -> dict:
        result: dict = {}
        result["type"] = to_enum(TypeEnum, self.type)
        if self.declaration is not None:
            result["declaration"] = from_union([lambda x: to_class(GetSignature, x), from_none], self.declaration)
        if self.element_type is not None:
            result["elementType"] = from_union([lambda x: to_class(ElementType, x), from_none], self.element_type)
        if self.name is not None:
            result["name"] = from_union([lambda x: to_enum(Name, x), from_none], self.name)
        return result


@dataclass
class IndexSignatureElement:
    flags: GetSignatureFlags
    id: int
    kind: int
    kind_string: str
    name: str
    type: 'PurpleType'
    parameters: 'list[GetSignature] | None'

    @staticmethod
    def from_dict(obj: Any) -> 'IndexSignatureElement':
        assert isinstance(obj, dict)
        flags = GetSignatureFlags.from_dict(obj["flags"])
        id = from_int(obj["id"])
        kind = from_int(obj["kind"])
        kind_string = from_str(obj["kindString"])
        name = from_str(obj["name"])
        type = PurpleType.from_dict(obj["type"])
        parameters = from_union([lambda x: from_list(GetSignature.from_dict, x), from_none], obj.get("parameters"))
        return IndexSignatureElement(flags, id, kind, kind_string, name, type, parameters)

    def to_dict(self) -> dict:
        result: dict = {}
        result["flags"] = to_class(GetSignatureFlags, self.flags)
        result["id"] = from_int(self.id)
        result["kind"] = from_int(self.kind)
        result["kindString"] = from_str(self.kind_string)
        result["name"] = from_str(self.name)
        result["type"] = to_class(PurpleType, self.type)
        if self.parameters is not None:
            result["parameters"] = from_union([lambda x: from_list(lambda x: to_class(GetSignature, x), x), from_none], self.parameters)
        return result


@dataclass
class PurpleType:
    type: TypeEnum
    declaration: 'GetSignature | None'
    name: Name | None

    @staticmethod
    def from_dict(obj: Any) -> 'PurpleType':
        assert isinstance(obj, dict)
        type = TypeEnum(obj["type"])
        declaration = from_union([GetSignature.from_dict, from_none], obj.get("declaration"))
        name = from_union([Name, from_none], obj.get("name"))
        return PurpleType(type, declaration, name)

    def to_dict(self) -> dict:
        result: dict = {}
        result["type"] = to_enum(TypeEnum, self.type)
        if self.declaration is not None:
            result["declaration"] = from_union([lambda x: to_class(GetSignature, x), from_none], self.declaration)
        if self.name is not None:
            result["name"] = from_union([lambda x: to_enum(Name, x), from_none], self.name)
        return result


@dataclass
class GetSignatureChild:
    flags: FluffyFlags
    id: int
    kind: int
    kind_string: PurpleKindString
    name: str
    sources: list[Source]
    type: PurpleType
    comment: FluffyComment | None

    @staticmethod
    def from_dict(obj: Any) -> 'GetSignatureChild':
        assert isinstance(obj, dict)
        flags = FluffyFlags.from_dict(obj["flags"])
        id = from_int(obj["id"])
        kind = from_int(obj["kind"])
        kind_string = PurpleKindString(obj["kindString"])
        name = from_str(obj["name"])
        sources = from_list(Source.from_dict, obj["sources"])
        type = PurpleType.from_dict(obj["type"])
        comment = from_union([FluffyComment.from_dict, from_none], obj.get("comment"))
        return GetSignatureChild(flags, id, kind, kind_string, name, sources, type, comment)

    def to_dict(self) -> dict:
        result: dict = {}
        result["flags"] = to_class(FluffyFlags, self.flags)
        result["id"] = from_int(self.id)
        result["kind"] = from_int(self.kind)
        result["kindString"] = to_enum(PurpleKindString, self.kind_string)
        result["name"] = from_str(self.name)
        result["sources"] = from_list(lambda x: to_class(Source, x), self.sources)
        result["type"] = to_class(PurpleType, self.type)
        if self.comment is not None:
            result["comment"] = from_union([lambda x: to_class(FluffyComment, x), from_none], self.comment)
        return result


@dataclass
class GetSignature:
    flags: GetSignatureFlags
    id: int
    kind: int
    kind_string: str
    name: str
    children: list[GetSignatureChild] | None
    comment: GetSignatureComment | None
    default_value: str | None
    groups: list[Group] | None
    parameters: list[GetSignatureParameter] | None
    signatures: list[IndexSignatureElement] | None
    sources: list[Source] | None
    type: GetSignatureType | None
    type_parameter: 'list[GetSignature] | None'

    @staticmethod
    def from_dict(obj: Any) -> 'GetSignature':
        assert isinstance(obj, dict)
        flags = GetSignatureFlags.from_dict(obj["flags"])
        id = from_int(obj["id"])
        kind = from_int(obj["kind"])
        kind_string = from_str(obj["kindString"])
        name = from_str(obj["name"])
        children = from_union([lambda x: from_list(GetSignatureChild.from_dict, x), from_none], obj.get("children"))
        comment = from_union([GetSignatureComment.from_dict, from_none], obj.get("comment"))
        default_value = from_union([from_none, from_str], obj.get("defaultValue"))
        groups = from_union([lambda x: from_list(Group.from_dict, x), from_none], obj.get("groups"))
        parameters = from_union([lambda x: from_list(GetSignatureParameter.from_dict, x), from_none], obj.get("parameters"))
        signatures = from_union([lambda x: from_list(IndexSignatureElement.from_dict, x), from_none], obj.get("signatures"))
        sources = from_union([lambda x: from_list(Source.from_dict, x), from_none], obj.get("sources"))
        type = from_union([GetSignatureType.from_dict, from_none], obj.get("type"))
        type_parameter = from_union([lambda x: from_list(GetSignature.from_dict, x), from_none], obj.get("typeParameter"))
        return GetSignature(flags, id, kind, kind_string, name, children, comment, default_value, groups, parameters, signatures, sources, type, type_parameter)

    def to_dict(self) -> dict:
        result: dict = {}
        result["flags"] = to_class(GetSignatureFlags, self.flags)
        result["id"] = from_int(self.id)
        result["kind"] = from_int(self.kind)
        result["kindString"] = from_str(self.kind_string)
        result["name"] = from_str(self.name)
        if self.children is not None:
            result["children"] = from_union([lambda x: from_list(lambda x: to_class(GetSignatureChild, x), x), from_none], self.children)
        if self.comment is not None:
            result["comment"] = from_union([lambda x: to_class(GetSignatureComment, x), from_none], self.comment)
        if self.default_value is not None:
            result["defaultValue"] = from_union([from_none, from_str], self.default_value)
        if self.groups is not None:
            result["groups"] = from_union([lambda x: from_list(lambda x: to_class(Group, x), x), from_none], self.groups)
        if self.parameters is not None:
            result["parameters"] = from_union([lambda x: from_list(lambda x: to_class(GetSignatureParameter, x), x), from_none], self.parameters)
        if self.signatures is not None:
            result["signatures"] = from_union([lambda x: from_list(lambda x: to_class(IndexSignatureElement, x), x), from_none], self.signatures)
        if self.sources is not None:
            result["sources"] = from_union([lambda x: from_list(lambda x: to_class(Source, x), x), from_none], self.sources)
        if self.type is not None:
            result["type"] = from_union([lambda x: to_class(GetSignatureType, x), from_none], self.type)
        if self.type_parameter is not None:
            result["typeParameter"] = from_union([lambda x: from_list(lambda x: to_class(GetSignature, x), x), from_none], self.type_parameter)
        return result


@dataclass
class PurpleDeclaration:
    children: list[GetSignature]
    flags: GetSignatureFlags
    groups: list[Group]
    id: int
    kind: int
    kind_string: str
    name: str

    @staticmethod
    def from_dict(obj: Any) -> 'PurpleDeclaration':
        assert isinstance(obj, dict)
        children = from_list(GetSignature.from_dict, obj["children"])
        flags = GetSignatureFlags.from_dict(obj["flags"])
        groups = from_list(Group.from_dict, obj["groups"])
        id = from_int(obj["id"])
        kind = from_int(obj["kind"])
        kind_string = from_str(obj["kindString"])
        name = from_str(obj["name"])
        return PurpleDeclaration(children, flags, groups, id, kind, kind_string, name)

    def to_dict(self) -> dict:
        result: dict = {}
        result["children"] = from_list(lambda x: to_class(GetSignature, x), self.children)
        result["flags"] = to_class(GetSignatureFlags, self.flags)
        result["groups"] = from_list(lambda x: to_class(Group, x), self.groups)
        result["id"] = from_int(self.id)
        result["kind"] = from_int(self.kind)
        result["kindString"] = from_str(self.kind_string)
        result["name"] = from_str(self.name)
        return result


@dataclass
class TentacledType:
    type: TypeEnum
    declaration: PurpleDeclaration | None
    name: Name | None

    @staticmethod
    def from_dict(obj: Any) -> 'TentacledType':
        assert isinstance(obj, dict)
        type = TypeEnum(obj["type"])
        declaration = from_union([PurpleDeclaration.from_dict, from_none], obj.get("declaration"))
        name = from_union([Name, from_none], obj.get("name"))
        return TentacledType(type, declaration, name)

    def to_dict(self) -> dict:
        result: dict = {}
        result["type"] = to_enum(TypeEnum, self.type)
        if self.declaration is not None:
            result["declaration"] = from_union([lambda x: to_class(PurpleDeclaration, x), from_none], self.declaration)
        if self.name is not None:
            result["name"] = from_union([lambda x: to_enum(Name, x), from_none], self.name)
        return result


@dataclass
class PurpleSignature:
    flags: GetSignatureFlags
    id: int
    kind: int
    kind_string: SignatureKindString
    name: str
    parameters: list[GetSignature]
    type: TentacledType
    comment: PurpleComment | None

    @staticmethod
    def from_dict(obj: Any) -> 'PurpleSignature':
        assert isinstance(obj, dict)
        flags = GetSignatureFlags.from_dict(obj["flags"])
        id = from_int(obj["id"])
        kind = from_int(obj["kind"])
        kind_string = SignatureKindString(obj["kindString"])
        name = from_str(obj["name"])
        parameters = from_list(GetSignature.from_dict, obj["parameters"])
        type = TentacledType.from_dict(obj["type"])
        comment = from_union([PurpleComment.from_dict, from_none], obj.get("comment"))
        return PurpleSignature(flags, id, kind, kind_string, name, parameters, type, comment)

    def to_dict(self) -> dict:
        result: dict = {}
        result["flags"] = to_class(GetSignatureFlags, self.flags)
        result["id"] = from_int(self.id)
        result["kind"] = from_int(self.kind)
        result["kindString"] = to_enum(SignatureKindString, self.kind_string)
        result["name"] = from_str(self.name)
        result["parameters"] = from_list(lambda x: to_class(GetSignature, x), self.parameters)
        result["type"] = to_class(TentacledType, self.type)
        if self.comment is not None:
            result["comment"] = from_union([lambda x: to_class(PurpleComment, x), from_none], self.comment)
        return result


@dataclass
class TypeElement:
    type: TypeEnum
    declaration: GetSignature | None
    element_type: ElementType | None
    name: Name | None
    type_arguments: list[ElementType] | None

    @staticmethod
    def from_dict(obj: Any) -> 'TypeElement':
        assert isinstance(obj, dict)
        type = TypeEnum(obj["type"])
        declaration = from_union([GetSignature.from_dict, from_none], obj.get("declaration"))
        element_type = from_union([ElementType.from_dict, from_none], obj.get("elementType"))
        name = from_union([Name, from_none], obj.get("name"))
        type_arguments = from_union([lambda x: from_list(ElementType.from_dict, x), from_none], obj.get("typeArguments"))
        return TypeElement(type, declaration, element_type, name, type_arguments)

    def to_dict(self) -> dict:
        result: dict = {}
        result["type"] = to_enum(TypeEnum, self.type)
        if self.declaration is not None:
            result["declaration"] = from_union([lambda x: to_class(GetSignature, x), from_none], self.declaration)
        if self.element_type is not None:
            result["elementType"] = from_union([lambda x: to_class(ElementType, x), from_none], self.element_type)
        if self.name is not None:
            result["name"] = from_union([lambda x: to_enum(Name, x), from_none], self.name)
        if self.type_arguments is not None:
            result["typeArguments"] = from_union([lambda x: from_list(lambda x: to_class(ElementType, x), x), from_none], self.type_arguments)
        return result


@dataclass
class TentacledChild:
    flags: PurpleFlags
    id: int
    kind: int
    kind_string: PurpleKindString
    name: str
    sources: list[Source]
    comment: PurpleComment | None
    default_value: str | None
    signatures: list[PurpleSignature] | None
    type: TypeElement | None

    @staticmethod
    def from_dict(obj: Any) -> 'TentacledChild':
        assert isinstance(obj, dict)
        flags = PurpleFlags.from_dict(obj["flags"])
        id = from_int(obj["id"])
        kind = from_int(obj["kind"])
        kind_string = PurpleKindString(obj["kindString"])
        name = from_str(obj["name"])
        sources = from_list(Source.from_dict, obj["sources"])
        comment = from_union([PurpleComment.from_dict, from_none], obj.get("comment"))
        default_value = from_union([from_none, from_str], obj.get("defaultValue"))
        signatures = from_union([lambda x: from_list(PurpleSignature.from_dict, x), from_none], obj.get("signatures"))
        type = from_union([TypeElement.from_dict, from_none], obj.get("type"))
        return TentacledChild(flags, id, kind, kind_string, name, sources, comment, default_value, signatures, type)

    def to_dict(self) -> dict:
        result: dict = {}
        result["flags"] = to_class(PurpleFlags, self.flags)
        result["id"] = from_int(self.id)
        result["kind"] = from_int(self.kind)
        result["kindString"] = to_enum(PurpleKindString, self.kind_string)
        result["name"] = from_str(self.name)
        result["sources"] = from_list(lambda x: to_class(Source, x), self.sources)
        if self.comment is not None:
            result["comment"] = from_union([lambda x: to_class(PurpleComment, x), from_none], self.comment)
        if self.default_value is not None:
            result["defaultValue"] = from_union([from_none, from_str], self.default_value)
        if self.signatures is not None:
            result["signatures"] = from_union([lambda x: from_list(lambda x: to_class(PurpleSignature, x), x), from_none], self.signatures)
        if self.type is not None:
            result["type"] = from_union([lambda x: to_class(TypeElement, x), from_none], self.type)
        return result


@dataclass
class Tag:
    tag: str
    text: str

    @staticmethod
    def from_dict(obj: Any) -> 'Tag':
        assert isinstance(obj, dict)
        tag = from_str(obj["tag"])
        text = from_str(obj["text"])
        return Tag(tag, text)

    def to_dict(self) -> dict:
        result: dict = {}
        result["tag"] = from_str(self.tag)
        result["text"] = from_str(self.text)
        return result


@dataclass
class StickyComment:
    returns: str | None
    short_text: str | None
    tags: list[Tag] | None
    text: str | None

    @staticmethod
    def from_dict(obj: Any) -> 'StickyComment':
        assert isinstance(obj, dict)
        returns = from_union([from_none, from_str], obj.get("returns"))
        short_text = from_union([from_none, from_str], obj.get("shortText"))
        tags = from_union([lambda x: from_list(Tag.from_dict, x), from_none], obj.get("tags"))
        text = from_union([from_none, from_str], obj.get("text"))
        return StickyComment(returns, short_text, tags, text)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.returns is not None:
            result["returns"] = from_union([from_none, from_str], self.returns)
        if self.short_text is not None:
            result["shortText"] = from_union([from_none, from_str], self.short_text)
        if self.tags is not None:
            result["tags"] = from_union([lambda x: from_list(lambda x: to_class(Tag, x), x), from_none], self.tags)
        if self.text is not None:
            result["text"] = from_union([from_none, from_str], self.text)
        return result


@dataclass
class StickyFlags:
    is_abstract: bool | None
    is_constructor_property: bool | None
    is_exported: bool | None
    is_private: bool | None
    is_protected: bool | None
    is_public: bool | None
    is_static: bool | None

    @staticmethod
    def from_dict(obj: Any) -> 'StickyFlags':
        assert isinstance(obj, dict)
        is_abstract = from_union([from_bool, from_none], obj.get("isAbstract"))
        is_constructor_property = from_union([from_bool, from_none], obj.get("isConstructorProperty"))
        is_exported = from_union([from_bool, from_none], obj.get("isExported"))
        is_private = from_union([from_bool, from_none], obj.get("isPrivate"))
        is_protected = from_union([from_bool, from_none], obj.get("isProtected"))
        is_public = from_union([from_bool, from_none], obj.get("isPublic"))
        is_static = from_union([from_bool, from_none], obj.get("isStatic"))
        return StickyFlags(is_abstract, is_constructor_property, is_exported, is_private, is_protected, is_public, is_static)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.is_abstract is not None:
            result["isAbstract"] = from_union([from_bool, from_none], self.is_abstract)
        if self.is_constructor_property is not None:
            result["isConstructorProperty"] = from_union([from_bool, from_none], self.is_constructor_property)
        if self.is_exported is not None:
            result["isExported"] = from_union([from_bool, from_none], self.is_exported)
        if self.is_private is not None:
            result["isPrivate"] = from_union([from_bool, from_none], self.is_private)
        if self.is_protected is not None:
            result["isProtected"] = from_union([from_bool, from_none], self.is_protected)
        if self.is_public is not None:
            result["isPublic"] = from_union([from_bool, from_none], self.is_public)
        if self.is_static is not None:
            result["isStatic"] = from_union([from_bool, from_none], self.is_static)
        return result


@dataclass
class ExtendedBy:
    name: str
    type: TypeEnum
    constraint: 'ExtendedBy | None'
    id: int | None
    type_arguments: 'list[ExtendedBy] | None'

    @staticmethod
    def from_dict(obj: Any) -> 'ExtendedBy':
        assert isinstance(obj, dict)
        name = from_str(obj["name"])
        type = TypeEnum(obj["type"])
        constraint = from_union([ExtendedBy.from_dict, from_none], obj.get("constraint"))
        id = from_union([from_int, from_none], obj.get("id"))
        type_arguments = from_union([lambda x: from_list(ExtendedBy.from_dict, x), from_none], obj.get("typeArguments"))
        return ExtendedBy(name, type, constraint, id, type_arguments)

    def to_dict(self) -> dict:
        result: dict = {}
        result["name"] = from_str(self.name)
        result["type"] = to_enum(TypeEnum, self.type)
        if self.constraint is not None:
            result["constraint"] = from_union([lambda x: to_class(ExtendedBy, x), from_none], self.constraint)
        if self.id is not None:
            result["id"] = from_union([from_int, from_none], self.id)
        if self.type_arguments is not None:
            result["typeArguments"] = from_union([lambda x: from_list(lambda x: to_class(ExtendedBy, x), x), from_none], self.type_arguments)
        return result


@dataclass
class IndigoFlags:
    is_private: bool | None
    is_protected: bool | None

    @staticmethod
    def from_dict(obj: Any) -> 'IndigoFlags':
        assert isinstance(obj, dict)
        is_private = from_union([from_bool, from_none], obj.get("isPrivate"))
        is_protected = from_union([from_bool, from_none], obj.get("isProtected"))
        return IndigoFlags(is_private, is_protected)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.is_private is not None:
            result["isPrivate"] = from_union([from_bool, from_none], self.is_private)
        if self.is_protected is not None:
            result["isProtected"] = from_union([from_bool, from_none], self.is_protected)
        return result


@dataclass
class StickyType:
    type: TypeEnum
    constraint: ExtendedBy | None
    declaration: GetSignature | None
    element_type: ElementType | None
    elements: list[ExtendedBy] | None
    id: int | None
    name: str | None
    type_arguments: list[ElementType] | None

    @staticmethod
    def from_dict(obj: Any) -> 'StickyType':
        assert isinstance(obj, dict)
        type = TypeEnum(obj["type"])
        constraint = from_union([ExtendedBy.from_dict, from_none], obj.get("constraint"))
        declaration = from_union([GetSignature.from_dict, from_none], obj.get("declaration"))
        element_type = from_union([ElementType.from_dict, from_none], obj.get("elementType"))
        elements = from_union([lambda x: from_list(ExtendedBy.from_dict, x), from_none], obj.get("elements"))
        id = from_union([from_int, from_none], obj.get("id"))
        name = from_union([from_none, from_str], obj.get("name"))
        type_arguments = from_union([lambda x: from_list(ElementType.from_dict, x), from_none], obj.get("typeArguments"))
        return StickyType(type, constraint, declaration, element_type, elements, id, name, type_arguments)

    def to_dict(self) -> dict:
        result: dict = {}
        result["type"] = to_enum(TypeEnum, self.type)
        if self.constraint is not None:
            result["constraint"] = from_union([lambda x: to_class(ExtendedBy, x), from_none], self.constraint)
        if self.declaration is not None:
            result["declaration"] = from_union([lambda x: to_class(GetSignature, x), from_none], self.declaration)
        if self.element_type is not None:
            result["elementType"] = from_union([lambda x: to_class(ElementType, x), from_none], self.element_type)
        if self.elements is not None:
            result["elements"] = from_union([lambda x: from_list(lambda x: to_class(ExtendedBy, x), x), from_none], self.elements)
        if self.id is not None:
            result["id"] = from_union([from_int, from_none], self.id)
        if self.name is not None:
            result["name"] = from_union([from_none, from_str], self.name)
        if self.type_arguments is not None:
            result["typeArguments"] = from_union([lambda x: from_list(lambda x: to_class(ElementType, x), x), from_none], self.type_arguments)
        return result


@dataclass
class PurpleParameter:
    flags: GetSignatureFlags
    id: int
    kind: int
    kind_string: ParameterKindString
    name: str
    type: StickyType
    comment: TentacledComment | None

    @staticmethod
    def from_dict(obj: Any) -> 'PurpleParameter':
        assert isinstance(obj, dict)
        flags = GetSignatureFlags.from_dict(obj["flags"])
        id = from_int(obj["id"])
        kind = from_int(obj["kind"])
        kind_string = ParameterKindString(obj["kindString"])
        name = from_str(obj["name"])
        type = StickyType.from_dict(obj["type"])
        comment = from_union([TentacledComment.from_dict, from_none], obj.get("comment"))
        return PurpleParameter(flags, id, kind, kind_string, name, type, comment)

    def to_dict(self) -> dict:
        result: dict = {}
        result["flags"] = to_class(GetSignatureFlags, self.flags)
        result["id"] = from_int(self.id)
        result["kind"] = from_int(self.kind)
        result["kindString"] = to_enum(ParameterKindString, self.kind_string)
        result["name"] = from_str(self.name)
        result["type"] = to_class(StickyType, self.type)
        if self.comment is not None:
            result["comment"] = from_union([lambda x: to_class(TentacledComment, x), from_none], self.comment)
        return result


@dataclass
class FluffySignature:
    flags: IndigoFlags
    id: int
    kind: int
    kind_string: SignatureKindString
    name: str
    type: ExtendedBy
    comment: StickyComment | None
    implementation_of: ExtendedBy | None
    inherited_from: ExtendedBy | None
    overwrites: ExtendedBy | None
    parameters: list[PurpleParameter] | None
    type_parameter: list[GetSignature] | None

    @staticmethod
    def from_dict(obj: Any) -> 'FluffySignature':
        assert isinstance(obj, dict)
        flags = IndigoFlags.from_dict(obj["flags"])
        id = from_int(obj["id"])
        kind = from_int(obj["kind"])
        kind_string = SignatureKindString(obj["kindString"])
        name = from_str(obj["name"])
        type = ExtendedBy.from_dict(obj["type"])
        comment = from_union([StickyComment.from_dict, from_none], obj.get("comment"))
        implementation_of = from_union([ExtendedBy.from_dict, from_none], obj.get("implementationOf"))
        inherited_from = from_union([ExtendedBy.from_dict, from_none], obj.get("inheritedFrom"))
        overwrites = from_union([ExtendedBy.from_dict, from_none], obj.get("overwrites"))
        parameters = from_union([lambda x: from_list(PurpleParameter.from_dict, x), from_none], obj.get("parameters"))
        type_parameter = from_union([lambda x: from_list(GetSignature.from_dict, x), from_none], obj.get("typeParameter"))
        return FluffySignature(flags, id, kind, kind_string, name, type, comment, implementation_of, inherited_from, overwrites, parameters, type_parameter)

    def to_dict(self) -> dict:
        result: dict = {}
        result["flags"] = to_class(IndigoFlags, self.flags)
        result["id"] = from_int(self.id)
        result["kind"] = from_int(self.kind)
        result["kindString"] = to_enum(SignatureKindString, self.kind_string)
        result["name"] = from_str(self.name)
        result["type"] = to_class(ExtendedBy, self.type)
        if self.comment is not None:
            result["comment"] = from_union([lambda x: to_class(StickyComment, x), from_none], self.comment)
        if self.implementation_of is not None:
            result["implementationOf"] = from_union([lambda x: to_class(ExtendedBy, x), from_none], self.implementation_of)
        if self.inherited_from is not None:
            result["inheritedFrom"] = from_union([lambda x: to_class(ExtendedBy, x), from_none], self.inherited_from)
        if self.overwrites is not None:
            result["overwrites"] = from_union([lambda x: to_class(ExtendedBy, x), from_none], self.overwrites)
        if self.parameters is not None:
            result["parameters"] = from_union([lambda x: from_list(lambda x: to_class(PurpleParameter, x), x), from_none], self.parameters)
        if self.type_parameter is not None:
            result["typeParameter"] = from_union([lambda x: from_list(lambda x: to_class(GetSignature, x), x), from_none], self.type_parameter)
        return result


@dataclass
class IndecentType:
    type: TypeEnum
    declaration: GetSignature | None
    elements: list[ElementType] | None
    name: Name | None

    @staticmethod
    def from_dict(obj: Any) -> 'IndecentType':
        assert isinstance(obj, dict)
        type = TypeEnum(obj["type"])
        declaration = from_union([GetSignature.from_dict, from_none], obj.get("declaration"))
        elements = from_union([lambda x: from_list(ElementType.from_dict, x), from_none], obj.get("elements"))
        name = from_union([Name, from_none], obj.get("name"))
        return IndecentType(type, declaration, elements, name)

    def to_dict(self) -> dict:
        result: dict = {}
        result["type"] = to_enum(TypeEnum, self.type)
        if self.declaration is not None:
            result["declaration"] = from_union([lambda x: to_class(GetSignature, x), from_none], self.declaration)
        if self.elements is not None:
            result["elements"] = from_union([lambda x: from_list(lambda x: to_class(ElementType, x), x), from_none], self.elements)
        if self.name is not None:
            result["name"] = from_union([lambda x: to_enum(Name, x), from_none], self.name)
        return result


@dataclass
class StickyChild:
    flags: FluffyFlags
    id: int
    kind: int
    kind_string: PurpleKindString
    name: str
    sources: list[Source]
    type: IndecentType
    comment: FluffyComment | None

    @staticmethod
    def from_dict(obj: Any) -> 'StickyChild':
        assert isinstance(obj, dict)
        flags = FluffyFlags.from_dict(obj["flags"])
        id = from_int(obj["id"])
        kind = from_int(obj["kind"])
        kind_string = PurpleKindString(obj["kindString"])
        name = from_str(obj["name"])
        sources = from_list(Source.from_dict, obj["sources"])
        type = IndecentType.from_dict(obj["type"])
        comment = from_union([FluffyComment.from_dict, from_none], obj.get("comment"))
        return StickyChild(flags, id, kind, kind_string, name, sources, type, comment)

    def to_dict(self) -> dict:
        result: dict = {}
        result["flags"] = to_class(FluffyFlags, self.flags)
        result["id"] = from_int(self.id)
        result["kind"] = from_int(self.kind)
        result["kindString"] = to_enum(PurpleKindString, self.kind_string)
        result["name"] = from_str(self.name)
        result["sources"] = from_list(lambda x: to_class(Source, x), self.sources)
        result["type"] = to_class(IndecentType, self.type)
        if self.comment is not None:
            result["comment"] = from_union([lambda x: to_class(FluffyComment, x), from_none], self.comment)
        return result


@dataclass
class HilariousType:
    declaration: GetSignature
    type: TypeEnum

    @staticmethod
    def from_dict(obj: Any) -> 'HilariousType':
        assert isinstance(obj, dict)
        declaration = GetSignature.from_dict(obj["declaration"])
        type = TypeEnum(obj["type"])
        return HilariousType(declaration, type)

    def to_dict(self) -> dict:
        result: dict = {}
        result["declaration"] = to_class(GetSignature, self.declaration)
        result["type"] = to_enum(TypeEnum, self.type)
        return result


@dataclass
class IndexSignature:
    flags: GetSignatureFlags
    id: int
    kind: int
    kind_string: str
    name: str
    parameters: list[GetSignature]
    type: HilariousType

    @staticmethod
    def from_dict(obj: Any) -> 'IndexSignature':
        assert isinstance(obj, dict)
        flags = GetSignatureFlags.from_dict(obj["flags"])
        id = from_int(obj["id"])
        kind = from_int(obj["kind"])
        kind_string = from_str(obj["kindString"])
        name = from_str(obj["name"])
        parameters = from_list(GetSignature.from_dict, obj["parameters"])
        type = HilariousType.from_dict(obj["type"])
        return IndexSignature(flags, id, kind, kind_string, name, parameters, type)

    def to_dict(self) -> dict:
        result: dict = {}
        result["flags"] = to_class(GetSignatureFlags, self.flags)
        result["id"] = from_int(self.id)
        result["kind"] = from_int(self.kind)
        result["kindString"] = from_str(self.kind_string)
        result["name"] = from_str(self.name)
        result["parameters"] = from_list(lambda x: to_class(GetSignature, x), self.parameters)
        result["type"] = to_class(HilariousType, self.type)
        return result


@dataclass
class IndigoComment:
    returns: str
    short_text: str

    @staticmethod
    def from_dict(obj: Any) -> 'IndigoComment':
        assert isinstance(obj, dict)
        returns = from_str(obj["returns"])
        short_text = from_str(obj["shortText"])
        return IndigoComment(returns, short_text)

    def to_dict(self) -> dict:
        result: dict = {}
        result["returns"] = from_str(self.returns)
        result["shortText"] = from_str(self.short_text)
        return result


@dataclass
class FluffyParameter:
    flags: FluffyFlags
    id: int
    kind: int
    kind_string: str
    name: str
    type: ElementType
    comment: FluffyComment | None
    sources: list[Source] | None

    @staticmethod
    def from_dict(obj: Any) -> 'FluffyParameter':
        assert isinstance(obj, dict)
        flags = FluffyFlags.from_dict(obj["flags"])
        id = from_int(obj["id"])
        kind = from_int(obj["kind"])
        kind_string = from_str(obj["kindString"])
        name = from_str(obj["name"])
        type = ElementType.from_dict(obj["type"])
        comment = from_union([FluffyComment.from_dict, from_none], obj.get("comment"))
        sources = from_union([lambda x: from_list(Source.from_dict, x), from_none], obj.get("sources"))
        return FluffyParameter(flags, id, kind, kind_string, name, type, comment, sources)

    def to_dict(self) -> dict:
        result: dict = {}
        result["flags"] = to_class(FluffyFlags, self.flags)
        result["id"] = from_int(self.id)
        result["kind"] = from_int(self.kind)
        result["kindString"] = from_str(self.kind_string)
        result["name"] = from_str(self.name)
        result["type"] = to_class(ElementType, self.type)
        if self.comment is not None:
            result["comment"] = from_union([lambda x: to_class(FluffyComment, x), from_none], self.comment)
        if self.sources is not None:
            result["sources"] = from_union([lambda x: from_list(lambda x: to_class(Source, x), x), from_none], self.sources)
        return result


@dataclass
class TentacledSignature:
    flags: GetSignatureFlags
    id: int
    kind: int
    kind_string: SignatureKindString
    name: str
    type: ExtendedBy
    comment: IndigoComment | None
    parameters: list[FluffyParameter] | None

    @staticmethod
    def from_dict(obj: Any) -> 'TentacledSignature':
        assert isinstance(obj, dict)
        flags = GetSignatureFlags.from_dict(obj["flags"])
        id = from_int(obj["id"])
        kind = from_int(obj["kind"])
        kind_string = SignatureKindString(obj["kindString"])
        name = from_str(obj["name"])
        type = ExtendedBy.from_dict(obj["type"])
        comment = from_union([IndigoComment.from_dict, from_none], obj.get("comment"))
        parameters = from_union([lambda x: from_list(FluffyParameter.from_dict, x), from_none], obj.get("parameters"))
        return TentacledSignature(flags, id, kind, kind_string, name, type, comment, parameters)

    def to_dict(self) -> dict:
        result: dict = {}
        result["flags"] = to_class(GetSignatureFlags, self.flags)
        result["id"] = from_int(self.id)
        result["kind"] = from_int(self.kind)
        result["kindString"] = to_enum(SignatureKindString, self.kind_string)
        result["name"] = from_str(self.name)
        result["type"] = to_class(ExtendedBy, self.type)
        if self.comment is not None:
            result["comment"] = from_union([lambda x: to_class(IndigoComment, x), from_none], self.comment)
        if self.parameters is not None:
            result["parameters"] = from_union([lambda x: from_list(lambda x: to_class(FluffyParameter, x), x), from_none], self.parameters)
        return result


@dataclass
class FluffyDeclaration:
    flags: GetSignatureFlags
    id: int
    kind: int
    kind_string: str
    name: str
    sources: list[Source]
    children: list[StickyChild] | None
    groups: list[Group] | None
    index_signature: IndexSignature | None
    signatures: list[TentacledSignature] | None

    @staticmethod
    def from_dict(obj: Any) -> 'FluffyDeclaration':
        assert isinstance(obj, dict)
        flags = GetSignatureFlags.from_dict(obj["flags"])
        id = from_int(obj["id"])
        kind = from_int(obj["kind"])
        kind_string = from_str(obj["kindString"])
        name = from_str(obj["name"])
        sources = from_list(Source.from_dict, obj["sources"])
        children = from_union([lambda x: from_list(StickyChild.from_dict, x), from_none], obj.get("children"))
        groups = from_union([lambda x: from_list(Group.from_dict, x), from_none], obj.get("groups"))
        index_signature = from_union([IndexSignature.from_dict, from_none], obj.get("indexSignature"))
        signatures = from_union([lambda x: from_list(TentacledSignature.from_dict, x), from_none], obj.get("signatures"))
        return FluffyDeclaration(flags, id, kind, kind_string, name, sources, children, groups, index_signature, signatures)

    def to_dict(self) -> dict:
        result: dict = {}
        result["flags"] = to_class(GetSignatureFlags, self.flags)
        result["id"] = from_int(self.id)
        result["kind"] = from_int(self.kind)
        result["kindString"] = from_str(self.kind_string)
        result["name"] = from_str(self.name)
        result["sources"] = from_list(lambda x: to_class(Source, x), self.sources)
        if self.children is not None:
            result["children"] = from_union([lambda x: from_list(lambda x: to_class(StickyChild, x), x), from_none], self.children)
        if self.groups is not None:
            result["groups"] = from_union([lambda x: from_list(lambda x: to_class(Group, x), x), from_none], self.groups)
        if self.index_signature is not None:
            result["indexSignature"] = from_union([lambda x: to_class(IndexSignature, x), from_none], self.index_signature)
        if self.signatures is not None:
            result["signatures"] = from_union([lambda x: from_list(lambda x: to_class(TentacledSignature, x), x), from_none], self.signatures)
        return result


@dataclass
class PurpleTypeArgument:
    operator: str
    target: ElementType
    type: str

    @staticmethod
    def from_dict(obj: Any) -> 'PurpleTypeArgument':
        assert isinstance(obj, dict)
        operator = from_str(obj["operator"])
        target = ElementType.from_dict(obj["target"])
        type = from_str(obj["type"])
        return PurpleTypeArgument(operator, target, type)

    def to_dict(self) -> dict:
        result: dict = {}
        result["operator"] = from_str(self.operator)
        result["target"] = to_class(ElementType, self.target)
        result["type"] = from_str(self.type)
        return result


@dataclass
class IndigoType:
    type: TypeEnum
    constraint: ExtendedBy | None
    declaration: FluffyDeclaration | None
    element_type: ExtendedBy | None
    elements: list[ElementType] | None
    id: int | None
    name: str | None
    type_arguments: list[PurpleTypeArgument] | None
    types: list[TypeElement] | None

    @staticmethod
    def from_dict(obj: Any) -> 'IndigoType':
        assert isinstance(obj, dict)
        type = TypeEnum(obj["type"])
        constraint = from_union([ExtendedBy.from_dict, from_none], obj.get("constraint"))
        declaration = from_union([FluffyDeclaration.from_dict, from_none], obj.get("declaration"))
        element_type = from_union([ExtendedBy.from_dict, from_none], obj.get("elementType"))
        elements = from_union([lambda x: from_list(ElementType.from_dict, x), from_none], obj.get("elements"))
        id = from_union([from_int, from_none], obj.get("id"))
        name = from_union([from_none, from_str], obj.get("name"))
        type_arguments = from_union([lambda x: from_list(PurpleTypeArgument.from_dict, x), from_none], obj.get("typeArguments"))
        types = from_union([lambda x: from_list(TypeElement.from_dict, x), from_none], obj.get("types"))
        return IndigoType(type, constraint, declaration, element_type, elements, id, name, type_arguments, types)

    def to_dict(self) -> dict:
        result: dict = {}
        result["type"] = to_enum(TypeEnum, self.type)
        if self.constraint is not None:
            result["constraint"] = from_union([lambda x: to_class(ExtendedBy, x), from_none], self.constraint)
        if self.declaration is not None:
            result["declaration"] = from_union([lambda x: to_class(FluffyDeclaration, x), from_none], self.declaration)
        if self.element_type is not None:
            result["elementType"] = from_union([lambda x: to_class(ExtendedBy, x), from_none], self.element_type)
        if self.elements is not None:
            result["elements"] = from_union([lambda x: from_list(lambda x: to_class(ElementType, x), x), from_none], self.elements)
        if self.id is not None:
            result["id"] = from_union([from_int, from_none], self.id)
        if self.name is not None:
            result["name"] = from_union([from_none, from_str], self.name)
        if self.type_arguments is not None:
            result["typeArguments"] = from_union([lambda x: from_list(lambda x: to_class(PurpleTypeArgument, x), x), from_none], self.type_arguments)
        if self.types is not None:
            result["types"] = from_union([lambda x: from_list(lambda x: to_class(TypeElement, x), x), from_none], self.types)
        return result


@dataclass
class FluffyChild:
    flags: StickyFlags
    id: int
    kind: int
    kind_string: PurpleKindString
    name: str
    sources: list[Source]
    children: list[TentacledChild] | None
    comment: StickyComment | None
    default_value: str | None
    get_signature: GetSignature | None
    groups: list[Group] | None
    implementation_of: ExtendedBy | None
    inherited_from: ExtendedBy | None
    overwrites: ExtendedBy | None
    set_signature: GetSignature | None
    signatures: list[FluffySignature] | None
    type: IndigoType | None

    @staticmethod
    def from_dict(obj: Any) -> 'FluffyChild':
        assert isinstance(obj, dict)
        flags = StickyFlags.from_dict(obj["flags"])
        id = from_int(obj["id"])
        kind = from_int(obj["kind"])
        kind_string = PurpleKindString(obj["kindString"])
        name = from_str(obj["name"])
        sources = from_list(Source.from_dict, obj["sources"])
        children = from_union([lambda x: from_list(TentacledChild.from_dict, x), from_none], obj.get("children"))
        comment = from_union([StickyComment.from_dict, from_none], obj.get("comment"))
        default_value = from_union([from_none, from_str], obj.get("defaultValue"))
        get_signature = from_union([GetSignature.from_dict, from_none], obj.get("getSignature"))
        groups = from_union([lambda x: from_list(Group.from_dict, x), from_none], obj.get("groups"))
        implementation_of = from_union([ExtendedBy.from_dict, from_none], obj.get("implementationOf"))
        inherited_from = from_union([ExtendedBy.from_dict, from_none], obj.get("inheritedFrom"))
        overwrites = from_union([ExtendedBy.from_dict, from_none], obj.get("overwrites"))
        set_signature = from_union([GetSignature.from_dict, from_none], obj.get("setSignature"))
        signatures = from_union([lambda x: from_list(FluffySignature.from_dict, x), from_none], obj.get("signatures"))
        type = from_union([IndigoType.from_dict, from_none], obj.get("type"))
        return FluffyChild(flags, id, kind, kind_string, name, sources, children, comment, default_value, get_signature, groups, implementation_of, inherited_from, overwrites, set_signature, signatures, type)

    def to_dict(self) -> dict:
        result: dict = {}
        result["flags"] = to_class(StickyFlags, self.flags)
        result["id"] = from_int(self.id)
        result["kind"] = from_int(self.kind)
        result["kindString"] = to_enum(PurpleKindString, self.kind_string)
        result["name"] = from_str(self.name)
        result["sources"] = from_list(lambda x: to_class(Source, x), self.sources)
        if self.children is not None:
            result["children"] = from_union([lambda x: from_list(lambda x: to_class(TentacledChild, x), x), from_none], self.children)
        if self.comment is not None:
            result["comment"] = from_union([lambda x: to_class(StickyComment, x), from_none], self.comment)
        if self.default_value is not None:
            result["defaultValue"] = from_union([from_none, from_str], self.default_value)
        if self.get_signature is not None:
            result["getSignature"] = from_union([lambda x: to_class(GetSignature, x), from_none], self.get_signature)
        if self.groups is not None:
            result["groups"] = from_union([lambda x: from_list(lambda x: to_class(Group, x), x), from_none], self.groups)
        if self.implementation_of is not None:
            result["implementationOf"] = from_union([lambda x: to_class(ExtendedBy, x), from_none], self.implementation_of)
        if self.inherited_from is not None:
            result["inheritedFrom"] = from_union([lambda x: to_class(ExtendedBy, x), from_none], self.inherited_from)
        if self.overwrites is not None:
            result["overwrites"] = from_union([lambda x: to_class(ExtendedBy, x), from_none], self.overwrites)
        if self.set_signature is not None:
            result["setSignature"] = from_union([lambda x: to_class(GetSignature, x), from_none], self.set_signature)
        if self.signatures is not None:
            result["signatures"] = from_union([lambda x: from_list(lambda x: to_class(FluffySignature, x), x), from_none], self.signatures)
        if self.type is not None:
            result["type"] = from_union([lambda x: to_class(IndigoType, x), from_none], self.type)
        return result


@dataclass
class IndecentFlags:
    has_export_assignment: bool | None
    is_abstract: bool | None
    is_const: bool | None
    is_exported: bool | None
    is_let: bool | None
    is_private: bool | None
    is_protected: bool | None

    @staticmethod
    def from_dict(obj: Any) -> 'IndecentFlags':
        assert isinstance(obj, dict)
        has_export_assignment = from_union([from_bool, from_none], obj.get("hasExportAssignment"))
        is_abstract = from_union([from_bool, from_none], obj.get("isAbstract"))
        is_const = from_union([from_bool, from_none], obj.get("isConst"))
        is_exported = from_union([from_bool, from_none], obj.get("isExported"))
        is_let = from_union([from_bool, from_none], obj.get("isLet"))
        is_private = from_union([from_bool, from_none], obj.get("isPrivate"))
        is_protected = from_union([from_bool, from_none], obj.get("isProtected"))
        return IndecentFlags(has_export_assignment, is_abstract, is_const, is_exported, is_let, is_private, is_protected)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.has_export_assignment is not None:
            result["hasExportAssignment"] = from_union([from_bool, from_none], self.has_export_assignment)
        if self.is_abstract is not None:
            result["isAbstract"] = from_union([from_bool, from_none], self.is_abstract)
        if self.is_const is not None:
            result["isConst"] = from_union([from_bool, from_none], self.is_const)
        if self.is_exported is not None:
            result["isExported"] = from_union([from_bool, from_none], self.is_exported)
        if self.is_let is not None:
            result["isLet"] = from_union([from_bool, from_none], self.is_let)
        if self.is_private is not None:
            result["isPrivate"] = from_union([from_bool, from_none], self.is_private)
        if self.is_protected is not None:
            result["isProtected"] = from_union([from_bool, from_none], self.is_protected)
        return result


class FluffyKindString(Enum):
    MODULE = "Module"
    CLASS = "Class"
    VARIABLE = "Variable"
    FUNCTION = "Function"
    INTERFACE = "Interface"
    ENUMERATION = "Enumeration"
    OBJECT_LITERAL = "Object literal"
    TYPE_ALIAS = "Type alias"


@dataclass
class IndigoChild:
    comment: FluffyComment
    flags: FluffyFlags
    id: int
    kind: int
    kind_string: PurpleKindString
    name: str
    sources: list[Source]
    type: IndecentType
    default_value: str | None

    @staticmethod
    def from_dict(obj: Any) -> 'IndigoChild':
        assert isinstance(obj, dict)
        comment = FluffyComment.from_dict(obj["comment"])
        flags = FluffyFlags.from_dict(obj["flags"])
        id = from_int(obj["id"])
        kind = from_int(obj["kind"])
        kind_string = PurpleKindString(obj["kindString"])
        name = from_str(obj["name"])
        sources = from_list(Source.from_dict, obj["sources"])
        type = IndecentType.from_dict(obj["type"])
        default_value = from_union([from_none, from_str], obj.get("defaultValue"))
        return IndigoChild(comment, flags, id, kind, kind_string, name, sources, type, default_value)

    def to_dict(self) -> dict:
        result: dict = {}
        result["comment"] = to_class(FluffyComment, self.comment)
        result["flags"] = to_class(FluffyFlags, self.flags)
        result["id"] = from_int(self.id)
        result["kind"] = from_int(self.kind)
        result["kindString"] = to_enum(PurpleKindString, self.kind_string)
        result["name"] = from_str(self.name)
        result["sources"] = from_list(lambda x: to_class(Source, x), self.sources)
        result["type"] = to_class(IndecentType, self.type)
        if self.default_value is not None:
            result["defaultValue"] = from_union([from_none, from_str], self.default_value)
        return result


@dataclass
class TentacledDeclaration:
    flags: GetSignatureFlags
    id: int
    kind: int
    kind_string: str
    name: str
    sources: list[Source]
    children: list[IndigoChild] | None
    groups: list[Group] | None
    index_signature: IndexSignatureElement | None
    signatures: list[GetSignature] | None

    @staticmethod
    def from_dict(obj: Any) -> 'TentacledDeclaration':
        assert isinstance(obj, dict)
        flags = GetSignatureFlags.from_dict(obj["flags"])
        id = from_int(obj["id"])
        kind = from_int(obj["kind"])
        kind_string = from_str(obj["kindString"])
        name = from_str(obj["name"])
        sources = from_list(Source.from_dict, obj["sources"])
        children = from_union([lambda x: from_list(IndigoChild.from_dict, x), from_none], obj.get("children"))
        groups = from_union([lambda x: from_list(Group.from_dict, x), from_none], obj.get("groups"))
        index_signature = from_union([IndexSignatureElement.from_dict, from_none], obj.get("indexSignature"))
        signatures = from_union([lambda x: from_list(GetSignature.from_dict, x), from_none], obj.get("signatures"))
        return TentacledDeclaration(flags, id, kind, kind_string, name, sources, children, groups, index_signature, signatures)

    def to_dict(self) -> dict:
        result: dict = {}
        result["flags"] = to_class(GetSignatureFlags, self.flags)
        result["id"] = from_int(self.id)
        result["kind"] = from_int(self.kind)
        result["kindString"] = from_str(self.kind_string)
        result["name"] = from_str(self.name)
        result["sources"] = from_list(lambda x: to_class(Source, x), self.sources)
        if self.children is not None:
            result["children"] = from_union([lambda x: from_list(lambda x: to_class(IndigoChild, x), x), from_none], self.children)
        if self.groups is not None:
            result["groups"] = from_union([lambda x: from_list(lambda x: to_class(Group, x), x), from_none], self.groups)
        if self.index_signature is not None:
            result["indexSignature"] = from_union([lambda x: to_class(IndexSignatureElement, x), from_none], self.index_signature)
        if self.signatures is not None:
            result["signatures"] = from_union([lambda x: from_list(lambda x: to_class(GetSignature, x), x), from_none], self.signatures)
        return result


@dataclass
class AmbitiousType:
    type: TypeEnum
    declaration: TentacledDeclaration | None
    element_type: ElementType | None
    id: int | None
    name: str | None
    type_arguments: list[ElementType] | None

    @staticmethod
    def from_dict(obj: Any) -> 'AmbitiousType':
        assert isinstance(obj, dict)
        type = TypeEnum(obj["type"])
        declaration = from_union([TentacledDeclaration.from_dict, from_none], obj.get("declaration"))
        element_type = from_union([ElementType.from_dict, from_none], obj.get("elementType"))
        id = from_union([from_int, from_none], obj.get("id"))
        name = from_union([from_none, from_str], obj.get("name"))
        type_arguments = from_union([lambda x: from_list(ElementType.from_dict, x), from_none], obj.get("typeArguments"))
        return AmbitiousType(type, declaration, element_type, id, name, type_arguments)

    def to_dict(self) -> dict:
        result: dict = {}
        result["type"] = to_enum(TypeEnum, self.type)
        if self.declaration is not None:
            result["declaration"] = from_union([lambda x: to_class(TentacledDeclaration, x), from_none], self.declaration)
        if self.element_type is not None:
            result["elementType"] = from_union([lambda x: to_class(ElementType, x), from_none], self.element_type)
        if self.id is not None:
            result["id"] = from_union([from_int, from_none], self.id)
        if self.name is not None:
            result["name"] = from_union([from_none, from_str], self.name)
        if self.type_arguments is not None:
            result["typeArguments"] = from_union([lambda x: from_list(lambda x: to_class(ElementType, x), x), from_none], self.type_arguments)
        return result


@dataclass
class TentacledParameter:
    flags: TentacledFlags
    id: int
    kind: int
    kind_string: ParameterKindString
    name: str
    type: AmbitiousType
    comment: TentacledComment | None
    default_value: str | None
    original_name: str | None

    @staticmethod
    def from_dict(obj: Any) -> 'TentacledParameter':
        assert isinstance(obj, dict)
        flags = TentacledFlags.from_dict(obj["flags"])
        id = from_int(obj["id"])
        kind = from_int(obj["kind"])
        kind_string = ParameterKindString(obj["kindString"])
        name = from_str(obj["name"])
        type = AmbitiousType.from_dict(obj["type"])
        comment = from_union([TentacledComment.from_dict, from_none], obj.get("comment"))
        default_value = from_union([from_none, from_str], obj.get("defaultValue"))
        original_name = from_union([from_none, from_str], obj.get("originalName"))
        return TentacledParameter(flags, id, kind, kind_string, name, type, comment, default_value, original_name)

    def to_dict(self) -> dict:
        result: dict = {}
        result["flags"] = to_class(TentacledFlags, self.flags)
        result["id"] = from_int(self.id)
        result["kind"] = from_int(self.kind)
        result["kindString"] = to_enum(ParameterKindString, self.kind_string)
        result["name"] = from_str(self.name)
        result["type"] = to_class(AmbitiousType, self.type)
        if self.comment is not None:
            result["comment"] = from_union([lambda x: to_class(TentacledComment, x), from_none], self.comment)
        if self.default_value is not None:
            result["defaultValue"] = from_union([from_none, from_str], self.default_value)
        if self.original_name is not None:
            result["originalName"] = from_union([from_none, from_str], self.original_name)
        return result


@dataclass
class CunningType:
    type: TypeEnum
    declaration: PurpleDeclaration | None
    id: int | None
    name: Name | None
    type_arguments: list[ElementType] | None

    @staticmethod
    def from_dict(obj: Any) -> 'CunningType':
        assert isinstance(obj, dict)
        type = TypeEnum(obj["type"])
        declaration = from_union([PurpleDeclaration.from_dict, from_none], obj.get("declaration"))
        id = from_union([from_int, from_none], obj.get("id"))
        name = from_union([Name, from_none], obj.get("name"))
        type_arguments = from_union([lambda x: from_list(ElementType.from_dict, x), from_none], obj.get("typeArguments"))
        return CunningType(type, declaration, id, name, type_arguments)

    def to_dict(self) -> dict:
        result: dict = {}
        result["type"] = to_enum(TypeEnum, self.type)
        if self.declaration is not None:
            result["declaration"] = from_union([lambda x: to_class(PurpleDeclaration, x), from_none], self.declaration)
        if self.id is not None:
            result["id"] = from_union([from_int, from_none], self.id)
        if self.name is not None:
            result["name"] = from_union([lambda x: to_enum(Name, x), from_none], self.name)
        if self.type_arguments is not None:
            result["typeArguments"] = from_union([lambda x: from_list(lambda x: to_class(ElementType, x), x), from_none], self.type_arguments)
        return result


@dataclass
class StickySignature:
    comment: StickyComment
    flags: IndigoFlags
    id: int
    kind: int
    kind_string: SignatureKindString
    name: str
    type: CunningType
    parameters: list[TentacledParameter] | None
    type_parameter: list[GetSignature] | None

    @staticmethod
    def from_dict(obj: Any) -> 'StickySignature':
        assert isinstance(obj, dict)
        comment = StickyComment.from_dict(obj["comment"])
        flags = IndigoFlags.from_dict(obj["flags"])
        id = from_int(obj["id"])
        kind = from_int(obj["kind"])
        kind_string = SignatureKindString(obj["kindString"])
        name = from_str(obj["name"])
        type = CunningType.from_dict(obj["type"])
        parameters = from_union([lambda x: from_list(TentacledParameter.from_dict, x), from_none], obj.get("parameters"))
        type_parameter = from_union([lambda x: from_list(GetSignature.from_dict, x), from_none], obj.get("typeParameter"))
        return StickySignature(comment, flags, id, kind, kind_string, name, type, parameters, type_parameter)

    def to_dict(self) -> dict:
        result: dict = {}
        result["comment"] = to_class(StickyComment, self.comment)
        result["flags"] = to_class(IndigoFlags, self.flags)
        result["id"] = from_int(self.id)
        result["kind"] = from_int(self.kind)
        result["kindString"] = to_enum(SignatureKindString, self.kind_string)
        result["name"] = from_str(self.name)
        result["type"] = to_class(CunningType, self.type)
        if self.parameters is not None:
            result["parameters"] = from_union([lambda x: from_list(lambda x: to_class(TentacledParameter, x), x), from_none], self.parameters)
        if self.type_parameter is not None:
            result["typeParameter"] = from_union([lambda x: from_list(lambda x: to_class(GetSignature, x), x), from_none], self.type_parameter)
        return result


@dataclass
class IndigoDeclaration:
    flags: GetSignatureFlags
    id: int
    kind: int
    kind_string: str
    name: str
    sources: list[Source]
    children: list[GetSignature] | None
    groups: list[Group] | None
    signatures: list[GetSignature] | None

    @staticmethod
    def from_dict(obj: Any) -> 'IndigoDeclaration':
        assert isinstance(obj, dict)
        flags = GetSignatureFlags.from_dict(obj["flags"])
        id = from_int(obj["id"])
        kind = from_int(obj["kind"])
        kind_string = from_str(obj["kindString"])
        name = from_str(obj["name"])
        sources = from_list(Source.from_dict, obj["sources"])
        children = from_union([lambda x: from_list(GetSignature.from_dict, x), from_none], obj.get("children"))
        groups = from_union([lambda x: from_list(Group.from_dict, x), from_none], obj.get("groups"))
        signatures = from_union([lambda x: from_list(GetSignature.from_dict, x), from_none], obj.get("signatures"))
        return IndigoDeclaration(flags, id, kind, kind_string, name, sources, children, groups, signatures)

    def to_dict(self) -> dict:
        result: dict = {}
        result["flags"] = to_class(GetSignatureFlags, self.flags)
        result["id"] = from_int(self.id)
        result["kind"] = from_int(self.kind)
        result["kindString"] = from_str(self.kind_string)
        result["name"] = from_str(self.name)
        result["sources"] = from_list(lambda x: to_class(Source, x), self.sources)
        if self.children is not None:
            result["children"] = from_union([lambda x: from_list(lambda x: to_class(GetSignature, x), x), from_none], self.children)
        if self.groups is not None:
            result["groups"] = from_union([lambda x: from_list(lambda x: to_class(Group, x), x), from_none], self.groups)
        if self.signatures is not None:
            result["signatures"] = from_union([lambda x: from_list(lambda x: to_class(GetSignature, x), x), from_none], self.signatures)
        return result


@dataclass
class FriskyType:
    type: TypeEnum
    declaration: IndigoDeclaration | None
    name: Name | None

    @staticmethod
    def from_dict(obj: Any) -> 'FriskyType':
        assert isinstance(obj, dict)
        type = TypeEnum(obj["type"])
        declaration = from_union([IndigoDeclaration.from_dict, from_none], obj.get("declaration"))
        name = from_union([Name, from_none], obj.get("name"))
        return FriskyType(type, declaration, name)

    def to_dict(self) -> dict:
        result: dict = {}
        result["type"] = to_enum(TypeEnum, self.type)
        if self.declaration is not None:
            result["declaration"] = from_union([lambda x: to_class(IndigoDeclaration, x), from_none], self.declaration)
        if self.name is not None:
            result["name"] = from_union([lambda x: to_enum(Name, x), from_none], self.name)
        return result


@dataclass
class IndecentChild:
    flags: FluffyFlags
    id: int
    kind: int
    kind_string: PurpleKindString
    name: str
    sources: list[Source]
    type: FriskyType

    @staticmethod
    def from_dict(obj: Any) -> 'IndecentChild':
        assert isinstance(obj, dict)
        flags = FluffyFlags.from_dict(obj["flags"])
        id = from_int(obj["id"])
        kind = from_int(obj["kind"])
        kind_string = PurpleKindString(obj["kindString"])
        name = from_str(obj["name"])
        sources = from_list(Source.from_dict, obj["sources"])
        type = FriskyType.from_dict(obj["type"])
        return IndecentChild(flags, id, kind, kind_string, name, sources, type)

    def to_dict(self) -> dict:
        result: dict = {}
        result["flags"] = to_class(FluffyFlags, self.flags)
        result["id"] = from_int(self.id)
        result["kind"] = from_int(self.kind)
        result["kindString"] = to_enum(PurpleKindString, self.kind_string)
        result["name"] = from_str(self.name)
        result["sources"] = from_list(lambda x: to_class(Source, x), self.sources)
        result["type"] = to_class(FriskyType, self.type)
        return result


@dataclass
class StickyDeclaration:
    flags: GetSignatureFlags
    id: int
    kind: int
    kind_string: str
    name: str
    signatures: list[GetSignature]
    sources: list[Source]
    children: list[IndecentChild] | None
    groups: list[Group] | None

    @staticmethod
    def from_dict(obj: Any) -> 'StickyDeclaration':
        assert isinstance(obj, dict)
        flags = GetSignatureFlags.from_dict(obj["flags"])
        id = from_int(obj["id"])
        kind = from_int(obj["kind"])
        kind_string = from_str(obj["kindString"])
        name = from_str(obj["name"])
        signatures = from_list(GetSignature.from_dict, obj["signatures"])
        sources = from_list(Source.from_dict, obj["sources"])
        children = from_union([lambda x: from_list(IndecentChild.from_dict, x), from_none], obj.get("children"))
        groups = from_union([lambda x: from_list(Group.from_dict, x), from_none], obj.get("groups"))
        return StickyDeclaration(flags, id, kind, kind_string, name, signatures, sources, children, groups)

    def to_dict(self) -> dict:
        result: dict = {}
        result["flags"] = to_class(GetSignatureFlags, self.flags)
        result["id"] = from_int(self.id)
        result["kind"] = from_int(self.kind)
        result["kindString"] = from_str(self.kind_string)
        result["name"] = from_str(self.name)
        result["signatures"] = from_list(lambda x: to_class(GetSignature, x), self.signatures)
        result["sources"] = from_list(lambda x: to_class(Source, x), self.sources)
        if self.children is not None:
            result["children"] = from_union([lambda x: from_list(lambda x: to_class(IndecentChild, x), x), from_none], self.children)
        if self.groups is not None:
            result["groups"] = from_union([lambda x: from_list(lambda x: to_class(Group, x), x), from_none], self.groups)
        return result


@dataclass
class FluffyTypeArgument:
    type: TypeEnum
    types: list[ElementType]

    @staticmethod
    def from_dict(obj: Any) -> 'FluffyTypeArgument':
        assert isinstance(obj, dict)
        type = TypeEnum(obj["type"])
        types = from_list(ElementType.from_dict, obj["types"])
        return FluffyTypeArgument(type, types)

    def to_dict(self) -> dict:
        result: dict = {}
        result["type"] = to_enum(TypeEnum, self.type)
        result["types"] = from_list(lambda x: to_class(ElementType, x), self.types)
        return result


@dataclass
class MagentaType:
    type: TypeEnum
    declaration: StickyDeclaration | None
    element_type: ElementType | None
    elements: list[ExtendedBy] | None
    id: int | None
    name: str | None
    type_arguments: list[FluffyTypeArgument] | None
    types: list[ExtendedBy] | None
    value: str | None

    @staticmethod
    def from_dict(obj: Any) -> 'MagentaType':
        assert isinstance(obj, dict)
        type = TypeEnum(obj["type"])
        declaration = from_union([StickyDeclaration.from_dict, from_none], obj.get("declaration"))
        element_type = from_union([ElementType.from_dict, from_none], obj.get("elementType"))
        elements = from_union([lambda x: from_list(ExtendedBy.from_dict, x), from_none], obj.get("elements"))
        id = from_union([from_int, from_none], obj.get("id"))
        name = from_union([from_none, from_str], obj.get("name"))
        type_arguments = from_union([lambda x: from_list(FluffyTypeArgument.from_dict, x), from_none], obj.get("typeArguments"))
        types = from_union([lambda x: from_list(ExtendedBy.from_dict, x), from_none], obj.get("types"))
        value = from_union([from_none, from_str], obj.get("value"))
        return MagentaType(type, declaration, element_type, elements, id, name, type_arguments, types, value)

    def to_dict(self) -> dict:
        result: dict = {}
        result["type"] = to_enum(TypeEnum, self.type)
        if self.declaration is not None:
            result["declaration"] = from_union([lambda x: to_class(StickyDeclaration, x), from_none], self.declaration)
        if self.element_type is not None:
            result["elementType"] = from_union([lambda x: to_class(ElementType, x), from_none], self.element_type)
        if self.elements is not None:
            result["elements"] = from_union([lambda x: from_list(lambda x: to_class(ExtendedBy, x), x), from_none], self.elements)
        if self.id is not None:
            result["id"] = from_union([from_int, from_none], self.id)
        if self.name is not None:
            result["name"] = from_union([from_none, from_str], self.name)
        if self.type_arguments is not None:
            result["typeArguments"] = from_union([lambda x: from_list(lambda x: to_class(FluffyTypeArgument, x), x), from_none], self.type_arguments)
        if self.types is not None:
            result["types"] = from_union([lambda x: from_list(lambda x: to_class(ExtendedBy, x), x), from_none], self.types)
        if self.value is not None:
            result["value"] = from_union([from_none, from_str], self.value)
        return result


@dataclass
class MischievousType:
    type: str
    id: int | None
    name: Name | None
    operator: str | None
    target: ElementType | None

    @staticmethod
    def from_dict(obj: Any) -> 'MischievousType':
        assert isinstance(obj, dict)
        type = from_str(obj["type"])
        id = from_union([from_int, from_none], obj.get("id"))
        name = from_union([Name, from_none], obj.get("name"))
        operator = from_union([from_none, from_str], obj.get("operator"))
        target = from_union([ElementType.from_dict, from_none], obj.get("target"))
        return MischievousType(type, id, name, operator, target)

    def to_dict(self) -> dict:
        result: dict = {}
        result["type"] = from_str(self.type)
        if self.id is not None:
            result["id"] = from_union([from_int, from_none], self.id)
        if self.name is not None:
            result["name"] = from_union([lambda x: to_enum(Name, x), from_none], self.name)
        if self.operator is not None:
            result["operator"] = from_union([from_none, from_str], self.operator)
        if self.target is not None:
            result["target"] = from_union([lambda x: to_class(ElementType, x), from_none], self.target)
        return result


@dataclass
class TypeParameter:
    flags: GetSignatureFlags
    id: int
    kind: int
    kind_string: str
    name: str
    comment: PurpleComment | None
    type: MischievousType | None

    @staticmethod
    def from_dict(obj: Any) -> 'TypeParameter':
        assert isinstance(obj, dict)
        flags = GetSignatureFlags.from_dict(obj["flags"])
        id = from_int(obj["id"])
        kind = from_int(obj["kind"])
        kind_string = from_str(obj["kindString"])
        name = from_str(obj["name"])
        comment = from_union([PurpleComment.from_dict, from_none], obj.get("comment"))
        type = from_union([MischievousType.from_dict, from_none], obj.get("type"))
        return TypeParameter(flags, id, kind, kind_string, name, comment, type)

    def to_dict(self) -> dict:
        result: dict = {}
        result["flags"] = to_class(GetSignatureFlags, self.flags)
        result["id"] = from_int(self.id)
        result["kind"] = from_int(self.kind)
        result["kindString"] = from_str(self.kind_string)
        result["name"] = from_str(self.name)
        if self.comment is not None:
            result["comment"] = from_union([lambda x: to_class(PurpleComment, x), from_none], self.comment)
        if self.type is not None:
            result["type"] = from_union([lambda x: to_class(MischievousType, x), from_none], self.type)
        return result


@dataclass
class PurpleChild:
    flags: IndecentFlags
    id: int
    kind: int
    kind_string: FluffyKindString
    name: str
    sources: list[Source]
    children: list[FluffyChild] | None
    comment: StickyComment | None
    default_value: str | None
    extended_by: list[ExtendedBy] | None
    extended_types: list[ExtendedBy] | None
    groups: list[Group] | None
    implemented_by: list[ExtendedBy] | None
    implemented_types: list[ExtendedBy] | None
    signatures: list[StickySignature] | None
    type: MagentaType | None
    type_parameter: list[TypeParameter] | None

    @staticmethod
    def from_dict(obj: Any) -> 'PurpleChild':
        assert isinstance(obj, dict)
        flags = IndecentFlags.from_dict(obj["flags"])
        id = from_int(obj["id"])
        kind = from_int(obj["kind"])
        kind_string = FluffyKindString(obj["kindString"])
        name = from_str(obj["name"])
        sources = from_list(Source.from_dict, obj["sources"])
        children = from_union([lambda x: from_list(FluffyChild.from_dict, x), from_none], obj.get("children"))
        comment = from_union([StickyComment.from_dict, from_none], obj.get("comment"))
        default_value = from_union([from_none, from_str], obj.get("defaultValue"))
        extended_by = from_union([lambda x: from_list(ExtendedBy.from_dict, x), from_none], obj.get("extendedBy"))
        extended_types = from_union([lambda x: from_list(ExtendedBy.from_dict, x), from_none], obj.get("extendedTypes"))
        groups = from_union([lambda x: from_list(Group.from_dict, x), from_none], obj.get("groups"))
        implemented_by = from_union([lambda x: from_list(ExtendedBy.from_dict, x), from_none], obj.get("implementedBy"))
        implemented_types = from_union([lambda x: from_list(ExtendedBy.from_dict, x), from_none], obj.get("implementedTypes"))
        signatures = from_union([lambda x: from_list(StickySignature.from_dict, x), from_none], obj.get("signatures"))
        type = from_union([MagentaType.from_dict, from_none], obj.get("type"))
        type_parameter = from_union([lambda x: from_list(TypeParameter.from_dict, x), from_none], obj.get("typeParameter"))
        return PurpleChild(flags, id, kind, kind_string, name, sources, children, comment, default_value, extended_by, extended_types, groups, implemented_by, implemented_types, signatures, type, type_parameter)

    def to_dict(self) -> dict:
        result: dict = {}
        result["flags"] = to_class(IndecentFlags, self.flags)
        result["id"] = from_int(self.id)
        result["kind"] = from_int(self.kind)
        result["kindString"] = to_enum(FluffyKindString, self.kind_string)
        result["name"] = from_str(self.name)
        result["sources"] = from_list(lambda x: to_class(Source, x), self.sources)
        if self.children is not None:
            result["children"] = from_union([lambda x: from_list(lambda x: to_class(FluffyChild, x), x), from_none], self.children)
        if self.comment is not None:
            result["comment"] = from_union([lambda x: to_class(StickyComment, x), from_none], self.comment)
        if self.default_value is not None:
            result["defaultValue"] = from_union([from_none, from_str], self.default_value)
        if self.extended_by is not None:
            result["extendedBy"] = from_union([lambda x: from_list(lambda x: to_class(ExtendedBy, x), x), from_none], self.extended_by)
        if self.extended_types is not None:
            result["extendedTypes"] = from_union([lambda x: from_list(lambda x: to_class(ExtendedBy, x), x), from_none], self.extended_types)
        if self.groups is not None:
            result["groups"] = from_union([lambda x: from_list(lambda x: to_class(Group, x), x), from_none], self.groups)
        if self.implemented_by is not None:
            result["implementedBy"] = from_union([lambda x: from_list(lambda x: to_class(ExtendedBy, x), x), from_none], self.implemented_by)
        if self.implemented_types is not None:
            result["implementedTypes"] = from_union([lambda x: from_list(lambda x: to_class(ExtendedBy, x), x), from_none], self.implemented_types)
        if self.signatures is not None:
            result["signatures"] = from_union([lambda x: from_list(lambda x: to_class(StickySignature, x), x), from_none], self.signatures)
        if self.type is not None:
            result["type"] = from_union([lambda x: to_class(MagentaType, x), from_none], self.type)
        if self.type_parameter is not None:
            result["typeParameter"] = from_union([lambda x: from_list(lambda x: to_class(TypeParameter, x), x), from_none], self.type_parameter)
        return result


@dataclass
class IndecentComment:
    short_text: str
    tags: list[Tag] | None

    @staticmethod
    def from_dict(obj: Any) -> 'IndecentComment':
        assert isinstance(obj, dict)
        short_text = from_str(obj["shortText"])
        tags = from_union([lambda x: from_list(Tag.from_dict, x), from_none], obj.get("tags"))
        return IndecentComment(short_text, tags)

    def to_dict(self) -> dict:
        result: dict = {}
        result["shortText"] = from_str(self.short_text)
        if self.tags is not None:
            result["tags"] = from_union([lambda x: from_list(lambda x: to_class(Tag, x), x), from_none], self.tags)
        return result


class TentacledKindString(Enum):
    EXTERNAL_MODULE = "External module"


@dataclass
class TopLevelChild:
    children: list[PurpleChild]
    flags: PurpleFlags
    groups: list[Group]
    id: int
    kind: int
    kind_string: TentacledKindString
    name: str
    original_name: str
    sources: list[Source]
    comment: IndecentComment | None

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevelChild':
        assert isinstance(obj, dict)
        children = from_list(PurpleChild.from_dict, obj["children"])
        flags = PurpleFlags.from_dict(obj["flags"])
        groups = from_list(Group.from_dict, obj["groups"])
        id = from_int(obj["id"])
        kind = from_int(obj["kind"])
        kind_string = TentacledKindString(obj["kindString"])
        name = from_str(obj["name"])
        original_name = from_str(obj["originalName"])
        sources = from_list(Source.from_dict, obj["sources"])
        comment = from_union([IndecentComment.from_dict, from_none], obj.get("comment"))
        return TopLevelChild(children, flags, groups, id, kind, kind_string, name, original_name, sources, comment)

    def to_dict(self) -> dict:
        result: dict = {}
        result["children"] = from_list(lambda x: to_class(PurpleChild, x), self.children)
        result["flags"] = to_class(PurpleFlags, self.flags)
        result["groups"] = from_list(lambda x: to_class(Group, x), self.groups)
        result["id"] = from_int(self.id)
        result["kind"] = from_int(self.kind)
        result["kindString"] = to_enum(TentacledKindString, self.kind_string)
        result["name"] = from_str(self.name)
        result["originalName"] = from_str(self.original_name)
        result["sources"] = from_list(lambda x: to_class(Source, x), self.sources)
        if self.comment is not None:
            result["comment"] = from_union([lambda x: to_class(IndecentComment, x), from_none], self.comment)
        return result


@dataclass
class TopLevel:
    children: list[TopLevelChild]
    flags: GetSignatureFlags
    groups: list[Group]
    id: int
    kind: int
    name: str

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        children = from_list(TopLevelChild.from_dict, obj["children"])
        flags = GetSignatureFlags.from_dict(obj["flags"])
        groups = from_list(Group.from_dict, obj["groups"])
        id = from_int(obj["id"])
        kind = from_int(obj["kind"])
        name = from_str(obj["name"])
        return TopLevel(children, flags, groups, id, kind, name)

    def to_dict(self) -> dict:
        result: dict = {}
        result["children"] = from_list(lambda x: to_class(TopLevelChild, x), self.children)
        result["flags"] = to_class(GetSignatureFlags, self.flags)
        result["groups"] = from_list(lambda x: to_class(Group, x), self.groups)
        result["id"] = from_int(self.id)
        result["kind"] = from_int(self.kind)
        result["name"] = from_str(self.name)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
