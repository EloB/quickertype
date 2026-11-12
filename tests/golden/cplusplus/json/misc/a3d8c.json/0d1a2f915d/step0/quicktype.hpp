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
        std::optional<std::string> average;
        std::string largest;
        int64_t non_null;
        int64_t null;
        std::string smallest;
        std::optional<std::string> sum;
        std::vector<Top> top;

        public:
        const std::optional<std::string> & get_average() const { return average; }
        std::optional<std::string> & get_mutable_average() { return average; }
        void set_average(const std::optional<std::string> & value) { this->average = value; }

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

        const std::optional<std::string> & get_sum() const { return sum; }
        std::optional<std::string> & get_mutable_sum() { return sum; }
        void set_sum(const std::optional<std::string> & value) { this->sum = value; }

        const std::vector<Top> & get_top() const { return top; }
        std::vector<Top> & get_mutable_top() { return top; }
        void set_top(const std::vector<Top> & value) { this->top = value; }
    };

    enum class TypeName : int { META_DATA, NUMBER, TEXT };

    class Query {
        public:
        Query() = default;
        virtual ~Query() = default;

        private:

        public:
    };

    class Column {
        public:
        Column() = default;
        virtual ~Column() = default;

        private:
        std::optional<CachedContents> cached_contents;
        TypeName data_type_name;
        std::string field_name;
        std::optional<std::vector<std::string>> flags;
        Query format;
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

        const std::string & get_field_name() const { return field_name; }
        std::string & get_mutable_field_name() { return field_name; }
        void set_field_name(const std::string & value) { this->field_name = value; }

        const std::optional<std::vector<std::string>> & get_flags() const { return flags; }
        std::optional<std::vector<std::string>> & get_mutable_flags() { return flags; }
        void set_flags(const std::optional<std::vector<std::string>> & value) { this->flags = value; }

        const Query & get_format() const { return format; }
        Query & get_mutable_format() { return format; }
        void set_format(const Query & value) { this->format = value; }

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

    class License {
        public:
        License() = default;
        virtual ~License() = default;

        private:
        std::string name;

        public:
        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }
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
        std::vector<std::string> available_display_types;
        std::string rdf_class;
        std::string rdf_subject;
        RenderTypeConfig render_type_config;
        std::string row_identifier;

        public:
        const std::vector<std::string> & get_available_display_types() const { return available_display_types; }
        std::vector<std::string> & get_mutable_available_display_types() { return available_display_types; }
        void set_available_display_types(const std::vector<std::string> & value) { this->available_display_types = value; }

        const std::string & get_rdf_class() const { return rdf_class; }
        std::string & get_mutable_rdf_class() { return rdf_class; }
        void set_rdf_class(const std::string & value) { this->rdf_class = value; }

        const std::string & get_rdf_subject() const { return rdf_subject; }
        std::string & get_mutable_rdf_subject() { return rdf_subject; }
        void set_rdf_subject(const std::string & value) { this->rdf_subject = value; }

        const RenderTypeConfig & get_render_type_config() const { return render_type_config; }
        RenderTypeConfig & get_mutable_render_type_config() { return render_type_config; }
        void set_render_type_config(const RenderTypeConfig & value) { this->render_type_config = value; }

        const std::string & get_row_identifier() const { return row_identifier; }
        std::string & get_mutable_row_identifier() { return row_identifier; }
        void set_row_identifier(const std::string & value) { this->row_identifier = value; }
    };

    class Owner {
        public:
        Owner() = default;
        virtual ~Owner() = default;

        private:
        std::string display_name;
        std::string id;
        std::string screen_name;

        public:
        const std::string & get_display_name() const { return display_name; }
        std::string & get_mutable_display_name() { return display_name; }
        void set_display_name(const std::string & value) { this->display_name = value; }

        const std::string & get_id() const { return id; }
        std::string & get_mutable_id() { return id; }
        void set_id(const std::string & value) { this->id = value; }

        const std::string & get_screen_name() const { return screen_name; }
        std::string & get_mutable_screen_name() { return screen_name; }
        void set_screen_name(const std::string & value) { this->screen_name = value; }
    };

    class View {
        public:
        View() = default;
        virtual ~View() = default;

        private:
        int64_t average_rating;
        std::string category;
        std::vector<Column> columns;
        int64_t created_at;
        std::string display_type;
        int64_t download_count;
        std::vector<std::string> flags;
        std::vector<Grant> grants;
        bool hide_from_catalog;
        bool hide_from_data_json;
        std::string id;
        int64_t index_updated_at;
        License license;
        std::string license_id;
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
        std::string row_class;
        int64_t rows_updated_at;
        std::string rows_updated_by;
        Owner table_author;
        int64_t table_id;
        int64_t total_times_rated;
        int64_t view_count;
        int64_t view_last_modified;
        std::string view_type;

        public:
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

        const License & get_license() const { return license; }
        License & get_mutable_license() { return license; }
        void set_license(const License & value) { this->license = value; }

        const std::string & get_license_id() const { return license_id; }
        std::string & get_mutable_license_id() { return license_id; }
        void set_license_id(const std::string & value) { this->license_id = value; }

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

        const std::string & get_row_class() const { return row_class; }
        std::string & get_mutable_row_class() { return row_class; }
        void set_row_class(const std::string & value) { this->row_class = value; }

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

void from_json(const json & j, Query & x);
void to_json(json & j, const Query & x);

void from_json(const json & j, Column & x);
void to_json(json & j, const Column & x);

void from_json(const json & j, Grant & x);
void to_json(json & j, const Grant & x);

void from_json(const json & j, License & x);
void to_json(json & j, const License & x);

void from_json(const json & j, Visible & x);
void to_json(json & j, const Visible & x);

void from_json(const json & j, RenderTypeConfig & x);
void to_json(json & j, const RenderTypeConfig & x);

void from_json(const json & j, Metadata & x);
void to_json(json & j, const Metadata & x);

void from_json(const json & j, Owner & x);
void to_json(json & j, const Owner & x);

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
        if (j.find("average") != j.end() && j.at("average").is_null()) throw std::runtime_error("Unexpected null");
        x.set_average(get_stack_optional<std::string>(j, "average"));
        x.set_largest(j.at("largest").get<std::string>());
        if (j.find("non_null") != j.end() && !j.at("non_null").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_non_null(j.at("non_null").get<int64_t>());
        if (j.find("null") != j.end() && !j.at("null").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_null(j.at("null").get<int64_t>());
        x.set_smallest(j.at("smallest").get<std::string>());
        if (j.find("sum") != j.end() && j.at("sum").is_null()) throw std::runtime_error("Unexpected null");
        x.set_sum(get_stack_optional<std::string>(j, "sum"));
        x.set_top(j.at("top").get<std::vector<Top>>());
    }

    inline void to_json(json & j, const CachedContents & x) {
        j = json::object();
        j["average"] = x.get_average();
        j["largest"] = x.get_largest();
        j["non_null"] = x.get_non_null();
        j["null"] = x.get_null();
        j["smallest"] = x.get_smallest();
        j["sum"] = x.get_sum();
        j["top"] = x.get_top();
    }

    inline void from_json(const json & j, Query& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Query & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Column& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("cachedContents") != j.end() && j.at("cachedContents").is_null()) throw std::runtime_error("Unexpected null");
        x.set_cached_contents(get_stack_optional<CachedContents>(j, "cachedContents"));
        x.set_data_type_name(j.at("dataTypeName").get<TypeName>());
        x.set_field_name(j.at("fieldName").get<std::string>());
        if (j.find("flags") != j.end() && j.at("flags").is_null()) throw std::runtime_error("Unexpected null");
        x.set_flags(get_stack_optional<std::vector<std::string>>(j, "flags"));
        x.set_format(j.at("format").get<Query>());
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

    inline void from_json(const json & j, License& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_name(j.at("name").get<std::string>());
    }

    inline void to_json(json & j, const License & x) {
        j = json::object();
        j["name"] = x.get_name();
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
        x.set_available_display_types(j.at("availableDisplayTypes").get<std::vector<std::string>>());
        x.set_rdf_class(j.at("rdfClass").get<std::string>());
        x.set_rdf_subject(j.at("rdfSubject").get<std::string>());
        x.set_render_type_config(j.at("renderTypeConfig").get<RenderTypeConfig>());
        x.set_row_identifier(j.at("rowIdentifier").get<std::string>());
    }

    inline void to_json(json & j, const Metadata & x) {
        j = json::object();
        j["availableDisplayTypes"] = x.get_available_display_types();
        j["rdfClass"] = x.get_rdf_class();
        j["rdfSubject"] = x.get_rdf_subject();
        j["renderTypeConfig"] = x.get_render_type_config();
        j["rowIdentifier"] = x.get_row_identifier();
    }

    inline void from_json(const json & j, Owner& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_display_name(j.at("displayName").get<std::string>());
        x.set_id(j.at("id").get<std::string>());
        x.set_screen_name(j.at("screenName").get<std::string>());
    }

    inline void to_json(json & j, const Owner & x) {
        j = json::object();
        j["displayName"] = x.get_display_name();
        j["id"] = x.get_id();
        j["screenName"] = x.get_screen_name();
    }

    inline void from_json(const json & j, View& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("averageRating") != j.end() && !j.at("averageRating").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_average_rating(j.at("averageRating").get<int64_t>());
        x.set_category(j.at("category").get<std::string>());
        x.set_columns(j.at("columns").get<std::vector<Column>>());
        if (j.find("createdAt") != j.end() && !j.at("createdAt").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_created_at(j.at("createdAt").get<int64_t>());
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
        x.set_license(j.at("license").get<License>());
        x.set_license_id(j.at("licenseId").get<std::string>());
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
        x.set_row_class(j.at("rowClass").get<std::string>());
        if (j.find("rowsUpdatedAt") != j.end() && !j.at("rowsUpdatedAt").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_rows_updated_at(j.at("rowsUpdatedAt").get<int64_t>());
        x.set_rows_updated_by(j.at("rowsUpdatedBy").get<std::string>());
        x.set_table_author(j.at("tableAuthor").get<Owner>());
        if (j.find("tableId") != j.end() && !j.at("tableId").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_table_id(j.at("tableId").get<int64_t>());
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
        j["averageRating"] = x.get_average_rating();
        j["category"] = x.get_category();
        j["columns"] = x.get_columns();
        j["createdAt"] = x.get_created_at();
        j["displayType"] = x.get_display_type();
        j["downloadCount"] = x.get_download_count();
        j["flags"] = x.get_flags();
        j["grants"] = x.get_grants();
        j["hideFromCatalog"] = x.get_hide_from_catalog();
        j["hideFromDataJson"] = x.get_hide_from_data_json();
        j["id"] = x.get_id();
        j["indexUpdatedAt"] = x.get_index_updated_at();
        j["license"] = x.get_license();
        j["licenseId"] = x.get_license_id();
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
        j["rowClass"] = x.get_row_class();
        j["rowsUpdatedAt"] = x.get_rows_updated_at();
        j["rowsUpdatedBy"] = x.get_rows_updated_by();
        j["tableAuthor"] = x.get_table_author();
        j["tableId"] = x.get_table_id();
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
        else if (j == "number") x = TypeName::NUMBER;
        else if (j == "text") x = TypeName::TEXT;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"TypeName\""); }
    }

    inline void to_json(json & j, const TypeName & x) {
        switch (x) {
            case TypeName::META_DATA: j = "meta_data"; break;
            case TypeName::NUMBER: j = "number"; break;
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
