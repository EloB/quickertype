from enum import Enum
from dataclasses import dataclass
from typing import Any, TypeVar, Callable, Type, cast


T = TypeVar("T")
EnumT = TypeVar("EnumT", bound=Enum)


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


def from_float(x: Any) -> float:
    assert isinstance(x, (float, int)) and not isinstance(x, bool)
    return float(x)


def to_float(x: Any) -> float:
    assert isinstance(x, (int, float))
    return x


def to_enum(c: Type[EnumT], x: Any) -> EnumT:
    assert isinstance(x, c)
    return x.value


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


class GeometryType(Enum):
    POINT = "Point"


@dataclass
class Geometry:
    coordinates: list[float]
    type: GeometryType

    @staticmethod
    def from_dict(obj: Any) -> 'Geometry':
        assert isinstance(obj, dict)
        coordinates = from_list(from_float, obj["coordinates"])
        type = GeometryType(obj["type"])
        return Geometry(coordinates, type)

    def to_dict(self) -> dict:
        result: dict = {}
        result["coordinates"] = from_list(to_float, self.coordinates)
        result["type"] = to_enum(GeometryType, self.type)
        return result


class MaintainingAuthority(Enum):
    CITY_OF_BALLARAT = "City of Ballarat"


class Class(Enum):
    NO_CODE_ALLOCATED = "No Code Allocated"
    OS_DISTRICT = "OS-District"
    OS_NEIGHBOURHOOD = "OS-Neighbourhood"
    OS_REGIONAL = "OS-Regional"


class Ward(Enum):
    SOUTH = "South"
    NORTH = "North"
    CENTRAL = "Central"


@dataclass
class Properties:
    area: str
    central_asset_id: str
    properties_class: Class
    feature_location: str
    maintaining_authority: MaintainingAuthority
    number: int
    site_name: str
    ward: Ward
    lat: str
    long: str

    @staticmethod
    def from_dict(obj: Any) -> 'Properties':
        assert isinstance(obj, dict)
        area = from_str(obj["Area"])
        central_asset_id = from_str(obj["Central Asset ID"])
        properties_class = Class(obj["Class"])
        feature_location = from_str(obj["Feature Location"])
        maintaining_authority = MaintainingAuthority(obj["Maintaining Authority"])
        number = int(from_str(obj["Number"]))
        site_name = from_str(obj["Site Name"])
        ward = Ward(obj["Ward"])
        lat = from_str(obj["lat"])
        long = from_str(obj["long"])
        return Properties(area, central_asset_id, properties_class, feature_location, maintaining_authority, number, site_name, ward, lat, long)

    def to_dict(self) -> dict:
        result: dict = {}
        result["Area"] = from_str(self.area)
        result["Central Asset ID"] = from_str(self.central_asset_id)
        result["Class"] = to_enum(Class, self.properties_class)
        result["Feature Location"] = from_str(self.feature_location)
        result["Maintaining Authority"] = to_enum(MaintainingAuthority, self.maintaining_authority)
        result["Number"] = from_str(str(self.number))
        result["Site Name"] = from_str(self.site_name)
        result["Ward"] = to_enum(Ward, self.ward)
        result["lat"] = from_str(self.lat)
        result["long"] = from_str(self.long)
        return result


class FeatureType(Enum):
    FEATURE = "Feature"


@dataclass
class Feature:
    geometry: Geometry
    properties: Properties
    type: FeatureType

    @staticmethod
    def from_dict(obj: Any) -> 'Feature':
        assert isinstance(obj, dict)
        geometry = Geometry.from_dict(obj["geometry"])
        properties = Properties.from_dict(obj["properties"])
        type = FeatureType(obj["type"])
        return Feature(geometry, properties, type)

    def to_dict(self) -> dict:
        result: dict = {}
        result["geometry"] = to_class(Geometry, self.geometry)
        result["properties"] = to_class(Properties, self.properties)
        result["type"] = to_enum(FeatureType, self.type)
        return result


@dataclass
class TopLevel:
    features: list[Feature]
    name: str
    type: str

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        features = from_list(Feature.from_dict, obj["features"])
        name = from_str(obj["name"])
        type = from_str(obj["type"])
        return TopLevel(features, name, type)

    def to_dict(self) -> dict:
        result: dict = {}
        result["features"] = from_list(lambda x: to_class(Feature, x), self.features)
        result["name"] = from_str(self.name)
        result["type"] = from_str(self.type)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
