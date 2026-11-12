from enum import Enum
from dataclasses import dataclass
from typing import Any, TypeVar, Callable, Type, cast


T = TypeVar("T")
EnumT = TypeVar("EnumT", bound=Enum)


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


def from_bool(x: Any) -> bool:
    assert isinstance(x, bool)
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


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def is_type(t: Type[T], x: Any) -> T:
    assert isinstance(x, t)
    return x


class DisplayType(Enum):
    TABLE = "table"
    DATA_LENS = "data_lens"
    FATROW = "fatrow"
    PAGE = "page"


class TopLevelFlag(Enum):
    DEFAULT = "default"
    RESTORABLE = "restorable"
    RESTORE_POSSIBLE_FOR_TYPE = "restorePossibleForType"


class GrantFlag(Enum):
    PUBLIC = "public"


class GrantType(Enum):
    VIEWER = "viewer"


@dataclass
class Grant:
    flags: list[GrantFlag]
    inherited: bool
    type: GrantType

    @staticmethod
    def from_dict(obj: Any) -> 'Grant':
        assert isinstance(obj, dict)
        flags = from_list(GrantFlag, obj["flags"])
        inherited = from_bool(obj["inherited"])
        type = GrantType(obj["type"])
        return Grant(flags, inherited, type)

    def to_dict(self) -> dict:
        result: dict = {}
        result["flags"] = from_list(lambda x: to_enum(GrantFlag, x), self.flags)
        result["inherited"] = from_bool(self.inherited)
        result["type"] = to_enum(GrantType, self.type)
        return result


@dataclass
class Test:
    cfpb1: str

    @staticmethod
    def from_dict(obj: Any) -> 'Test':
        assert isinstance(obj, dict)
        cfpb1 = from_str(obj["CFPB1"])
        return Test(cfpb1)

    def to_dict(self) -> dict:
        result: dict = {}
        result["CFPB1"] = from_str(self.cfpb1)
        return result


@dataclass
class CustomFields:
    test: Test

    @staticmethod
    def from_dict(obj: Any) -> 'CustomFields':
        assert isinstance(obj, dict)
        test = Test.from_dict(obj["TEST"])
        return CustomFields(test)

    def to_dict(self) -> dict:
        result: dict = {}
        result["TEST"] = to_class(Test, self.test)
        return result


@dataclass
class Group:
    column_field_name: str

    @staticmethod
    def from_dict(obj: Any) -> 'Group':
        assert isinstance(obj, dict)
        column_field_name = from_str(obj["columnFieldName"])
        return Group(column_field_name)

    def to_dict(self) -> dict:
        result: dict = {}
        result["columnFieldName"] = from_str(self.column_field_name)
        return result


class OrderColumnFieldName(Enum):
    DATE_RECEIVED = "date_received"
    AGREEMENT_DATE = "agreement_date"
    IN_EFFECT_AS_OF_1_1_2012 = "in_effect_as_of_1_1_2012"


@dataclass
class Order:
    ascending: bool
    column_field_name: OrderColumnFieldName

    @staticmethod
    def from_dict(obj: Any) -> 'Order':
        assert isinstance(obj, dict)
        ascending = from_bool(obj["ascending"])
        column_field_name = OrderColumnFieldName(obj["columnFieldName"])
        return Order(ascending, column_field_name)

    def to_dict(self) -> dict:
        result: dict = {}
        result["ascending"] = from_bool(self.ascending)
        result["columnFieldName"] = to_enum(OrderColumnFieldName, self.column_field_name)
        return result


@dataclass
class Select:
    column_field_name: str
    aggregate: str | None

    @staticmethod
    def from_dict(obj: Any) -> 'Select':
        assert isinstance(obj, dict)
        column_field_name = from_str(obj["columnFieldName"])
        aggregate = from_union([from_none, from_str], obj.get("aggregate"))
        return Select(column_field_name, aggregate)

    def to_dict(self) -> dict:
        result: dict = {}
        result["columnFieldName"] = from_str(self.column_field_name)
        if self.aggregate is not None:
            result["aggregate"] = from_union([from_none, from_str], self.aggregate)
        return result


class ChildColumnFieldName(Enum):
    PRODUCT = "product"
    COMPLAINT_WHAT_HAPPENED = "complaint_what_happened"
    SUB_PRODUCT = "sub_product"
    ISSUE = "issue"


class MetadataOperator(Enum):
    EQUALS = "EQUALS"
    BLANK = "blank?"


@dataclass
class TableColumnID:
    the_2819740: int

    @staticmethod
    def from_dict(obj: Any) -> 'TableColumnID':
        assert isinstance(obj, dict)
        the_2819740 = from_int(obj["2819740"])
        return TableColumnID(the_2819740)

    def to_dict(self) -> dict:
        result: dict = {}
        result["2819740"] = from_int(self.the_2819740)
        return result


@dataclass
class ChildMetadata:
    custom_values: list[str] | None
    freeform: bool | None
    include_auto: int | None
    operator: MetadataOperator | None
    table_column_id: TableColumnID | None
    unified_version: int | None

    @staticmethod
    def from_dict(obj: Any) -> 'ChildMetadata':
        assert isinstance(obj, dict)
        custom_values = from_union([lambda x: from_list(from_str, x), from_none], obj.get("customValues"))
        freeform = from_union([from_bool, from_none], obj.get("freeform"))
        include_auto = from_union([from_int, from_none], obj.get("includeAuto"))
        operator = from_union([MetadataOperator, from_none], obj.get("operator"))
        table_column_id = from_union([TableColumnID.from_dict, from_none], obj.get("tableColumnId"))
        unified_version = from_union([from_int, from_none], obj.get("unifiedVersion"))
        return ChildMetadata(custom_values, freeform, include_auto, operator, table_column_id, unified_version)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.custom_values is not None:
            result["customValues"] = from_union([lambda x: from_list(from_str, x), from_none], self.custom_values)
        if self.freeform is not None:
            result["freeform"] = from_union([from_bool, from_none], self.freeform)
        if self.include_auto is not None:
            result["includeAuto"] = from_union([from_int, from_none], self.include_auto)
        if self.operator is not None:
            result["operator"] = from_union([lambda x: to_enum(MetadataOperator, x), from_none], self.operator)
        if self.table_column_id is not None:
            result["tableColumnId"] = from_union([lambda x: to_class(TableColumnID, x), from_none], self.table_column_id)
        if self.unified_version is not None:
            result["unifiedVersion"] = from_union([from_int, from_none], self.unified_version)
        return result


class ChildOperator(Enum):
    EQUALS = "EQUALS"
    IS_NOT_BLANK = "IS_NOT_BLANK"


@dataclass
class Child:
    column_field_name: ChildColumnFieldName
    operator: ChildOperator
    metadata: ChildMetadata | None
    value: str | None

    @staticmethod
    def from_dict(obj: Any) -> 'Child':
        assert isinstance(obj, dict)
        column_field_name = ChildColumnFieldName(obj["columnFieldName"])
        operator = ChildOperator(obj["operator"])
        metadata = from_union([ChildMetadata.from_dict, from_none], obj.get("metadata"))
        value = from_union([from_none, from_str], obj.get("value"))
        return Child(column_field_name, operator, metadata, value)

    def to_dict(self) -> dict:
        result: dict = {}
        result["columnFieldName"] = to_enum(ChildColumnFieldName, self.column_field_name)
        result["operator"] = to_enum(ChildOperator, self.operator)
        if self.metadata is not None:
            result["metadata"] = from_union([lambda x: to_class(ChildMetadata, x), from_none], self.metadata)
        if self.value is not None:
            result["value"] = from_union([from_none, from_str], self.value)
        return result


class WhereOperator(Enum):
    EQUALS = "EQUALS"
    AND = "AND"


@dataclass
class Where:
    operator: WhereOperator
    children: list[Child] | None
    column_field_name: ChildColumnFieldName | None
    metadata: ChildMetadata | None
    value: str | None

    @staticmethod
    def from_dict(obj: Any) -> 'Where':
        assert isinstance(obj, dict)
        operator = WhereOperator(obj["operator"])
        children = from_union([lambda x: from_list(Child.from_dict, x), from_none], obj.get("children"))
        column_field_name = from_union([ChildColumnFieldName, from_none], obj.get("columnFieldName"))
        metadata = from_union([ChildMetadata.from_dict, from_none], obj.get("metadata"))
        value = from_union([from_none, from_str], obj.get("value"))
        return Where(operator, children, column_field_name, metadata, value)

    def to_dict(self) -> dict:
        result: dict = {}
        result["operator"] = to_enum(WhereOperator, self.operator)
        if self.children is not None:
            result["children"] = from_union([lambda x: from_list(lambda x: to_class(Child, x), x), from_none], self.children)
        if self.column_field_name is not None:
            result["columnFieldName"] = from_union([lambda x: to_enum(ChildColumnFieldName, x), from_none], self.column_field_name)
        if self.metadata is not None:
            result["metadata"] = from_union([lambda x: to_class(ChildMetadata, x), from_none], self.metadata)
        if self.value is not None:
            result["value"] = from_union([from_none, from_str], self.value)
        return result


@dataclass
class JSONQuery:
    group: list[Group] | None
    order: list[Order] | None
    select: list[Select] | None
    where: Where | None

    @staticmethod
    def from_dict(obj: Any) -> 'JSONQuery':
        assert isinstance(obj, dict)
        group = from_union([lambda x: from_list(Group.from_dict, x), from_none], obj.get("group"))
        order = from_union([lambda x: from_list(Order.from_dict, x), from_none], obj.get("order"))
        select = from_union([lambda x: from_list(Select.from_dict, x), from_none], obj.get("select"))
        where = from_union([Where.from_dict, from_none], obj.get("where"))
        return JSONQuery(group, order, select, where)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.group is not None:
            result["group"] = from_union([lambda x: from_list(lambda x: to_class(Group, x), x), from_none], self.group)
        if self.order is not None:
            result["order"] = from_union([lambda x: from_list(lambda x: to_class(Order, x), x), from_none], self.order)
        if self.select is not None:
            result["select"] = from_union([lambda x: from_list(lambda x: to_class(Select, x), x), from_none], self.select)
        if self.where is not None:
            result["where"] = from_union([lambda x: to_class(Where, x), from_none], self.where)
        return result


@dataclass
class PurpleVisible:
    fatrow: bool | None
    table: bool | None

    @staticmethod
    def from_dict(obj: Any) -> 'PurpleVisible':
        assert isinstance(obj, dict)
        fatrow = from_union([from_bool, from_none], obj.get("fatrow"))
        table = from_union([from_bool, from_none], obj.get("table"))
        return PurpleVisible(fatrow, table)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.fatrow is not None:
            result["fatrow"] = from_union([from_bool, from_none], self.fatrow)
        if self.table is not None:
            result["table"] = from_union([from_bool, from_none], self.table)
        return result


@dataclass
class MetadataRenderTypeConfig:
    visible: PurpleVisible

    @staticmethod
    def from_dict(obj: Any) -> 'MetadataRenderTypeConfig':
        assert isinstance(obj, dict)
        visible = PurpleVisible.from_dict(obj["visible"])
        return MetadataRenderTypeConfig(visible)

    def to_dict(self) -> dict:
        result: dict = {}
        result["visible"] = to_class(PurpleVisible, self.visible)
        return result


class FieldType(Enum):
    COLUMN_LABEL = "columnLabel"
    COLUMN_DATA = "columnData"


@dataclass
class Field:
    table_column_id: int
    type: FieldType

    @staticmethod
    def from_dict(obj: Any) -> 'Field':
        assert isinstance(obj, dict)
        table_column_id = from_int(obj["tableColumnId"])
        type = FieldType(obj["type"])
        return Field(table_column_id, type)

    def to_dict(self) -> dict:
        result: dict = {}
        result["tableColumnId"] = from_int(self.table_column_id)
        result["type"] = to_enum(FieldType, self.type)
        return result


@dataclass
class Row:
    fields: list[Field]

    @staticmethod
    def from_dict(obj: Any) -> 'Row':
        assert isinstance(obj, dict)
        fields = from_list(Field.from_dict, obj["fields"])
        return Row(fields)

    def to_dict(self) -> dict:
        result: dict = {}
        result["fields"] = from_list(lambda x: to_class(Field, x), self.fields)
        return result


class Width(Enum):
    THE_27 = "27%"
    THE_40 = "40%"
    THE_30 = "30%"
    THE_33 = "33%"


@dataclass
class Styles:
    width: Width

    @staticmethod
    def from_dict(obj: Any) -> 'Styles':
        assert isinstance(obj, dict)
        width = Width(obj["width"])
        return Styles(width)

    def to_dict(self) -> dict:
        result: dict = {}
        result["width"] = to_enum(Width, self.width)
        return result


@dataclass
class Column:
    rows: list[Row]
    styles: Styles

    @staticmethod
    def from_dict(obj: Any) -> 'Column':
        assert isinstance(obj, dict)
        rows = from_list(Row.from_dict, obj["rows"])
        styles = Styles.from_dict(obj["styles"])
        return Column(rows, styles)

    def to_dict(self) -> dict:
        result: dict = {}
        result["rows"] = from_list(lambda x: to_class(Row, x), self.rows)
        result["styles"] = to_class(Styles, self.styles)
        return result


@dataclass
class FatRow:
    columns: list[Column]

    @staticmethod
    def from_dict(obj: Any) -> 'FatRow':
        assert isinstance(obj, dict)
        columns = from_list(Column.from_dict, obj["columns"])
        return FatRow(columns)

    def to_dict(self) -> dict:
        result: dict = {}
        result["columns"] = from_list(lambda x: to_class(Column, x), self.columns)
        return result


@dataclass
class RichRendererConfigs:
    fat_row: FatRow

    @staticmethod
    def from_dict(obj: Any) -> 'RichRendererConfigs':
        assert isinstance(obj, dict)
        fat_row = FatRow.from_dict(obj["fatRow"])
        return RichRendererConfigs(fat_row)

    def to_dict(self) -> dict:
        result: dict = {}
        result["fatRow"] = to_class(FatRow, self.fat_row)
        return result


@dataclass
class AccessPoints:
    new_view: str

    @staticmethod
    def from_dict(obj: Any) -> 'AccessPoints':
        assert isinstance(obj, dict)
        new_view = from_str(obj["new_view"])
        return AccessPoints(new_view)

    def to_dict(self) -> dict:
        result: dict = {}
        result["new_view"] = from_str(self.new_view)
        return result


@dataclass
class FluffyVisible:
    href: bool

    @staticmethod
    def from_dict(obj: Any) -> 'FluffyVisible':
        assert isinstance(obj, dict)
        href = from_bool(obj["href"])
        return FluffyVisible(href)

    def to_dict(self) -> dict:
        result: dict = {}
        result["href"] = from_bool(self.href)
        return result


@dataclass
class V1ArchivedPropertiesRenderTypeConfig:
    visible: FluffyVisible

    @staticmethod
    def from_dict(obj: Any) -> 'V1ArchivedPropertiesRenderTypeConfig':
        assert isinstance(obj, dict)
        visible = FluffyVisible.from_dict(obj["visible"])
        return V1ArchivedPropertiesRenderTypeConfig(visible)

    def to_dict(self) -> dict:
        result: dict = {}
        result["visible"] = to_class(FluffyVisible, self.visible)
        return result


@dataclass
class V1ArchivedProperties:
    access_points: AccessPoints
    blist_id: int
    render_type_config: V1ArchivedPropertiesRenderTypeConfig

    @staticmethod
    def from_dict(obj: Any) -> 'V1ArchivedProperties':
        assert isinstance(obj, dict)
        access_points = AccessPoints.from_dict(obj["accessPoints"])
        blist_id = int(from_str(obj["blist_id"]))
        render_type_config = V1ArchivedPropertiesRenderTypeConfig.from_dict(obj["renderTypeConfig"])
        return V1ArchivedProperties(access_points, blist_id, render_type_config)

    def to_dict(self) -> dict:
        result: dict = {}
        result["accessPoints"] = to_class(AccessPoints, self.access_points)
        result["blist_id"] = from_str(str(self.blist_id))
        result["renderTypeConfig"] = to_class(V1ArchivedPropertiesRenderTypeConfig, self.render_type_config)
        return result


@dataclass
class TopLevelMetadata:
    available_display_types: list[DisplayType] | None
    custom_fields: CustomFields | None
    json_query: JSONQuery | None
    rdf_class: str | None
    rdf_subject: int | None
    render_type_config: MetadataRenderTypeConfig | None
    rich_renderer_configs: RichRendererConfigs | None
    row_identifier: str | None
    row_label: str | None
    v1_archived_properties: V1ArchivedProperties | None

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevelMetadata':
        assert isinstance(obj, dict)
        available_display_types = from_union([lambda x: from_list(DisplayType, x), from_none], obj.get("availableDisplayTypes"))
        custom_fields = from_union([CustomFields.from_dict, from_none], obj.get("custom_fields"))
        json_query = from_union([JSONQuery.from_dict, from_none], obj.get("jsonQuery"))
        rdf_class = from_union([from_none, from_str], obj.get("rdfClass"))
        rdf_subject = from_union([from_none, lambda x: int(from_str(x))], obj.get("rdfSubject"))
        render_type_config = from_union([MetadataRenderTypeConfig.from_dict, from_none], obj.get("renderTypeConfig"))
        rich_renderer_configs = from_union([RichRendererConfigs.from_dict, from_none], obj.get("richRendererConfigs"))
        row_identifier = from_union([from_none, from_str], obj.get("rowIdentifier"))
        row_label = from_union([from_none, from_str], obj.get("rowLabel"))
        v1_archived_properties = from_union([V1ArchivedProperties.from_dict, from_none], obj.get("v1_archived_properties"))
        return TopLevelMetadata(available_display_types, custom_fields, json_query, rdf_class, rdf_subject, render_type_config, rich_renderer_configs, row_identifier, row_label, v1_archived_properties)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.available_display_types is not None:
            result["availableDisplayTypes"] = from_union([lambda x: from_list(lambda x: to_enum(DisplayType, x), x), from_none], self.available_display_types)
        if self.custom_fields is not None:
            result["custom_fields"] = from_union([lambda x: to_class(CustomFields, x), from_none], self.custom_fields)
        if self.json_query is not None:
            result["jsonQuery"] = from_union([lambda x: to_class(JSONQuery, x), from_none], self.json_query)
        if self.rdf_class is not None:
            result["rdfClass"] = from_union([from_none, from_str], self.rdf_class)
        if self.rdf_subject is not None:
            result["rdfSubject"] = from_union([lambda x: from_none((lambda x: is_type(type(None), x))(x)), lambda x: from_str((lambda x: str((lambda x: is_type(int, x))(x)))(x))], self.rdf_subject)
        if self.render_type_config is not None:
            result["renderTypeConfig"] = from_union([lambda x: to_class(MetadataRenderTypeConfig, x), from_none], self.render_type_config)
        if self.rich_renderer_configs is not None:
            result["richRendererConfigs"] = from_union([lambda x: to_class(RichRendererConfigs, x), from_none], self.rich_renderer_configs)
        if self.row_identifier is not None:
            result["rowIdentifier"] = from_union([from_none, from_str], self.row_identifier)
        if self.row_label is not None:
            result["rowLabel"] = from_union([from_none, from_str], self.row_label)
        if self.v1_archived_properties is not None:
            result["v1_archived_properties"] = from_union([lambda x: to_class(V1ArchivedProperties, x), from_none], self.v1_archived_properties)
        return result


class ModifyingViewUid(Enum):
    S6_EW_H6_MP = "s6ew-h6mp"


class RoleName(Enum):
    ADMINISTRATOR = "administrator"
    PUBLISHER = "publisher"


@dataclass
class Owner:
    display_name: str
    id: str
    screen_name: str
    flags: list[str] | None
    last_notification_seen_at: int | None
    profile_image_url_large: str | None
    profile_image_url_medium: str | None
    profile_image_url_small: str | None
    rights: list[str] | None
    role_name: RoleName | None

    @staticmethod
    def from_dict(obj: Any) -> 'Owner':
        assert isinstance(obj, dict)
        display_name = from_str(obj["displayName"])
        id = from_str(obj["id"])
        screen_name = from_str(obj["screenName"])
        flags = from_union([lambda x: from_list(from_str, x), from_none], obj.get("flags"))
        last_notification_seen_at = from_union([from_int, from_none], obj.get("lastNotificationSeenAt"))
        profile_image_url_large = from_union([from_none, from_str], obj.get("profileImageUrlLarge"))
        profile_image_url_medium = from_union([from_none, from_str], obj.get("profileImageUrlMedium"))
        profile_image_url_small = from_union([from_none, from_str], obj.get("profileImageUrlSmall"))
        rights = from_union([lambda x: from_list(from_str, x), from_none], obj.get("rights"))
        role_name = from_union([RoleName, from_none], obj.get("roleName"))
        return Owner(display_name, id, screen_name, flags, last_notification_seen_at, profile_image_url_large, profile_image_url_medium, profile_image_url_small, rights, role_name)

    def to_dict(self) -> dict:
        result: dict = {}
        result["displayName"] = from_str(self.display_name)
        result["id"] = from_str(self.id)
        result["screenName"] = from_str(self.screen_name)
        if self.flags is not None:
            result["flags"] = from_union([lambda x: from_list(from_str, x), from_none], self.flags)
        if self.last_notification_seen_at is not None:
            result["lastNotificationSeenAt"] = from_union([from_int, from_none], self.last_notification_seen_at)
        if self.profile_image_url_large is not None:
            result["profileImageUrlLarge"] = from_union([from_none, from_str], self.profile_image_url_large)
        if self.profile_image_url_medium is not None:
            result["profileImageUrlMedium"] = from_union([from_none, from_str], self.profile_image_url_medium)
        if self.profile_image_url_small is not None:
            result["profileImageUrlSmall"] = from_union([from_none, from_str], self.profile_image_url_small)
        if self.rights is not None:
            result["rights"] = from_union([lambda x: from_list(from_str, x), from_none], self.rights)
        if self.role_name is not None:
            result["roleName"] = from_union([lambda x: to_enum(RoleName, x), from_none], self.role_name)
        return result


class Provenance(Enum):
    OFFICIAL = "official"


class PublicationStage(Enum):
    PUBLISHED = "published"


@dataclass
class Ratings:
    rating: int

    @staticmethod
    def from_dict(obj: Any) -> 'Ratings':
        assert isinstance(obj, dict)
        rating = from_int(obj["rating"])
        return Ratings(rating)

    def to_dict(self) -> dict:
        result: dict = {}
        result["rating"] = from_int(self.rating)
        return result


class Right(Enum):
    READ = "read"


class RowsUpdatedBy(Enum):
    PJXG_VE4_M = "pjxg-ve4m"
    THE_54_A3_QYUN = "54a3-qyun"
    THE_9_E3_M_2843 = "9e3m-2843"
    VVCA_FR6_G = "vvca-fr6g"


@dataclass
class TableAuthor:
    display_name: str
    id: str
    screen_name: str
    rights: list[str] | None
    role_name: RoleName | None

    @staticmethod
    def from_dict(obj: Any) -> 'TableAuthor':
        assert isinstance(obj, dict)
        display_name = from_str(obj["displayName"])
        id = from_str(obj["id"])
        screen_name = from_str(obj["screenName"])
        rights = from_union([lambda x: from_list(from_str, x), from_none], obj.get("rights"))
        role_name = from_union([RoleName, from_none], obj.get("roleName"))
        return TableAuthor(display_name, id, screen_name, rights, role_name)

    def to_dict(self) -> dict:
        result: dict = {}
        result["displayName"] = from_str(self.display_name)
        result["id"] = from_str(self.id)
        result["screenName"] = from_str(self.screen_name)
        if self.rights is not None:
            result["rights"] = from_union([lambda x: from_list(from_str, x), from_none], self.rights)
        if self.role_name is not None:
            result["roleName"] = from_union([lambda x: to_enum(RoleName, x), from_none], self.role_name)
        return result


class ViewType(Enum):
    TABULAR = "tabular"


@dataclass
class TopLevelElement:
    average_rating: int
    created_at: int
    download_count: int
    grants: list[Grant]
    hide_from_catalog: bool
    hide_from_data_json: bool
    id: str
    locale: str
    metadata: TopLevelMetadata
    name: str
    new_backend: bool
    number_of_comments: int
    oid: int
    owner: Owner
    provenance: Provenance
    publication_append_enabled: bool
    publication_group: int
    publication_stage: PublicationStage
    rights: list[Right]
    table_author: TableAuthor
    table_id: int
    total_times_rated: int
    view_count: int
    view_last_modified: int
    view_type: ViewType
    category: str | None
    description: str | None
    display_type: DisplayType | None
    flags: list[TopLevelFlag] | None
    index_updated_at: int | None
    moderation_status: bool | None
    modifying_view_uid: ModifyingViewUid | None
    publication_date: int | None
    ratings: Ratings | None
    resource_name: str | None
    row_class: str | None
    row_identifier_column_id: int | None
    rows_updated_at: int | None
    rows_updated_by: RowsUpdatedBy | None
    tags: list[str] | None

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevelElement':
        assert isinstance(obj, dict)
        average_rating = from_int(obj["averageRating"])
        created_at = from_int(obj["createdAt"])
        download_count = from_int(obj["downloadCount"])
        grants = from_list(Grant.from_dict, obj["grants"])
        hide_from_catalog = from_bool(obj["hideFromCatalog"])
        hide_from_data_json = from_bool(obj["hideFromDataJson"])
        id = from_str(obj["id"])
        locale = from_str(obj["locale"])
        metadata = TopLevelMetadata.from_dict(obj["metadata"])
        name = from_str(obj["name"])
        new_backend = from_bool(obj["newBackend"])
        number_of_comments = from_int(obj["numberOfComments"])
        oid = from_int(obj["oid"])
        owner = Owner.from_dict(obj["owner"])
        provenance = Provenance(obj["provenance"])
        publication_append_enabled = from_bool(obj["publicationAppendEnabled"])
        publication_group = from_int(obj["publicationGroup"])
        publication_stage = PublicationStage(obj["publicationStage"])
        rights = from_list(Right, obj["rights"])
        table_author = TableAuthor.from_dict(obj["tableAuthor"])
        table_id = from_int(obj["tableId"])
        total_times_rated = from_int(obj["totalTimesRated"])
        view_count = from_int(obj["viewCount"])
        view_last_modified = from_int(obj["viewLastModified"])
        view_type = ViewType(obj["viewType"])
        category = from_union([from_none, from_str], obj.get("category"))
        description = from_union([from_none, from_str], obj.get("description"))
        display_type = from_union([DisplayType, from_none], obj.get("displayType"))
        flags = from_union([lambda x: from_list(TopLevelFlag, x), from_none], obj.get("flags"))
        index_updated_at = from_union([from_int, from_none], obj.get("indexUpdatedAt"))
        moderation_status = from_union([from_bool, from_none], obj.get("moderationStatus"))
        modifying_view_uid = from_union([ModifyingViewUid, from_none], obj.get("modifyingViewUid"))
        publication_date = from_union([from_int, from_none], obj.get("publicationDate"))
        ratings = from_union([Ratings.from_dict, from_none], obj.get("ratings"))
        resource_name = from_union([from_none, from_str], obj.get("resourceName"))
        row_class = from_union([from_none, from_str], obj.get("rowClass"))
        row_identifier_column_id = from_union([from_int, from_none], obj.get("rowIdentifierColumnId"))
        rows_updated_at = from_union([from_int, from_none], obj.get("rowsUpdatedAt"))
        rows_updated_by = from_union([RowsUpdatedBy, from_none], obj.get("rowsUpdatedBy"))
        tags = from_union([lambda x: from_list(from_str, x), from_none], obj.get("tags"))
        return TopLevelElement(average_rating, created_at, download_count, grants, hide_from_catalog, hide_from_data_json, id, locale, metadata, name, new_backend, number_of_comments, oid, owner, provenance, publication_append_enabled, publication_group, publication_stage, rights, table_author, table_id, total_times_rated, view_count, view_last_modified, view_type, category, description, display_type, flags, index_updated_at, moderation_status, modifying_view_uid, publication_date, ratings, resource_name, row_class, row_identifier_column_id, rows_updated_at, rows_updated_by, tags)

    def to_dict(self) -> dict:
        result: dict = {}
        result["averageRating"] = from_int(self.average_rating)
        result["createdAt"] = from_int(self.created_at)
        result["downloadCount"] = from_int(self.download_count)
        result["grants"] = from_list(lambda x: to_class(Grant, x), self.grants)
        result["hideFromCatalog"] = from_bool(self.hide_from_catalog)
        result["hideFromDataJson"] = from_bool(self.hide_from_data_json)
        result["id"] = from_str(self.id)
        result["locale"] = from_str(self.locale)
        result["metadata"] = to_class(TopLevelMetadata, self.metadata)
        result["name"] = from_str(self.name)
        result["newBackend"] = from_bool(self.new_backend)
        result["numberOfComments"] = from_int(self.number_of_comments)
        result["oid"] = from_int(self.oid)
        result["owner"] = to_class(Owner, self.owner)
        result["provenance"] = to_enum(Provenance, self.provenance)
        result["publicationAppendEnabled"] = from_bool(self.publication_append_enabled)
        result["publicationGroup"] = from_int(self.publication_group)
        result["publicationStage"] = to_enum(PublicationStage, self.publication_stage)
        result["rights"] = from_list(lambda x: to_enum(Right, x), self.rights)
        result["tableAuthor"] = to_class(TableAuthor, self.table_author)
        result["tableId"] = from_int(self.table_id)
        result["totalTimesRated"] = from_int(self.total_times_rated)
        result["viewCount"] = from_int(self.view_count)
        result["viewLastModified"] = from_int(self.view_last_modified)
        result["viewType"] = to_enum(ViewType, self.view_type)
        if self.category is not None:
            result["category"] = from_union([from_none, from_str], self.category)
        if self.description is not None:
            result["description"] = from_union([from_none, from_str], self.description)
        if self.display_type is not None:
            result["displayType"] = from_union([lambda x: to_enum(DisplayType, x), from_none], self.display_type)
        if self.flags is not None:
            result["flags"] = from_union([lambda x: from_list(lambda x: to_enum(TopLevelFlag, x), x), from_none], self.flags)
        if self.index_updated_at is not None:
            result["indexUpdatedAt"] = from_union([from_int, from_none], self.index_updated_at)
        if self.moderation_status is not None:
            result["moderationStatus"] = from_union([from_bool, from_none], self.moderation_status)
        if self.modifying_view_uid is not None:
            result["modifyingViewUid"] = from_union([lambda x: to_enum(ModifyingViewUid, x), from_none], self.modifying_view_uid)
        if self.publication_date is not None:
            result["publicationDate"] = from_union([from_int, from_none], self.publication_date)
        if self.ratings is not None:
            result["ratings"] = from_union([lambda x: to_class(Ratings, x), from_none], self.ratings)
        if self.resource_name is not None:
            result["resourceName"] = from_union([from_none, from_str], self.resource_name)
        if self.row_class is not None:
            result["rowClass"] = from_union([from_none, from_str], self.row_class)
        if self.row_identifier_column_id is not None:
            result["rowIdentifierColumnId"] = from_union([from_int, from_none], self.row_identifier_column_id)
        if self.rows_updated_at is not None:
            result["rowsUpdatedAt"] = from_union([from_int, from_none], self.rows_updated_at)
        if self.rows_updated_by is not None:
            result["rowsUpdatedBy"] = from_union([lambda x: to_enum(RowsUpdatedBy, x), from_none], self.rows_updated_by)
        if self.tags is not None:
            result["tags"] = from_union([lambda x: from_list(from_str, x), from_none], self.tags)
        return result


def top_level_from_dict(s: Any) -> list[TopLevelElement]:
    return from_list(TopLevelElement.from_dict, s)


def top_level_to_dict(x: list[TopLevelElement]) -> Any:
    return from_list(lambda x: to_class(TopLevelElement, x), x)
