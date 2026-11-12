from dataclasses import dataclass
from typing import Any, TypeVar, Type, cast


T = TypeVar("T")


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


@dataclass
class Hints:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Hints':
        assert isinstance(obj, dict)
        return Hints()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Labels:
    account_number: str
    title: str

    @staticmethod
    def from_dict(obj: Any) -> 'Labels':
        assert isinstance(obj, dict)
        account_number = from_str(obj["AccountNumber"])
        title = from_str(obj["Title"])
        return Labels(account_number, title)

    def to_dict(self) -> dict:
        result: dict = {}
        result["AccountNumber"] = from_str(self.account_number)
        result["Title"] = from_str(self.title)
        return result


@dataclass
class TopLevel:
    hints: Hints
    labels: Labels

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        hints = Hints.from_dict(obj["Hints"])
        labels = Labels.from_dict(obj["Labels"])
        return TopLevel(hints, labels)

    def to_dict(self) -> dict:
        result: dict = {}
        result["Hints"] = to_class(Hints, self.hints)
        result["Labels"] = to_class(Labels, self.labels)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
