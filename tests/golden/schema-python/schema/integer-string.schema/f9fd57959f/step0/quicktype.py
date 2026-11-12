from enum import Enum
from dataclasses import dataclass
from typing import Any, TypeVar, Callable, Type, cast


T = TypeVar("T")
EnumT = TypeVar("EnumT", bound=Enum)


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
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


class UnionWithIntAndEnumEnum(Enum):
    FOO = "foo"


@dataclass
class TopLevel:
    one: int
    union_with_int: int
    union_with_int_and_enum: int | UnionWithIntAndEnumEnum
    arr_nullable: list[int | None] | None = None
    arr_one: list[int] | None = None
    nullable: int | None = None
    optional: int | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        one = int(from_str(obj["one"]))
        union_with_int = from_union([from_int, lambda x: int(from_str(x))], obj["unionWithInt"])
        union_with_int_and_enum = from_union([from_int, lambda x: from_union([UnionWithIntAndEnumEnum, lambda x: int(x)], from_str(x))], obj["unionWithIntAndEnum"])
        arr_nullable = from_union([lambda x: from_list(lambda x: from_union([from_none, lambda x: int(from_str(x))], x), x), from_none], obj.get("arrNullable"))
        arr_one = from_union([lambda x: from_list(lambda x: int(from_str(x)), x), from_none], obj.get("arrOne"))
        nullable = from_union([from_none, lambda x: int(from_str(x))], obj["nullable"])
        optional = from_union([from_none, lambda x: int(from_str(x))], obj.get("optional"))
        return TopLevel(one, union_with_int, union_with_int_and_enum, arr_nullable, arr_one, nullable, optional)

    def to_dict(self) -> dict:
        result: dict = {}
        result["one"] = from_str(str(self.one))
        result["unionWithInt"] = from_int(self.union_with_int)
        result["unionWithIntAndEnum"] = from_union([lambda x: from_int((lambda x: is_type(int, x))(x)), lambda x: from_str((lambda x: to_enum(UnionWithIntAndEnumEnum, (lambda x: is_type(UnionWithIntAndEnumEnum, x))(x)))(x))], self.union_with_int_and_enum)
        if self.arr_nullable is not None:
            result["arrNullable"] = from_union([lambda x: from_list(lambda x: from_union([lambda x: from_none((lambda x: is_type(type(None), x))(x)), lambda x: from_str((lambda x: str((lambda x: is_type(int, x))(x)))(x))], x), x), from_none], self.arr_nullable)
        if self.arr_one is not None:
            result["arrOne"] = from_union([lambda x: from_list(lambda x: from_str((lambda x: str(x))(x)), x), from_none], self.arr_one)
        result["nullable"] = from_union([lambda x: from_none((lambda x: is_type(type(None), x))(x)), lambda x: from_str((lambda x: str((lambda x: is_type(int, x))(x)))(x))], self.nullable)
        if self.optional is not None:
            result["optional"] = from_union([lambda x: from_none((lambda x: is_type(type(None), x))(x)), lambda x: from_str((lambda x: str((lambda x: is_type(int, x))(x)))(x))], self.optional)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
