//  To parse this JSON data, first install
//
//      json.hpp  https://github.com/nlohmann/json
//
//  Then include this file, and then do
//
//     TopLevel data = nlohmann::json::parse(jsonString);

#pragma once

#include <optional>
#include <variant>
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

    using Datum = std::optional<std::variant<int64_t, std::string>>;

    class Top {
        public:
        Top() = default;
        virtual ~Top() = default;

        private:
        int64_t count;
        std::string item;

        public:
        const int64_t & get_count() const { return count; }
        int64_t & get_mutable_count() { return count; }
        void set_count(const int64_t & value) { this->count = value; }

        const std::string & get_item() const { return item; }
        std::string & get_mutable_item() { return item; }
        void set_item(const std::string & value) { this->item = value; }
    };

    class CachedContents {
        public:
        CachedContents() = default;
        virtual ~CachedContents() = default;

        private:
        std::string largest;
        int64_t non_null;
        int64_t null;
        std::string smallest;
        std::vector<Top> top;

        public:
        const std::string & get_largest() const { return largest; }
        std::string & get_mutable_largest() { return largest; }
        void set_largest(const std::string & value) { this->largest = value; }

        const int64_t & get_non_null() const { return non_null; }
        int64_t & get_mutable_non_null() { return non_null; }
        void set_non_null(const int64_t & value) { this->non_null = value; }

        const int64_t & get_null() const { return null; }
        int64_t & get_mutable_null() { return null; }
        void set_null(const int64_t & value) { this->null = value; }

        const std::string & get_smallest() const { return smallest; }
        std::string & get_mutable_smallest() { return smallest; }
        void set_smallest(const std::string & value) { this->smallest = value; }

        const std::vector<Top> & get_top() const { return top; }
        std::vector<Top> & get_mutable_top() { return top; }
        void set_top(const std::vector<Top> & value) { this->top = value; }
    };

    enum class TypeName : int { META_DATA, CALENDAR_DATE, TEXT };

    class Format {
        public:
        Format() = default;
        virtual ~Format() = default;

        private:
        std::optional<std::string> align;
        std::optional<std::string> view;

        public:
        const std::optional<std::string> & get_align() const { return align; }
        std::optional<std::string> & get_mutable_align() { return align; }
        void set_align(const std::optional<std::string> & value) { this->align = value; }

        const std::optional<std::string> & get_view() const { return view; }
        std::optional<std::string> & get_mutable_view() { return view; }
        void set_view(const std::optional<std::string> & value) { this->view = value; }
    };

    class Column {
        public:
        Column() = default;
        virtual ~Column() = default;

        private:
        std::optional<CachedContents> cached_contents;
        TypeName data_type_name;
        std::optional<std::string> description;
        std::string field_name;
        std::optional<std::vector<std::string>> flags;
        Format format;
        int64_t id;
        std::string name;
        int64_t position;
        TypeName render_type_name;
        std::optional<int64_t> table_column_id;
        std::optional<int64_t> width;

        public:
        const std::optional<CachedContents> & get_cached_contents() const { return cached_contents; }
        std::optional<CachedContents> & get_mutable_cached_contents() { return cached_contents; }
        void set_cached_contents(const std::optional<CachedContents> & value) { this->cached_contents = value; }

        const TypeName & get_data_type_name() const { return data_type_name; }
        TypeName & get_mutable_data_type_name() { return data_type_name; }
        void set_data_type_name(const TypeName & value) { this->data_type_name = value; }

        const std::optional<std::string> & get_description() const { return description; }
        std::optional<std::string> & get_mutable_description() { return description; }
        void set_description(const std::optional<std::string> & value) { this->description = value; }

        const std::string & get_field_name() const { return field_name; }
        std::string & get_mutable_field_name() { return field_name; }
        void set_field_name(const std::string & value) { this->field_name = value; }

        const std::optional<std::vector<std::string>> & get_flags() const { return flags; }
        std::optional<std::vector<std::string>> & get_mutable_flags() { return flags; }
        void set_flags(const std::optional<std::vector<std::string>> & value) { this->flags = value; }

        const Format & get_format() const { return format; }
        Format & get_mutable_format() { return format; }
        void set_format(const Format & value) { this->format = value; }

        const int64_t & get_id() const { return id; }
        int64_t & get_mutable_id() { return id; }
        void set_id(const int64_t & value) { this->id = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const int64_t & get_position() const { return position; }
        int64_t & get_mutable_position() { return position; }
        void set_position(const int64_t & value) { this->position = value; }

        const TypeName & get_render_type_name() const { return render_type_name; }
        TypeName & get_mutable_render_type_name() { return render_type_name; }
        void set_render_type_name(const TypeName & value) { this->render_type_name = value; }

        const std::optional<int64_t> & get_table_column_id() const { return table_column_id; }
        std::optional<int64_t> & get_mutable_table_column_id() { return table_column_id; }
        void set_table_column_id(const std::optional<int64_t> & value) { this->table_column_id = value; }

        const std::optional<int64_t> & get_width() const { return width; }
        std::optional<int64_t> & get_mutable_width() { return width; }
        void set_width(const std::optional<int64_t> & value) { this->width = value; }
    };

    class Grant {
        public:
        Grant() = default;
        virtual ~Grant() = default;

        private:
        std::vector<std::string> flags;
        bool inherited;
        std::string type;

        public:
        const std::vector<std::string> & get_flags() const { return flags; }
        std::vector<std::string> & get_mutable_flags() { return flags; }
        void set_flags(const std::vector<std::string> & value) { this->flags = value; }

        const bool & get_inherited() const { return inherited; }
        bool & get_mutable_inherited() { return inherited; }
        void set_inherited(const bool & value) { this->inherited = value; }

        const std::string & get_type() const { return type; }
        std::string & get_mutable_type() { return type; }
        void set_type(const std::string & value) { this->type = value; }
    };

    class Attachment {
        public:
        Attachment() = default;
        virtual ~Attachment() = default;

        private:
        std::string asset_id;
        std::string blob_id;
        std::string filename;
        std::string name;

        public:
        const std::string & get_asset_id() const { return asset_id; }
        std::string & get_mutable_asset_id() { return asset_id; }
        void set_asset_id(const std::string & value) { this->asset_id = value; }

        const std::string & get_blob_id() const { return blob_id; }
        std::string & get_mutable_blob_id() { return blob_id; }
        void set_blob_id(const std::string & value) { this->blob_id = value; }

        const std::string & get_filename() const { return filename; }
        std::string & get_mutable_filename() { return filename; }
        void set_filename(const std::string & value) { this->filename = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }
    };

    class AdditionalResources {
        public:
        AdditionalResources() = default;
        virtual ~AdditionalResources() = default;

        private:
        std::string see_also;

        public:
        const std::string & get_see_also() const { return see_also; }
        std::string & get_mutable_see_also() { return see_also; }
        void set_see_also(const std::string & value) { this->see_also = value; }
    };

    class CommonCore {
        public:
        CommonCore() = default;
        virtual ~CommonCore() = default;

        private:
        std::string contact_email;
        std::string contact_name;
        std::string publisher;

        public:
        const std::string & get_contact_email() const { return contact_email; }
        std::string & get_mutable_contact_email() { return contact_email; }
        void set_contact_email(const std::string & value) { this->contact_email = value; }

        const std::string & get_contact_name() const { return contact_name; }
        std::string & get_mutable_contact_name() { return contact_name; }
        void set_contact_name(const std::string & value) { this->contact_name = value; }

        const std::string & get_publisher() const { return publisher; }
        std::string & get_mutable_publisher() { return publisher; }
        void set_publisher(const std::string & value) { this->publisher = value; }
    };

    class DatasetInformation {
        public:
        DatasetInformation() = default;
        virtual ~DatasetInformation() = default;

        private:
        std::string agency;

        public:
        const std::string & get_agency() const { return agency; }
        std::string & get_mutable_agency() { return agency; }
        void set_agency(const std::string & value) { this->agency = value; }
    };

    class DatasetSummary {
        public:
        DatasetSummary() = default;
        virtual ~DatasetSummary() = default;

        private:
        std::string contact_information;
        std::string coverage;
        std::string data_frequency;
        std::string dataset_owner;
        std::string granularity;
        std::string organization;
        std::string posting_frequency;
        std::string time_period;

        public:
        const std::string & get_contact_information() const { return contact_information; }
        std::string & get_mutable_contact_information() { return contact_information; }
        void set_contact_information(const std::string & value) { this->contact_information = value; }

        const std::string & get_coverage() const { return coverage; }
        std::string & get_mutable_coverage() { return coverage; }
        void set_coverage(const std::string & value) { this->coverage = value; }

        const std::string & get_data_frequency() const { return data_frequency; }
        std::string & get_mutable_data_frequency() { return data_frequency; }
        void set_data_frequency(const std::string & value) { this->data_frequency = value; }

        const std::string & get_dataset_owner() const { return dataset_owner; }
        std::string & get_mutable_dataset_owner() { return dataset_owner; }
        void set_dataset_owner(const std::string & value) { this->dataset_owner = value; }

        const std::string & get_granularity() const { return granularity; }
        std::string & get_mutable_granularity() { return granularity; }
        void set_granularity(const std::string & value) { this->granularity = value; }

        const std::string & get_organization() const { return organization; }
        std::string & get_mutable_organization() { return organization; }
        void set_organization(const std::string & value) { this->organization = value; }

        const std::string & get_posting_frequency() const { return posting_frequency; }
        std::string & get_mutable_posting_frequency() { return posting_frequency; }
        void set_posting_frequency(const std::string & value) { this->posting_frequency = value; }

        const std::string & get_time_period() const { return time_period; }
        std::string & get_mutable_time_period() { return time_period; }
        void set_time_period(const std::string & value) { this->time_period = value; }
    };

    class Notes {
        public:
        Notes() = default;
        virtual ~Notes() = default;

        private:
        std::string notes;

        public:
        const std::string & get_notes() const { return notes; }
        std::string & get_mutable_notes() { return notes; }
        void set_notes(const std::string & value) { this->notes = value; }
    };

    class CustomFields {
        public:
        CustomFields() = default;
        virtual ~CustomFields() = default;

        private:
        AdditionalResources additional_resources;
        CommonCore common_core;
        DatasetInformation dataset_information;
        DatasetSummary dataset_summary;
        Notes notes;

        public:
        const AdditionalResources & get_additional_resources() const { return additional_resources; }
        AdditionalResources & get_mutable_additional_resources() { return additional_resources; }
        void set_additional_resources(const AdditionalResources & value) { this->additional_resources = value; }

        const CommonCore & get_common_core() const { return common_core; }
        CommonCore & get_mutable_common_core() { return common_core; }
        void set_common_core(const CommonCore & value) { this->common_core = value; }

        const DatasetInformation & get_dataset_information() const { return dataset_information; }
        DatasetInformation & get_mutable_dataset_information() { return dataset_information; }
        void set_dataset_information(const DatasetInformation & value) { this->dataset_information = value; }

        const DatasetSummary & get_dataset_summary() const { return dataset_summary; }
        DatasetSummary & get_mutable_dataset_summary() { return dataset_summary; }
        void set_dataset_summary(const DatasetSummary & value) { this->dataset_summary = value; }

        const Notes & get_notes() const { return notes; }
        Notes & get_mutable_notes() { return notes; }
        void set_notes(const Notes & value) { this->notes = value; }
    };

    class Order {
        public:
        Order() = default;
        virtual ~Order() = default;

        private:
        bool ascending;
        std::string column_field_name;

        public:
        const bool & get_ascending() const { return ascending; }
        bool & get_mutable_ascending() { return ascending; }
        void set_ascending(const bool & value) { this->ascending = value; }

        const std::string & get_column_field_name() const { return column_field_name; }
        std::string & get_mutable_column_field_name() { return column_field_name; }
        void set_column_field_name(const std::string & value) { this->column_field_name = value; }
    };

    class JsonQuery {
        public:
        JsonQuery() = default;
        virtual ~JsonQuery() = default;

        private:
        std::vector<Order> order;

        public:
        const std::vector<Order> & get_order() const { return order; }
        std::vector<Order> & get_mutable_order() { return order; }
        void set_order(const std::vector<Order> & value) { this->order = value; }
    };

    class Visible {
        public:
        Visible() = default;
        virtual ~Visible() = default;

        private:
        bool table;

        public:
        const bool & get_table() const { return table; }
        bool & get_mutable_table() { return table; }
        void set_table(const bool & value) { this->table = value; }
    };

    class RenderTypeConfig {
        public:
        RenderTypeConfig() = default;
        virtual ~RenderTypeConfig() = default;

        private:
        Visible visible;

        public:
        const Visible & get_visible() const { return visible; }
        Visible & get_mutable_visible() { return visible; }
        void set_visible(const Visible & value) { this->visible = value; }
    };

    class Metadata {
        public:
        Metadata() = default;
        virtual ~Metadata() = default;

        private:
        std::vector<Attachment> attachments;
        std::vector<std::string> available_display_types;
        CustomFields custom_fields;
        JsonQuery json_query;
        std::string rdf_subject;
        RenderTypeConfig render_type_config;

        public:
        const std::vector<Attachment> & get_attachments() const { return attachments; }
        std::vector<Attachment> & get_mutable_attachments() { return attachments; }
        void set_attachments(const std::vector<Attachment> & value) { this->attachments = value; }

        const std::vector<std::string> & get_available_display_types() const { return available_display_types; }
        std::vector<std::string> & get_mutable_available_display_types() { return available_display_types; }
        void set_available_display_types(const std::vector<std::string> & value) { this->available_display_types = value; }

        const CustomFields & get_custom_fields() const { return custom_fields; }
        CustomFields & get_mutable_custom_fields() { return custom_fields; }
        void set_custom_fields(const CustomFields & value) { this->custom_fields = value; }

        const JsonQuery & get_json_query() const { return json_query; }
        JsonQuery & get_mutable_json_query() { return json_query; }
        void set_json_query(const JsonQuery & value) { this->json_query = value; }

        const std::string & get_rdf_subject() const { return rdf_subject; }
        std::string & get_mutable_rdf_subject() { return rdf_subject; }
        void set_rdf_subject(const std::string & value) { this->rdf_subject = value; }

        const RenderTypeConfig & get_render_type_config() const { return render_type_config; }
        RenderTypeConfig & get_mutable_render_type_config() { return render_type_config; }
        void set_render_type_config(const RenderTypeConfig & value) { this->render_type_config = value; }
    };

    class Owner {
        public:
        Owner() = default;
        virtual ~Owner() = default;

        private:
        std::string display_name;
        std::string id;
        std::string profile_image_url_large;
        std::string profile_image_url_medium;
        std::string profile_image_url_small;
        std::vector<std::string> rights;
        std::string role_name;
        std::string screen_name;

        public:
        const std::string & get_display_name() const { return display_name; }
        std::string & get_mutable_display_name() { return display_name; }
        void set_display_name(const std::string & value) { this->display_name = value; }

        const std::string & get_id() const { return id; }
        std::string & get_mutable_id() { return id; }
        void set_id(const std::string & value) { this->id = value; }

        const std::string & get_profile_image_url_large() const { return profile_image_url_large; }
        std::string & get_mutable_profile_image_url_large() { return profile_image_url_large; }
        void set_profile_image_url_large(const std::string & value) { this->profile_image_url_large = value; }

        const std::string & get_profile_image_url_medium() const { return profile_image_url_medium; }
        std::string & get_mutable_profile_image_url_medium() { return profile_image_url_medium; }
        void set_profile_image_url_medium(const std::string & value) { this->profile_image_url_medium = value; }

        const std::string & get_profile_image_url_small() const { return profile_image_url_small; }
        std::string & get_mutable_profile_image_url_small() { return profile_image_url_small; }
        void set_profile_image_url_small(const std::string & value) { this->profile_image_url_small = value; }

        const std::vector<std::string> & get_rights() const { return rights; }
        std::vector<std::string> & get_mutable_rights() { return rights; }
        void set_rights(const std::vector<std::string> & value) { this->rights = value; }

        const std::string & get_role_name() const { return role_name; }
        std::string & get_mutable_role_name() { return role_name; }
        void set_role_name(const std::string & value) { this->role_name = value; }

        const std::string & get_screen_name() const { return screen_name; }
        std::string & get_mutable_screen_name() { return screen_name; }
        void set_screen_name(const std::string & value) { this->screen_name = value; }
    };

    class Expression {
        public:
        Expression() = default;
        virtual ~Expression() = default;

        private:
        int64_t column_id;
        std::string type;

        public:
        const int64_t & get_column_id() const { return column_id; }
        int64_t & get_mutable_column_id() { return column_id; }
        void set_column_id(const int64_t & value) { this->column_id = value; }

        const std::string & get_type() const { return type; }
        std::string & get_mutable_type() { return type; }
        void set_type(const std::string & value) { this->type = value; }
    };

    class OrderBy {
        public:
        OrderBy() = default;
        virtual ~OrderBy() = default;

        private:
        bool ascending;
        Expression expression;

        public:
        const bool & get_ascending() const { return ascending; }
        bool & get_mutable_ascending() { return ascending; }
        void set_ascending(const bool & value) { this->ascending = value; }

        const Expression & get_expression() const { return expression; }
        Expression & get_mutable_expression() { return expression; }
        void set_expression(const Expression & value) { this->expression = value; }
    };

    class Query {
        public:
        Query() = default;
        virtual ~Query() = default;

        private:
        std::vector<OrderBy> order_bys;

        public:
        const std::vector<OrderBy> & get_order_bys() const { return order_bys; }
        std::vector<OrderBy> & get_mutable_order_bys() { return order_bys; }
        void set_order_bys(const std::vector<OrderBy> & value) { this->order_bys = value; }
    };

    class View {
        public:
        View() = default;
        virtual ~View() = default;

        private:
        std::string attribution;
        std::string attribution_link;
        int64_t average_rating;
        std::string category;
        std::vector<Column> columns;
        int64_t created_at;
        std::string description;
        std::string display_type;
        int64_t download_count;
        std::vector<std::string> flags;
        std::vector<Grant> grants;
        bool hide_from_catalog;
        bool hide_from_data_json;
        std::string id;
        int64_t index_updated_at;
        std::string locale;
        Metadata metadata;
        std::string name;
        bool new_backend;
        int64_t number_of_comments;
        int64_t oid;
        Owner owner;
        std::string provenance;
        bool publication_append_enabled;
        int64_t publication_date;
        int64_t publication_group;
        std::string publication_stage;
        Query query;
        std::vector<std::string> rights;
        int64_t rows_updated_at;
        std::string rows_updated_by;
        Owner table_author;
        int64_t table_id;
        std::vector<std::string> tags;
        int64_t total_times_rated;
        int64_t view_count;
        int64_t view_last_modified;
        std::string view_type;

        public:
        const std::string & get_attribution() const { return attribution; }
        std::string & get_mutable_attribution() { return attribution; }
        void set_attribution(const std::string & value) { this->attribution = value; }

        const std::string & get_attribution_link() const { return attribution_link; }
        std::string & get_mutable_attribution_link() { return attribution_link; }
        void set_attribution_link(const std::string & value) { this->attribution_link = value; }

        const int64_t & get_average_rating() const { return average_rating; }
        int64_t & get_mutable_average_rating() { return average_rating; }
        void set_average_rating(const int64_t & value) { this->average_rating = value; }

        const std::string & get_category() const { return category; }
        std::string & get_mutable_category() { return category; }
        void set_category(const std::string & value) { this->category = value; }

        const std::vector<Column> & get_columns() const { return columns; }
        std::vector<Column> & get_mutable_columns() { return columns; }
        void set_columns(const std::vector<Column> & value) { this->columns = value; }

        const int64_t & get_created_at() const { return created_at; }
        int64_t & get_mutable_created_at() { return created_at; }
        void set_created_at(const int64_t & value) { this->created_at = value; }

        const std::string & get_description() const { return description; }
        std::string & get_mutable_description() { return description; }
        void set_description(const std::string & value) { this->description = value; }

        const std::string & get_display_type() const { return display_type; }
        std::string & get_mutable_display_type() { return display_type; }
        void set_display_type(const std::string & value) { this->display_type = value; }

        const int64_t & get_download_count() const { return download_count; }
        int64_t & get_mutable_download_count() { return download_count; }
        void set_download_count(const int64_t & value) { this->download_count = value; }

        const std::vector<std::string> & get_flags() const { return flags; }
        std::vector<std::string> & get_mutable_flags() { return flags; }
        void set_flags(const std::vector<std::string> & value) { this->flags = value; }

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

        const int64_t & get_index_updated_at() const { return index_updated_at; }
        int64_t & get_mutable_index_updated_at() { return index_updated_at; }
        void set_index_updated_at(const int64_t & value) { this->index_updated_at = value; }

        const std::string & get_locale() const { return locale; }
        std::string & get_mutable_locale() { return locale; }
        void set_locale(const std::string & value) { this->locale = value; }

        const Metadata & get_metadata() const { return metadata; }
        Metadata & get_mutable_metadata() { return metadata; }
        void set_metadata(const Metadata & value) { this->metadata = value; }

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

        const std::string & get_provenance() const { return provenance; }
        std::string & get_mutable_provenance() { return provenance; }
        void set_provenance(const std::string & value) { this->provenance = value; }

        const bool & get_publication_append_enabled() const { return publication_append_enabled; }
        bool & get_mutable_publication_append_enabled() { return publication_append_enabled; }
        void set_publication_append_enabled(const bool & value) { this->publication_append_enabled = value; }

        const int64_t & get_publication_date() const { return publication_date; }
        int64_t & get_mutable_publication_date() { return publication_date; }
        void set_publication_date(const int64_t & value) { this->publication_date = value; }

        const int64_t & get_publication_group() const { return publication_group; }
        int64_t & get_mutable_publication_group() { return publication_group; }
        void set_publication_group(const int64_t & value) { this->publication_group = value; }

        const std::string & get_publication_stage() const { return publication_stage; }
        std::string & get_mutable_publication_stage() { return publication_stage; }
        void set_publication_stage(const std::string & value) { this->publication_stage = value; }

        const Query & get_query() const { return query; }
        Query & get_mutable_query() { return query; }
        void set_query(const Query & value) { this->query = value; }

        const std::vector<std::string> & get_rights() const { return rights; }
        std::vector<std::string> & get_mutable_rights() { return rights; }
        void set_rights(const std::vector<std::string> & value) { this->rights = value; }

        const int64_t & get_rows_updated_at() const { return rows_updated_at; }
        int64_t & get_mutable_rows_updated_at() { return rows_updated_at; }
        void set_rows_updated_at(const int64_t & value) { this->rows_updated_at = value; }

        const std::string & get_rows_updated_by() const { return rows_updated_by; }
        std::string & get_mutable_rows_updated_by() { return rows_updated_by; }
        void set_rows_updated_by(const std::string & value) { this->rows_updated_by = value; }

        const Owner & get_table_author() const { return table_author; }
        Owner & get_mutable_table_author() { return table_author; }
        void set_table_author(const Owner & value) { this->table_author = value; }

        const int64_t & get_table_id() const { return table_id; }
        int64_t & get_mutable_table_id() { return table_id; }
        void set_table_id(const int64_t & value) { this->table_id = value; }

        const std::vector<std::string> & get_tags() const { return tags; }
        std::vector<std::string> & get_mutable_tags() { return tags; }
        void set_tags(const std::vector<std::string> & value) { this->tags = value; }

        const int64_t & get_total_times_rated() const { return total_times_rated; }
        int64_t & get_mutable_total_times_rated() { return total_times_rated; }
        void set_total_times_rated(const int64_t & value) { this->total_times_rated = value; }

        const int64_t & get_view_count() const { return view_count; }
        int64_t & get_mutable_view_count() { return view_count; }
        void set_view_count(const int64_t & value) { this->view_count = value; }

        const int64_t & get_view_last_modified() const { return view_last_modified; }
        int64_t & get_mutable_view_last_modified() { return view_last_modified; }
        void set_view_last_modified(const int64_t & value) { this->view_last_modified = value; }

        const std::string & get_view_type() const { return view_type; }
        std::string & get_mutable_view_type() { return view_type; }
        void set_view_type(const std::string & value) { this->view_type = value; }
    };

    class Meta {
        public:
        Meta() = default;
        virtual ~Meta() = default;

        private:
        View view;

        public:
        const View & get_view() const { return view; }
        View & get_mutable_view() { return view; }
        void set_view(const View & value) { this->view = value; }
    };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        std::vector<std::vector<Datum>> data;
        Meta meta;

        public:
        const std::vector<std::vector<Datum>> & get_data() const { return data; }
        std::vector<std::vector<Datum>> & get_mutable_data() { return data; }
        void set_data(const std::vector<std::vector<Datum>> & value) { this->data = value; }

        const Meta & get_meta() const { return meta; }
        Meta & get_mutable_meta() { return meta; }
        void set_meta(const Meta & value) { this->meta = value; }
    };
}

namespace quicktype {
void from_json(const json & j, Top & x);
void to_json(json & j, const Top & x);

void from_json(const json & j, CachedContents & x);
void to_json(json & j, const CachedContents & x);

void from_json(const json & j, Format & x);
void to_json(json & j, const Format & x);

void from_json(const json & j, Column & x);
void to_json(json & j, const Column & x);

void from_json(const json & j, Grant & x);
void to_json(json & j, const Grant & x);

void from_json(const json & j, Attachment & x);
void to_json(json & j, const Attachment & x);

void from_json(const json & j, AdditionalResources & x);
void to_json(json & j, const AdditionalResources & x);

void from_json(const json & j, CommonCore & x);
void to_json(json & j, const CommonCore & x);

void from_json(const json & j, DatasetInformation & x);
void to_json(json & j, const DatasetInformation & x);

void from_json(const json & j, DatasetSummary & x);
void to_json(json & j, const DatasetSummary & x);

void from_json(const json & j, Notes & x);
void to_json(json & j, const Notes & x);

void from_json(const json & j, CustomFields & x);
void to_json(json & j, const CustomFields & x);

void from_json(const json & j, Order & x);
void to_json(json & j, const Order & x);

void from_json(const json & j, JsonQuery & x);
void to_json(json & j, const JsonQuery & x);

void from_json(const json & j, Visible & x);
void to_json(json & j, const Visible & x);

void from_json(const json & j, RenderTypeConfig & x);
void to_json(json & j, const RenderTypeConfig & x);

void from_json(const json & j, Metadata & x);
void to_json(json & j, const Metadata & x);

void from_json(const json & j, Owner & x);
void to_json(json & j, const Owner & x);

void from_json(const json & j, Expression & x);
void to_json(json & j, const Expression & x);

void from_json(const json & j, OrderBy & x);
void to_json(json & j, const OrderBy & x);

void from_json(const json & j, Query & x);
void to_json(json & j, const Query & x);

void from_json(const json & j, View & x);
void to_json(json & j, const View & x);

void from_json(const json & j, Meta & x);
void to_json(json & j, const Meta & x);

void from_json(const json & j, TopLevel & x);
void to_json(json & j, const TopLevel & x);

void from_json(const json & j, TypeName & x);
void to_json(json & j, const TypeName & x);
}
namespace nlohmann {
template <>
struct adl_serializer<std::variant<int64_t, std::string>> {
    static void from_json(const json & j, std::variant<int64_t, std::string> & x);
    static void to_json(json & j, const std::variant<int64_t, std::string> & x);
};
}
namespace quicktype {
    inline void from_json(const json & j, Top& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("count") != j.end() && !j.at("count").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_count(j.at("count").get<int64_t>());
        x.set_item(j.at("item").get<std::string>());
    }

    inline void to_json(json & j, const Top & x) {
        j = json::object();
        j["count"] = x.get_count();
        j["item"] = x.get_item();
    }

    inline void from_json(const json & j, CachedContents& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_largest(j.at("largest").get<std::string>());
        if (j.find("non_null") != j.end() && !j.at("non_null").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_non_null(j.at("non_null").get<int64_t>());
        if (j.find("null") != j.end() && !j.at("null").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_null(j.at("null").get<int64_t>());
        x.set_smallest(j.at("smallest").get<std::string>());
        x.set_top(j.at("top").get<std::vector<Top>>());
    }

    inline void to_json(json & j, const CachedContents & x) {
        j = json::object();
        j["largest"] = x.get_largest();
        j["non_null"] = x.get_non_null();
        j["null"] = x.get_null();
        j["smallest"] = x.get_smallest();
        j["top"] = x.get_top();
    }

    inline void from_json(const json & j, Format& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("align") != j.end() && j.at("align").is_null()) throw std::runtime_error("Unexpected null");
        x.set_align(get_stack_optional<std::string>(j, "align"));
        if (j.find("view") != j.end() && j.at("view").is_null()) throw std::runtime_error("Unexpected null");
        x.set_view(get_stack_optional<std::string>(j, "view"));
    }

    inline void to_json(json & j, const Format & x) {
        j = json::object();
        j["align"] = x.get_align();
        j["view"] = x.get_view();
    }

    inline void from_json(const json & j, Column& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("cachedContents") != j.end() && j.at("cachedContents").is_null()) throw std::runtime_error("Unexpected null");
        x.set_cached_contents(get_stack_optional<CachedContents>(j, "cachedContents"));
        x.set_data_type_name(j.at("dataTypeName").get<TypeName>());
        if (j.find("description") != j.end() && j.at("description").is_null()) throw std::runtime_error("Unexpected null");
        x.set_description(get_stack_optional<std::string>(j, "description"));
        x.set_field_name(j.at("fieldName").get<std::string>());
        if (j.find("flags") != j.end() && j.at("flags").is_null()) throw std::runtime_error("Unexpected null");
        x.set_flags(get_stack_optional<std::vector<std::string>>(j, "flags"));
        x.set_format(j.at("format").get<Format>());
        if (j.find("id") != j.end() && !j.at("id").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_id(j.at("id").get<int64_t>());
        x.set_name(j.at("name").get<std::string>());
        if (j.find("position") != j.end() && !j.at("position").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_position(j.at("position").get<int64_t>());
        x.set_render_type_name(j.at("renderTypeName").get<TypeName>());
        if (j.find("tableColumnId") != j.end() && !j.at("tableColumnId").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("tableColumnId") != j.end() && j.at("tableColumnId").is_null()) throw std::runtime_error("Unexpected null");
        x.set_table_column_id(get_stack_optional<int64_t>(j, "tableColumnId"));
        if (j.find("width") != j.end() && !j.at("width").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("width") != j.end() && j.at("width").is_null()) throw std::runtime_error("Unexpected null");
        x.set_width(get_stack_optional<int64_t>(j, "width"));
    }

    inline void to_json(json & j, const Column & x) {
        j = json::object();
        j["cachedContents"] = x.get_cached_contents();
        j["dataTypeName"] = x.get_data_type_name();
        j["description"] = x.get_description();
        j["fieldName"] = x.get_field_name();
        j["flags"] = x.get_flags();
        j["format"] = x.get_format();
        j["id"] = x.get_id();
        j["name"] = x.get_name();
        j["position"] = x.get_position();
        j["renderTypeName"] = x.get_render_type_name();
        j["tableColumnId"] = x.get_table_column_id();
        j["width"] = x.get_width();
    }

    inline void from_json(const json & j, Grant& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_flags(j.at("flags").get<std::vector<std::string>>());
        x.set_inherited(j.at("inherited").get<bool>());
        x.set_type(j.at("type").get<std::string>());
    }

    inline void to_json(json & j, const Grant & x) {
        j = json::object();
        j["flags"] = x.get_flags();
        j["inherited"] = x.get_inherited();
        j["type"] = x.get_type();
    }

    inline void from_json(const json & j, Attachment& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_asset_id(j.at("assetId").get<std::string>());
        x.set_blob_id(j.at("blobId").get<std::string>());
        x.set_filename(j.at("filename").get<std::string>());
        x.set_name(j.at("name").get<std::string>());
    }

    inline void to_json(json & j, const Attachment & x) {
        j = json::object();
        j["assetId"] = x.get_asset_id();
        j["blobId"] = x.get_blob_id();
        j["filename"] = x.get_filename();
        j["name"] = x.get_name();
    }

    inline void from_json(const json & j, AdditionalResources& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_see_also(j.at("See Also").get<std::string>());
    }

    inline void to_json(json & j, const AdditionalResources & x) {
        j = json::object();
        j["See Also"] = x.get_see_also();
    }

    inline void from_json(const json & j, CommonCore& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_contact_email(j.at("Contact Email").get<std::string>());
        x.set_contact_name(j.at("Contact Name").get<std::string>());
        x.set_publisher(j.at("Publisher").get<std::string>());
    }

    inline void to_json(json & j, const CommonCore & x) {
        j = json::object();
        j["Contact Email"] = x.get_contact_email();
        j["Contact Name"] = x.get_contact_name();
        j["Publisher"] = x.get_publisher();
    }

    inline void from_json(const json & j, DatasetInformation& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_agency(j.at("Agency").get<std::string>());
    }

    inline void to_json(json & j, const DatasetInformation & x) {
        j = json::object();
        j["Agency"] = x.get_agency();
    }

    inline void from_json(const json & j, DatasetSummary& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_contact_information(j.at("Contact Information").get<std::string>());
        x.set_coverage(j.at("Coverage").get<std::string>());
        x.set_data_frequency(j.at("Data Frequency").get<std::string>());
        x.set_dataset_owner(j.at("Dataset Owner").get<std::string>());
        x.set_granularity(j.at("Granularity").get<std::string>());
        x.set_organization(j.at("Organization").get<std::string>());
        x.set_posting_frequency(j.at("Posting Frequency").get<std::string>());
        x.set_time_period(j.at("Time Period").get<std::string>());
    }

    inline void to_json(json & j, const DatasetSummary & x) {
        j = json::object();
        j["Contact Information"] = x.get_contact_information();
        j["Coverage"] = x.get_coverage();
        j["Data Frequency"] = x.get_data_frequency();
        j["Dataset Owner"] = x.get_dataset_owner();
        j["Granularity"] = x.get_granularity();
        j["Organization"] = x.get_organization();
        j["Posting Frequency"] = x.get_posting_frequency();
        j["Time Period"] = x.get_time_period();
    }

    inline void from_json(const json & j, Notes& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_notes(j.at("Notes").get<std::string>());
    }

    inline void to_json(json & j, const Notes & x) {
        j = json::object();
        j["Notes"] = x.get_notes();
    }

    inline void from_json(const json & j, CustomFields& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_additional_resources(j.at("Additional Resources").get<AdditionalResources>());
        x.set_common_core(j.at("Common Core").get<CommonCore>());
        x.set_dataset_information(j.at("Dataset Information").get<DatasetInformation>());
        x.set_dataset_summary(j.at("Dataset Summary").get<DatasetSummary>());
        x.set_notes(j.at("Notes").get<Notes>());
    }

    inline void to_json(json & j, const CustomFields & x) {
        j = json::object();
        j["Additional Resources"] = x.get_additional_resources();
        j["Common Core"] = x.get_common_core();
        j["Dataset Information"] = x.get_dataset_information();
        j["Dataset Summary"] = x.get_dataset_summary();
        j["Notes"] = x.get_notes();
    }

    inline void from_json(const json & j, Order& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_ascending(j.at("ascending").get<bool>());
        x.set_column_field_name(j.at("columnFieldName").get<std::string>());
    }

    inline void to_json(json & j, const Order & x) {
        j = json::object();
        j["ascending"] = x.get_ascending();
        j["columnFieldName"] = x.get_column_field_name();
    }

    inline void from_json(const json & j, JsonQuery& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_order(j.at("order").get<std::vector<Order>>());
    }

    inline void to_json(json & j, const JsonQuery & x) {
        j = json::object();
        j["order"] = x.get_order();
    }

    inline void from_json(const json & j, Visible& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_table(j.at("table").get<bool>());
    }

    inline void to_json(json & j, const Visible & x) {
        j = json::object();
        j["table"] = x.get_table();
    }

    inline void from_json(const json & j, RenderTypeConfig& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_visible(j.at("visible").get<Visible>());
    }

    inline void to_json(json & j, const RenderTypeConfig & x) {
        j = json::object();
        j["visible"] = x.get_visible();
    }

    inline void from_json(const json & j, Metadata& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_attachments(j.at("attachments").get<std::vector<Attachment>>());
        x.set_available_display_types(j.at("availableDisplayTypes").get<std::vector<std::string>>());
        x.set_custom_fields(j.at("custom_fields").get<CustomFields>());
        x.set_json_query(j.at("jsonQuery").get<JsonQuery>());
        x.set_rdf_subject(j.at("rdfSubject").get<std::string>());
        x.set_render_type_config(j.at("renderTypeConfig").get<RenderTypeConfig>());
    }

    inline void to_json(json & j, const Metadata & x) {
        j = json::object();
        j["attachments"] = x.get_attachments();
        j["availableDisplayTypes"] = x.get_available_display_types();
        j["custom_fields"] = x.get_custom_fields();
        j["jsonQuery"] = x.get_json_query();
        j["rdfSubject"] = x.get_rdf_subject();
        j["renderTypeConfig"] = x.get_render_type_config();
    }

    inline void from_json(const json & j, Owner& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_display_name(j.at("displayName").get<std::string>());
        x.set_id(j.at("id").get<std::string>());
        x.set_profile_image_url_large(j.at("profileImageUrlLarge").get<std::string>());
        x.set_profile_image_url_medium(j.at("profileImageUrlMedium").get<std::string>());
        x.set_profile_image_url_small(j.at("profileImageUrlSmall").get<std::string>());
        x.set_rights(j.at("rights").get<std::vector<std::string>>());
        x.set_role_name(j.at("roleName").get<std::string>());
        x.set_screen_name(j.at("screenName").get<std::string>());
    }

    inline void to_json(json & j, const Owner & x) {
        j = json::object();
        j["displayName"] = x.get_display_name();
        j["id"] = x.get_id();
        j["profileImageUrlLarge"] = x.get_profile_image_url_large();
        j["profileImageUrlMedium"] = x.get_profile_image_url_medium();
        j["profileImageUrlSmall"] = x.get_profile_image_url_small();
        j["rights"] = x.get_rights();
        j["roleName"] = x.get_role_name();
        j["screenName"] = x.get_screen_name();
    }

    inline void from_json(const json & j, Expression& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("columnId") != j.end() && !j.at("columnId").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_column_id(j.at("columnId").get<int64_t>());
        x.set_type(j.at("type").get<std::string>());
    }

    inline void to_json(json & j, const Expression & x) {
        j = json::object();
        j["columnId"] = x.get_column_id();
        j["type"] = x.get_type();
    }

    inline void from_json(const json & j, OrderBy& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_ascending(j.at("ascending").get<bool>());
        x.set_expression(j.at("expression").get<Expression>());
    }

    inline void to_json(json & j, const OrderBy & x) {
        j = json::object();
        j["ascending"] = x.get_ascending();
        j["expression"] = x.get_expression();
    }

    inline void from_json(const json & j, Query& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_order_bys(j.at("orderBys").get<std::vector<OrderBy>>());
    }

    inline void to_json(json & j, const Query & x) {
        j = json::object();
        j["orderBys"] = x.get_order_bys();
    }

    inline void from_json(const json & j, View& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_attribution(j.at("attribution").get<std::string>());
        x.set_attribution_link(j.at("attributionLink").get<std::string>());
        if (j.find("averageRating") != j.end() && !j.at("averageRating").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_average_rating(j.at("averageRating").get<int64_t>());
        x.set_category(j.at("category").get<std::string>());
        x.set_columns(j.at("columns").get<std::vector<Column>>());
        if (j.find("createdAt") != j.end() && !j.at("createdAt").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_created_at(j.at("createdAt").get<int64_t>());
        x.set_description(j.at("description").get<std::string>());
        x.set_display_type(j.at("displayType").get<std::string>());
        if (j.find("downloadCount") != j.end() && !j.at("downloadCount").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_download_count(j.at("downloadCount").get<int64_t>());
        x.set_flags(j.at("flags").get<std::vector<std::string>>());
        x.set_grants(j.at("grants").get<std::vector<Grant>>());
        x.set_hide_from_catalog(j.at("hideFromCatalog").get<bool>());
        x.set_hide_from_data_json(j.at("hideFromDataJson").get<bool>());
        x.set_id(j.at("id").get<std::string>());
        if (j.find("indexUpdatedAt") != j.end() && !j.at("indexUpdatedAt").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_index_updated_at(j.at("indexUpdatedAt").get<int64_t>());
        x.set_locale(j.at("locale").get<std::string>());
        x.set_metadata(j.at("metadata").get<Metadata>());
        x.set_name(j.at("name").get<std::string>());
        x.set_new_backend(j.at("newBackend").get<bool>());
        if (j.find("numberOfComments") != j.end() && !j.at("numberOfComments").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_number_of_comments(j.at("numberOfComments").get<int64_t>());
        if (j.find("oid") != j.end() && !j.at("oid").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_oid(j.at("oid").get<int64_t>());
        x.set_owner(j.at("owner").get<Owner>());
        x.set_provenance(j.at("provenance").get<std::string>());
        x.set_publication_append_enabled(j.at("publicationAppendEnabled").get<bool>());
        if (j.find("publicationDate") != j.end() && !j.at("publicationDate").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_publication_date(j.at("publicationDate").get<int64_t>());
        if (j.find("publicationGroup") != j.end() && !j.at("publicationGroup").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_publication_group(j.at("publicationGroup").get<int64_t>());
        x.set_publication_stage(j.at("publicationStage").get<std::string>());
        x.set_query(j.at("query").get<Query>());
        x.set_rights(j.at("rights").get<std::vector<std::string>>());
        if (j.find("rowsUpdatedAt") != j.end() && !j.at("rowsUpdatedAt").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_rows_updated_at(j.at("rowsUpdatedAt").get<int64_t>());
        x.set_rows_updated_by(j.at("rowsUpdatedBy").get<std::string>());
        x.set_table_author(j.at("tableAuthor").get<Owner>());
        if (j.find("tableId") != j.end() && !j.at("tableId").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_table_id(j.at("tableId").get<int64_t>());
        x.set_tags(j.at("tags").get<std::vector<std::string>>());
        if (j.find("totalTimesRated") != j.end() && !j.at("totalTimesRated").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_total_times_rated(j.at("totalTimesRated").get<int64_t>());
        if (j.find("viewCount") != j.end() && !j.at("viewCount").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_view_count(j.at("viewCount").get<int64_t>());
        if (j.find("viewLastModified") != j.end() && !j.at("viewLastModified").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_view_last_modified(j.at("viewLastModified").get<int64_t>());
        x.set_view_type(j.at("viewType").get<std::string>());
    }

    inline void to_json(json & j, const View & x) {
        j = json::object();
        j["attribution"] = x.get_attribution();
        j["attributionLink"] = x.get_attribution_link();
        j["averageRating"] = x.get_average_rating();
        j["category"] = x.get_category();
        j["columns"] = x.get_columns();
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
        j["query"] = x.get_query();
        j["rights"] = x.get_rights();
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

    inline void from_json(const json & j, Meta& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_view(j.at("view").get<View>());
    }

    inline void to_json(json & j, const Meta & x) {
        j = json::object();
        j["view"] = x.get_view();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_data(j.at("data").get<std::vector<std::vector<Datum>>>());
        x.set_meta(j.at("meta").get<Meta>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["data"] = x.get_data();
        j["meta"] = x.get_meta();
    }

    inline void from_json(const json & j, TypeName & x) {
        if (j == "meta_data") x = TypeName::META_DATA;
        else if (j == "calendar_date") x = TypeName::CALENDAR_DATE;
        else if (j == "text") x = TypeName::TEXT;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"TypeName\""); }
    }

    inline void to_json(json & j, const TypeName & x) {
        switch (x) {
            case TypeName::META_DATA: j = "meta_data"; break;
            case TypeName::CALENDAR_DATE: j = "calendar_date"; break;
            case TypeName::TEXT: j = "text"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"TypeName\": " + std::to_string(static_cast<int>(x)));
        }
    }
}
namespace nlohmann {
    inline void adl_serializer<std::variant<int64_t, std::string>>::from_json(const json & j, std::variant<int64_t, std::string> & x) {
        if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_string())
            x = j.get<std::string>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<int64_t, std::string>>::to_json(json & j, const std::variant<int64_t, std::string> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<int64_t>(x);
                break;
            case 1:
                j = std::get<std::string>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }
}
