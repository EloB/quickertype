from dataclasses import dataclass
from typing import Any, TypeVar, Type, cast


T = TypeVar("T")


def from_bool(x: Any) -> bool:
    assert isinstance(x, bool)
    return x


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


@dataclass
class TopLevel:
    spaces_are_separators_too: bool
    json_string: str
    pretty_easy_too: bool
    zsr_hh_demo3_delmatnr: bool
    an_easy_one: int
    is_mnist_letter: bool
    should_know_that_id_is_an_initialism: str

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        spaces_are_separators_too = from_bool(obj["   spaces are separators  too  "])
        json_string = from_str(obj["JSONString"])
        pretty_easy_too = from_bool(obj["PrettyEasyToo"])
        zsr_hh_demo3_delmatnr = from_bool(obj["ZSR_HH_DEMO3_DELMATNR"])
        an_easy_one = from_int(obj["anEasyOne"])
        is_mnist_letter = from_bool(obj["isMNISTLetter"])
        should_know_that_id_is_an_initialism = from_str(obj["should_know_that_id_is_an_initialism"])
        return TopLevel(spaces_are_separators_too, json_string, pretty_easy_too, zsr_hh_demo3_delmatnr, an_easy_one, is_mnist_letter, should_know_that_id_is_an_initialism)

    def to_dict(self) -> dict:
        result: dict = {}
        result["   spaces are separators  too  "] = from_bool(self.spaces_are_separators_too)
        result["JSONString"] = from_str(self.json_string)
        result["PrettyEasyToo"] = from_bool(self.pretty_easy_too)
        result["ZSR_HH_DEMO3_DELMATNR"] = from_bool(self.zsr_hh_demo3_delmatnr)
        result["anEasyOne"] = from_int(self.an_easy_one)
        result["isMNISTLetter"] = from_bool(self.is_mnist_letter)
        result["should_know_that_id_is_an_initialism"] = from_str(self.should_know_that_id_is_an_initialism)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
