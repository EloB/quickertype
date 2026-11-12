from dataclasses import dataclass
from typing import Any, TypeVar, Callable, Type, cast


T = TypeVar("T")


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


@dataclass
class TopLevel:
    block_index: int
    hash: str
    height: int
    time: int
    tx_indexes: list[int]

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        block_index = from_int(obj["block_index"])
        hash = from_str(obj["hash"])
        height = from_int(obj["height"])
        time = from_int(obj["time"])
        tx_indexes = from_list(from_int, obj["txIndexes"])
        return TopLevel(block_index, hash, height, time, tx_indexes)

    def to_dict(self) -> dict:
        result: dict = {}
        result["block_index"] = from_int(self.block_index)
        result["hash"] = from_str(self.hash)
        result["height"] = from_int(self.height)
        result["time"] = from_int(self.time)
        result["txIndexes"] = from_list(from_int, self.tx_indexes)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
