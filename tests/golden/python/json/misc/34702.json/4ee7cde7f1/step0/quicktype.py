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


class GeometryName(Enum):
    GEOM = "geom"


class FireBanR(Enum):
    NORTH_CENTRAL = "North Central"
    CENTRAL = "Central"
    SOUTH_WEST = "South West"
    WIMMERA = "Wimmera"
    NORTHERN_COUNTRY = "Northern Country"
    EAST_GIPPSLAND = "East Gippsland"
    NORTH_EAST = "North East"
    MALLEE = "Mallee"
    WEST_SOUTH_GIPPSLAND = "West &South Gippsland"
    BALLARAT = "Ballarat"


class Region(Enum):
    EASTERN = "Eastern"
    NORTHERN_METRO = "Northern Metro"
    WESTERN = "Western"
    SOUTHERN_METRO = "Southern Metro"


class PropertiesType(Enum):
    STREET = "STREET"
    AVENUE = "AVENUE"
    ROAD = "ROAD"
    HIGHWAY = "HIGHWAY"
    BOULEVARD = "BOULEVARD"
    COURT = "COURT"
    WAY = "WAY"
    DRIVE = "DRIVE"
    SOUTH = "SOUTH"
    HILL = "HILL"
    LANE = "LANE"
    CLOSE = "CLOSE"
    PARADE = "PARADE"
    TYPE_ROAD = "Road"
    PLACE = "PLACE"
    RD = "RD"


@dataclass
class FeatureProperties:
    division: int
    fax: float
    latitude: float
    local_govt: str
    longitude: float
    phone: float
    postcode: int
    psa: str
    region: Region
    station: str
    street: str
    suburb: str
    fire_ban_r: FireBanR | None
    no: str | None
    type: PropertiesType | None

    @staticmethod
    def from_dict(obj: Any) -> 'FeatureProperties':
        assert isinstance(obj, dict)
        division = int(from_str(obj["division"]))
        fax = from_float(obj["fax"])
        latitude = from_float(obj["latitude"])
        local_govt = from_str(obj["local_govt"])
        longitude = from_float(obj["longitude"])
        phone = from_float(obj["phone"])
        postcode = from_int(obj["postcode"])
        psa = from_str(obj["psa"])
        region = Region(obj["region"])
        station = from_str(obj["station"])
        street = from_str(obj["street"])
        suburb = from_str(obj["suburb"])
        fire_ban_r = from_union([FireBanR, from_none], obj["fire_ban_r"])
        no = from_union([from_none, from_str], obj["no"])
        type = from_union([PropertiesType, from_none], obj["type"])
        return FeatureProperties(division, fax, latitude, local_govt, longitude, phone, postcode, psa, region, station, street, suburb, fire_ban_r, no, type)

    def to_dict(self) -> dict:
        result: dict = {}
        result["division"] = from_str(str(self.division))
        result["fax"] = to_float(self.fax)
        result["latitude"] = to_float(self.latitude)
        result["local_govt"] = from_str(self.local_govt)
        result["longitude"] = to_float(self.longitude)
        result["phone"] = to_float(self.phone)
        result["postcode"] = from_int(self.postcode)
        result["psa"] = from_str(self.psa)
        result["region"] = to_enum(Region, self.region)
        result["station"] = from_str(self.station)
        result["street"] = from_str(self.street)
        result["suburb"] = from_str(self.suburb)
        result["fire_ban_r"] = from_union([lambda x: to_enum(FireBanR, x), from_none], self.fire_ban_r)
        result["no"] = from_union([from_none, from_str], self.no)
        result["type"] = from_union([lambda x: to_enum(PropertiesType, x), from_none], self.type)
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
