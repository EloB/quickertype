from typing import Any, TypeVar, Callable


T = TypeVar("T")


def from_dict(f: Callable[[Any], T], x: Any) -> dict[str, T]:
    assert isinstance(x, dict)
    return { k: f(v) for (k, v) in x.items() }


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def top_level_from_dict(s: Any) -> dict[str, str]:
    return from_dict(from_str, s)


def top_level_to_dict(x: dict[str, str]) -> Any:
    return from_dict(from_str, x)
