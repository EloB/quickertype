from dataclasses import dataclass
from typing import Any, TypeVar, Callable, Type, cast


T = TypeVar("T")


def from_dict(f: Callable[[Any], T], x: Any) -> dict[str, T]:
    assert isinstance(x, dict)
    return { k: f(v) for (k, v) in x.items() }


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


@dataclass
class Reward:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Reward':
        assert isinstance(obj, dict)
        return Reward()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Objective:
    rewards: dict[str, Reward]

    @staticmethod
    def from_dict(obj: Any) -> 'Objective':
        assert isinstance(obj, dict)
        rewards = from_dict(Reward.from_dict, obj["rewards"])
        return Objective(rewards)

    def to_dict(self) -> dict:
        result: dict = {}
        result["rewards"] = from_dict(lambda x: to_class(Reward, x), self.rewards)
        return result


@dataclass
class MissionSpec:
    objectives: dict[str, Objective]

    @staticmethod
    def from_dict(obj: Any) -> 'MissionSpec':
        assert isinstance(obj, dict)
        objectives = from_dict(Objective.from_dict, obj["objectives"])
        return MissionSpec(objectives)

    def to_dict(self) -> dict:
        result: dict = {}
        result["objectives"] = from_dict(lambda x: to_class(Objective, x), self.objectives)
        return result


@dataclass
class TopLevel:
    mission_specs: dict[str, MissionSpec]

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        mission_specs = from_dict(MissionSpec.from_dict, obj["mission_specs"])
        return TopLevel(mission_specs)

    def to_dict(self) -> dict:
        result: dict = {}
        result["mission_specs"] = from_dict(lambda x: to_class(MissionSpec, x), self.mission_specs)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
