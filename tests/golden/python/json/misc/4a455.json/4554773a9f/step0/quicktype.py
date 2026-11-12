from dataclasses import dataclass
from typing import Any, TypeVar, Type, cast, Callable
from enum import Enum


T = TypeVar("T")
EnumT = TypeVar("EnumT", bound=Enum)


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


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


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


@dataclass
class CRSProperties:
    name: str

    @staticmethod
    def from_dict(obj: Any) -> 'CRSProperties':
        assert isinstance(obj, dict)
        name = from_str(obj["name"])
        return CRSProperties(name)

    def to_dict(self) -> dict:
        result: dict = {}
        result["name"] = from_str(self.name)
        return result


@dataclass
class CRS:
    properties: CRSProperties
    type: str

    @staticmethod
    def from_dict(obj: Any) -> 'CRS':
        assert isinstance(obj, dict)
        properties = CRSProperties.from_dict(obj["properties"])
        type = from_str(obj["type"])
        return CRS(properties, type)

    def to_dict(self) -> dict:
        result: dict = {}
        result["properties"] = to_class(CRSProperties, self.properties)
        result["type"] = from_str(self.type)
        return result


class GeometryType(Enum):
    MULTI_POINT = "MultiPoint"


@dataclass
class Geometry:
    coordinates: list[list[float]]
    type: GeometryType

    @staticmethod
    def from_dict(obj: Any) -> 'Geometry':
        assert isinstance(obj, dict)
        coordinates = from_list(lambda x: from_list(from_float, x), obj["coordinates"])
        type = GeometryType(obj["type"])
        return Geometry(coordinates, type)

    def to_dict(self) -> dict:
        result: dict = {}
        result["coordinates"] = from_list(lambda x: from_list(to_float, x), self.coordinates)
        result["type"] = to_enum(GeometryType, self.type)
        return result


class GeometryName(Enum):
    GEOM = "geom"


@dataclass
class FeatureProperties:
    facebookaccount: str
    frequencyfinderurl: str
    name: str
    siteurl: str
    streetaddress: str
    twitteraccount: str

    @staticmethod
    def from_dict(obj: Any) -> 'FeatureProperties':
        assert isinstance(obj, dict)
        facebookaccount = from_str(obj["facebookaccount"])
        frequencyfinderurl = from_str(obj["frequencyfinderurl"])
        name = from_str(obj["name"])
        siteurl = from_str(obj["siteurl"])
        streetaddress = from_str(obj["streetaddress"])
        twitteraccount = from_str(obj["twitteraccount"])
        return FeatureProperties(facebookaccount, frequencyfinderurl, name, siteurl, streetaddress, twitteraccount)

    def to_dict(self) -> dict:
        result: dict = {}
        result["facebookaccount"] = from_str(self.facebookaccount)
        result["frequencyfinderurl"] = from_str(self.frequencyfinderurl)
        result["name"] = from_str(self.name)
        result["siteurl"] = from_str(self.siteurl)
        result["streetaddress"] = from_str(self.streetaddress)
        result["twitteraccount"] = from_str(self.twitteraccount)
        return result


class FeatureType(Enum):
    FEATURE = "Feature"


@dataclass
class Feature:
    geometry: Geometry
    geometry_name: GeometryName
    id: str
    properties: FeatureProperties
    type: FeatureType

    @staticmethod
    def from_dict(obj: Any) -> 'Feature':
        assert isinstance(obj, dict)
        geometry = Geometry.from_dict(obj["geometry"])
        geometry_name = GeometryName(obj["geometry_name"])
        id = from_str(obj["id"])
        properties = FeatureProperties.from_dict(obj["properties"])
        type = FeatureType(obj["type"])
        return Feature(geometry, geometry_name, id, properties, type)

    def to_dict(self) -> dict:
        result: dict = {}
        result["geometry"] = to_class(Geometry, self.geometry)
        result["geometry_name"] = to_enum(GeometryName, self.geometry_name)
        result["id"] = from_str(self.id)
        result["properties"] = to_class(FeatureProperties, self.properties)
        result["type"] = to_enum(FeatureType, self.type)
        return result


@dataclass
class TopLevel:
    crs: CRS
    features: list[Feature]
    total_features: int
    type: str

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        crs = CRS.from_dict(obj["crs"])
        features = from_list(Feature.from_dict, obj["features"])
        total_features = from_int(obj["totalFeatures"])
        type = from_str(obj["type"])
        return TopLevel(crs, features, total_features, type)

    def to_dict(self) -> dict:
        result: dict = {}
        result["crs"] = to_class(CRS, self.crs)
        result["features"] = from_list(lambda x: to_class(Feature, x), self.features)
        result["totalFeatures"] = from_int(self.total_features)
        result["type"] = from_str(self.type)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
