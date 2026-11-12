import re
from dataclasses import dataclass
from typing import Any, cast, TypeVar, Callable, Type
from enum import Enum


T = TypeVar("T")
EnumT = TypeVar("EnumT", bound=Enum)


def from_float(x: Any) -> float:
    assert isinstance(x, (float, int)) and not isinstance(x, bool)
    return float(x)


def from_none(x: Any) -> Any:
    assert x is None
    return x


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


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


def from_bool(x: Any) -> bool:
    assert isinstance(x, bool)
    return x


def to_enum(c: Type[EnumT], x: Any) -> EnumT:
    assert isinstance(x, c)
    return x.value


@dataclass
class Color:
    rgb: float | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'Color':
        assert isinstance(obj, dict)
        rgb = from_union([from_float, from_none], obj.get("rgb"))
        return Color(rgb)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.rgb is not None:
            result["rgb"] = from_union([to_float, from_none], self.rgb)
        return result


@dataclass
class CircularShape:
    shape_name: str | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'CircularShape':
        assert isinstance(obj, dict)
        shape_name = from_union([from_str, from_none], obj.get("shapeName"))
        return CircularShape(shape_name)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.shape_name is not None:
            result["shapeName"] = from_union([from_str, from_none], self.shape_name)
        return result


@dataclass
class Part:
    depth: str | None = None
    length: str | None = None
    width: str | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'Part':
        assert isinstance(obj, dict)
        depth = from_union([from_str, from_none], obj.get("depth"))
        length = from_union([from_str, from_none], obj.get("length"))
        width = from_union([from_str, from_none], obj.get("width"))
        return Part(depth, length, width)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.depth is not None:
            result["depth"] = from_union([from_str, from_none], self.depth)
        if self.length is not None:
            result["length"] = from_union([from_str, from_none], self.length)
        if self.width is not None:
            result["width"] = from_union([from_str, from_none], self.width)
        return result


@dataclass
class RectShape:
    parts: list[Part] | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'RectShape':
        assert isinstance(obj, dict)
        parts = from_union([lambda x: from_list(Part.from_dict, x), from_none], obj.get("parts"))
        return RectShape(parts)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.parts is not None:
            result["parts"] = from_union([lambda x: from_list(lambda x: to_class(Part, x), x), from_none], self.parts)
        return result


@dataclass
class Geometry:
    rect_shape: RectShape | None = None
    circular_shape: list[CircularShape] | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'Geometry':
        assert isinstance(obj, dict)
        rect_shape = from_union([RectShape.from_dict, from_none], obj.get("rectShape"))
        circular_shape = from_union([lambda x: from_list(CircularShape.from_dict, x), from_none], obj.get("circularShape"))
        return Geometry(rect_shape, circular_shape)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.rect_shape is not None:
            result["rectShape"] = from_union([lambda x: to_class(RectShape, x), from_none], self.rect_shape)
        if self.circular_shape is not None:
            result["circularShape"] = from_union([lambda x: from_list(lambda x: to_class(CircularShape, x), x), from_none], self.circular_shape)
        return result


@dataclass
class History:
    history_class: str | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'History':
        assert isinstance(obj, dict)
        history_class = from_union([from_str, from_none], obj.get("class"))
        return History(history_class)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.history_class is not None:
            result["class"] = from_union([from_str, from_none], self.history_class)
        return result


@dataclass
class Shape:
    geometry: Geometry | None = None
    history: History | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'Shape':
        assert isinstance(obj, dict)
        geometry = from_union([Geometry.from_dict, from_none], obj.get("geometry"))
        history = from_union([History.from_dict, from_none], obj.get("history"))
        return Shape(geometry, history)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.geometry is not None:
            result["geometry"] = from_union([lambda x: to_class(Geometry, x), from_none], self.geometry)
        if self.history is not None:
            result["history"] = from_union([lambda x: to_class(History, x), from_none], self.history)
        return result


@dataclass
class Berry:
    color: Color | None = None
    name: str | None = None
    shapes: list[Shape] | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'Berry':
        assert isinstance(obj, dict)
        color = from_union([Color.from_dict, from_none], obj.get("color"))
        name = from_union([from_str, from_none], obj.get("name"))
        assert name is None or 1 <= len(cast(str, obj.get("name")))
        shapes = from_union([lambda x: from_list(Shape.from_dict, x), from_none], obj.get("shapes"))
        return Berry(color, name, shapes)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.color is not None:
            result["color"] = from_union([lambda x: to_class(Color, x), from_none], self.color)
        if self.name is not None:
            result["name"] = from_union([from_str, from_none], self.name)
        if self.shapes is not None:
            result["shapes"] = from_union([lambda x: from_list(lambda x: to_class(Shape, x), x), from_none], self.shapes)
        return result


@dataclass
class Fruit:
    apple: bool | None = None
    berries: list[Berry] | None = None
    orange: bool | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'Fruit':
        assert isinstance(obj, dict)
        apple = from_union([from_bool, from_none], obj.get("apple"))
        berries = from_union([lambda x: from_list(Berry.from_dict, x), from_none], obj.get("berries"))
        orange = from_union([from_bool, from_none], obj.get("orange"))
        return Fruit(apple, berries, orange)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.apple is not None:
            result["apple"] = from_union([from_bool, from_none], self.apple)
        if self.berries is not None:
            result["berries"] = from_union([lambda x: from_list(lambda x: to_class(Berry, x), x), from_none], self.berries)
        if self.orange is not None:
            result["orange"] = from_union([from_bool, from_none], self.orange)
        return result


@dataclass
class Limit:
    maximum: float | None = None
    minimum: float | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'Limit':
        assert isinstance(obj, dict)
        maximum = from_union([from_float, from_none], obj.get("maximum"))
        minimum = from_union([from_float, from_none], obj.get("minimum"))
        return Limit(maximum, minimum)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.maximum is not None:
            result["maximum"] = from_union([to_float, from_none], self.maximum)
        if self.minimum is not None:
            result["minimum"] = from_union([to_float, from_none], self.minimum)
        return result


@dataclass
class Speed:
    velocity: Limit | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'Speed':
        assert isinstance(obj, dict)
        velocity = from_union([Limit.from_dict, from_none], obj.get("velocity"))
        return Speed(velocity)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.velocity is not None:
            result["velocity"] = from_union([lambda x: to_class(Limit, x), from_none], self.velocity)
        return result


class Axis(Enum):
    X = "X"
    Y = "Y"
    Z = "Z"
    XY = "XY"
    YZ = "YZ"
    ZX = "ZX"


class Name(Enum):
    TRUCK = "truck"
    BUS = "bus"
    CAR = "car"
    VAN = "van"
    TRAIN = "train"
    BIKE = "Bike"
    AEROPLANE = "Aeroplane"
    JEEP = "Jeep"
    TROLLEY = "Trolley"


@dataclass
class VehicleType:
    name: Name | None = None
    width: Axis | None = None
    length: Axis | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'VehicleType':
        assert isinstance(obj, dict)
        name = from_union([Name, from_none], obj.get("name"))
        width = from_union([Axis, from_none], obj.get("width"))
        length = from_union([Axis, from_none], obj.get("length"))
        return VehicleType(name, width, length)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.name is not None:
            result["name"] = from_union([lambda x: to_enum(Name, x), from_none], self.name)
        if self.width is not None:
            result["width"] = from_union([lambda x: to_enum(Axis, x), from_none], self.width)
        if self.length is not None:
            result["length"] = from_union([lambda x: to_enum(Axis, x), from_none], self.length)
        return result


@dataclass
class Vehicle:
    brand: str | None = None
    id: str | None = None
    speed: Speed | None = None
    sub_module: bool | None = None
    type: VehicleType | None = None
    year: str | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'Vehicle':
        assert isinstance(obj, dict)
        brand = from_union([from_str, from_none], obj.get("brand"))
        id = from_union([from_str, from_none], obj.get("id"))
        assert id is None or 1 <= len(cast(str, obj.get("id")))
        speed = from_union([Speed.from_dict, from_none], obj.get("speed"))
        sub_module = from_union([from_bool, from_none], obj.get("subModule"))
        type = from_union([VehicleType.from_dict, from_none], obj.get("type"))
        year = from_union([from_str, from_none], obj.get("year"))
        return Vehicle(brand, id, speed, sub_module, type, year)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.brand is not None:
            result["brand"] = from_union([from_str, from_none], self.brand)
        if self.id is not None:
            result["id"] = from_union([from_str, from_none], self.id)
        if self.speed is not None:
            result["speed"] = from_union([lambda x: to_class(Speed, x), from_none], self.speed)
        if self.sub_module is not None:
            result["subModule"] = from_union([from_bool, from_none], self.sub_module)
        if self.type is not None:
            result["type"] = from_union([lambda x: to_class(VehicleType, x), from_none], self.type)
        if self.year is not None:
            result["year"] = from_union([from_str, from_none], self.year)
        return result


@dataclass
class TopLevel:
    version: str | None = None
    fruits: list[Fruit] | None = None
    vehicles: list[Vehicle] | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        version = from_union([from_str, from_none], obj.get("version"))
        assert version is None or re.search("^\\d{1,5}.{1}\\d{1,5}.{1}\\d{1,5}$", cast(str, obj.get("version")))
        fruits = from_union([lambda x: from_list(Fruit.from_dict, x), from_none], obj.get("fruits"))
        vehicles = from_union([lambda x: from_list(Vehicle.from_dict, x), from_none], obj.get("vehicles"))
        return TopLevel(version, fruits, vehicles)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.version is not None:
            result["version"] = from_union([from_str, from_none], self.version)
        if self.fruits is not None:
            result["fruits"] = from_union([lambda x: from_list(lambda x: to_class(Fruit, x), x), from_none], self.fruits)
        if self.vehicles is not None:
            result["vehicles"] = from_union([lambda x: from_list(lambda x: to_class(Vehicle, x), x), from_none], self.vehicles)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
