from dataclasses import dataclass
from typing import Any, TypeVar, Callable, Type, cast


T = TypeVar("T")


def from_none(x: Any) -> Any:
    assert x is None
    return x


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def from_float(x: Any) -> float:
    assert isinstance(x, (float, int)) and not isinstance(x, bool)
    return float(x)


def from_bool(x: Any) -> bool:
    assert isinstance(x, bool)
    return x


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def from_union(fs, x):
    for f in fs:
        try:
            return f(x)
        except:
            pass
    assert False


def from_dict(f: Callable[[Any], T], x: Any) -> dict[str, T]:
    assert isinstance(x, dict)
    return { k: f(v) for (k, v) in x.items() }


def to_float(x: Any) -> float:
    assert isinstance(x, (int, float))
    return x


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


@dataclass
class XClass:
    x: 'float | int | bool | list[float | int | bool | list[Any] | XClass | str | None] | dict[str, Any] | str | None' = None

    @staticmethod
    def from_dict(obj: Any) -> 'XClass':
        assert isinstance(obj, dict)
        x = from_union([from_none, from_int, from_float, from_bool, lambda x: from_list(lambda x: from_union([from_none, from_int, from_float, from_bool, lambda x: from_list(lambda x: x, x), XClass.from_dict, from_str], x), x), lambda x: from_dict(lambda x: x, x), from_str], obj.get("x"))
        return XClass(x)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.x is not None:
            result["x"] = from_union([from_none, from_int, to_float, from_bool, lambda x: from_list(lambda x: from_union([from_none, from_int, to_float, from_bool, lambda x: from_list(lambda x: x, x), lambda x: to_class(XClass, x), from_str], x), x), lambda x: from_dict(lambda x: x, x), from_str], self.x)
        return result


@dataclass
class TopLevelClass:
    x: float | int | bool | list[float | int | bool | list[Any] | XClass | str | None] | dict[str, Any] | str | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevelClass':
        assert isinstance(obj, dict)
        x = from_union([from_none, from_int, from_float, from_bool, lambda x: from_list(lambda x: from_union([from_none, from_int, from_float, from_bool, lambda x: from_list(lambda x: x, x), XClass.from_dict, from_str], x), x), lambda x: from_dict(lambda x: x, x), from_str], obj.get("x"))
        return TopLevelClass(x)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.x is not None:
            result["x"] = from_union([from_none, from_int, to_float, from_bool, lambda x: from_list(lambda x: from_union([from_none, from_int, to_float, from_bool, lambda x: from_list(lambda x: x, x), lambda x: to_class(XClass, x), from_str], x), x), lambda x: from_dict(lambda x: x, x), from_str], self.x)
        return result


def top_level_from_dict(s: Any) -> float | int | bool | str | list[float | int | bool | list[Any] | TopLevelClass | str | None] | dict[str, Any] | None:
    return from_union([from_none, from_int, from_float, from_bool, from_str, lambda x: from_list(lambda x: from_union([from_none, from_int, from_float, from_bool, lambda x: from_list(lambda x: x, x), TopLevelClass.from_dict, from_str], x), x), lambda x: from_dict(lambda x: x, x)], s)


def top_level_to_dict(x: float | int | bool | str | list[float | int | bool | list[Any] | TopLevelClass | str | None] | dict[str, Any] | None) -> Any:
    return from_union([from_none, from_int, to_float, from_bool, from_str, lambda x: from_list(lambda x: from_union([from_none, from_int, to_float, from_bool, lambda x: from_list(lambda x: x, x), lambda x: to_class(TopLevelClass, x), from_str], x), x), lambda x: from_dict(lambda x: x, x)], x)
