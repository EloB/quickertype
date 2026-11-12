from dataclasses import dataclass
from typing import Any, TypeVar, Callable, Type, cast
from enum import Enum


T = TypeVar("T")
EnumT = TypeVar("EnumT", bound=Enum)


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


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


def is_type(t: Type[T], x: Any) -> T:
    assert isinstance(x, t)
    return x


def to_enum(c: Type[EnumT], x: Any) -> EnumT:
    assert isinstance(x, c)
    return x.value


def from_bool(x: Any) -> bool:
    assert isinstance(x, bool)
    return x


@dataclass
class Top:
    count: int
    item: str

    @staticmethod
    def from_dict(obj: Any) -> 'Top':
        assert isinstance(obj, dict)
        count = from_int(obj["count"])
        item = from_str(obj["item"])
        return Top(count, item)

    def to_dict(self) -> dict:
        result: dict = {}
        result["count"] = from_int(self.count)
        result["item"] = from_str(self.item)
        return result


@dataclass
class CachedContents:
    largest: str
    non_null: int
    null: int
    smallest: str
    top: list[Top]
    average: str | None
    sum: int | None

    @staticmethod
    def from_dict(obj: Any) -> 'CachedContents':
        assert isinstance(obj, dict)
        largest = from_str(obj["largest"])
        non_null = from_int(obj["non_null"])
        null = from_int(obj["null"])
        smallest = from_str(obj["smallest"])
        top = from_list(Top.from_dict, obj["top"])
        average = from_union([from_none, from_str], obj.get("average"))
        sum = from_union([from_none, lambda x: int(from_str(x))], obj.get("sum"))
        return CachedContents(largest, non_null, null, smallest, top, average, sum)

    def to_dict(self) -> dict:
        result: dict = {}
        result["largest"] = from_str(self.largest)
        result["non_null"] = from_int(self.non_null)
        result["null"] = from_int(self.null)
        result["smallest"] = from_str(self.smallest)
        result["top"] = from_list(lambda x: to_class(Top, x), self.top)
        if self.average is not None:
            result["average"] = from_union([from_none, from_str], self.average)
        if self.sum is not None:
            result["sum"] = from_union([lambda x: from_none((lambda x: is_type(type(None), x))(x)), lambda x: from_str((lambda x: str((lambda x: is_type(int, x))(x)))(x))], self.sum)
        return result


class TypeName(Enum):
    META_DATA = "meta_data"
    NUMBER = "number"
    TEXT = "text"


@dataclass
class Query:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Query':
        assert isinstance(obj, dict)
        return Query()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Column:
    data_type_name: TypeName
    field_name: str
    format: Query
    id: int
    name: str
    position: int
    render_type_name: TypeName
    cached_contents: CachedContents | None
    flags: list[str] | None
    table_column_id: int | None
    width: int | None

    @staticmethod
    def from_dict(obj: Any) -> 'Column':
        assert isinstance(obj, dict)
        data_type_name = TypeName(obj["dataTypeName"])
        field_name = from_str(obj["fieldName"])
        format = Query.from_dict(obj["format"])
        id = from_int(obj["id"])
        name = from_str(obj["name"])
        position = from_int(obj["position"])
        render_type_name = TypeName(obj["renderTypeName"])
        cached_contents = from_union([CachedContents.from_dict, from_none], obj.get("cachedContents"))
        flags = from_union([lambda x: from_list(from_str, x), from_none], obj.get("flags"))
        table_column_id = from_union([from_int, from_none], obj.get("tableColumnId"))
        width = from_union([from_int, from_none], obj.get("width"))
        return Column(data_type_name, field_name, format, id, name, position, render_type_name, cached_contents, flags, table_column_id, width)

    def to_dict(self) -> dict:
        result: dict = {}
        result["dataTypeName"] = to_enum(TypeName, self.data_type_name)
        result["fieldName"] = from_str(self.field_name)
        result["format"] = to_class(Query, self.format)
        result["id"] = from_int(self.id)
        result["name"] = from_str(self.name)
        result["position"] = from_int(self.position)
        result["renderTypeName"] = to_enum(TypeName, self.render_type_name)
        if self.cached_contents is not None:
            result["cachedContents"] = from_union([lambda x: to_class(CachedContents, x), from_none], self.cached_contents)
        if self.flags is not None:
            result["flags"] = from_union([lambda x: from_list(from_str, x), from_none], self.flags)
        if self.table_column_id is not None:
            result["tableColumnId"] = from_union([from_int, from_none], self.table_column_id)
        if self.width is not None:
            result["width"] = from_union([from_int, from_none], self.width)
        return result


@dataclass
class Grant:
    flags: list[str]
    inherited: bool
    type: str

    @staticmethod
    def from_dict(obj: Any) -> 'Grant':
        assert isinstance(obj, dict)
        flags = from_list(from_str, obj["flags"])
        inherited = from_bool(obj["inherited"])
        type = from_str(obj["type"])
        return Grant(flags, inherited, type)

    def to_dict(self) -> dict:
        result: dict = {}
        result["flags"] = from_list(from_str, self.flags)
        result["inherited"] = from_bool(self.inherited)
        result["type"] = from_str(self.type)
        return result


@dataclass
class License:
    name: str

    @staticmethod
    def from_dict(obj: Any) -> 'License':
        assert isinstance(obj, dict)
        name = from_str(obj["name"])
        return License(name)

    def to_dict(self) -> dict:
        result: dict = {}
        result["name"] = from_str(self.name)
        return result


@dataclass
class Visible:
    table: bool

    @staticmethod
    def from_dict(obj: Any) -> 'Visible':
        assert isinstance(obj, dict)
        table = from_bool(obj["table"])
        return Visible(table)

    def to_dict(self) -> dict:
        result: dict = {}
        result["table"] = from_bool(self.table)
        return result


@dataclass
class RenderTypeConfig:
    visible: Visible

    @staticmethod
    def from_dict(obj: Any) -> 'RenderTypeConfig':
        assert isinstance(obj, dict)
        visible = Visible.from_dict(obj["visible"])
        return RenderTypeConfig(visible)

    def to_dict(self) -> dict:
        result: dict = {}
        result["visible"] = to_class(Visible, self.visible)
        return result


@dataclass
class Metadata:
    available_display_types: list[str]
    rdf_class: str
    rdf_subject: int
    render_type_config: RenderTypeConfig
    row_identifier: int

    @staticmethod
    def from_dict(obj: Any) -> 'Metadata':
        assert isinstance(obj, dict)
        available_display_types = from_list(from_str, obj["availableDisplayTypes"])
        rdf_class = from_str(obj["rdfClass"])
        rdf_subject = int(from_str(obj["rdfSubject"]))
        render_type_config = RenderTypeConfig.from_dict(obj["renderTypeConfig"])
        row_identifier = int(from_str(obj["rowIdentifier"]))
        return Metadata(available_display_types, rdf_class, rdf_subject, render_type_config, row_identifier)

    def to_dict(self) -> dict:
        result: dict = {}
        result["availableDisplayTypes"] = from_list(from_str, self.available_display_types)
        result["rdfClass"] = from_str(self.rdf_class)
        result["rdfSubject"] = from_str(str(self.rdf_subject))
        result["renderTypeConfig"] = to_class(RenderTypeConfig, self.render_type_config)
        result["rowIdentifier"] = from_str(str(self.row_identifier))
        return result


@dataclass
class Owner:
    display_name: str
    id: str
    screen_name: str

    @staticmethod
    def from_dict(obj: Any) -> 'Owner':
        assert isinstance(obj, dict)
        display_name = from_str(obj["displayName"])
        id = from_str(obj["id"])
        screen_name = from_str(obj["screenName"])
        return Owner(display_name, id, screen_name)

    def to_dict(self) -> dict:
        result: dict = {}
        result["displayName"] = from_str(self.display_name)
        result["id"] = from_str(self.id)
        result["screenName"] = from_str(self.screen_name)
        return result


@dataclass
class View:
    average_rating: int
    category: str
    columns: list[Column]
    created_at: int
    display_type: str
    download_count: int
    flags: list[str]
    grants: list[Grant]
    hide_from_catalog: bool
    hide_from_data_json: bool
    id: str
    index_updated_at: int
    license: License
    license_id: str
    locale: str
    metadata: Metadata
    name: str
    new_backend: bool
    number_of_comments: int
    oid: int
    owner: Owner
    provenance: str
    publication_append_enabled: bool
    publication_date: int
    publication_group: int
    publication_stage: str
    query: Query
    rights: list[str]
    row_class: str
    rows_updated_at: int
    rows_updated_by: str
    table_author: Owner
    table_id: int
    total_times_rated: int
    view_count: int
    view_last_modified: int
    view_type: str

    @staticmethod
    def from_dict(obj: Any) -> 'View':
        assert isinstance(obj, dict)
        average_rating = from_int(obj["averageRating"])
        category = from_str(obj["category"])
        columns = from_list(Column.from_dict, obj["columns"])
        created_at = from_int(obj["createdAt"])
        display_type = from_str(obj["displayType"])
        download_count = from_int(obj["downloadCount"])
        flags = from_list(from_str, obj["flags"])
        grants = from_list(Grant.from_dict, obj["grants"])
        hide_from_catalog = from_bool(obj["hideFromCatalog"])
        hide_from_data_json = from_bool(obj["hideFromDataJson"])
        id = from_str(obj["id"])
        index_updated_at = from_int(obj["indexUpdatedAt"])
        license = License.from_dict(obj["license"])
        license_id = from_str(obj["licenseId"])
        locale = from_str(obj["locale"])
        metadata = Metadata.from_dict(obj["metadata"])
        name = from_str(obj["name"])
        new_backend = from_bool(obj["newBackend"])
        number_of_comments = from_int(obj["numberOfComments"])
        oid = from_int(obj["oid"])
        owner = Owner.from_dict(obj["owner"])
        provenance = from_str(obj["provenance"])
        publication_append_enabled = from_bool(obj["publicationAppendEnabled"])
        publication_date = from_int(obj["publicationDate"])
        publication_group = from_int(obj["publicationGroup"])
        publication_stage = from_str(obj["publicationStage"])
        query = Query.from_dict(obj["query"])
        rights = from_list(from_str, obj["rights"])
        row_class = from_str(obj["rowClass"])
        rows_updated_at = from_int(obj["rowsUpdatedAt"])
        rows_updated_by = from_str(obj["rowsUpdatedBy"])
        table_author = Owner.from_dict(obj["tableAuthor"])
        table_id = from_int(obj["tableId"])
        total_times_rated = from_int(obj["totalTimesRated"])
        view_count = from_int(obj["viewCount"])
        view_last_modified = from_int(obj["viewLastModified"])
        view_type = from_str(obj["viewType"])
        return View(average_rating, category, columns, created_at, display_type, download_count, flags, grants, hide_from_catalog, hide_from_data_json, id, index_updated_at, license, license_id, locale, metadata, name, new_backend, number_of_comments, oid, owner, provenance, publication_append_enabled, publication_date, publication_group, publication_stage, query, rights, row_class, rows_updated_at, rows_updated_by, table_author, table_id, total_times_rated, view_count, view_last_modified, view_type)

    def to_dict(self) -> dict:
        result: dict = {}
        result["averageRating"] = from_int(self.average_rating)
        result["category"] = from_str(self.category)
        result["columns"] = from_list(lambda x: to_class(Column, x), self.columns)
        result["createdAt"] = from_int(self.created_at)
        result["displayType"] = from_str(self.display_type)
        result["downloadCount"] = from_int(self.download_count)
        result["flags"] = from_list(from_str, self.flags)
        result["grants"] = from_list(lambda x: to_class(Grant, x), self.grants)
        result["hideFromCatalog"] = from_bool(self.hide_from_catalog)
        result["hideFromDataJson"] = from_bool(self.hide_from_data_json)
        result["id"] = from_str(self.id)
        result["indexUpdatedAt"] = from_int(self.index_updated_at)
        result["license"] = to_class(License, self.license)
        result["licenseId"] = from_str(self.license_id)
        result["locale"] = from_str(self.locale)
        result["metadata"] = to_class(Metadata, self.metadata)
        result["name"] = from_str(self.name)
        result["newBackend"] = from_bool(self.new_backend)
        result["numberOfComments"] = from_int(self.number_of_comments)
        result["oid"] = from_int(self.oid)
        result["owner"] = to_class(Owner, self.owner)
        result["provenance"] = from_str(self.provenance)
        result["publicationAppendEnabled"] = from_bool(self.publication_append_enabled)
        result["publicationDate"] = from_int(self.publication_date)
        result["publicationGroup"] = from_int(self.publication_group)
        result["publicationStage"] = from_str(self.publication_stage)
        result["query"] = to_class(Query, self.query)
        result["rights"] = from_list(from_str, self.rights)
        result["rowClass"] = from_str(self.row_class)
        result["rowsUpdatedAt"] = from_int(self.rows_updated_at)
        result["rowsUpdatedBy"] = from_str(self.rows_updated_by)
        result["tableAuthor"] = to_class(Owner, self.table_author)
        result["tableId"] = from_int(self.table_id)
        result["totalTimesRated"] = from_int(self.total_times_rated)
        result["viewCount"] = from_int(self.view_count)
        result["viewLastModified"] = from_int(self.view_last_modified)
        result["viewType"] = from_str(self.view_type)
        return result


@dataclass
class Meta:
    view: View

    @staticmethod
    def from_dict(obj: Any) -> 'Meta':
        assert isinstance(obj, dict)
        view = View.from_dict(obj["view"])
        return Meta(view)

    def to_dict(self) -> dict:
        result: dict = {}
        result["view"] = to_class(View, self.view)
        return result


@dataclass
class TopLevel:
    data: list[list[int | str | None]]
    meta: Meta

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        data = from_list(lambda x: from_list(lambda x: from_union([from_int, from_none, from_str], x), x), obj["data"])
        meta = Meta.from_dict(obj["meta"])
        return TopLevel(data, meta)

    def to_dict(self) -> dict:
        result: dict = {}
        result["data"] = from_list(lambda x: from_list(lambda x: from_union([from_int, from_none, from_str], x), x), self.data)
        result["meta"] = to_class(Meta, self.meta)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
