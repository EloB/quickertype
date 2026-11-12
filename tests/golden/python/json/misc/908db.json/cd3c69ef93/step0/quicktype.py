from dataclasses import dataclass
from typing import Any, TypeVar, Type, cast, Callable


T = TypeVar("T")


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


@dataclass
class StateState:
    state_id: str
    state_name: str

    @staticmethod
    def from_dict(obj: Any) -> 'StateState':
        assert isinstance(obj, dict)
        state_id = from_str(obj["state_id"])
        state_name = from_str(obj["state_name"])
        return StateState(state_id, state_name)

    def to_dict(self) -> dict:
        result: dict = {}
        result["state_id"] = from_str(self.state_id)
        result["state_name"] = from_str(self.state_name)
        return result


@dataclass
class StateElement:
    state: StateState

    @staticmethod
    def from_dict(obj: Any) -> 'StateElement':
        assert isinstance(obj, dict)
        state = StateState.from_dict(obj["state"])
        return StateElement(state)

    def to_dict(self) -> dict:
        result: dict = {}
        result["state"] = to_class(StateState, self.state)
        return result


@dataclass
class TopLevel:
    states: list[StateElement]

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        states = from_list(StateElement.from_dict, obj["states"])
        return TopLevel(states)

    def to_dict(self) -> dict:
        result: dict = {}
        result["states"] = from_list(lambda x: to_class(StateElement, x), self.states)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
