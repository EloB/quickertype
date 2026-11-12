//  To parse this JSON data, first install
//
//      json.hpp  https://github.com/nlohmann/json
//
//  Then include this file, and then do
//
//     TopLevel data = nlohmann::json::parse(jsonString);

#pragma once

#include <optional>
#include "json.hpp"

#include <optional>
#include <stdexcept>
#include <regex>

#ifndef NLOHMANN_OPT_HELPER
#define NLOHMANN_OPT_HELPER
namespace nlohmann {
    template <typename T>
    struct adl_serializer<std::shared_ptr<T>> {
        static void to_json(json & j, const std::shared_ptr<T> & opt) {
            if (!opt) j = nullptr; else j = *opt;
        }

        static std::shared_ptr<T> from_json(const json & j) {
            if (j.is_null()) return std::shared_ptr<T>(); else return std::make_shared<T>(j.get<T>());
        }
    };
    template <typename T>
    struct adl_serializer<std::optional<T>> {
        static void to_json(json & j, const std::optional<T> & opt) {
            if (!opt) j = nullptr; else j = *opt;
        }

        static std::optional<T> from_json(const json & j) {
            if (j.is_null()) return std::optional<T>(); else return std::make_optional<T>(j.get<T>());
        }
    };
}
#endif

namespace quicktype {
    using nlohmann::json;

    #ifndef NLOHMANN_UNTYPED_quicktype_HELPER
    #define NLOHMANN_UNTYPED_quicktype_HELPER
    inline json get_untyped(const json & j, const char * property) {
        if (j.find(property) != j.end()) {
            return j.at(property).get<json>();
        }
        return json();
    }

    inline json get_untyped(const json & j, std::string property) {
        return get_untyped(j, property.data());
    }
    #endif

    #ifndef NLOHMANN_OPTIONAL_quicktype_HELPER
    #define NLOHMANN_OPTIONAL_quicktype_HELPER
    template <typename T>
    inline std::shared_ptr<T> get_heap_optional(const json & j, const char * property) {
        auto it = j.find(property);
        if (it != j.end() && !it->is_null()) {
            return j.at(property).get<std::shared_ptr<T>>();
        }
        return std::shared_ptr<T>();
    }

    template <typename T>
    inline std::shared_ptr<T> get_heap_optional(const json & j, std::string property) {
        return get_heap_optional<T>(j, property.data());
    }
    template <typename T>
    inline std::optional<T> get_stack_optional(const json & j, const char * property) {
        auto it = j.find(property);
        if (it != j.end() && !it->is_null()) {
            return j.at(property).get<std::optional<T>>();
        }
        return std::optional<T>();
    }

    template <typename T>
    inline std::optional<T> get_stack_optional(const json & j, std::string property) {
        return get_stack_optional<T>(j, property.data());
    }
    #endif

    enum class DisplayType : int { TABLE, DATA_LENS, FATROW, PAGE };

    enum class TopLevelFlag : int { DEFAULT, RESTORABLE, RESTORE_POSSIBLE_FOR_TYPE };

    enum class GrantFlag : int { PUBLIC };

    enum class GrantType : int { VIEWER };

    class Grant {
        public:
        Grant() = default;
        virtual ~Grant() = default;

        private:
        std::vector<GrantFlag> flags;
        bool inherited;
        GrantType type;

        public:
        const std::vector<GrantFlag> & get_flags() const { return flags; }
        std::vector<GrantFlag> & get_mutable_flags() { return flags; }
        void set_flags(const std::vector<GrantFlag> & value) { this->flags = value; }

        const bool & get_inherited() const { return inherited; }
        bool & get_mutable_inherited() { return inherited; }
        void set_inherited(const bool & value) { this->inherited = value; }

        const GrantType & get_type() const { return type; }
        GrantType & get_mutable_type() { return type; }
        void set_type(const GrantType & value) { this->type = value; }
    };

    class Test {
        public:
        Test() = default;
        virtual ~Test() = default;

        private:
        std::string cfpb1;

        public:
        const std::string & get_cfpb1() const { return cfpb1; }
        std::string & get_mutable_cfpb1() { return cfpb1; }
        void set_cfpb1(const std::string & value) { this->cfpb1 = value; }
    };

    class CustomFields {
        public:
        CustomFields() = default;
        virtual ~CustomFields() = default;

        private:
        Test test;

        public:
        const Test & get_test() const { return test; }
        Test & get_mutable_test() { return test; }
        void set_test(const Test & value) { this->test = value; }
    };

    class Group {
        public:
        Group() = default;
        virtual ~Group() = default;

        private:
        std::string column_field_name;

        public:
        const std::string & get_column_field_name() const { return column_field_name; }
        std::string & get_mutable_column_field_name() { return column_field_name; }
        void set_column_field_name(const std::string & value) { this->column_field_name = value; }
    };

    enum class OrderColumnFieldName : int { DATE_RECEIVED, AGREEMENT_DATE, IN_EFFECT_AS_OF_1_1_2012 };

    class Order {
        public:
        Order() = default;
        virtual ~Order() = default;

        private:
        bool ascending;
        OrderColumnFieldName column_field_name;

        public:
        const bool & get_ascending() const { return ascending; }
        bool & get_mutable_ascending() { return ascending; }
        void set_ascending(const bool & value) { this->ascending = value; }

        const OrderColumnFieldName & get_column_field_name() const { return column_field_name; }
        OrderColumnFieldName & get_mutable_column_field_name() { return column_field_name; }
        void set_column_field_name(const OrderColumnFieldName & value) { this->column_field_name = value; }
    };

    class Select {
        public:
        Select() = default;
        virtual ~Select() = default;

        private:
        std::optional<std::string> aggregate;
        std::string column_field_name;

        public:
        const std::optional<std::string> & get_aggregate() const { return aggregate; }
        std::optional<std::string> & get_mutable_aggregate() { return aggregate; }
        void set_aggregate(const std::optional<std::string> & value) { this->aggregate = value; }

        const std::string & get_column_field_name() const { return column_field_name; }
        std::string & get_mutable_column_field_name() { return column_field_name; }
        void set_column_field_name(const std::string & value) { this->column_field_name = value; }
    };

    enum class ChildOperator : int { EQUALS, IS_NOT_BLANK };

    enum class ChildColumnFieldName : int { PRODUCT, COMPLAINT_WHAT_HAPPENED, SUB_PRODUCT, ISSUE };

    enum class MetadataOperator : int { EQUALS, BLANK };

    class TableColumnId {
        public:
        TableColumnId() = default;
        virtual ~TableColumnId() = default;

        private:
        int64_t the_2819740;

        public:
        const int64_t & get_the_2819740() const { return the_2819740; }
        int64_t & get_mutable_the_2819740() { return the_2819740; }
        void set_the_2819740(const int64_t & value) { this->the_2819740 = value; }
    };

    class ChildMetadata {
        public:
        ChildMetadata() = default;
        virtual ~ChildMetadata() = default;

        private:
        std::optional<std::vector<std::string>> custom_values;
        std::optional<bool> freeform;
        std::optional<int64_t> include_auto;
        std::optional<MetadataOperator> metadata_operator;
        std::optional<TableColumnId> table_column_id;
        std::optional<int64_t> unified_version;

        public:
        const std::optional<std::vector<std::string>> & get_custom_values() const { return custom_values; }
        std::optional<std::vector<std::string>> & get_mutable_custom_values() { return custom_values; }
        void set_custom_values(const std::optional<std::vector<std::string>> & value) { this->custom_values = value; }

        const std::optional<bool> & get_freeform() const { return freeform; }
        std::optional<bool> & get_mutable_freeform() { return freeform; }
        void set_freeform(const std::optional<bool> & value) { this->freeform = value; }

        const std::optional<int64_t> & get_include_auto() const { return include_auto; }
        std::optional<int64_t> & get_mutable_include_auto() { return include_auto; }
        void set_include_auto(const std::optional<int64_t> & value) { this->include_auto = value; }

        const std::optional<MetadataOperator> & get_metadata_operator() const { return metadata_operator; }
        std::optional<MetadataOperator> & get_mutable_metadata_operator() { return metadata_operator; }
        void set_metadata_operator(const std::optional<MetadataOperator> & value) { this->metadata_operator = value; }

        const std::optional<TableColumnId> & get_table_column_id() const { return table_column_id; }
        std::optional<TableColumnId> & get_mutable_table_column_id() { return table_column_id; }
        void set_table_column_id(const std::optional<TableColumnId> & value) { this->table_column_id = value; }

        const std::optional<int64_t> & get_unified_version() const { return unified_version; }
        std::optional<int64_t> & get_mutable_unified_version() { return unified_version; }
        void set_unified_version(const std::optional<int64_t> & value) { this->unified_version = value; }
    };

    class Child {
        public:
        Child() = default;
        virtual ~Child() = default;

        private:
        ChildOperator child_operator;
        ChildColumnFieldName column_field_name;
        std::optional<ChildMetadata> metadata;
        std::optional<std::string> value;

        public:
        const ChildOperator & get_child_operator() const { return child_operator; }
        ChildOperator & get_mutable_child_operator() { return child_operator; }
        void set_child_operator(const ChildOperator & value) { this->child_operator = value; }

        const ChildColumnFieldName & get_column_field_name() const { return column_field_name; }
        ChildColumnFieldName & get_mutable_column_field_name() { return column_field_name; }
        void set_column_field_name(const ChildColumnFieldName & value) { this->column_field_name = value; }

        const std::optional<ChildMetadata> & get_metadata() const { return metadata; }
        std::optional<ChildMetadata> & get_mutable_metadata() { return metadata; }
        void set_metadata(const std::optional<ChildMetadata> & value) { this->metadata = value; }

        const std::optional<std::string> & get_value() const { return value; }
        std::optional<std::string> & get_mutable_value() { return value; }
        void set_value(const std::optional<std::string> & value) { this->value = value; }
    };

    enum class WhereOperator : int { EQUALS, AND };

    class Where {
        public:
        Where() = default;
        virtual ~Where() = default;

        private:
        std::optional<std::vector<Child>> children;
        std::optional<ChildColumnFieldName> column_field_name;
        std::optional<ChildMetadata> metadata;
        std::optional<std::string> value;
        WhereOperator where_operator;

        public:
        const std::optional<std::vector<Child>> & get_children() const { return children; }
        std::optional<std::vector<Child>> & get_mutable_children() { return children; }
        void set_children(const std::optional<std::vector<Child>> & value) { this->children = value; }

        const std::optional<ChildColumnFieldName> & get_column_field_name() const { return column_field_name; }
        std::optional<ChildColumnFieldName> & get_mutable_column_field_name() { return column_field_name; }
        void set_column_field_name(const std::optional<ChildColumnFieldName> & value) { this->column_field_name = value; }

        const std::optional<ChildMetadata> & get_metadata() const { return metadata; }
        std::optional<ChildMetadata> & get_mutable_metadata() { return metadata; }
        void set_metadata(const std::optional<ChildMetadata> & value) { this->metadata = value; }

        const std::optional<std::string> & get_value() const { return value; }
        std::optional<std::string> & get_mutable_value() { return value; }
        void set_value(const std::optional<std::string> & value) { this->value = value; }

        const WhereOperator & get_where_operator() const { return where_operator; }
        WhereOperator & get_mutable_where_operator() { return where_operator; }
        void set_where_operator(const WhereOperator & value) { this->where_operator = value; }
    };

    class JsonQuery {
        public:
        JsonQuery() = default;
        virtual ~JsonQuery() = default;

        private:
        std::optional<std::vector<Group>> group;
        std::optional<std::vector<Order>> order;
        std::optional<std::vector<Select>> select;
        std::optional<Where> where;

        public:
        const std::optional<std::vector<Group>> & get_group() const { return group; }
        std::optional<std::vector<Group>> & get_mutable_group() { return group; }
        void set_group(const std::optional<std::vector<Group>> & value) { this->group = value; }

        const std::optional<std::vector<Order>> & get_order() const { return order; }
        std::optional<std::vector<Order>> & get_mutable_order() { return order; }
        void set_order(const std::optional<std::vector<Order>> & value) { this->order = value; }

        const std::optional<std::vector<Select>> & get_select() const { return select; }
        std::optional<std::vector<Select>> & get_mutable_select() { return select; }
        void set_select(const std::optional<std::vector<Select>> & value) { this->select = value; }

        const std::optional<Where> & get_where() const { return where; }
        std::optional<Where> & get_mutable_where() { return where; }
        void set_where(const std::optional<Where> & value) { this->where = value; }
    };

    class PurpleVisible {
        public:
        PurpleVisible() = default;
        virtual ~PurpleVisible() = default;

        private:
        std::optional<bool> fatrow;
        std::optional<bool> table;

        public:
        const std::optional<bool> & get_fatrow() const { return fatrow; }
        std::optional<bool> & get_mutable_fatrow() { return fatrow; }
        void set_fatrow(const std::optional<bool> & value) { this->fatrow = value; }

        const std::optional<bool> & get_table() const { return table; }
        std::optional<bool> & get_mutable_table() { return table; }
        void set_table(const std::optional<bool> & value) { this->table = value; }
    };

    class MetadataRenderTypeConfig {
        public:
        MetadataRenderTypeConfig() = default;
        virtual ~MetadataRenderTypeConfig() = default;

        private:
        PurpleVisible visible;

        public:
        const PurpleVisible & get_visible() const { return visible; }
        PurpleVisible & get_mutable_visible() { return visible; }
        void set_visible(const PurpleVisible & value) { this->visible = value; }
    };

    enum class FieldType : int { COLUMN_LABEL, COLUMN_DATA };

    class Field {
        public:
        Field() = default;
        virtual ~Field() = default;

        private:
        int64_t table_column_id;
        FieldType type;

        public:
        const int64_t & get_table_column_id() const { return table_column_id; }
        int64_t & get_mutable_table_column_id() { return table_column_id; }
        void set_table_column_id(const int64_t & value) { this->table_column_id = value; }

        const FieldType & get_type() const { return type; }
        FieldType & get_mutable_type() { return type; }
        void set_type(const FieldType & value) { this->type = value; }
    };

    class Row {
        public:
        Row() = default;
        virtual ~Row() = default;

        private:
        std::vector<Field> fields;

        public:
        const std::vector<Field> & get_fields() const { return fields; }
        std::vector<Field> & get_mutable_fields() { return fields; }
        void set_fields(const std::vector<Field> & value) { this->fields = value; }
    };

    enum class Width : int { THE_27, THE_40, THE_30, THE_33 };

    class Styles {
        public:
        Styles() = default;
        virtual ~Styles() = default;

        private:
        Width width;

        public:
        const Width & get_width() const { return width; }
        Width & get_mutable_width() { return width; }
        void set_width(const Width & value) { this->width = value; }
    };

    class Column {
        public:
        Column() = default;
        virtual ~Column() = default;

        private:
        std::vector<Row> rows;
        Styles styles;

        public:
        const std::vector<Row> & get_rows() const { return rows; }
        std::vector<Row> & get_mutable_rows() { return rows; }
        void set_rows(const std::vector<Row> & value) { this->rows = value; }

        const Styles & get_styles() const { return styles; }
        Styles & get_mutable_styles() { return styles; }
        void set_styles(const Styles & value) { this->styles = value; }
    };

    class FatRow {
        public:
        FatRow() = default;
        virtual ~FatRow() = default;

        private:
        std::vector<Column> columns;

        public:
        const std::vector<Column> & get_columns() const { return columns; }
        std::vector<Column> & get_mutable_columns() { return columns; }
        void set_columns(const std::vector<Column> & value) { this->columns = value; }
    };

    class RichRendererConfigs {
        public:
        RichRendererConfigs() = default;
        virtual ~RichRendererConfigs() = default;

        private:
        FatRow fat_row;

        public:
        const FatRow & get_fat_row() const { return fat_row; }
        FatRow & get_mutable_fat_row() { return fat_row; }
        void set_fat_row(const FatRow & value) { this->fat_row = value; }
    };

    class AccessPoints {
        public:
        AccessPoints() = default;
        virtual ~AccessPoints() = default;

        private:
        std::string new_view;

        public:
        const std::string & get_new_view() const { return new_view; }
        std::string & get_mutable_new_view() { return new_view; }
        void set_new_view(const std::string & value) { this->new_view = value; }
    };

    class FluffyVisible {
        public:
        FluffyVisible() = default;
        virtual ~FluffyVisible() = default;

        private:
        bool href;

        public:
        const bool & get_href() const { return href; }
        bool & get_mutable_href() { return href; }
        void set_href(const bool & value) { this->href = value; }
    };

    class V1ArchivedPropertiesRenderTypeConfig {
        public:
        V1ArchivedPropertiesRenderTypeConfig() = default;
        virtual ~V1ArchivedPropertiesRenderTypeConfig() = default;

        private:
        FluffyVisible visible;

        public:
        const FluffyVisible & get_visible() const { return visible; }
        FluffyVisible & get_mutable_visible() { return visible; }
        void set_visible(const FluffyVisible & value) { this->visible = value; }
    };

    class V1ArchivedProperties {
        public:
        V1ArchivedProperties() = default;
        virtual ~V1ArchivedProperties() = default;

        private:
        AccessPoints access_points;
        std::string blist_id;
        V1ArchivedPropertiesRenderTypeConfig render_type_config;

        public:
        const AccessPoints & get_access_points() const { return access_points; }
        AccessPoints & get_mutable_access_points() { return access_points; }
        void set_access_points(const AccessPoints & value) { this->access_points = value; }

        const std::string & get_blist_id() const { return blist_id; }
        std::string & get_mutable_blist_id() { return blist_id; }
        void set_blist_id(const std::string & value) { this->blist_id = value; }

        const V1ArchivedPropertiesRenderTypeConfig & get_render_type_config() const { return render_type_config; }
        V1ArchivedPropertiesRenderTypeConfig & get_mutable_render_type_config() { return render_type_config; }
        void set_render_type_config(const V1ArchivedPropertiesRenderTypeConfig & value) { this->render_type_config = value; }
    };

    class TopLevelMetadata {
        public:
        TopLevelMetadata() = default;
        virtual ~TopLevelMetadata() = default;

        private:
        std::optional<std::vector<DisplayType>> available_display_types;
        std::optional<CustomFields> custom_fields;
        std::optional<JsonQuery> json_query;
        std::optional<std::string> rdf_class;
        std::optional<std::string> rdf_subject;
        std::optional<MetadataRenderTypeConfig> render_type_config;
        std::optional<RichRendererConfigs> rich_renderer_configs;
        std::optional<std::string> row_identifier;
        std::optional<std::string> row_label;
        std::optional<V1ArchivedProperties> v1_archived_properties;

        public:
        const std::optional<std::vector<DisplayType>> & get_available_display_types() const { return available_display_types; }
        std::optional<std::vector<DisplayType>> & get_mutable_available_display_types() { return available_display_types; }
        void set_available_display_types(const std::optional<std::vector<DisplayType>> & value) { this->available_display_types = value; }

        const std::optional<CustomFields> & get_custom_fields() const { return custom_fields; }
        std::optional<CustomFields> & get_mutable_custom_fields() { return custom_fields; }
        void set_custom_fields(const std::optional<CustomFields> & value) { this->custom_fields = value; }

        const std::optional<JsonQuery> & get_json_query() const { return json_query; }
        std::optional<JsonQuery> & get_mutable_json_query() { return json_query; }
        void set_json_query(const std::optional<JsonQuery> & value) { this->json_query = value; }

        const std::optional<std::string> & get_rdf_class() const { return rdf_class; }
        std::optional<std::string> & get_mutable_rdf_class() { return rdf_class; }
        void set_rdf_class(const std::optional<std::string> & value) { this->rdf_class = value; }

        const std::optional<std::string> & get_rdf_subject() const { return rdf_subject; }
        std::optional<std::string> & get_mutable_rdf_subject() { return rdf_subject; }
        void set_rdf_subject(const std::optional<std::string> & value) { this->rdf_subject = value; }

        const std::optional<MetadataRenderTypeConfig> & get_render_type_config() const { return render_type_config; }
        std::optional<MetadataRenderTypeConfig> & get_mutable_render_type_config() { return render_type_config; }
        void set_render_type_config(const std::optional<MetadataRenderTypeConfig> & value) { this->render_type_config = value; }

        const std::optional<RichRendererConfigs> & get_rich_renderer_configs() const { return rich_renderer_configs; }
        std::optional<RichRendererConfigs> & get_mutable_rich_renderer_configs() { return rich_renderer_configs; }
        void set_rich_renderer_configs(const std::optional<RichRendererConfigs> & value) { this->rich_renderer_configs = value; }

        const std::optional<std::string> & get_row_identifier() const { return row_identifier; }
        std::optional<std::string> & get_mutable_row_identifier() { return row_identifier; }
        void set_row_identifier(const std::optional<std::string> & value) { this->row_identifier = value; }

        const std::optional<std::string> & get_row_label() const { return row_label; }
        std::optional<std::string> & get_mutable_row_label() { return row_label; }
        void set_row_label(const std::optional<std::string> & value) { this->row_label = value; }

        const std::optional<V1ArchivedProperties> & get_v1_archived_properties() const { return v1_archived_properties; }
        std::optional<V1ArchivedProperties> & get_mutable_v1_archived_properties() { return v1_archived_properties; }
        void set_v1_archived_properties(const std::optional<V1ArchivedProperties> & value) { this->v1_archived_properties = value; }
    };

    enum class ModifyingViewUid : int { S6_EW_H6_MP };

    enum class RoleName : int { ADMINISTRATOR, PUBLISHER };

    class Owner {
        public:
        Owner() = default;
        virtual ~Owner() = default;

        private:
        std::string display_name;
        std::optional<std::vector<std::string>> flags;
        std::string id;
        std::optional<int64_t> last_notification_seen_at;
        std::optional<std::string> profile_image_url_large;
        std::optional<std::string> profile_image_url_medium;
        std::optional<std::string> profile_image_url_small;
        std::optional<std::vector<std::string>> rights;
        std::optional<RoleName> role_name;
        std::string screen_name;

        public:
        const std::string & get_display_name() const { return display_name; }
        std::string & get_mutable_display_name() { return display_name; }
        void set_display_name(const std::string & value) { this->display_name = value; }

        const std::optional<std::vector<std::string>> & get_flags() const { return flags; }
        std::optional<std::vector<std::string>> & get_mutable_flags() { return flags; }
        void set_flags(const std::optional<std::vector<std::string>> & value) { this->flags = value; }

        const std::string & get_id() const { return id; }
        std::string & get_mutable_id() { return id; }
        void set_id(const std::string & value) { this->id = value; }

        const std::optional<int64_t> & get_last_notification_seen_at() const { return last_notification_seen_at; }
        std::optional<int64_t> & get_mutable_last_notification_seen_at() { return last_notification_seen_at; }
        void set_last_notification_seen_at(const std::optional<int64_t> & value) { this->last_notification_seen_at = value; }

        const std::optional<std::string> & get_profile_image_url_large() const { return profile_image_url_large; }
        std::optional<std::string> & get_mutable_profile_image_url_large() { return profile_image_url_large; }
        void set_profile_image_url_large(const std::optional<std::string> & value) { this->profile_image_url_large = value; }

        const std::optional<std::string> & get_profile_image_url_medium() const { return profile_image_url_medium; }
        std::optional<std::string> & get_mutable_profile_image_url_medium() { return profile_image_url_medium; }
        void set_profile_image_url_medium(const std::optional<std::string> & value) { this->profile_image_url_medium = value; }

        const std::optional<std::string> & get_profile_image_url_small() const { return profile_image_url_small; }
        std::optional<std::string> & get_mutable_profile_image_url_small() { return profile_image_url_small; }
        void set_profile_image_url_small(const std::optional<std::string> & value) { this->profile_image_url_small = value; }

        const std::optional<std::vector<std::string>> & get_rights() const { return rights; }
        std::optional<std::vector<std::string>> & get_mutable_rights() { return rights; }
        void set_rights(const std::optional<std::vector<std::string>> & value) { this->rights = value; }

        const std::optional<RoleName> & get_role_name() const { return role_name; }
        std::optional<RoleName> & get_mutable_role_name() { return role_name; }
        void set_role_name(const std::optional<RoleName> & value) { this->role_name = value; }

        const std::string & get_screen_name() const { return screen_name; }
        std::string & get_mutable_screen_name() { return screen_name; }
        void set_screen_name(const std::string & value) { this->screen_name = value; }
    };

    enum class Provenance : int { OFFICIAL };

    enum class PublicationStage : int { PUBLISHED };

    class Ratings {
        public:
        Ratings() = default;
        virtual ~Ratings() = default;

        private:
        int64_t rating;

        public:
        const int64_t & get_rating() const { return rating; }
        int64_t & get_mutable_rating() { return rating; }
        void set_rating(const int64_t & value) { this->rating = value; }
    };

    enum class Right : int { READ };

    enum class RowsUpdatedBy : int { PJXG_VE4_M, THE_54_A3_QYUN, THE_9_E3_M_2843, VVCA_FR6_G };

    class TableAuthor {
        public:
        TableAuthor() = default;
        virtual ~TableAuthor() = default;

        private:
        std::string display_name;
        std::string id;
        std::optional<std::vector<std::string>> rights;
        std::optional<RoleName> role_name;
        std::string screen_name;

        public:
        const std::string & get_display_name() const { return display_name; }
        std::string & get_mutable_display_name() { return display_name; }
        void set_display_name(const std::string & value) { this->display_name = value; }

        const std::string & get_id() const { return id; }
        std::string & get_mutable_id() { return id; }
        void set_id(const std::string & value) { this->id = value; }

        const std::optional<std::vector<std::string>> & get_rights() const { return rights; }
        std::optional<std::vector<std::string>> & get_mutable_rights() { return rights; }
        void set_rights(const std::optional<std::vector<std::string>> & value) { this->rights = value; }

        const std::optional<RoleName> & get_role_name() const { return role_name; }
        std::optional<RoleName> & get_mutable_role_name() { return role_name; }
        void set_role_name(const std::optional<RoleName> & value) { this->role_name = value; }

        const std::string & get_screen_name() const { return screen_name; }
        std::string & get_mutable_screen_name() { return screen_name; }
        void set_screen_name(const std::string & value) { this->screen_name = value; }
    };

    enum class ViewType : int { TABULAR };

    class TopLevelElement {
        public:
        TopLevelElement() = default;
        virtual ~TopLevelElement() = default;

        private:
        int64_t average_rating;
        std::optional<std::string> category;
        int64_t created_at;
        std::optional<std::string> description;
        std::optional<DisplayType> display_type;
        int64_t download_count;
        std::optional<std::vector<TopLevelFlag>> flags;
        std::vector<Grant> grants;
        bool hide_from_catalog;
        bool hide_from_data_json;
        std::string id;
        std::optional<int64_t> index_updated_at;
        std::string locale;
        TopLevelMetadata metadata;
        std::optional<bool> moderation_status;
        std::optional<ModifyingViewUid> modifying_view_uid;
        std::string name;
        bool new_backend;
        int64_t number_of_comments;
        int64_t oid;
        Owner owner;
        Provenance provenance;
        bool publication_append_enabled;
        std::optional<int64_t> publication_date;
        int64_t publication_group;
        PublicationStage publication_stage;
        std::optional<Ratings> ratings;
        std::optional<std::string> resource_name;
        std::vector<Right> rights;
        std::optional<std::string> row_class;
        std::optional<int64_t> row_identifier_column_id;
        std::optional<int64_t> rows_updated_at;
        std::optional<RowsUpdatedBy> rows_updated_by;
        TableAuthor table_author;
        int64_t table_id;
        std::optional<std::vector<std::string>> tags;
        int64_t total_times_rated;
        int64_t view_count;
        int64_t view_last_modified;
        ViewType view_type;

        public:
        const int64_t & get_average_rating() const { return average_rating; }
        int64_t & get_mutable_average_rating() { return average_rating; }
        void set_average_rating(const int64_t & value) { this->average_rating = value; }

        const std::optional<std::string> & get_category() const { return category; }
        std::optional<std::string> & get_mutable_category() { return category; }
        void set_category(const std::optional<std::string> & value) { this->category = value; }

        const int64_t & get_created_at() const { return created_at; }
        int64_t & get_mutable_created_at() { return created_at; }
        void set_created_at(const int64_t & value) { this->created_at = value; }

        const std::optional<std::string> & get_description() const { return description; }
        std::optional<std::string> & get_mutable_description() { return description; }
        void set_description(const std::optional<std::string> & value) { this->description = value; }

        const std::optional<DisplayType> & get_display_type() const { return display_type; }
        std::optional<DisplayType> & get_mutable_display_type() { return display_type; }
        void set_display_type(const std::optional<DisplayType> & value) { this->display_type = value; }

        const int64_t & get_download_count() const { return download_count; }
        int64_t & get_mutable_download_count() { return download_count; }
        void set_download_count(const int64_t & value) { this->download_count = value; }

        const std::optional<std::vector<TopLevelFlag>> & get_flags() const { return flags; }
        std::optional<std::vector<TopLevelFlag>> & get_mutable_flags() { return flags; }
        void set_flags(const std::optional<std::vector<TopLevelFlag>> & value) { this->flags = value; }

        const std::vector<Grant> & get_grants() const { return grants; }
        std::vector<Grant> & get_mutable_grants() { return grants; }
        void set_grants(const std::vector<Grant> & value) { this->grants = value; }

        const bool & get_hide_from_catalog() const { return hide_from_catalog; }
        bool & get_mutable_hide_from_catalog() { return hide_from_catalog; }
        void set_hide_from_catalog(const bool & value) { this->hide_from_catalog = value; }

        const bool & get_hide_from_data_json() const { return hide_from_data_json; }
        bool & get_mutable_hide_from_data_json() { return hide_from_data_json; }
        void set_hide_from_data_json(const bool & value) { this->hide_from_data_json = value; }

        const std::string & get_id() const { return id; }
        std::string & get_mutable_id() { return id; }
        void set_id(const std::string & value) { this->id = value; }

        const std::optional<int64_t> & get_index_updated_at() const { return index_updated_at; }
        std::optional<int64_t> & get_mutable_index_updated_at() { return index_updated_at; }
        void set_index_updated_at(const std::optional<int64_t> & value) { this->index_updated_at = value; }

        const std::string & get_locale() const { return locale; }
        std::string & get_mutable_locale() { return locale; }
        void set_locale(const std::string & value) { this->locale = value; }

        const TopLevelMetadata & get_metadata() const { return metadata; }
        TopLevelMetadata & get_mutable_metadata() { return metadata; }
        void set_metadata(const TopLevelMetadata & value) { this->metadata = value; }

        const std::optional<bool> & get_moderation_status() const { return moderation_status; }
        std::optional<bool> & get_mutable_moderation_status() { return moderation_status; }
        void set_moderation_status(const std::optional<bool> & value) { this->moderation_status = value; }

        const std::optional<ModifyingViewUid> & get_modifying_view_uid() const { return modifying_view_uid; }
        std::optional<ModifyingViewUid> & get_mutable_modifying_view_uid() { return modifying_view_uid; }
        void set_modifying_view_uid(const std::optional<ModifyingViewUid> & value) { this->modifying_view_uid = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const bool & get_new_backend() const { return new_backend; }
        bool & get_mutable_new_backend() { return new_backend; }
        void set_new_backend(const bool & value) { this->new_backend = value; }

        const int64_t & get_number_of_comments() const { return number_of_comments; }
        int64_t & get_mutable_number_of_comments() { return number_of_comments; }
        void set_number_of_comments(const int64_t & value) { this->number_of_comments = value; }

        const int64_t & get_oid() const { return oid; }
        int64_t & get_mutable_oid() { return oid; }
        void set_oid(const int64_t & value) { this->oid = value; }

        const Owner & get_owner() const { return owner; }
        Owner & get_mutable_owner() { return owner; }
        void set_owner(const Owner & value) { this->owner = value; }

        const Provenance & get_provenance() const { return provenance; }
        Provenance & get_mutable_provenance() { return provenance; }
        void set_provenance(const Provenance & value) { this->provenance = value; }

        const bool & get_publication_append_enabled() const { return publication_append_enabled; }
        bool & get_mutable_publication_append_enabled() { return publication_append_enabled; }
        void set_publication_append_enabled(const bool & value) { this->publication_append_enabled = value; }

        const std::optional<int64_t> & get_publication_date() const { return publication_date; }
        std::optional<int64_t> & get_mutable_publication_date() { return publication_date; }
        void set_publication_date(const std::optional<int64_t> & value) { this->publication_date = value; }

        const int64_t & get_publication_group() const { return publication_group; }
        int64_t & get_mutable_publication_group() { return publication_group; }
        void set_publication_group(const int64_t & value) { this->publication_group = value; }

        const PublicationStage & get_publication_stage() const { return publication_stage; }
        PublicationStage & get_mutable_publication_stage() { return publication_stage; }
        void set_publication_stage(const PublicationStage & value) { this->publication_stage = value; }

        const std::optional<Ratings> & get_ratings() const { return ratings; }
        std::optional<Ratings> & get_mutable_ratings() { return ratings; }
        void set_ratings(const std::optional<Ratings> & value) { this->ratings = value; }

        const std::optional<std::string> & get_resource_name() const { return resource_name; }
        std::optional<std::string> & get_mutable_resource_name() { return resource_name; }
        void set_resource_name(const std::optional<std::string> & value) { this->resource_name = value; }

        const std::vector<Right> & get_rights() const { return rights; }
        std::vector<Right> & get_mutable_rights() { return rights; }
        void set_rights(const std::vector<Right> & value) { this->rights = value; }

        const std::optional<std::string> & get_row_class() const { return row_class; }
        std::optional<std::string> & get_mutable_row_class() { return row_class; }
        void set_row_class(const std::optional<std::string> & value) { this->row_class = value; }

        const std::optional<int64_t> & get_row_identifier_column_id() const { return row_identifier_column_id; }
        std::optional<int64_t> & get_mutable_row_identifier_column_id() { return row_identifier_column_id; }
        void set_row_identifier_column_id(const std::optional<int64_t> & value) { this->row_identifier_column_id = value; }

        const std::optional<int64_t> & get_rows_updated_at() const { return rows_updated_at; }
        std::optional<int64_t> & get_mutable_rows_updated_at() { return rows_updated_at; }
        void set_rows_updated_at(const std::optional<int64_t> & value) { this->rows_updated_at = value; }

        const std::optional<RowsUpdatedBy> & get_rows_updated_by() const { return rows_updated_by; }
        std::optional<RowsUpdatedBy> & get_mutable_rows_updated_by() { return rows_updated_by; }
        void set_rows_updated_by(const std::optional<RowsUpdatedBy> & value) { this->rows_updated_by = value; }

        const TableAuthor & get_table_author() const { return table_author; }
        TableAuthor & get_mutable_table_author() { return table_author; }
        void set_table_author(const TableAuthor & value) { this->table_author = value; }

        const int64_t & get_table_id() const { return table_id; }
        int64_t & get_mutable_table_id() { return table_id; }
        void set_table_id(const int64_t & value) { this->table_id = value; }

        const std::optional<std::vector<std::string>> & get_tags() const { return tags; }
        std::optional<std::vector<std::string>> & get_mutable_tags() { return tags; }
        void set_tags(const std::optional<std::vector<std::string>> & value) { this->tags = value; }

        const int64_t & get_total_times_rated() const { return total_times_rated; }
        int64_t & get_mutable_total_times_rated() { return total_times_rated; }
        void set_total_times_rated(const int64_t & value) { this->total_times_rated = value; }

        const int64_t & get_view_count() const { return view_count; }
        int64_t & get_mutable_view_count() { return view_count; }
        void set_view_count(const int64_t & value) { this->view_count = value; }

        const int64_t & get_view_last_modified() const { return view_last_modified; }
        int64_t & get_mutable_view_last_modified() { return view_last_modified; }
        void set_view_last_modified(const int64_t & value) { this->view_last_modified = value; }

        const ViewType & get_view_type() const { return view_type; }
        ViewType & get_mutable_view_type() { return view_type; }
        void set_view_type(const ViewType & value) { this->view_type = value; }
    };

    using TopLevel = std::vector<TopLevelElement>;
}

namespace quicktype {
    void from_json(const json & j, Grant & x);
    void to_json(json & j, const Grant & x);

    void from_json(const json & j, Test & x);
    void to_json(json & j, const Test & x);

    void from_json(const json & j, CustomFields & x);
    void to_json(json & j, const CustomFields & x);

    void from_json(const json & j, Group & x);
    void to_json(json & j, const Group & x);

    void from_json(const json & j, Order & x);
    void to_json(json & j, const Order & x);

    void from_json(const json & j, Select & x);
    void to_json(json & j, const Select & x);

    void from_json(const json & j, TableColumnId & x);
    void to_json(json & j, const TableColumnId & x);

    void from_json(const json & j, ChildMetadata & x);
    void to_json(json & j, const ChildMetadata & x);

    void from_json(const json & j, Child & x);
    void to_json(json & j, const Child & x);

    void from_json(const json & j, Where & x);
    void to_json(json & j, const Where & x);

    void from_json(const json & j, JsonQuery & x);
    void to_json(json & j, const JsonQuery & x);

    void from_json(const json & j, PurpleVisible & x);
    void to_json(json & j, const PurpleVisible & x);

    void from_json(const json & j, MetadataRenderTypeConfig & x);
    void to_json(json & j, const MetadataRenderTypeConfig & x);

    void from_json(const json & j, Field & x);
    void to_json(json & j, const Field & x);

    void from_json(const json & j, Row & x);
    void to_json(json & j, const Row & x);

    void from_json(const json & j, Styles & x);
    void to_json(json & j, const Styles & x);

    void from_json(const json & j, Column & x);
    void to_json(json & j, const Column & x);

    void from_json(const json & j, FatRow & x);
    void to_json(json & j, const FatRow & x);

    void from_json(const json & j, RichRendererConfigs & x);
    void to_json(json & j, const RichRendererConfigs & x);

    void from_json(const json & j, AccessPoints & x);
    void to_json(json & j, const AccessPoints & x);

    void from_json(const json & j, FluffyVisible & x);
    void to_json(json & j, const FluffyVisible & x);

    void from_json(const json & j, V1ArchivedPropertiesRenderTypeConfig & x);
    void to_json(json & j, const V1ArchivedPropertiesRenderTypeConfig & x);

    void from_json(const json & j, V1ArchivedProperties & x);
    void to_json(json & j, const V1ArchivedProperties & x);

    void from_json(const json & j, TopLevelMetadata & x);
    void to_json(json & j, const TopLevelMetadata & x);

    void from_json(const json & j, Owner & x);
    void to_json(json & j, const Owner & x);

    void from_json(const json & j, Ratings & x);
    void to_json(json & j, const Ratings & x);

    void from_json(const json & j, TableAuthor & x);
    void to_json(json & j, const TableAuthor & x);

    void from_json(const json & j, TopLevelElement & x);
    void to_json(json & j, const TopLevelElement & x);

    void from_json(const json & j, DisplayType & x);
    void to_json(json & j, const DisplayType & x);

    void from_json(const json & j, TopLevelFlag & x);
    void to_json(json & j, const TopLevelFlag & x);

    void from_json(const json & j, GrantFlag & x);
    void to_json(json & j, const GrantFlag & x);

    void from_json(const json & j, GrantType & x);
    void to_json(json & j, const GrantType & x);

    void from_json(const json & j, OrderColumnFieldName & x);
    void to_json(json & j, const OrderColumnFieldName & x);

    void from_json(const json & j, ChildOperator & x);
    void to_json(json & j, const ChildOperator & x);

    void from_json(const json & j, ChildColumnFieldName & x);
    void to_json(json & j, const ChildColumnFieldName & x);

    void from_json(const json & j, MetadataOperator & x);
    void to_json(json & j, const MetadataOperator & x);

    void from_json(const json & j, WhereOperator & x);
    void to_json(json & j, const WhereOperator & x);

    void from_json(const json & j, FieldType & x);
    void to_json(json & j, const FieldType & x);

    void from_json(const json & j, Width & x);
    void to_json(json & j, const Width & x);

    void from_json(const json & j, ModifyingViewUid & x);
    void to_json(json & j, const ModifyingViewUid & x);

    void from_json(const json & j, RoleName & x);
    void to_json(json & j, const RoleName & x);

    void from_json(const json & j, Provenance & x);
    void to_json(json & j, const Provenance & x);

    void from_json(const json & j, PublicationStage & x);
    void to_json(json & j, const PublicationStage & x);

    void from_json(const json & j, Right & x);
    void to_json(json & j, const Right & x);

    void from_json(const json & j, RowsUpdatedBy & x);
    void to_json(json & j, const RowsUpdatedBy & x);

    void from_json(const json & j, ViewType & x);
    void to_json(json & j, const ViewType & x);

    inline void from_json(const json & j, Grant& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_flags(j.at("flags").get<std::vector<GrantFlag>>());
        x.set_inherited(j.at("inherited").get<bool>());
        x.set_type(j.at("type").get<GrantType>());
    }

    inline void to_json(json & j, const Grant & x) {
        j = json::object();
        j["flags"] = x.get_flags();
        j["inherited"] = x.get_inherited();
        j["type"] = x.get_type();
    }

    inline void from_json(const json & j, Test& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_cfpb1(j.at("CFPB1").get<std::string>());
    }

    inline void to_json(json & j, const Test & x) {
        j = json::object();
        j["CFPB1"] = x.get_cfpb1();
    }

    inline void from_json(const json & j, CustomFields& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_test(j.at("TEST").get<Test>());
    }

    inline void to_json(json & j, const CustomFields & x) {
        j = json::object();
        j["TEST"] = x.get_test();
    }

    inline void from_json(const json & j, Group& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_column_field_name(j.at("columnFieldName").get<std::string>());
    }

    inline void to_json(json & j, const Group & x) {
        j = json::object();
        j["columnFieldName"] = x.get_column_field_name();
    }

    inline void from_json(const json & j, Order& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_ascending(j.at("ascending").get<bool>());
        x.set_column_field_name(j.at("columnFieldName").get<OrderColumnFieldName>());
    }

    inline void to_json(json & j, const Order & x) {
        j = json::object();
        j["ascending"] = x.get_ascending();
        j["columnFieldName"] = x.get_column_field_name();
    }

    inline void from_json(const json & j, Select& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("aggregate") != j.end() && j.at("aggregate").is_null()) throw std::runtime_error("Unexpected null");
        x.set_aggregate(get_stack_optional<std::string>(j, "aggregate"));
        x.set_column_field_name(j.at("columnFieldName").get<std::string>());
    }

    inline void to_json(json & j, const Select & x) {
        j = json::object();
        j["aggregate"] = x.get_aggregate();
        j["columnFieldName"] = x.get_column_field_name();
    }

    inline void from_json(const json & j, TableColumnId& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("2819740") != j.end() && !j.at("2819740").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_the_2819740(j.at("2819740").get<int64_t>());
    }

    inline void to_json(json & j, const TableColumnId & x) {
        j = json::object();
        j["2819740"] = x.get_the_2819740();
    }

    inline void from_json(const json & j, ChildMetadata& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("customValues") != j.end() && j.at("customValues").is_null()) throw std::runtime_error("Unexpected null");
        x.set_custom_values(get_stack_optional<std::vector<std::string>>(j, "customValues"));
        if (j.find("freeform") != j.end() && j.at("freeform").is_null()) throw std::runtime_error("Unexpected null");
        x.set_freeform(get_stack_optional<bool>(j, "freeform"));
        if (j.find("includeAuto") != j.end() && !j.at("includeAuto").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("includeAuto") != j.end() && j.at("includeAuto").is_null()) throw std::runtime_error("Unexpected null");
        x.set_include_auto(get_stack_optional<int64_t>(j, "includeAuto"));
        if (j.find("operator") != j.end() && j.at("operator").is_null()) throw std::runtime_error("Unexpected null");
        x.set_metadata_operator(get_stack_optional<MetadataOperator>(j, "operator"));
        if (j.find("tableColumnId") != j.end() && j.at("tableColumnId").is_null()) throw std::runtime_error("Unexpected null");
        x.set_table_column_id(get_stack_optional<TableColumnId>(j, "tableColumnId"));
        if (j.find("unifiedVersion") != j.end() && !j.at("unifiedVersion").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("unifiedVersion") != j.end() && j.at("unifiedVersion").is_null()) throw std::runtime_error("Unexpected null");
        x.set_unified_version(get_stack_optional<int64_t>(j, "unifiedVersion"));
    }

    inline void to_json(json & j, const ChildMetadata & x) {
        j = json::object();
        j["customValues"] = x.get_custom_values();
        j["freeform"] = x.get_freeform();
        j["includeAuto"] = x.get_include_auto();
        j["operator"] = x.get_metadata_operator();
        j["tableColumnId"] = x.get_table_column_id();
        j["unifiedVersion"] = x.get_unified_version();
    }

    inline void from_json(const json & j, Child& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_child_operator(j.at("operator").get<ChildOperator>());
        x.set_column_field_name(j.at("columnFieldName").get<ChildColumnFieldName>());
        if (j.find("metadata") != j.end() && j.at("metadata").is_null()) throw std::runtime_error("Unexpected null");
        x.set_metadata(get_stack_optional<ChildMetadata>(j, "metadata"));
        if (j.find("value") != j.end() && j.at("value").is_null()) throw std::runtime_error("Unexpected null");
        x.set_value(get_stack_optional<std::string>(j, "value"));
    }

    inline void to_json(json & j, const Child & x) {
        j = json::object();
        j["operator"] = x.get_child_operator();
        j["columnFieldName"] = x.get_column_field_name();
        j["metadata"] = x.get_metadata();
        j["value"] = x.get_value();
    }

    inline void from_json(const json & j, Where& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("children") != j.end() && j.at("children").is_null()) throw std::runtime_error("Unexpected null");
        x.set_children(get_stack_optional<std::vector<Child>>(j, "children"));
        if (j.find("columnFieldName") != j.end() && j.at("columnFieldName").is_null()) throw std::runtime_error("Unexpected null");
        x.set_column_field_name(get_stack_optional<ChildColumnFieldName>(j, "columnFieldName"));
        if (j.find("metadata") != j.end() && j.at("metadata").is_null()) throw std::runtime_error("Unexpected null");
        x.set_metadata(get_stack_optional<ChildMetadata>(j, "metadata"));
        if (j.find("value") != j.end() && j.at("value").is_null()) throw std::runtime_error("Unexpected null");
        x.set_value(get_stack_optional<std::string>(j, "value"));
        x.set_where_operator(j.at("operator").get<WhereOperator>());
    }

    inline void to_json(json & j, const Where & x) {
        j = json::object();
        j["children"] = x.get_children();
        j["columnFieldName"] = x.get_column_field_name();
        j["metadata"] = x.get_metadata();
        j["value"] = x.get_value();
        j["operator"] = x.get_where_operator();
    }

    inline void from_json(const json & j, JsonQuery& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("group") != j.end() && j.at("group").is_null()) throw std::runtime_error("Unexpected null");
        x.set_group(get_stack_optional<std::vector<Group>>(j, "group"));
        if (j.find("order") != j.end() && j.at("order").is_null()) throw std::runtime_error("Unexpected null");
        x.set_order(get_stack_optional<std::vector<Order>>(j, "order"));
        if (j.find("select") != j.end() && j.at("select").is_null()) throw std::runtime_error("Unexpected null");
        x.set_select(get_stack_optional<std::vector<Select>>(j, "select"));
        if (j.find("where") != j.end() && j.at("where").is_null()) throw std::runtime_error("Unexpected null");
        x.set_where(get_stack_optional<Where>(j, "where"));
    }

    inline void to_json(json & j, const JsonQuery & x) {
        j = json::object();
        j["group"] = x.get_group();
        j["order"] = x.get_order();
        j["select"] = x.get_select();
        j["where"] = x.get_where();
    }

    inline void from_json(const json & j, PurpleVisible& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("fatrow") != j.end() && j.at("fatrow").is_null()) throw std::runtime_error("Unexpected null");
        x.set_fatrow(get_stack_optional<bool>(j, "fatrow"));
        if (j.find("table") != j.end() && j.at("table").is_null()) throw std::runtime_error("Unexpected null");
        x.set_table(get_stack_optional<bool>(j, "table"));
    }

    inline void to_json(json & j, const PurpleVisible & x) {
        j = json::object();
        j["fatrow"] = x.get_fatrow();
        j["table"] = x.get_table();
    }

    inline void from_json(const json & j, MetadataRenderTypeConfig& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_visible(j.at("visible").get<PurpleVisible>());
    }

    inline void to_json(json & j, const MetadataRenderTypeConfig & x) {
        j = json::object();
        j["visible"] = x.get_visible();
    }

    inline void from_json(const json & j, Field& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("tableColumnId") != j.end() && !j.at("tableColumnId").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_table_column_id(j.at("tableColumnId").get<int64_t>());
        x.set_type(j.at("type").get<FieldType>());
    }

    inline void to_json(json & j, const Field & x) {
        j = json::object();
        j["tableColumnId"] = x.get_table_column_id();
        j["type"] = x.get_type();
    }

    inline void from_json(const json & j, Row& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_fields(j.at("fields").get<std::vector<Field>>());
    }

    inline void to_json(json & j, const Row & x) {
        j = json::object();
        j["fields"] = x.get_fields();
    }

    inline void from_json(const json & j, Styles& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_width(j.at("width").get<Width>());
    }

    inline void to_json(json & j, const Styles & x) {
        j = json::object();
        j["width"] = x.get_width();
    }

    inline void from_json(const json & j, Column& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_rows(j.at("rows").get<std::vector<Row>>());
        x.set_styles(j.at("styles").get<Styles>());
    }

    inline void to_json(json & j, const Column & x) {
        j = json::object();
        j["rows"] = x.get_rows();
        j["styles"] = x.get_styles();
    }

    inline void from_json(const json & j, FatRow& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_columns(j.at("columns").get<std::vector<Column>>());
    }

    inline void to_json(json & j, const FatRow & x) {
        j = json::object();
        j["columns"] = x.get_columns();
    }

    inline void from_json(const json & j, RichRendererConfigs& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_fat_row(j.at("fatRow").get<FatRow>());
    }

    inline void to_json(json & j, const RichRendererConfigs & x) {
        j = json::object();
        j["fatRow"] = x.get_fat_row();
    }

    inline void from_json(const json & j, AccessPoints& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_new_view(j.at("new_view").get<std::string>());
    }

    inline void to_json(json & j, const AccessPoints & x) {
        j = json::object();
        j["new_view"] = x.get_new_view();
    }

    inline void from_json(const json & j, FluffyVisible& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_href(j.at("href").get<bool>());
    }

    inline void to_json(json & j, const FluffyVisible & x) {
        j = json::object();
        j["href"] = x.get_href();
    }

    inline void from_json(const json & j, V1ArchivedPropertiesRenderTypeConfig& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_visible(j.at("visible").get<FluffyVisible>());
    }

    inline void to_json(json & j, const V1ArchivedPropertiesRenderTypeConfig & x) {
        j = json::object();
        j["visible"] = x.get_visible();
    }

    inline void from_json(const json & j, V1ArchivedProperties& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_access_points(j.at("accessPoints").get<AccessPoints>());
        x.set_blist_id(j.at("blist_id").get<std::string>());
        x.set_render_type_config(j.at("renderTypeConfig").get<V1ArchivedPropertiesRenderTypeConfig>());
    }

    inline void to_json(json & j, const V1ArchivedProperties & x) {
        j = json::object();
        j["accessPoints"] = x.get_access_points();
        j["blist_id"] = x.get_blist_id();
        j["renderTypeConfig"] = x.get_render_type_config();
    }

    inline void from_json(const json & j, TopLevelMetadata& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("availableDisplayTypes") != j.end() && j.at("availableDisplayTypes").is_null()) throw std::runtime_error("Unexpected null");
        x.set_available_display_types(get_stack_optional<std::vector<DisplayType>>(j, "availableDisplayTypes"));
        if (j.find("custom_fields") != j.end() && j.at("custom_fields").is_null()) throw std::runtime_error("Unexpected null");
        x.set_custom_fields(get_stack_optional<CustomFields>(j, "custom_fields"));
        if (j.find("jsonQuery") != j.end() && j.at("jsonQuery").is_null()) throw std::runtime_error("Unexpected null");
        x.set_json_query(get_stack_optional<JsonQuery>(j, "jsonQuery"));
        if (j.find("rdfClass") != j.end() && j.at("rdfClass").is_null()) throw std::runtime_error("Unexpected null");
        x.set_rdf_class(get_stack_optional<std::string>(j, "rdfClass"));
        if (j.find("rdfSubject") != j.end() && j.at("rdfSubject").is_null()) throw std::runtime_error("Unexpected null");
        x.set_rdf_subject(get_stack_optional<std::string>(j, "rdfSubject"));
        if (j.find("renderTypeConfig") != j.end() && j.at("renderTypeConfig").is_null()) throw std::runtime_error("Unexpected null");
        x.set_render_type_config(get_stack_optional<MetadataRenderTypeConfig>(j, "renderTypeConfig"));
        if (j.find("richRendererConfigs") != j.end() && j.at("richRendererConfigs").is_null()) throw std::runtime_error("Unexpected null");
        x.set_rich_renderer_configs(get_stack_optional<RichRendererConfigs>(j, "richRendererConfigs"));
        if (j.find("rowIdentifier") != j.end() && j.at("rowIdentifier").is_null()) throw std::runtime_error("Unexpected null");
        x.set_row_identifier(get_stack_optional<std::string>(j, "rowIdentifier"));
        if (j.find("rowLabel") != j.end() && j.at("rowLabel").is_null()) throw std::runtime_error("Unexpected null");
        x.set_row_label(get_stack_optional<std::string>(j, "rowLabel"));
        if (j.find("v1_archived_properties") != j.end() && j.at("v1_archived_properties").is_null()) throw std::runtime_error("Unexpected null");
        x.set_v1_archived_properties(get_stack_optional<V1ArchivedProperties>(j, "v1_archived_properties"));
    }

    inline void to_json(json & j, const TopLevelMetadata & x) {
        j = json::object();
        j["availableDisplayTypes"] = x.get_available_display_types();
        j["custom_fields"] = x.get_custom_fields();
        j["jsonQuery"] = x.get_json_query();
        j["rdfClass"] = x.get_rdf_class();
        j["rdfSubject"] = x.get_rdf_subject();
        j["renderTypeConfig"] = x.get_render_type_config();
        j["richRendererConfigs"] = x.get_rich_renderer_configs();
        j["rowIdentifier"] = x.get_row_identifier();
        j["rowLabel"] = x.get_row_label();
        j["v1_archived_properties"] = x.get_v1_archived_properties();
    }

    inline void from_json(const json & j, Owner& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_display_name(j.at("displayName").get<std::string>());
        if (j.find("flags") != j.end() && j.at("flags").is_null()) throw std::runtime_error("Unexpected null");
        x.set_flags(get_stack_optional<std::vector<std::string>>(j, "flags"));
        x.set_id(j.at("id").get<std::string>());
        if (j.find("lastNotificationSeenAt") != j.end() && !j.at("lastNotificationSeenAt").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("lastNotificationSeenAt") != j.end() && j.at("lastNotificationSeenAt").is_null()) throw std::runtime_error("Unexpected null");
        x.set_last_notification_seen_at(get_stack_optional<int64_t>(j, "lastNotificationSeenAt"));
        if (j.find("profileImageUrlLarge") != j.end() && j.at("profileImageUrlLarge").is_null()) throw std::runtime_error("Unexpected null");
        x.set_profile_image_url_large(get_stack_optional<std::string>(j, "profileImageUrlLarge"));
        if (j.find("profileImageUrlMedium") != j.end() && j.at("profileImageUrlMedium").is_null()) throw std::runtime_error("Unexpected null");
        x.set_profile_image_url_medium(get_stack_optional<std::string>(j, "profileImageUrlMedium"));
        if (j.find("profileImageUrlSmall") != j.end() && j.at("profileImageUrlSmall").is_null()) throw std::runtime_error("Unexpected null");
        x.set_profile_image_url_small(get_stack_optional<std::string>(j, "profileImageUrlSmall"));
        if (j.find("rights") != j.end() && j.at("rights").is_null()) throw std::runtime_error("Unexpected null");
        x.set_rights(get_stack_optional<std::vector<std::string>>(j, "rights"));
        if (j.find("roleName") != j.end() && j.at("roleName").is_null()) throw std::runtime_error("Unexpected null");
        x.set_role_name(get_stack_optional<RoleName>(j, "roleName"));
        x.set_screen_name(j.at("screenName").get<std::string>());
    }

    inline void to_json(json & j, const Owner & x) {
        j = json::object();
        j["displayName"] = x.get_display_name();
        j["flags"] = x.get_flags();
        j["id"] = x.get_id();
        j["lastNotificationSeenAt"] = x.get_last_notification_seen_at();
        j["profileImageUrlLarge"] = x.get_profile_image_url_large();
        j["profileImageUrlMedium"] = x.get_profile_image_url_medium();
        j["profileImageUrlSmall"] = x.get_profile_image_url_small();
        j["rights"] = x.get_rights();
        j["roleName"] = x.get_role_name();
        j["screenName"] = x.get_screen_name();
    }

    inline void from_json(const json & j, Ratings& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("rating") != j.end() && !j.at("rating").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_rating(j.at("rating").get<int64_t>());
    }

    inline void to_json(json & j, const Ratings & x) {
        j = json::object();
        j["rating"] = x.get_rating();
    }

    inline void from_json(const json & j, TableAuthor& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_display_name(j.at("displayName").get<std::string>());
        x.set_id(j.at("id").get<std::string>());
        if (j.find("rights") != j.end() && j.at("rights").is_null()) throw std::runtime_error("Unexpected null");
        x.set_rights(get_stack_optional<std::vector<std::string>>(j, "rights"));
        if (j.find("roleName") != j.end() && j.at("roleName").is_null()) throw std::runtime_error("Unexpected null");
        x.set_role_name(get_stack_optional<RoleName>(j, "roleName"));
        x.set_screen_name(j.at("screenName").get<std::string>());
    }

    inline void to_json(json & j, const TableAuthor & x) {
        j = json::object();
        j["displayName"] = x.get_display_name();
        j["id"] = x.get_id();
        j["rights"] = x.get_rights();
        j["roleName"] = x.get_role_name();
        j["screenName"] = x.get_screen_name();
    }

    inline void from_json(const json & j, TopLevelElement& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("averageRating") != j.end() && !j.at("averageRating").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_average_rating(j.at("averageRating").get<int64_t>());
        if (j.find("category") != j.end() && j.at("category").is_null()) throw std::runtime_error("Unexpected null");
        x.set_category(get_stack_optional<std::string>(j, "category"));
        if (j.find("createdAt") != j.end() && !j.at("createdAt").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_created_at(j.at("createdAt").get<int64_t>());
        if (j.find("description") != j.end() && j.at("description").is_null()) throw std::runtime_error("Unexpected null");
        x.set_description(get_stack_optional<std::string>(j, "description"));
        if (j.find("displayType") != j.end() && j.at("displayType").is_null()) throw std::runtime_error("Unexpected null");
        x.set_display_type(get_stack_optional<DisplayType>(j, "displayType"));
        if (j.find("downloadCount") != j.end() && !j.at("downloadCount").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_download_count(j.at("downloadCount").get<int64_t>());
        if (j.find("flags") != j.end() && j.at("flags").is_null()) throw std::runtime_error("Unexpected null");
        x.set_flags(get_stack_optional<std::vector<TopLevelFlag>>(j, "flags"));
        x.set_grants(j.at("grants").get<std::vector<Grant>>());
        x.set_hide_from_catalog(j.at("hideFromCatalog").get<bool>());
        x.set_hide_from_data_json(j.at("hideFromDataJson").get<bool>());
        x.set_id(j.at("id").get<std::string>());
        if (j.find("indexUpdatedAt") != j.end() && !j.at("indexUpdatedAt").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("indexUpdatedAt") != j.end() && j.at("indexUpdatedAt").is_null()) throw std::runtime_error("Unexpected null");
        x.set_index_updated_at(get_stack_optional<int64_t>(j, "indexUpdatedAt"));
        x.set_locale(j.at("locale").get<std::string>());
        x.set_metadata(j.at("metadata").get<TopLevelMetadata>());
        if (j.find("moderationStatus") != j.end() && j.at("moderationStatus").is_null()) throw std::runtime_error("Unexpected null");
        x.set_moderation_status(get_stack_optional<bool>(j, "moderationStatus"));
        if (j.find("modifyingViewUid") != j.end() && j.at("modifyingViewUid").is_null()) throw std::runtime_error("Unexpected null");
        x.set_modifying_view_uid(get_stack_optional<ModifyingViewUid>(j, "modifyingViewUid"));
        x.set_name(j.at("name").get<std::string>());
        x.set_new_backend(j.at("newBackend").get<bool>());
        if (j.find("numberOfComments") != j.end() && !j.at("numberOfComments").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_number_of_comments(j.at("numberOfComments").get<int64_t>());
        if (j.find("oid") != j.end() && !j.at("oid").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_oid(j.at("oid").get<int64_t>());
        x.set_owner(j.at("owner").get<Owner>());
        x.set_provenance(j.at("provenance").get<Provenance>());
        x.set_publication_append_enabled(j.at("publicationAppendEnabled").get<bool>());
        if (j.find("publicationDate") != j.end() && !j.at("publicationDate").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("publicationDate") != j.end() && j.at("publicationDate").is_null()) throw std::runtime_error("Unexpected null");
        x.set_publication_date(get_stack_optional<int64_t>(j, "publicationDate"));
        if (j.find("publicationGroup") != j.end() && !j.at("publicationGroup").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_publication_group(j.at("publicationGroup").get<int64_t>());
        x.set_publication_stage(j.at("publicationStage").get<PublicationStage>());
        if (j.find("ratings") != j.end() && j.at("ratings").is_null()) throw std::runtime_error("Unexpected null");
        x.set_ratings(get_stack_optional<Ratings>(j, "ratings"));
        if (j.find("resourceName") != j.end() && j.at("resourceName").is_null()) throw std::runtime_error("Unexpected null");
        x.set_resource_name(get_stack_optional<std::string>(j, "resourceName"));
        x.set_rights(j.at("rights").get<std::vector<Right>>());
        if (j.find("rowClass") != j.end() && j.at("rowClass").is_null()) throw std::runtime_error("Unexpected null");
        x.set_row_class(get_stack_optional<std::string>(j, "rowClass"));
        if (j.find("rowIdentifierColumnId") != j.end() && !j.at("rowIdentifierColumnId").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("rowIdentifierColumnId") != j.end() && j.at("rowIdentifierColumnId").is_null()) throw std::runtime_error("Unexpected null");
        x.set_row_identifier_column_id(get_stack_optional<int64_t>(j, "rowIdentifierColumnId"));
        if (j.find("rowsUpdatedAt") != j.end() && !j.at("rowsUpdatedAt").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("rowsUpdatedAt") != j.end() && j.at("rowsUpdatedAt").is_null()) throw std::runtime_error("Unexpected null");
        x.set_rows_updated_at(get_stack_optional<int64_t>(j, "rowsUpdatedAt"));
        if (j.find("rowsUpdatedBy") != j.end() && j.at("rowsUpdatedBy").is_null()) throw std::runtime_error("Unexpected null");
        x.set_rows_updated_by(get_stack_optional<RowsUpdatedBy>(j, "rowsUpdatedBy"));
        x.set_table_author(j.at("tableAuthor").get<TableAuthor>());
        if (j.find("tableId") != j.end() && !j.at("tableId").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_table_id(j.at("tableId").get<int64_t>());
        if (j.find("tags") != j.end() && j.at("tags").is_null()) throw std::runtime_error("Unexpected null");
        x.set_tags(get_stack_optional<std::vector<std::string>>(j, "tags"));
        if (j.find("totalTimesRated") != j.end() && !j.at("totalTimesRated").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_total_times_rated(j.at("totalTimesRated").get<int64_t>());
        if (j.find("viewCount") != j.end() && !j.at("viewCount").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_view_count(j.at("viewCount").get<int64_t>());
        if (j.find("viewLastModified") != j.end() && !j.at("viewLastModified").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_view_last_modified(j.at("viewLastModified").get<int64_t>());
        x.set_view_type(j.at("viewType").get<ViewType>());
    }

    inline void to_json(json & j, const TopLevelElement & x) {
        j = json::object();
        j["averageRating"] = x.get_average_rating();
        j["category"] = x.get_category();
        j["createdAt"] = x.get_created_at();
        j["description"] = x.get_description();
        j["displayType"] = x.get_display_type();
        j["downloadCount"] = x.get_download_count();
        j["flags"] = x.get_flags();
        j["grants"] = x.get_grants();
        j["hideFromCatalog"] = x.get_hide_from_catalog();
        j["hideFromDataJson"] = x.get_hide_from_data_json();
        j["id"] = x.get_id();
        j["indexUpdatedAt"] = x.get_index_updated_at();
        j["locale"] = x.get_locale();
        j["metadata"] = x.get_metadata();
        j["moderationStatus"] = x.get_moderation_status();
        j["modifyingViewUid"] = x.get_modifying_view_uid();
        j["name"] = x.get_name();
        j["newBackend"] = x.get_new_backend();
        j["numberOfComments"] = x.get_number_of_comments();
        j["oid"] = x.get_oid();
        j["owner"] = x.get_owner();
        j["provenance"] = x.get_provenance();
        j["publicationAppendEnabled"] = x.get_publication_append_enabled();
        j["publicationDate"] = x.get_publication_date();
        j["publicationGroup"] = x.get_publication_group();
        j["publicationStage"] = x.get_publication_stage();
        j["ratings"] = x.get_ratings();
        j["resourceName"] = x.get_resource_name();
        j["rights"] = x.get_rights();
        j["rowClass"] = x.get_row_class();
        j["rowIdentifierColumnId"] = x.get_row_identifier_column_id();
        j["rowsUpdatedAt"] = x.get_rows_updated_at();
        j["rowsUpdatedBy"] = x.get_rows_updated_by();
        j["tableAuthor"] = x.get_table_author();
        j["tableId"] = x.get_table_id();
        j["tags"] = x.get_tags();
        j["totalTimesRated"] = x.get_total_times_rated();
        j["viewCount"] = x.get_view_count();
        j["viewLastModified"] = x.get_view_last_modified();
        j["viewType"] = x.get_view_type();
    }

    inline void from_json(const json & j, DisplayType & x) {
        if (j == "table") x = DisplayType::TABLE;
        else if (j == "data_lens") x = DisplayType::DATA_LENS;
        else if (j == "fatrow") x = DisplayType::FATROW;
        else if (j == "page") x = DisplayType::PAGE;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"DisplayType\""); }
    }

    inline void to_json(json & j, const DisplayType & x) {
        switch (x) {
            case DisplayType::TABLE: j = "table"; break;
            case DisplayType::DATA_LENS: j = "data_lens"; break;
            case DisplayType::FATROW: j = "fatrow"; break;
            case DisplayType::PAGE: j = "page"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"DisplayType\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, TopLevelFlag & x) {
        if (j == "default") x = TopLevelFlag::DEFAULT;
        else if (j == "restorable") x = TopLevelFlag::RESTORABLE;
        else if (j == "restorePossibleForType") x = TopLevelFlag::RESTORE_POSSIBLE_FOR_TYPE;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"TopLevelFlag\""); }
    }

    inline void to_json(json & j, const TopLevelFlag & x) {
        switch (x) {
            case TopLevelFlag::DEFAULT: j = "default"; break;
            case TopLevelFlag::RESTORABLE: j = "restorable"; break;
            case TopLevelFlag::RESTORE_POSSIBLE_FOR_TYPE: j = "restorePossibleForType"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"TopLevelFlag\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, GrantFlag & x) {
        if (j == "public") x = GrantFlag::PUBLIC;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"GrantFlag\""); }
    }

    inline void to_json(json & j, const GrantFlag & x) {
        switch (x) {
            case GrantFlag::PUBLIC: j = "public"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"GrantFlag\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, GrantType & x) {
        if (j == "viewer") x = GrantType::VIEWER;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"GrantType\""); }
    }

    inline void to_json(json & j, const GrantType & x) {
        switch (x) {
            case GrantType::VIEWER: j = "viewer"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"GrantType\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, OrderColumnFieldName & x) {
        if (j == "date_received") x = OrderColumnFieldName::DATE_RECEIVED;
        else if (j == "agreement_date") x = OrderColumnFieldName::AGREEMENT_DATE;
        else if (j == "in_effect_as_of_1_1_2012") x = OrderColumnFieldName::IN_EFFECT_AS_OF_1_1_2012;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"OrderColumnFieldName\""); }
    }

    inline void to_json(json & j, const OrderColumnFieldName & x) {
        switch (x) {
            case OrderColumnFieldName::DATE_RECEIVED: j = "date_received"; break;
            case OrderColumnFieldName::AGREEMENT_DATE: j = "agreement_date"; break;
            case OrderColumnFieldName::IN_EFFECT_AS_OF_1_1_2012: j = "in_effect_as_of_1_1_2012"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"OrderColumnFieldName\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, ChildOperator & x) {
        if (j == "EQUALS") x = ChildOperator::EQUALS;
        else if (j == "IS_NOT_BLANK") x = ChildOperator::IS_NOT_BLANK;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"ChildOperator\""); }
    }

    inline void to_json(json & j, const ChildOperator & x) {
        switch (x) {
            case ChildOperator::EQUALS: j = "EQUALS"; break;
            case ChildOperator::IS_NOT_BLANK: j = "IS_NOT_BLANK"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"ChildOperator\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, ChildColumnFieldName & x) {
        if (j == "product") x = ChildColumnFieldName::PRODUCT;
        else if (j == "complaint_what_happened") x = ChildColumnFieldName::COMPLAINT_WHAT_HAPPENED;
        else if (j == "sub_product") x = ChildColumnFieldName::SUB_PRODUCT;
        else if (j == "issue") x = ChildColumnFieldName::ISSUE;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"ChildColumnFieldName\""); }
    }

    inline void to_json(json & j, const ChildColumnFieldName & x) {
        switch (x) {
            case ChildColumnFieldName::PRODUCT: j = "product"; break;
            case ChildColumnFieldName::COMPLAINT_WHAT_HAPPENED: j = "complaint_what_happened"; break;
            case ChildColumnFieldName::SUB_PRODUCT: j = "sub_product"; break;
            case ChildColumnFieldName::ISSUE: j = "issue"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"ChildColumnFieldName\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, MetadataOperator & x) {
        if (j == "EQUALS") x = MetadataOperator::EQUALS;
        else if (j == "blank?") x = MetadataOperator::BLANK;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"MetadataOperator\""); }
    }

    inline void to_json(json & j, const MetadataOperator & x) {
        switch (x) {
            case MetadataOperator::EQUALS: j = "EQUALS"; break;
            case MetadataOperator::BLANK: j = "blank?"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"MetadataOperator\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, WhereOperator & x) {
        if (j == "EQUALS") x = WhereOperator::EQUALS;
        else if (j == "AND") x = WhereOperator::AND;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"WhereOperator\""); }
    }

    inline void to_json(json & j, const WhereOperator & x) {
        switch (x) {
            case WhereOperator::EQUALS: j = "EQUALS"; break;
            case WhereOperator::AND: j = "AND"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"WhereOperator\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, FieldType & x) {
        if (j == "columnLabel") x = FieldType::COLUMN_LABEL;
        else if (j == "columnData") x = FieldType::COLUMN_DATA;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"FieldType\""); }
    }

    inline void to_json(json & j, const FieldType & x) {
        switch (x) {
            case FieldType::COLUMN_LABEL: j = "columnLabel"; break;
            case FieldType::COLUMN_DATA: j = "columnData"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"FieldType\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, Width & x) {
        if (j == "27%") x = Width::THE_27;
        else if (j == "40%") x = Width::THE_40;
        else if (j == "30%") x = Width::THE_30;
        else if (j == "33%") x = Width::THE_33;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Width\""); }
    }

    inline void to_json(json & j, const Width & x) {
        switch (x) {
            case Width::THE_27: j = "27%"; break;
            case Width::THE_40: j = "40%"; break;
            case Width::THE_30: j = "30%"; break;
            case Width::THE_33: j = "33%"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Width\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, ModifyingViewUid & x) {
        if (j == "s6ew-h6mp") x = ModifyingViewUid::S6_EW_H6_MP;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"ModifyingViewUid\""); }
    }

    inline void to_json(json & j, const ModifyingViewUid & x) {
        switch (x) {
            case ModifyingViewUid::S6_EW_H6_MP: j = "s6ew-h6mp"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"ModifyingViewUid\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, RoleName & x) {
        if (j == "administrator") x = RoleName::ADMINISTRATOR;
        else if (j == "publisher") x = RoleName::PUBLISHER;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"RoleName\""); }
    }

    inline void to_json(json & j, const RoleName & x) {
        switch (x) {
            case RoleName::ADMINISTRATOR: j = "administrator"; break;
            case RoleName::PUBLISHER: j = "publisher"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"RoleName\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, Provenance & x) {
        if (j == "official") x = Provenance::OFFICIAL;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Provenance\""); }
    }

    inline void to_json(json & j, const Provenance & x) {
        switch (x) {
            case Provenance::OFFICIAL: j = "official"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Provenance\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, PublicationStage & x) {
        if (j == "published") x = PublicationStage::PUBLISHED;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"PublicationStage\""); }
    }

    inline void to_json(json & j, const PublicationStage & x) {
        switch (x) {
            case PublicationStage::PUBLISHED: j = "published"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"PublicationStage\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, Right & x) {
        if (j == "read") x = Right::READ;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Right\""); }
    }

    inline void to_json(json & j, const Right & x) {
        switch (x) {
            case Right::READ: j = "read"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Right\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, RowsUpdatedBy & x) {
        if (j == "pjxg-ve4m") x = RowsUpdatedBy::PJXG_VE4_M;
        else if (j == "54a3-qyun") x = RowsUpdatedBy::THE_54_A3_QYUN;
        else if (j == "9e3m-2843") x = RowsUpdatedBy::THE_9_E3_M_2843;
        else if (j == "vvca-fr6g") x = RowsUpdatedBy::VVCA_FR6_G;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"RowsUpdatedBy\""); }
    }

    inline void to_json(json & j, const RowsUpdatedBy & x) {
        switch (x) {
            case RowsUpdatedBy::PJXG_VE4_M: j = "pjxg-ve4m"; break;
            case RowsUpdatedBy::THE_54_A3_QYUN: j = "54a3-qyun"; break;
            case RowsUpdatedBy::THE_9_E3_M_2843: j = "9e3m-2843"; break;
            case RowsUpdatedBy::VVCA_FR6_G: j = "vvca-fr6g"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"RowsUpdatedBy\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, ViewType & x) {
        if (j == "tabular") x = ViewType::TABULAR;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"ViewType\""); }
    }

    inline void to_json(json & j, const ViewType & x) {
        switch (x) {
            case ViewType::TABULAR: j = "tabular"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"ViewType\": " + std::to_string(static_cast<int>(x)));
        }
    }
}
