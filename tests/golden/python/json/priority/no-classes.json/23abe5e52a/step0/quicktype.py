from typing import Any


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def top_level_from_dict(s: Any) -> int:
    return from_int(s)


def top_level_to_dict(x: int) -> Any:
    return from_int(x)
