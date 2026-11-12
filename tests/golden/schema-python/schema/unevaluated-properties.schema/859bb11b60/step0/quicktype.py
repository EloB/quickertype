from dataclasses import dataclass
from typing import Any, TypeVar, Callable, Type, cast


T = TypeVar("T")


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


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
class ClosedClass:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'ClosedClass':
        assert isinstance(obj, dict)
        return ClosedClass()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Item:
    key: str
    value: str

    @staticmethod
    def from_dict(obj: Any) -> 'Item':
        assert isinstance(obj, dict)
        key = from_str(obj["key"])
        value = from_str(obj["value"])
        return Item(key, value)

    def to_dict(self) -> dict:
        result: dict = {}
        result["key"] = from_str(self.key)
        result["value"] = from_str(self.value)
        return result


@dataclass
class Config:
    closed: float | int | bool | str | list[Any] | ClosedClass | None = None
    name: str | None = None
    settings: dict[str, list[Item]] | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'Config':
        assert isinstance(obj, dict)
        closed = from_union([from_none, from_int, from_float, from_bool, from_str, lambda x: from_list(lambda x: x, x), ClosedClass.from_dict], obj.get("closed"))
        name = from_union([from_str, from_none], obj.get("name"))
        settings = from_union([lambda x: from_dict(lambda x: from_list(Item.from_dict, x), x), from_none], obj.get("settings"))
        return Config(closed, name, settings)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.closed is not None:
            result["closed"] = from_union([from_none, from_int, to_float, from_bool, from_str, lambda x: from_list(lambda x: x, x), lambda x: to_class(ClosedClass, x)], self.closed)
        if self.name is not None:
            result["name"] = from_union([from_str, from_none], self.name)
        if self.settings is not None:
            result["settings"] = from_union([lambda x: from_dict(lambda x: from_list(lambda x: to_class(Item, x), x), x), from_none], self.settings)
        return result


@dataclass
class TopLevel:
    config: Config | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        config = from_union([Config.from_dict, from_none], obj.get("config"))
        return TopLevel(config)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.config is not None:
            result["config"] = from_union([lambda x: to_class(Config, x), from_none], self.config)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
