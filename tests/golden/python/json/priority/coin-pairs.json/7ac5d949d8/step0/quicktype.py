from dataclasses import dataclass
from typing import Any, TypeVar, Callable, Type, cast


T = TypeVar("T")


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def from_float(x: Any) -> float:
    assert isinstance(x, (float, int)) and not isinstance(x, bool)
    return float(x)


def to_float(x: Any) -> float:
    assert isinstance(x, (int, float))
    return x


def from_dict(f: Callable[[Any], T], x: Any) -> dict[str, T]:
    assert isinstance(x, dict)
    return { k: f(v) for (k, v) in x.items() }


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


@dataclass
class Pair:
    decimal_places: int
    fee: float
    hidden: int
    max_amount: int
    max_price: int
    min_amount: float
    min_price: float
    min_total: float

    @staticmethod
    def from_dict(obj: Any) -> 'Pair':
        assert isinstance(obj, dict)
        decimal_places = from_int(obj["decimal_places"])
        fee = from_float(obj["fee"])
        hidden = from_int(obj["hidden"])
        max_amount = from_int(obj["max_amount"])
        max_price = from_int(obj["max_price"])
        min_amount = from_float(obj["min_amount"])
        min_price = from_float(obj["min_price"])
        min_total = from_float(obj["min_total"])
        return Pair(decimal_places, fee, hidden, max_amount, max_price, min_amount, min_price, min_total)

    def to_dict(self) -> dict:
        result: dict = {}
        result["decimal_places"] = from_int(self.decimal_places)
        result["fee"] = to_float(self.fee)
        result["hidden"] = from_int(self.hidden)
        result["max_amount"] = from_int(self.max_amount)
        result["max_price"] = from_int(self.max_price)
        result["min_amount"] = to_float(self.min_amount)
        result["min_price"] = to_float(self.min_price)
        result["min_total"] = to_float(self.min_total)
        return result


@dataclass
class TopLevel:
    pairs: dict[str, Pair]
    server_time: int

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        pairs = from_dict(Pair.from_dict, obj["pairs"])
        server_time = from_int(obj["server_time"])
        return TopLevel(pairs, server_time)

    def to_dict(self) -> dict:
        result: dict = {}
        result["pairs"] = from_dict(lambda x: to_class(Pair, x), self.pairs)
        result["server_time"] = from_int(self.server_time)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
