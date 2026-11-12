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


def from_stringified_bool(x: str) -> bool:
    if x == "true":
        return True
    if x == "false":
        return False
    assert False


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
class Format:
    align: str | None
    no_commas: bool | None
    precision_style: str | None

    @staticmethod
    def from_dict(obj: Any) -> 'Format':
        assert isinstance(obj, dict)
        align = from_union([from_none, from_str], obj.get("align"))
        no_commas = from_union([from_none, lambda x: from_stringified_bool(from_str(x))], obj.get("noCommas"))
        precision_style = from_union([from_none, from_str], obj.get("precisionStyle"))
        return Format(align, no_commas, precision_style)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.align is not None:
            result["align"] = from_union([from_none, from_str], self.align)
        if self.no_commas is not None:
            result["noCommas"] = from_union([lambda x: from_none((lambda x: is_type(type(None), x))(x)), lambda x: from_str((lambda x: str((lambda x: is_type(bool, x))(x)).lower())(x))], self.no_commas)
        if self.precision_style is not None:
            result["precisionStyle"] = from_union([from_none, from_str], self.precision_style)
        return result


@dataclass
class Column:
    data_type_name: TypeName
    field_name: str
    format: Format
    id: int
    name: str
    position: int
    render_type_name: TypeName
    cached_contents: CachedContents | None
    description: str | None
    flags: list[str] | None
    table_column_id: int | None
    width: int | None

    @staticmethod
    def from_dict(obj: Any) -> 'Column':
        assert isinstance(obj, dict)
        data_type_name = TypeName(obj["dataTypeName"])
        field_name = from_str(obj["fieldName"])
        format = Format.from_dict(obj["format"])
        id = from_int(obj["id"])
        name = from_str(obj["name"])
        position = from_int(obj["position"])
        render_type_name = TypeName(obj["renderTypeName"])
        cached_contents = from_union([CachedContents.from_dict, from_none], obj.get("cachedContents"))
        description = from_union([from_none, from_str], obj.get("description"))
        flags = from_union([lambda x: from_list(from_str, x), from_none], obj.get("flags"))
        table_column_id = from_union([from_int, from_none], obj.get("tableColumnId"))
        width = from_union([from_int, from_none], obj.get("width"))
        return Column(data_type_name, field_name, format, id, name, position, render_type_name, cached_contents, description, flags, table_column_id, width)

    def to_dict(self) -> dict:
        result: dict = {}
        result["dataTypeName"] = to_enum(TypeName, self.data_type_name)
        result["fieldName"] = from_str(self.field_name)
        result["format"] = to_class(Format, self.format)
        result["id"] = from_int(self.id)
        result["name"] = from_str(self.name)
        result["position"] = from_int(self.position)
        result["renderTypeName"] = to_enum(TypeName, self.render_type_name)
        if self.cached_contents is not None:
            result["cachedContents"] = from_union([lambda x: to_class(CachedContents, x), from_none], self.cached_contents)
        if self.description is not None:
            result["description"] = from_union([from_none, from_str], self.description)
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
class Attachment:
    asset_id: str
    blob_id: str
    filename: str
    name: str

    @staticmethod
    def from_dict(obj: Any) -> 'Attachment':
        assert isinstance(obj, dict)
        asset_id = from_str(obj["assetId"])
        blob_id = from_str(obj["blobId"])
        filename = from_str(obj["filename"])
        name = from_str(obj["name"])
        return Attachment(asset_id, blob_id, filename, name)

    def to_dict(self) -> dict:
        result: dict = {}
        result["assetId"] = from_str(self.asset_id)
        result["blobId"] = from_str(self.blob_id)
        result["filename"] = from_str(self.filename)
        result["name"] = from_str(self.name)
        return result


@dataclass
class CommonCore:
    contact_email: str
    contact_name: str
    publisher: str

    @staticmethod
    def from_dict(obj: Any) -> 'CommonCore':
        assert isinstance(obj, dict)
        contact_email = from_str(obj["Contact Email"])
        contact_name = from_str(obj["Contact Name"])
        publisher = from_str(obj["Publisher"])
        return CommonCore(contact_email, contact_name, publisher)

    def to_dict(self) -> dict:
        result: dict = {}
        result["Contact Email"] = from_str(self.contact_email)
        result["Contact Name"] = from_str(self.contact_name)
        result["Publisher"] = from_str(self.publisher)
        return result


@dataclass
class DatasetInformation:
    agency: str

    @staticmethod
    def from_dict(obj: Any) -> 'DatasetInformation':
        assert isinstance(obj, dict)
        agency = from_str(obj["Agency"])
        return DatasetInformation(agency)

    def to_dict(self) -> dict:
        result: dict = {}
        result["Agency"] = from_str(self.agency)
        return result


@dataclass
class DatasetSummary:
    contact_information: str
    coverage: str
    granularity: str
    organization: str
    posting_frequency: str
    time_period: str

    @staticmethod
    def from_dict(obj: Any) -> 'DatasetSummary':
        assert isinstance(obj, dict)
        contact_information = from_str(obj["Contact Information"])
        coverage = from_str(obj["Coverage"])
        granularity = from_str(obj["Granularity"])
        organization = from_str(obj["Organization"])
        posting_frequency = from_str(obj["Posting Frequency"])
        time_period = from_str(obj["Time Period"])
        return DatasetSummary(contact_information, coverage, granularity, organization, posting_frequency, time_period)

    def to_dict(self) -> dict:
        result: dict = {}
        result["Contact Information"] = from_str(self.contact_information)
        result["Coverage"] = from_str(self.coverage)
        result["Granularity"] = from_str(self.granularity)
        result["Organization"] = from_str(self.organization)
        result["Posting Frequency"] = from_str(self.posting_frequency)
        result["Time Period"] = from_str(self.time_period)
        return result


@dataclass
class Disclaimers:
    disclaimer: str
    limitations: str

    @staticmethod
    def from_dict(obj: Any) -> 'Disclaimers':
        assert isinstance(obj, dict)
        disclaimer = from_str(obj["Disclaimer"])
        limitations = from_str(obj["Limitations"])
        return Disclaimers(disclaimer, limitations)

    def to_dict(self) -> dict:
        result: dict = {}
        result["Disclaimer"] = from_str(self.disclaimer)
        result["Limitations"] = from_str(self.limitations)
        return result


@dataclass
class CustomFields:
    common_core: CommonCore
    dataset_information: DatasetInformation
    dataset_summary: DatasetSummary
    disclaimers: Disclaimers

    @staticmethod
    def from_dict(obj: Any) -> 'CustomFields':
        assert isinstance(obj, dict)
        common_core = CommonCore.from_dict(obj["Common Core"])
        dataset_information = DatasetInformation.from_dict(obj["Dataset Information"])
        dataset_summary = DatasetSummary.from_dict(obj["Dataset Summary"])
        disclaimers = Disclaimers.from_dict(obj["Disclaimers"])
        return CustomFields(common_core, dataset_information, dataset_summary, disclaimers)

    def to_dict(self) -> dict:
        result: dict = {}
        result["Common Core"] = to_class(CommonCore, self.common_core)
        result["Dataset Information"] = to_class(DatasetInformation, self.dataset_information)
        result["Dataset Summary"] = to_class(DatasetSummary, self.dataset_summary)
        result["Disclaimers"] = to_class(Disclaimers, self.disclaimers)
        return result


@dataclass
class TableColumnID:
    the_703610: int

    @staticmethod
    def from_dict(obj: Any) -> 'TableColumnID':
        assert isinstance(obj, dict)
        the_703610 = from_int(obj["703610"])
        return TableColumnID(the_703610)

    def to_dict(self) -> dict:
        result: dict = {}
        result["703610"] = from_int(self.the_703610)
        return result


@dataclass
class ChildMetadata:
    custom_values: list[list[str]]
    operator: str
    table_column_id: TableColumnID

    @staticmethod
    def from_dict(obj: Any) -> 'ChildMetadata':
        assert isinstance(obj, dict)
        custom_values = from_list(lambda x: from_list(from_str, x), obj["customValues"])
        operator = from_str(obj["operator"])
        table_column_id = TableColumnID.from_dict(obj["tableColumnId"])
        return ChildMetadata(custom_values, operator, table_column_id)

    def to_dict(self) -> dict:
        result: dict = {}
        result["customValues"] = from_list(lambda x: from_list(from_str, x), self.custom_values)
        result["operator"] = from_str(self.operator)
        result["tableColumnId"] = to_class(TableColumnID, self.table_column_id)
        return result


@dataclass
class Child:
    metadata: ChildMetadata
    type: str
    value: str

    @staticmethod
    def from_dict(obj: Any) -> 'Child':
        assert isinstance(obj, dict)
        metadata = ChildMetadata.from_dict(obj["metadata"])
        type = from_str(obj["type"])
        value = from_str(obj["value"])
        return Child(metadata, type, value)

    def to_dict(self) -> dict:
        result: dict = {}
        result["metadata"] = to_class(ChildMetadata, self.metadata)
        result["type"] = from_str(self.type)
        result["value"] = from_str(self.value)
        return result


@dataclass
class FilterConditionMetadata:
    advanced: bool
    unified_version: int

    @staticmethod
    def from_dict(obj: Any) -> 'FilterConditionMetadata':
        assert isinstance(obj, dict)
        advanced = from_bool(obj["advanced"])
        unified_version = from_int(obj["unifiedVersion"])
        return FilterConditionMetadata(advanced, unified_version)

    def to_dict(self) -> dict:
        result: dict = {}
        result["advanced"] = from_bool(self.advanced)
        result["unifiedVersion"] = from_int(self.unified_version)
        return result


@dataclass
class FilterCondition:
    children: list[Child]
    metadata: FilterConditionMetadata
    type: str
    value: str

    @staticmethod
    def from_dict(obj: Any) -> 'FilterCondition':
        assert isinstance(obj, dict)
        children = from_list(Child.from_dict, obj["children"])
        metadata = FilterConditionMetadata.from_dict(obj["metadata"])
        type = from_str(obj["type"])
        value = from_str(obj["value"])
        return FilterCondition(children, metadata, type, value)

    def to_dict(self) -> dict:
        result: dict = {}
        result["children"] = from_list(lambda x: to_class(Child, x), self.children)
        result["metadata"] = to_class(FilterConditionMetadata, self.metadata)
        result["type"] = from_str(self.type)
        result["value"] = from_str(self.value)
        return result


@dataclass
class Order:
    ascending: bool
    column_field_name: str

    @staticmethod
    def from_dict(obj: Any) -> 'Order':
        assert isinstance(obj, dict)
        ascending = from_bool(obj["ascending"])
        column_field_name = from_str(obj["columnFieldName"])
        return Order(ascending, column_field_name)

    def to_dict(self) -> dict:
        result: dict = {}
        result["ascending"] = from_bool(self.ascending)
        result["columnFieldName"] = from_str(self.column_field_name)
        return result


@dataclass
class JSONQuery:
    order: list[Order]

    @staticmethod
    def from_dict(obj: Any) -> 'JSONQuery':
        assert isinstance(obj, dict)
        order = from_list(Order.from_dict, obj["order"])
        return JSONQuery(order)

    def to_dict(self) -> dict:
        result: dict = {}
        result["order"] = from_list(lambda x: to_class(Order, x), self.order)
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
class ViewMetadata:
    attachments: list[Attachment]
    available_display_types: list[str]
    custom_fields: CustomFields
    filter_condition: FilterCondition
    json_query: JSONQuery
    rdf_subject: int
    render_type_config: RenderTypeConfig
    row_label: str

    @staticmethod
    def from_dict(obj: Any) -> 'ViewMetadata':
        assert isinstance(obj, dict)
        attachments = from_list(Attachment.from_dict, obj["attachments"])
        available_display_types = from_list(from_str, obj["availableDisplayTypes"])
        custom_fields = CustomFields.from_dict(obj["custom_fields"])
        filter_condition = FilterCondition.from_dict(obj["filterCondition"])
        json_query = JSONQuery.from_dict(obj["jsonQuery"])
        rdf_subject = int(from_str(obj["rdfSubject"]))
        render_type_config = RenderTypeConfig.from_dict(obj["renderTypeConfig"])
        row_label = from_str(obj["rowLabel"])
        return ViewMetadata(attachments, available_display_types, custom_fields, filter_condition, json_query, rdf_subject, render_type_config, row_label)

    def to_dict(self) -> dict:
        result: dict = {}
        result["attachments"] = from_list(lambda x: to_class(Attachment, x), self.attachments)
        result["availableDisplayTypes"] = from_list(from_str, self.available_display_types)
        result["custom_fields"] = to_class(CustomFields, self.custom_fields)
        result["filterCondition"] = to_class(FilterCondition, self.filter_condition)
        result["jsonQuery"] = to_class(JSONQuery, self.json_query)
        result["rdfSubject"] = from_str(str(self.rdf_subject))
        result["renderTypeConfig"] = to_class(RenderTypeConfig, self.render_type_config)
        result["rowLabel"] = from_str(self.row_label)
        return result


@dataclass
class Owner:
    display_name: str
    id: str
    profile_image_url_large: str
    profile_image_url_medium: str
    profile_image_url_small: str
    rights: list[str]
    role_name: str
    screen_name: str

    @staticmethod
    def from_dict(obj: Any) -> 'Owner':
        assert isinstance(obj, dict)
        display_name = from_str(obj["displayName"])
        id = from_str(obj["id"])
        profile_image_url_large = from_str(obj["profileImageUrlLarge"])
        profile_image_url_medium = from_str(obj["profileImageUrlMedium"])
        profile_image_url_small = from_str(obj["profileImageUrlSmall"])
        rights = from_list(from_str, obj["rights"])
        role_name = from_str(obj["roleName"])
        screen_name = from_str(obj["screenName"])
        return Owner(display_name, id, profile_image_url_large, profile_image_url_medium, profile_image_url_small, rights, role_name, screen_name)

    def to_dict(self) -> dict:
        result: dict = {}
        result["displayName"] = from_str(self.display_name)
        result["id"] = from_str(self.id)
        result["profileImageUrlLarge"] = from_str(self.profile_image_url_large)
        result["profileImageUrlMedium"] = from_str(self.profile_image_url_medium)
        result["profileImageUrlSmall"] = from_str(self.profile_image_url_small)
        result["rights"] = from_list(from_str, self.rights)
        result["roleName"] = from_str(self.role_name)
        result["screenName"] = from_str(self.screen_name)
        return result


@dataclass
class Expression:
    column_id: int
    type: str

    @staticmethod
    def from_dict(obj: Any) -> 'Expression':
        assert isinstance(obj, dict)
        column_id = from_int(obj["columnId"])
        type = from_str(obj["type"])
        return Expression(column_id, type)

    def to_dict(self) -> dict:
        result: dict = {}
        result["columnId"] = from_int(self.column_id)
        result["type"] = from_str(self.type)
        return result


@dataclass
class OrderBy:
    ascending: bool
    expression: Expression

    @staticmethod
    def from_dict(obj: Any) -> 'OrderBy':
        assert isinstance(obj, dict)
        ascending = from_bool(obj["ascending"])
        expression = Expression.from_dict(obj["expression"])
        return OrderBy(ascending, expression)

    def to_dict(self) -> dict:
        result: dict = {}
        result["ascending"] = from_bool(self.ascending)
        result["expression"] = to_class(Expression, self.expression)
        return result


@dataclass
class Query:
    order_bys: list[OrderBy]

    @staticmethod
    def from_dict(obj: Any) -> 'Query':
        assert isinstance(obj, dict)
        order_bys = from_list(OrderBy.from_dict, obj["orderBys"])
        return Query(order_bys)

    def to_dict(self) -> dict:
        result: dict = {}
        result["orderBys"] = from_list(lambda x: to_class(OrderBy, x), self.order_bys)
        return result


@dataclass
class View:
    attribution: str
    average_rating: int
    category: str
    columns: list[Column]
    created_at: int
    description: str
    display_type: str
    download_count: int
    flags: list[str]
    grants: list[Grant]
    hide_from_catalog: bool
    hide_from_data_json: bool
    id: str
    index_updated_at: int
    locale: str
    metadata: ViewMetadata
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
    rows_updated_at: int
    rows_updated_by: str
    table_author: Owner
    table_id: int
    tags: list[str]
    total_times_rated: int
    view_count: int
    view_last_modified: int
    view_type: str

    @staticmethod
    def from_dict(obj: Any) -> 'View':
        assert isinstance(obj, dict)
        attribution = from_str(obj["attribution"])
        average_rating = from_int(obj["averageRating"])
        category = from_str(obj["category"])
        columns = from_list(Column.from_dict, obj["columns"])
        created_at = from_int(obj["createdAt"])
        description = from_str(obj["description"])
        display_type = from_str(obj["displayType"])
        download_count = from_int(obj["downloadCount"])
        flags = from_list(from_str, obj["flags"])
        grants = from_list(Grant.from_dict, obj["grants"])
        hide_from_catalog = from_bool(obj["hideFromCatalog"])
        hide_from_data_json = from_bool(obj["hideFromDataJson"])
        id = from_str(obj["id"])
        index_updated_at = from_int(obj["indexUpdatedAt"])
        locale = from_str(obj["locale"])
        metadata = ViewMetadata.from_dict(obj["metadata"])
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
        rows_updated_at = from_int(obj["rowsUpdatedAt"])
        rows_updated_by = from_str(obj["rowsUpdatedBy"])
        table_author = Owner.from_dict(obj["tableAuthor"])
        table_id = from_int(obj["tableId"])
        tags = from_list(from_str, obj["tags"])
        total_times_rated = from_int(obj["totalTimesRated"])
        view_count = from_int(obj["viewCount"])
        view_last_modified = from_int(obj["viewLastModified"])
        view_type = from_str(obj["viewType"])
        return View(attribution, average_rating, category, columns, created_at, description, display_type, download_count, flags, grants, hide_from_catalog, hide_from_data_json, id, index_updated_at, locale, metadata, name, new_backend, number_of_comments, oid, owner, provenance, publication_append_enabled, publication_date, publication_group, publication_stage, query, rights, rows_updated_at, rows_updated_by, table_author, table_id, tags, total_times_rated, view_count, view_last_modified, view_type)

    def to_dict(self) -> dict:
        result: dict = {}
        result["attribution"] = from_str(self.attribution)
        result["averageRating"] = from_int(self.average_rating)
        result["category"] = from_str(self.category)
        result["columns"] = from_list(lambda x: to_class(Column, x), self.columns)
        result["createdAt"] = from_int(self.created_at)
        result["description"] = from_str(self.description)
        result["displayType"] = from_str(self.display_type)
        result["downloadCount"] = from_int(self.download_count)
        result["flags"] = from_list(from_str, self.flags)
        result["grants"] = from_list(lambda x: to_class(Grant, x), self.grants)
        result["hideFromCatalog"] = from_bool(self.hide_from_catalog)
        result["hideFromDataJson"] = from_bool(self.hide_from_data_json)
        result["id"] = from_str(self.id)
        result["indexUpdatedAt"] = from_int(self.index_updated_at)
        result["locale"] = from_str(self.locale)
        result["metadata"] = to_class(ViewMetadata, self.metadata)
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
        result["rowsUpdatedAt"] = from_int(self.rows_updated_at)
        result["rowsUpdatedBy"] = from_str(self.rows_updated_by)
        result["tableAuthor"] = to_class(Owner, self.table_author)
        result["tableId"] = from_int(self.table_id)
        result["tags"] = from_list(from_str, self.tags)
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
