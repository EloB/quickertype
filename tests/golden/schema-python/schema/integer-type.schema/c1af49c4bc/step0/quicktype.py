from dataclasses import dataclass
from typing import Any, TypeVar, Type, cast


T = TypeVar("T")


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


@dataclass
class TopLevel:
    above_i32_max: int
    below_i32_min: int
    i32_range: int
    large_bounds: int
    only_maximum: int
    only_minimum: int
    small_negative: int
    small_positive: int
    unbounded: int

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        above_i32_max = from_int(obj["above_i32_max"])
        assert above_i32_max is None or 0 <= above_i32_max
        assert above_i32_max is None or above_i32_max <= 2147483648
        below_i32_min = from_int(obj["below_i32_min"])
        assert below_i32_min is None or -2147483649 <= below_i32_min
        assert below_i32_min is None or below_i32_min <= 0
        i32_range = from_int(obj["i32_range"])
        assert i32_range is None or -2147483648 <= i32_range
        assert i32_range is None or i32_range <= 2147483647
        large_bounds = from_int(obj["large_bounds"])
        assert large_bounds is None or -9007199254740991 <= large_bounds
        assert large_bounds is None or large_bounds <= 9007199254740991
        only_maximum = from_int(obj["only_maximum"])
        assert only_maximum is None or only_maximum <= 0
        only_minimum = from_int(obj["only_minimum"])
        assert only_minimum is None or 0 <= only_minimum
        small_negative = from_int(obj["small_negative"])
        assert small_negative is None or -100 <= small_negative
        assert small_negative is None or small_negative <= 0
        small_positive = from_int(obj["small_positive"])
        assert small_positive is None or 0 <= small_positive
        assert small_positive is None or small_positive <= 100
        unbounded = from_int(obj["unbounded"])
        return TopLevel(above_i32_max, below_i32_min, i32_range, large_bounds, only_maximum, only_minimum, small_negative, small_positive, unbounded)

    def to_dict(self) -> dict:
        result: dict = {}
        result["above_i32_max"] = from_int(self.above_i32_max)
        result["below_i32_min"] = from_int(self.below_i32_min)
        result["i32_range"] = from_int(self.i32_range)
        result["large_bounds"] = from_int(self.large_bounds)
        result["only_maximum"] = from_int(self.only_maximum)
        result["only_minimum"] = from_int(self.only_minimum)
        result["small_negative"] = from_int(self.small_negative)
        result["small_positive"] = from_int(self.small_positive)
        result["unbounded"] = from_int(self.unbounded)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
