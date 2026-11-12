from typing import Any


def from_float(x: Any) -> float:
    assert isinstance(x, (float, int)) and not isinstance(x, bool)
    return float(x)


def to_float(x: Any) -> float:
    assert isinstance(x, (int, float))
    return x


def top_level_from_dict(s: Any) -> float:
    return from_float(s)


def top_level_to_dict(x: float) -> Any:
    return to_float(x)
