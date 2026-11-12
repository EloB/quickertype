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


def is_type(t: Type[T], x: Any) -> T:
    assert isinstance(x, t)
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
    MULTI_POLYGON = "MultiPolygon"


@dataclass
class Geometry:
    coordinates: list[list[list[list[float]]]]
    type: GeometryType

    @staticmethod
    def from_dict(obj: Any) -> 'Geometry':
        assert isinstance(obj, dict)
        coordinates = from_list(lambda x: from_list(lambda x: from_list(lambda x: from_list(from_float, x), x), x), obj["coordinates"])
        type = GeometryType(obj["type"])
        return Geometry(coordinates, type)

    def to_dict(self) -> dict:
        result: dict = {}
        result["coordinates"] = from_list(lambda x: from_list(lambda x: from_list(lambda x: from_list(to_float, x), x), x), self.coordinates)
        result["type"] = to_enum(GeometryType, self.type)
        return result


class GeometryName(Enum):
    GEOM = "geom"


class AddImprov(Enum):
    F = "f"
    ADD_IMPROV_F = "F"
    T = "t"


class FundingBa(Enum):
    NON_GCCC = "Non GCCC"
    CAPEX = "Capex"
    INITIAL = "Initial"
    CONTRIBUTE = "Contribute"


class LevelAccu(Enum):
    GPS_CORRECTED_10_M = "GPS Corrected 1.0M"
    APPROX = "APPROX"
    GPS_C_ORRECTED_10_M = "GPS COrrected 1.0M"


class Material(Enum):
    GRAVEL = "Gravel"
    CONCRETE = "Concrete"
    BITUMEN = "Bitumen"
    INTERLOCK_CONC_BLOCK = "Interlock Conc Block"
    OTHER = "Other"
    EARTH = "Earth"


class MiSymbolo(Enum):
    PEN_2265535_BRUSH_1016777215 = "Pen (2, 2, 65535) Brush (1, 0, 16777215)"


class Status(Enum):
    CURRENT = "CURRENT"


class PropertiesType(Enum):
    BOAT_RAMP = "Boat Ramp"


@dataclass
class FeatureProperties:
    area: float
    asset_numb: str
    condition: int
    documents: str
    historic_c: int
    inspection: str
    material: Material
    mi_prinx: int
    mi_symbolo: MiSymbolo
    number_lan: int
    rec_id: int
    shape_area: float
    shape_leng: float
    status: Status
    toe_rl: float
    top_rl: float
    update_dat: str
    add_improv: AddImprov | None
    comments: str | None
    constructi: str | None
    createdate: None
    createuser: None
    disposal_d: None
    drawing_nu: str | None
    file_numbe: str | None
    folder_num: int | None
    funding_ba: FundingBa | None
    inspectors: None
    last_updat: None
    level_accu: LevelAccu | None
    owner: str | None
    positional: LevelAccu | None
    project_nu: str | None
    record_cre: str | None
    survey_num: None
    type: PropertiesType | None
    updatedate: None
    updateuser: None

    @staticmethod
    def from_dict(obj: Any) -> 'FeatureProperties':
        assert isinstance(obj, dict)
        area = from_float(obj["area_"])
        asset_numb = from_str(obj["asset_numb"])
        condition = from_int(obj["condition"])
        documents = from_str(obj["documents"])
        historic_c = from_int(obj["historic_c"])
        inspection = from_str(obj["inspection"])
        material = Material(obj["material"])
        mi_prinx = from_int(obj["mi_prinx"])
        mi_symbolo = MiSymbolo(obj["mi_symbolo"])
        number_lan = from_int(obj["number_lan"])
        rec_id = from_int(obj["rec_id"])
        shape_area = from_float(obj["shape_area"])
        shape_leng = from_float(obj["shape_leng"])
        status = Status(obj["status"])
        toe_rl = from_float(obj["toe_rl"])
        top_rl = from_float(obj["top_rl"])
        update_dat = from_str(obj["update_dat"])
        add_improv = from_union([AddImprov, from_none], obj["add_improv"])
        comments = from_union([from_none, from_str], obj["comments"])
        constructi = from_union([from_none, from_str], obj["constructi"])
        createdate = from_none(obj["createdate"])
        createuser = from_none(obj["createuser"])
        disposal_d = from_none(obj["disposal_d"])
        drawing_nu = from_union([from_none, from_str], obj["drawing_nu"])
        file_numbe = from_union([from_none, from_str], obj["file_numbe"])
        folder_num = from_union([from_none, lambda x: int(from_str(x))], obj["folder_num"])
        funding_ba = from_union([FundingBa, from_none], obj["funding_ba"])
        inspectors = from_none(obj["inspectors"])
        last_updat = from_none(obj["last_updat"])
        level_accu = from_union([LevelAccu, from_none], obj["level_accu"])
        owner = from_union([from_none, from_str], obj["owner"])
        positional = from_union([LevelAccu, from_none], obj["positional"])
        project_nu = from_union([from_none, from_str], obj["project_nu"])
        record_cre = from_union([from_none, from_str], obj["record_cre"])
        survey_num = from_none(obj["survey_num"])
        type = from_union([PropertiesType, from_none], obj["type"])
        updatedate = from_none(obj["updatedate"])
        updateuser = from_none(obj["updateuser"])
        return FeatureProperties(area, asset_numb, condition, documents, historic_c, inspection, material, mi_prinx, mi_symbolo, number_lan, rec_id, shape_area, shape_leng, status, toe_rl, top_rl, update_dat, add_improv, comments, constructi, createdate, createuser, disposal_d, drawing_nu, file_numbe, folder_num, funding_ba, inspectors, last_updat, level_accu, owner, positional, project_nu, record_cre, survey_num, type, updatedate, updateuser)

    def to_dict(self) -> dict:
        result: dict = {}
        result["area_"] = to_float(self.area)
        result["asset_numb"] = from_str(self.asset_numb)
        result["condition"] = from_int(self.condition)
        result["documents"] = from_str(self.documents)
        result["historic_c"] = from_int(self.historic_c)
        result["inspection"] = from_str(self.inspection)
        result["material"] = to_enum(Material, self.material)
        result["mi_prinx"] = from_int(self.mi_prinx)
        result["mi_symbolo"] = to_enum(MiSymbolo, self.mi_symbolo)
        result["number_lan"] = from_int(self.number_lan)
        result["rec_id"] = from_int(self.rec_id)
        result["shape_area"] = to_float(self.shape_area)
        result["shape_leng"] = to_float(self.shape_leng)
        result["status"] = to_enum(Status, self.status)
        result["toe_rl"] = to_float(self.toe_rl)
        result["top_rl"] = to_float(self.top_rl)
        result["update_dat"] = from_str(self.update_dat)
        result["add_improv"] = from_union([lambda x: to_enum(AddImprov, x), from_none], self.add_improv)
        result["comments"] = from_union([from_none, from_str], self.comments)
        result["constructi"] = from_union([from_none, from_str], self.constructi)
        result["createdate"] = from_none(self.createdate)
        result["createuser"] = from_none(self.createuser)
        result["disposal_d"] = from_none(self.disposal_d)
        result["drawing_nu"] = from_union([from_none, from_str], self.drawing_nu)
        result["file_numbe"] = from_union([from_none, from_str], self.file_numbe)
        result["folder_num"] = from_union([lambda x: from_none((lambda x: is_type(type(None), x))(x)), lambda x: from_str((lambda x: str((lambda x: is_type(int, x))(x)))(x))], self.folder_num)
        result["funding_ba"] = from_union([lambda x: to_enum(FundingBa, x), from_none], self.funding_ba)
        result["inspectors"] = from_none(self.inspectors)
        result["last_updat"] = from_none(self.last_updat)
        result["level_accu"] = from_union([lambda x: to_enum(LevelAccu, x), from_none], self.level_accu)
        result["owner"] = from_union([from_none, from_str], self.owner)
        result["positional"] = from_union([lambda x: to_enum(LevelAccu, x), from_none], self.positional)
        result["project_nu"] = from_union([from_none, from_str], self.project_nu)
        result["record_cre"] = from_union([from_none, from_str], self.record_cre)
        result["survey_num"] = from_none(self.survey_num)
        result["type"] = from_union([lambda x: to_enum(PropertiesType, x), from_none], self.type)
        result["updatedate"] = from_none(self.updatedate)
        result["updateuser"] = from_none(self.updateuser)
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
