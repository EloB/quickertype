from dataclasses import dataclass
from typing import Any, TypeVar, Callable, Type, cast


T = TypeVar("T")


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


def from_bool(x: Any) -> bool:
    assert isinstance(x, bool)
    return x


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
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


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


@dataclass
class MixedClass:
    nested: str

    @staticmethod
    def from_dict(obj: Any) -> 'MixedClass':
        assert isinstance(obj, dict)
        nested = from_str(obj["nested"])
        return MixedClass(nested)

    def to_dict(self) -> dict:
        result: dict = {}
        result["nested"] = from_str(self.nested)
        return result


@dataclass
class TopLevel:
    mixed: list[bool | MixedClass | int | str | None]

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        mixed = from_list(lambda x: from_union([from_bool, MixedClass.from_dict, from_int, from_none, from_str], x), obj["mixed"])
        return TopLevel(mixed)

    def to_dict(self) -> dict:
        result: dict = {}
        result["mixed"] = from_list(lambda x: from_union([from_bool, lambda x: to_class(MixedClass, x), from_int, from_none, from_str], x), self.mixed)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
