from dataclasses import dataclass
from typing import Any, TypeVar, Callable, Type, cast


T = TypeVar("T")


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def from_float(x: Any) -> float:
    assert isinstance(x, (float, int)) and not isinstance(x, bool)
    return float(x)


def to_float(x: Any) -> float:
    assert isinstance(x, (int, float))
    return x


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


@dataclass
class TextClassificationOutputElement:
    label: str
    score: float

    @staticmethod
    def from_dict(obj: Any) -> 'TextClassificationOutputElement':
        assert isinstance(obj, dict)
        label = from_str(obj["label"])
        score = from_float(obj["score"])
        return TextClassificationOutputElement(label, score)

    def to_dict(self) -> dict:
        result: dict = {}
        result["label"] = from_str(self.label)
        result["score"] = to_float(self.score)
        return result


def top_level_from_dict(s: Any) -> list[TextClassificationOutputElement]:
    return from_list(TextClassificationOutputElement.from_dict, s)


def top_level_to_dict(x: list[TextClassificationOutputElement]) -> Any:
    return from_list(lambda x: to_class(TextClassificationOutputElement, x), x)
