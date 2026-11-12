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
class LightParams:
    app_id: str
    outlet_id: str
    rgba: str

    @staticmethod
    def from_dict(obj: Any) -> 'LightParams':
        assert isinstance(obj, dict)
        app_id = from_str(obj["app_id"])
        outlet_id = from_str(obj["outlet_id"])
        rgba = from_str(obj["rgba"])
        return LightParams(app_id, outlet_id, rgba)

    def to_dict(self) -> dict:
        result: dict = {}
        result["app_id"] = from_str(self.app_id)
        result["outlet_id"] = from_str(self.outlet_id)
        result["rgba"] = from_str(self.rgba)
        return result


@dataclass
class TopLevel:
    light_params: LightParams

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        light_params = LightParams.from_dict(obj["LightParams"])
        return TopLevel(light_params)

    def to_dict(self) -> dict:
        result: dict = {}
        result["LightParams"] = to_class(LightParams, self.light_params)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
