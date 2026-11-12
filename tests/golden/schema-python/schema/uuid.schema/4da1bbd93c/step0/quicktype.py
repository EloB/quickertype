from enum import Enum
from dataclasses import dataclass
from uuid import UUID
from typing import Any, TypeVar, Callable, Type, cast


T = TypeVar("T")
EnumT = TypeVar("EnumT", bound=Enum)


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


def to_enum(c: Type[EnumT], x: Any) -> EnumT:
    assert isinstance(x, c)
    return x.value


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


class UnionWithEnumEnum(Enum):
    FOO = "foo"


@dataclass
class TopLevel:
    one: UUID
    union_with_enum: UnionWithEnumEnum | UUID
    arr_nullable: list[UUID | None] | None = None
    arr_one: list[UUID] | None = None
    nullable: UUID | None = None
    optional: UUID | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        one = UUID(obj["one"])
        union_with_enum = from_union([UnionWithEnumEnum, lambda x: UUID(x)], obj["unionWithEnum"])
        arr_nullable = from_union([lambda x: from_list(lambda x: from_union([from_none, lambda x: UUID(x)], x), x), from_none], obj.get("arrNullable"))
        arr_one = from_union([lambda x: from_list(lambda x: UUID(x), x), from_none], obj.get("arrOne"))
        nullable = from_union([from_none, lambda x: UUID(x)], obj["nullable"])
        optional = from_union([from_none, lambda x: UUID(x)], obj.get("optional"))
        return TopLevel(one, union_with_enum, arr_nullable, arr_one, nullable, optional)

    def to_dict(self) -> dict:
        result: dict = {}
        result["one"] = str(self.one)
        result["unionWithEnum"] = from_union([lambda x: to_enum(UnionWithEnumEnum, x), lambda x: str(x)], self.union_with_enum)
        if self.arr_nullable is not None:
            result["arrNullable"] = from_union([lambda x: from_list(lambda x: from_union([from_none, lambda x: str(x)], x), x), from_none], self.arr_nullable)
        if self.arr_one is not None:
            result["arrOne"] = from_union([lambda x: from_list(lambda x: str(x), x), from_none], self.arr_one)
        result["nullable"] = from_union([from_none, lambda x: str(x)], self.nullable)
        if self.optional is not None:
            result["optional"] = from_union([from_none, lambda x: str(x)], self.optional)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
