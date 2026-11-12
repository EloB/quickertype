from typing import Any, TypeVar, Callable


T = TypeVar("T")


def from_dict(f: Callable[[Any], T], x: Any) -> dict[str, T]:
    assert isinstance(x, dict)
    return { k: f(v) for (k, v) in x.items() }


def top_level_from_dict(s: Any) -> dict[str, Any]:
    return from_dict(lambda x: x, s)


def top_level_to_dict(x: dict[str, Any]) -> Any:
    return from_dict(lambda x: x, x)
