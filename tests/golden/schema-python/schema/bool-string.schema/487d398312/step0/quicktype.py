from enum import Enum
from dataclasses import dataclass
from typing import Any, TypeVar, Callable, Type, cast


T = TypeVar("T")
EnumT = TypeVar("EnumT", bound=Enum)


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def from_stringified_bool(x: str) -> bool:
    if x == "true":
        return True
    if x == "false":
        return False
    assert False


def from_bool(x: Any) -> bool:
    assert isinstance(x, bool)
    return x


def from_union(fs, x):
    for f in fs:
        try:
            return f(x)
        except:
            pass
    assert False


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


def from_none(x: Any) -> Any:
    assert x is None
    return x


def is_type(t: Type[T], x: Any) -> T:
    assert isinstance(x, t)
    return x


def to_enum(c: Type[EnumT], x: Any) -> EnumT:
    assert isinstance(x, c)
    return x.value


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


class UnionWithBoolAndEnumEnum(Enum):
    FOO = "foo"


@dataclass
class TopLevel:
    one: bool
    union_with_bool: bool
    union_with_bool_and_enum: bool | UnionWithBoolAndEnumEnum
    arr_nullable: list[bool | None] | None = None
    arr_one: list[bool] | None = None
    nullable: bool | None = None
    optional: bool | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        one = from_stringified_bool(from_str(obj["one"]))
        union_with_bool = from_union([from_bool, lambda x: from_stringified_bool(from_str(x))], obj["unionWithBool"])
        union_with_bool_and_enum = from_union([from_bool, lambda x: from_union([from_stringified_bool, UnionWithBoolAndEnumEnum], from_str(x))], obj["unionWithBoolAndEnum"])
        arr_nullable = from_union([lambda x: from_list(lambda x: from_union([from_none, lambda x: from_stringified_bool(from_str(x))], x), x), from_none], obj.get("arrNullable"))
        arr_one = from_union([lambda x: from_list(lambda x: from_stringified_bool(from_str(x)), x), from_none], obj.get("arrOne"))
        nullable = from_union([from_none, lambda x: from_stringified_bool(from_str(x))], obj["nullable"])
        optional = from_union([from_none, lambda x: from_stringified_bool(from_str(x))], obj.get("optional"))
        return TopLevel(one, union_with_bool, union_with_bool_and_enum, arr_nullable, arr_one, nullable, optional)

    def to_dict(self) -> dict:
        result: dict = {}
        result["one"] = from_str(str(self.one).lower())
        result["unionWithBool"] = from_bool(self.union_with_bool)
        result["unionWithBoolAndEnum"] = from_union([lambda x: from_bool((lambda x: is_type(bool, x))(x)), lambda x: from_str((lambda x: to_enum(UnionWithBoolAndEnumEnum, (lambda x: is_type(UnionWithBoolAndEnumEnum, x))(x)))(x))], self.union_with_bool_and_enum)
        if self.arr_nullable is not None:
            result["arrNullable"] = from_union([lambda x: from_list(lambda x: from_union([lambda x: from_none((lambda x: is_type(type(None), x))(x)), lambda x: from_str((lambda x: str((lambda x: is_type(bool, x))(x)).lower())(x))], x), x), from_none], self.arr_nullable)
        if self.arr_one is not None:
            result["arrOne"] = from_union([lambda x: from_list(lambda x: from_str((lambda x: str(x).lower())(x)), x), from_none], self.arr_one)
        result["nullable"] = from_union([lambda x: from_none((lambda x: is_type(type(None), x))(x)), lambda x: from_str((lambda x: str((lambda x: is_type(bool, x))(x)).lower())(x))], self.nullable)
        if self.optional is not None:
            result["optional"] = from_union([lambda x: from_none((lambda x: is_type(type(None), x))(x)), lambda x: from_str((lambda x: str((lambda x: is_type(bool, x))(x)).lower())(x))], self.optional)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
