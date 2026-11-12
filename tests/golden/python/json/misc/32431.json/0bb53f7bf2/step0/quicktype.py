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


class MagType(Enum):
    MD = "md"
    ML = "ml"
    MB = "mb"


class Status(Enum):
    AUTOMATIC = "automatic"
    REVIEWED = "reviewed"


class PropertiesType(Enum):
    EARTHQUAKE = "earthquake"


@dataclass
class Properties:
    code: str
    detail: str
    ids: str
    mag: float
    mag_type: MagType
    net: str
    place: str
    rms: float
    sig: int
    sources: str
    status: Status
    time: int
    title: str
    tsunami: int
    type: PropertiesType
    types: str
    tz: int
    updated: int
    url: str
    alert: None
    cdi: None
    dmin: float | None
    felt: None
    gap: int | None
    mmi: None
    nst: int | None

    @staticmethod
    def from_dict(obj: Any) -> 'Properties':
        assert isinstance(obj, dict)
        code = from_str(obj["code"])
        detail = from_str(obj["detail"])
        ids = from_str(obj["ids"])
        mag = from_float(obj["mag"])
        mag_type = MagType(obj["magType"])
        net = from_str(obj["net"])
        place = from_str(obj["place"])
        rms = from_float(obj["rms"])
        sig = from_int(obj["sig"])
        sources = from_str(obj["sources"])
        status = Status(obj["status"])
        time = from_int(obj["time"])
        title = from_str(obj["title"])
        tsunami = from_int(obj["tsunami"])
        type = PropertiesType(obj["type"])
        types = from_str(obj["types"])
        tz = from_int(obj["tz"])
        updated = from_int(obj["updated"])
        url = from_str(obj["url"])
        alert = from_none(obj["alert"])
        cdi = from_none(obj["cdi"])
        dmin = from_union([from_float, from_none], obj["dmin"])
        felt = from_none(obj["felt"])
        gap = from_union([from_int, from_none], obj["gap"])
        mmi = from_none(obj["mmi"])
        nst = from_union([from_int, from_none], obj["nst"])
        return Properties(code, detail, ids, mag, mag_type, net, place, rms, sig, sources, status, time, title, tsunami, type, types, tz, updated, url, alert, cdi, dmin, felt, gap, mmi, nst)

    def to_dict(self) -> dict:
        result: dict = {}
        result["code"] = from_str(self.code)
        result["detail"] = from_str(self.detail)
        result["ids"] = from_str(self.ids)
        result["mag"] = to_float(self.mag)
        result["magType"] = to_enum(MagType, self.mag_type)
        result["net"] = from_str(self.net)
        result["place"] = from_str(self.place)
        result["rms"] = to_float(self.rms)
        result["sig"] = from_int(self.sig)
        result["sources"] = from_str(self.sources)
        result["status"] = to_enum(Status, self.status)
        result["time"] = from_int(self.time)
        result["title"] = from_str(self.title)
        result["tsunami"] = from_int(self.tsunami)
        result["type"] = to_enum(PropertiesType, self.type)
        result["types"] = from_str(self.types)
        result["tz"] = from_int(self.tz)
        result["updated"] = from_int(self.updated)
        result["url"] = from_str(self.url)
        result["alert"] = from_none(self.alert)
        result["cdi"] = from_none(self.cdi)
        result["dmin"] = from_union([to_float, from_none], self.dmin)
        result["felt"] = from_none(self.felt)
        result["gap"] = from_union([from_int, from_none], self.gap)
        result["mmi"] = from_none(self.mmi)
        result["nst"] = from_union([from_int, from_none], self.nst)
        return result


class FeatureType(Enum):
    FEATURE = "Feature"


@dataclass
class Feature:
    geometry: Geometry
    id: str
    properties: Properties
    type: FeatureType

    @staticmethod
    def from_dict(obj: Any) -> 'Feature':
        assert isinstance(obj, dict)
        geometry = Geometry.from_dict(obj["geometry"])
        id = from_str(obj["id"])
        properties = Properties.from_dict(obj["properties"])
        type = FeatureType(obj["type"])
        return Feature(geometry, id, properties, type)

    def to_dict(self) -> dict:
        result: dict = {}
        result["geometry"] = to_class(Geometry, self.geometry)
        result["id"] = from_str(self.id)
        result["properties"] = to_class(Properties, self.properties)
        result["type"] = to_enum(FeatureType, self.type)
        return result


@dataclass
class Metadata:
    api: str
    count: int
    generated: int
    status: int
    title: str
    url: str

    @staticmethod
    def from_dict(obj: Any) -> 'Metadata':
        assert isinstance(obj, dict)
        api = from_str(obj["api"])
        count = from_int(obj["count"])
        generated = from_int(obj["generated"])
        status = from_int(obj["status"])
        title = from_str(obj["title"])
        url = from_str(obj["url"])
        return Metadata(api, count, generated, status, title, url)

    def to_dict(self) -> dict:
        result: dict = {}
        result["api"] = from_str(self.api)
        result["count"] = from_int(self.count)
        result["generated"] = from_int(self.generated)
        result["status"] = from_int(self.status)
        result["title"] = from_str(self.title)
        result["url"] = from_str(self.url)
        return result


@dataclass
class TopLevel:
    bbox: list[float]
    features: list[Feature]
    metadata: Metadata
    type: str

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        bbox = from_list(from_float, obj["bbox"])
        features = from_list(Feature.from_dict, obj["features"])
        metadata = Metadata.from_dict(obj["metadata"])
        type = from_str(obj["type"])
        return TopLevel(bbox, features, metadata, type)

    def to_dict(self) -> dict:
        result: dict = {}
        result["bbox"] = from_list(to_float, self.bbox)
        result["features"] = from_list(lambda x: to_class(Feature, x), self.features)
        result["metadata"] = to_class(Metadata, self.metadata)
        result["type"] = from_str(self.type)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
