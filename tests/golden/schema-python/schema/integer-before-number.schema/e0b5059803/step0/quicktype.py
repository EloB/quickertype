from typing import Any


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def from_float(x: Any) -> float:
    assert isinstance(x, (float, int)) and not isinstance(x, bool)
    return float(x)


def from_union(fs, x):
    for f in fs:
        try:
            return f(x)
        except:
            pass
    assert False


def to_float(x: Any) -> float:
    assert isinstance(x, (int, float))
    return x


def top_level_from_dict(s: Any) -> float | int:
    return from_union([from_int, from_float], s)


def top_level_to_dict(x: float | int) -> Any:
    return from_union([from_int, to_float], x)
