from dataclasses import dataclass
from typing import Any, TypeVar, Callable, Type, cast


T = TypeVar("T")


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def from_dict(f: Callable[[Any], T], x: Any) -> dict[str, T]:
    assert isinstance(x, dict)
    return { k: f(v) for (k, v) in x.items() }


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


@dataclass
class TopLevelValue:
    channel_id: int
    channel_name: str
    code: str
    emoticon_set: int
    id: int

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevelValue':
        assert isinstance(obj, dict)
        channel_id = int(from_str(obj["channel_id"]))
        channel_name = from_str(obj["channel_name"])
        code = from_str(obj["code"])
        emoticon_set = from_int(obj["emoticon_set"])
        id = from_int(obj["id"])
        return TopLevelValue(channel_id, channel_name, code, emoticon_set, id)

    def to_dict(self) -> dict:
        result: dict = {}
        result["channel_id"] = from_str(str(self.channel_id))
        result["channel_name"] = from_str(self.channel_name)
        result["code"] = from_str(self.code)
        result["emoticon_set"] = from_int(self.emoticon_set)
        result["id"] = from_int(self.id)
        return result


def top_level_from_dict(s: Any) -> dict[str, TopLevelValue]:
    return from_dict(TopLevelValue.from_dict, s)


def top_level_to_dict(x: dict[str, TopLevelValue]) -> Any:
    return from_dict(lambda x: to_class(TopLevelValue, x), x)
