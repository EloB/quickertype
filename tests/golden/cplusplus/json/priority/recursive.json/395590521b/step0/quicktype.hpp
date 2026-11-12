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

    class LinkLink {
        public:
        LinkLink() = default;
        virtual ~LinkLink() = default;

        private:
        std::string type;
        std::string url;

        public:
        const std::string & get_type() const { return type; }
        std::string & get_mutable_type() { return type; }
        void set_type(const std::string & value) { this->type = value; }

        const std::string & get_url() const { return url; }
        std::string & get_mutable_url() { return url; }
        void set_url(const std::string & value) { this->url = value; }
    };

    class LinkElement {
        public:
        LinkElement() = default;
        virtual ~LinkElement() = default;

        private:
        LinkLink link;

        public:
        const LinkLink & get_link() const { return link; }
        LinkLink & get_mutable_link() { return link; }
        void set_link(const LinkLink & value) { this->link = value; }
    };

    class CategoryThumbnail {
        public:
        CategoryThumbnail() = default;
        virtual ~CategoryThumbnail() = default;

        private:
        std::string url;

        public:
        const std::string & get_url() const { return url; }
        std::string & get_mutable_url() { return url; }
        void set_url(const std::string & value) { this->url = value; }
    };

    class Category {
        public:
        Category() = default;
        virtual ~Category() = default;

        private:
        bool concatenatecategoryname;
        bool hasoffer;
        int64_t id;
        bool isfinal;
        std::vector<LinkElement> links;
        std::string name;
        int64_t parentcategoryid;
        CategoryThumbnail thumbnail;

        public:
        const bool & get_concatenatecategoryname() const { return concatenatecategoryname; }
        bool & get_mutable_concatenatecategoryname() { return concatenatecategoryname; }
        void set_concatenatecategoryname(const bool & value) { this->concatenatecategoryname = value; }

        const bool & get_hasoffer() const { return hasoffer; }
        bool & get_mutable_hasoffer() { return hasoffer; }
        void set_hasoffer(const bool & value) { this->hasoffer = value; }

        const int64_t & get_id() const { return id; }
        int64_t & get_mutable_id() { return id; }
        void set_id(const int64_t & value) { this->id = value; }

        const bool & get_isfinal() const { return isfinal; }
        bool & get_mutable_isfinal() { return isfinal; }
        void set_isfinal(const bool & value) { this->isfinal = value; }

        const std::vector<LinkElement> & get_links() const { return links; }
        std::vector<LinkElement> & get_mutable_links() { return links; }
        void set_links(const std::vector<LinkElement> & value) { this->links = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const int64_t & get_parentcategoryid() const { return parentcategoryid; }
        int64_t & get_mutable_parentcategoryid() { return parentcategoryid; }
        void set_parentcategoryid(const int64_t & value) { this->parentcategoryid = value; }

        const CategoryThumbnail & get_thumbnail() const { return thumbnail; }
        CategoryThumbnail & get_mutable_thumbnail() { return thumbnail; }
        void set_thumbnail(const CategoryThumbnail & value) { this->thumbnail = value; }
    };

    class Eonandyear {
        public:
        Eonandyear() = default;
        virtual ~Eonandyear() = default;

        private:
        int64_t lowestsetbit;

        public:
        const int64_t & get_lowestsetbit() const { return lowestsetbit; }
        int64_t & get_mutable_lowestsetbit() { return lowestsetbit; }
        void set_lowestsetbit(const int64_t & value) { this->lowestsetbit = value; }
    };

    class Xmlschematype {
        public:
        Xmlschematype() = default;
        virtual ~Xmlschematype() = default;

        private:
        std::string localpart;
        std::string namespaceuri;
        std::string prefix;

        public:
        const std::string & get_localpart() const { return localpart; }
        std::string & get_mutable_localpart() { return localpart; }
        void set_localpart(const std::string & value) { this->localpart = value; }

        const std::string & get_namespaceuri() const { return namespaceuri; }
        std::string & get_mutable_namespaceuri() { return namespaceuri; }
        void set_namespaceuri(const std::string & value) { this->namespaceuri = value; }

        const std::string & get_prefix() const { return prefix; }
        std::string & get_mutable_prefix() { return prefix; }
        void set_prefix(const std::string & value) { this->prefix = value; }
    };

    class Date {
        public:
        Date() = default;
        virtual ~Date() = default;

        private:
        int64_t day;
        Eonandyear eonandyear;
        int64_t hour;
        int64_t millisecond;
        int64_t minute;
        int64_t month;
        int64_t second;
        int64_t timezone;
        bool valid;
        Xmlschematype xmlschematype;
        int64_t year;

        public:
        const int64_t & get_day() const { return day; }
        int64_t & get_mutable_day() { return day; }
        void set_day(const int64_t & value) { this->day = value; }

        const Eonandyear & get_eonandyear() const { return eonandyear; }
        Eonandyear & get_mutable_eonandyear() { return eonandyear; }
        void set_eonandyear(const Eonandyear & value) { this->eonandyear = value; }

        const int64_t & get_hour() const { return hour; }
        int64_t & get_mutable_hour() { return hour; }
        void set_hour(const int64_t & value) { this->hour = value; }

        const int64_t & get_millisecond() const { return millisecond; }
        int64_t & get_mutable_millisecond() { return millisecond; }
        void set_millisecond(const int64_t & value) { this->millisecond = value; }

        const int64_t & get_minute() const { return minute; }
        int64_t & get_mutable_minute() { return minute; }
        void set_minute(const int64_t & value) { this->minute = value; }

        const int64_t & get_month() const { return month; }
        int64_t & get_mutable_month() { return month; }
        void set_month(const int64_t & value) { this->month = value; }

        const int64_t & get_second() const { return second; }
        int64_t & get_mutable_second() { return second; }
        void set_second(const int64_t & value) { this->second = value; }

        const int64_t & get_timezone() const { return timezone; }
        int64_t & get_mutable_timezone() { return timezone; }
        void set_timezone(const int64_t & value) { this->timezone = value; }

        const bool & get_valid() const { return valid; }
        bool & get_mutable_valid() { return valid; }
        void set_valid(const bool & value) { this->valid = value; }

        const Xmlschematype & get_xmlschematype() const { return xmlschematype; }
        Xmlschematype & get_mutable_xmlschematype() { return xmlschematype; }
        void set_xmlschematype(const Xmlschematype & value) { this->xmlschematype = value; }

        const int64_t & get_year() const { return year; }
        int64_t & get_mutable_year() { return year; }
        void set_year(const int64_t & value) { this->year = value; }
    };

    class Details {
        public:
        Details() = default;
        virtual ~Details() = default;

        private:
        std::string applicationid;
        std::string applicationversion;
        int64_t code;
        Date date;
        int64_t elapsedtime;
        std::string message;
        std::string status;

        public:
        const std::string & get_applicationid() const { return applicationid; }
        std::string & get_mutable_applicationid() { return applicationid; }
        void set_applicationid(const std::string & value) { this->applicationid = value; }

        const std::string & get_applicationversion() const { return applicationversion; }
        std::string & get_mutable_applicationversion() { return applicationversion; }
        void set_applicationversion(const std::string & value) { this->applicationversion = value; }

        const int64_t & get_code() const { return code; }
        int64_t & get_mutable_code() { return code; }
        void set_code(const int64_t & value) { this->code = value; }

        const Date & get_date() const { return date; }
        Date & get_mutable_date() { return date; }
        void set_date(const Date & value) { this->date = value; }

        const int64_t & get_elapsedtime() const { return elapsedtime; }
        int64_t & get_mutable_elapsedtime() { return elapsedtime; }
        void set_elapsedtime(const int64_t & value) { this->elapsedtime = value; }

        const std::string & get_message() const { return message; }
        std::string & get_mutable_message() { return message; }
        void set_message(const std::string & value) { this->message = value; }

        const std::string & get_status() const { return status; }
        std::string & get_mutable_status() { return status; }
        void set_status(const std::string & value) { this->status = value; }
    };

    class Currency {
        public:
        Currency() = default;
        virtual ~Currency() = default;

        private:
        std::string abbreviation;

        public:
        const std::string & get_abbreviation() const { return abbreviation; }
        std::string & get_mutable_abbreviation() { return abbreviation; }
        void set_abbreviation(const std::string & value) { this->abbreviation = value; }
    };

    class Useraveragerating {
        public:
        Useraveragerating() = default;
        virtual ~Useraveragerating() = default;

        private:
        std::vector<LinkElement> links;
        int64_t numcomments;
        std::string rating;

        public:
        const std::vector<LinkElement> & get_links() const { return links; }
        std::vector<LinkElement> & get_mutable_links() { return links; }
        void set_links(const std::vector<LinkElement> & value) { this->links = value; }

        const int64_t & get_numcomments() const { return numcomments; }
        int64_t & get_mutable_numcomments() { return numcomments; }
        void set_numcomments(const int64_t & value) { this->numcomments = value; }

        const std::string & get_rating() const { return rating; }
        std::string & get_mutable_rating() { return rating; }
        void set_rating(const std::string & value) { this->rating = value; }
    };

    class Rating {
        public:
        Rating() = default;
        virtual ~Rating() = default;

        private:
        Useraveragerating useraveragerating;

        public:
        const Useraveragerating & get_useraveragerating() const { return useraveragerating; }
        Useraveragerating & get_mutable_useraveragerating() { return useraveragerating; }
        void set_useraveragerating(const Useraveragerating & value) { this->useraveragerating = value; }
    };

    class Specification {
        public:
        Specification() = default;
        virtual ~Specification() = default;

        private:
        std::vector<LinkElement> links;

        public:
        const std::vector<LinkElement> & get_links() const { return links; }
        std::vector<LinkElement> & get_mutable_links() { return links; }
        void set_links(const std::vector<LinkElement> & value) { this->links = value; }
    };

    class Format;

    class FormatsClass;

    class Format {
        public:
        Format() = default;
        virtual ~Format() = default;

        private:
        std::shared_ptr<FormatsClass> formats;

        public:
        const std::shared_ptr<FormatsClass> & get_formats() const { return formats; }
        std::shared_ptr<FormatsClass> & get_mutable_formats() { return formats; }
        void set_formats(const std::shared_ptr<FormatsClass> & value) { this->formats = value; }
    };

    class FormatsClass {
        public:
        FormatsClass() = default;
        virtual ~FormatsClass() = default;

        private:
        std::optional<std::vector<Format>> formats;
        int64_t height;
        std::string url;
        int64_t width;

        public:
        const std::optional<std::vector<Format>> & get_formats() const { return formats; }
        std::optional<std::vector<Format>> & get_mutable_formats() { return formats; }
        void set_formats(const std::optional<std::vector<Format>> & value) { this->formats = value; }

        const int64_t & get_height() const { return height; }
        int64_t & get_mutable_height() { return height; }
        void set_height(const int64_t & value) { this->height = value; }

        const std::string & get_url() const { return url; }
        std::string & get_mutable_url() { return url; }
        void set_url(const std::string & value) { this->url = value; }

        const int64_t & get_width() const { return width; }
        int64_t & get_mutable_width() { return width; }
        void set_width(const int64_t & value) { this->width = value; }
    };

    class ProductProduct {
        public:
        ProductProduct() = default;
        virtual ~ProductProduct() = default;

        private:
        int64_t categoryid;
        Currency currency;
        bool eco;
        bool fulldescription;
        bool hasmetasearch;
        int64_t id;
        std::vector<LinkElement> links;
        int64_t numoffers;
        std::string pricemax;
        std::string pricemin;
        std::string productname;
        int64_t quantity;
        Rating rating;
        Specification specification;
        std::shared_ptr<FormatsClass> thumbnail;
        int64_t totalsellers;

        public:
        const int64_t & get_categoryid() const { return categoryid; }
        int64_t & get_mutable_categoryid() { return categoryid; }
        void set_categoryid(const int64_t & value) { this->categoryid = value; }

        const Currency & get_currency() const { return currency; }
        Currency & get_mutable_currency() { return currency; }
        void set_currency(const Currency & value) { this->currency = value; }

        const bool & get_eco() const { return eco; }
        bool & get_mutable_eco() { return eco; }
        void set_eco(const bool & value) { this->eco = value; }

        const bool & get_fulldescription() const { return fulldescription; }
        bool & get_mutable_fulldescription() { return fulldescription; }
        void set_fulldescription(const bool & value) { this->fulldescription = value; }

        const bool & get_hasmetasearch() const { return hasmetasearch; }
        bool & get_mutable_hasmetasearch() { return hasmetasearch; }
        void set_hasmetasearch(const bool & value) { this->hasmetasearch = value; }

        const int64_t & get_id() const { return id; }
        int64_t & get_mutable_id() { return id; }
        void set_id(const int64_t & value) { this->id = value; }

        const std::vector<LinkElement> & get_links() const { return links; }
        std::vector<LinkElement> & get_mutable_links() { return links; }
        void set_links(const std::vector<LinkElement> & value) { this->links = value; }

        const int64_t & get_numoffers() const { return numoffers; }
        int64_t & get_mutable_numoffers() { return numoffers; }
        void set_numoffers(const int64_t & value) { this->numoffers = value; }

        const std::string & get_pricemax() const { return pricemax; }
        std::string & get_mutable_pricemax() { return pricemax; }
        void set_pricemax(const std::string & value) { this->pricemax = value; }

        const std::string & get_pricemin() const { return pricemin; }
        std::string & get_mutable_pricemin() { return pricemin; }
        void set_pricemin(const std::string & value) { this->pricemin = value; }

        const std::string & get_productname() const { return productname; }
        std::string & get_mutable_productname() { return productname; }
        void set_productname(const std::string & value) { this->productname = value; }

        const int64_t & get_quantity() const { return quantity; }
        int64_t & get_mutable_quantity() { return quantity; }
        void set_quantity(const int64_t & value) { this->quantity = value; }

        const Rating & get_rating() const { return rating; }
        Rating & get_mutable_rating() { return rating; }
        void set_rating(const Rating & value) { this->rating = value; }

        const Specification & get_specification() const { return specification; }
        Specification & get_mutable_specification() { return specification; }
        void set_specification(const Specification & value) { this->specification = value; }

        const std::shared_ptr<FormatsClass> & get_thumbnail() const { return thumbnail; }
        std::shared_ptr<FormatsClass> & get_mutable_thumbnail() { return thumbnail; }
        void set_thumbnail(const std::shared_ptr<FormatsClass> & value) { this->thumbnail = value; }

        const int64_t & get_totalsellers() const { return totalsellers; }
        int64_t & get_mutable_totalsellers() { return totalsellers; }
        void set_totalsellers(const int64_t & value) { this->totalsellers = value; }
    };

    class ProductElement {
        public:
        ProductElement() = default;
        virtual ~ProductElement() = default;

        private:
        ProductProduct product;

        public:
        const ProductProduct & get_product() const { return product; }
        ProductProduct & get_mutable_product() { return product; }
        void set_product(const ProductProduct & value) { this->product = value; }
    };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        Category category;
        Details details;
        std::string match;
        int64_t page;
        std::vector<ProductElement> product;
        bool schk;
        int64_t totallooseoffers;
        int64_t totalpages;
        int64_t totalresultsavailable;
        int64_t totalresultsreturned;

        public:
        const Category & get_category() const { return category; }
        Category & get_mutable_category() { return category; }
        void set_category(const Category & value) { this->category = value; }

        const Details & get_details() const { return details; }
        Details & get_mutable_details() { return details; }
        void set_details(const Details & value) { this->details = value; }

        const std::string & get_match() const { return match; }
        std::string & get_mutable_match() { return match; }
        void set_match(const std::string & value) { this->match = value; }

        const int64_t & get_page() const { return page; }
        int64_t & get_mutable_page() { return page; }
        void set_page(const int64_t & value) { this->page = value; }

        const std::vector<ProductElement> & get_product() const { return product; }
        std::vector<ProductElement> & get_mutable_product() { return product; }
        void set_product(const std::vector<ProductElement> & value) { this->product = value; }

        const bool & get_schk() const { return schk; }
        bool & get_mutable_schk() { return schk; }
        void set_schk(const bool & value) { this->schk = value; }

        const int64_t & get_totallooseoffers() const { return totallooseoffers; }
        int64_t & get_mutable_totallooseoffers() { return totallooseoffers; }
        void set_totallooseoffers(const int64_t & value) { this->totallooseoffers = value; }

        const int64_t & get_totalpages() const { return totalpages; }
        int64_t & get_mutable_totalpages() { return totalpages; }
        void set_totalpages(const int64_t & value) { this->totalpages = value; }

        const int64_t & get_totalresultsavailable() const { return totalresultsavailable; }
        int64_t & get_mutable_totalresultsavailable() { return totalresultsavailable; }
        void set_totalresultsavailable(const int64_t & value) { this->totalresultsavailable = value; }

        const int64_t & get_totalresultsreturned() const { return totalresultsreturned; }
        int64_t & get_mutable_totalresultsreturned() { return totalresultsreturned; }
        void set_totalresultsreturned(const int64_t & value) { this->totalresultsreturned = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, LinkLink & x);
    void to_json(json & j, const LinkLink & x);

    void from_json(const json & j, LinkElement & x);
    void to_json(json & j, const LinkElement & x);

    void from_json(const json & j, CategoryThumbnail & x);
    void to_json(json & j, const CategoryThumbnail & x);

    void from_json(const json & j, Category & x);
    void to_json(json & j, const Category & x);

    void from_json(const json & j, Eonandyear & x);
    void to_json(json & j, const Eonandyear & x);

    void from_json(const json & j, Xmlschematype & x);
    void to_json(json & j, const Xmlschematype & x);

    void from_json(const json & j, Date & x);
    void to_json(json & j, const Date & x);

    void from_json(const json & j, Details & x);
    void to_json(json & j, const Details & x);

    void from_json(const json & j, Currency & x);
    void to_json(json & j, const Currency & x);

    void from_json(const json & j, Useraveragerating & x);
    void to_json(json & j, const Useraveragerating & x);

    void from_json(const json & j, Rating & x);
    void to_json(json & j, const Rating & x);

    void from_json(const json & j, Specification & x);
    void to_json(json & j, const Specification & x);

    void from_json(const json & j, Format & x);
    void to_json(json & j, const Format & x);

    void from_json(const json & j, FormatsClass & x);
    void to_json(json & j, const FormatsClass & x);

    void from_json(const json & j, ProductProduct & x);
    void to_json(json & j, const ProductProduct & x);

    void from_json(const json & j, ProductElement & x);
    void to_json(json & j, const ProductElement & x);

    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    inline void from_json(const json & j, LinkLink& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_type(j.at("type").get<std::string>());
        x.set_url(j.at("url").get<std::string>());
    }

    inline void to_json(json & j, const LinkLink & x) {
        j = json::object();
        j["type"] = x.get_type();
        j["url"] = x.get_url();
    }

    inline void from_json(const json & j, LinkElement& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_link(j.at("link").get<LinkLink>());
    }

    inline void to_json(json & j, const LinkElement & x) {
        j = json::object();
        j["link"] = x.get_link();
    }

    inline void from_json(const json & j, CategoryThumbnail& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_url(j.at("url").get<std::string>());
    }

    inline void to_json(json & j, const CategoryThumbnail & x) {
        j = json::object();
        j["url"] = x.get_url();
    }

    inline void from_json(const json & j, Category& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_concatenatecategoryname(j.at("concatenatecategoryname").get<bool>());
        x.set_hasoffer(j.at("hasoffer").get<bool>());
        if (j.find("id") != j.end() && !j.at("id").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_id(j.at("id").get<int64_t>());
        x.set_isfinal(j.at("isfinal").get<bool>());
        x.set_links(j.at("links").get<std::vector<LinkElement>>());
        x.set_name(j.at("name").get<std::string>());
        if (j.find("parentcategoryid") != j.end() && !j.at("parentcategoryid").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_parentcategoryid(j.at("parentcategoryid").get<int64_t>());
        x.set_thumbnail(j.at("thumbnail").get<CategoryThumbnail>());
    }

    inline void to_json(json & j, const Category & x) {
        j = json::object();
        j["concatenatecategoryname"] = x.get_concatenatecategoryname();
        j["hasoffer"] = x.get_hasoffer();
        j["id"] = x.get_id();
        j["isfinal"] = x.get_isfinal();
        j["links"] = x.get_links();
        j["name"] = x.get_name();
        j["parentcategoryid"] = x.get_parentcategoryid();
        j["thumbnail"] = x.get_thumbnail();
    }

    inline void from_json(const json & j, Eonandyear& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("lowestsetbit") != j.end() && !j.at("lowestsetbit").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_lowestsetbit(j.at("lowestsetbit").get<int64_t>());
    }

    inline void to_json(json & j, const Eonandyear & x) {
        j = json::object();
        j["lowestsetbit"] = x.get_lowestsetbit();
    }

    inline void from_json(const json & j, Xmlschematype& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_localpart(j.at("localpart").get<std::string>());
        x.set_namespaceuri(j.at("namespaceuri").get<std::string>());
        x.set_prefix(j.at("prefix").get<std::string>());
    }

    inline void to_json(json & j, const Xmlschematype & x) {
        j = json::object();
        j["localpart"] = x.get_localpart();
        j["namespaceuri"] = x.get_namespaceuri();
        j["prefix"] = x.get_prefix();
    }

    inline void from_json(const json & j, Date& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("day") != j.end() && !j.at("day").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_day(j.at("day").get<int64_t>());
        x.set_eonandyear(j.at("eonandyear").get<Eonandyear>());
        if (j.find("hour") != j.end() && !j.at("hour").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_hour(j.at("hour").get<int64_t>());
        if (j.find("millisecond") != j.end() && !j.at("millisecond").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_millisecond(j.at("millisecond").get<int64_t>());
        if (j.find("minute") != j.end() && !j.at("minute").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_minute(j.at("minute").get<int64_t>());
        if (j.find("month") != j.end() && !j.at("month").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_month(j.at("month").get<int64_t>());
        if (j.find("second") != j.end() && !j.at("second").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_second(j.at("second").get<int64_t>());
        if (j.find("timezone") != j.end() && !j.at("timezone").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_timezone(j.at("timezone").get<int64_t>());
        x.set_valid(j.at("valid").get<bool>());
        x.set_xmlschematype(j.at("xmlschematype").get<Xmlschematype>());
        if (j.find("year") != j.end() && !j.at("year").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_year(j.at("year").get<int64_t>());
    }

    inline void to_json(json & j, const Date & x) {
        j = json::object();
        j["day"] = x.get_day();
        j["eonandyear"] = x.get_eonandyear();
        j["hour"] = x.get_hour();
        j["millisecond"] = x.get_millisecond();
        j["minute"] = x.get_minute();
        j["month"] = x.get_month();
        j["second"] = x.get_second();
        j["timezone"] = x.get_timezone();
        j["valid"] = x.get_valid();
        j["xmlschematype"] = x.get_xmlschematype();
        j["year"] = x.get_year();
    }

    inline void from_json(const json & j, Details& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_applicationid(j.at("applicationid").get<std::string>());
        x.set_applicationversion(j.at("applicationversion").get<std::string>());
        if (j.find("code") != j.end() && !j.at("code").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_code(j.at("code").get<int64_t>());
        x.set_date(j.at("date").get<Date>());
        if (j.find("elapsedtime") != j.end() && !j.at("elapsedtime").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_elapsedtime(j.at("elapsedtime").get<int64_t>());
        x.set_message(j.at("message").get<std::string>());
        x.set_status(j.at("status").get<std::string>());
    }

    inline void to_json(json & j, const Details & x) {
        j = json::object();
        j["applicationid"] = x.get_applicationid();
        j["applicationversion"] = x.get_applicationversion();
        j["code"] = x.get_code();
        j["date"] = x.get_date();
        j["elapsedtime"] = x.get_elapsedtime();
        j["message"] = x.get_message();
        j["status"] = x.get_status();
    }

    inline void from_json(const json & j, Currency& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_abbreviation(j.at("abbreviation").get<std::string>());
    }

    inline void to_json(json & j, const Currency & x) {
        j = json::object();
        j["abbreviation"] = x.get_abbreviation();
    }

    inline void from_json(const json & j, Useraveragerating& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_links(j.at("links").get<std::vector<LinkElement>>());
        if (j.find("numcomments") != j.end() && !j.at("numcomments").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_numcomments(j.at("numcomments").get<int64_t>());
        x.set_rating(j.at("rating").get<std::string>());
    }

    inline void to_json(json & j, const Useraveragerating & x) {
        j = json::object();
        j["links"] = x.get_links();
        j["numcomments"] = x.get_numcomments();
        j["rating"] = x.get_rating();
    }

    inline void from_json(const json & j, Rating& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_useraveragerating(j.at("useraveragerating").get<Useraveragerating>());
    }

    inline void to_json(json & j, const Rating & x) {
        j = json::object();
        j["useraveragerating"] = x.get_useraveragerating();
    }

    inline void from_json(const json & j, Specification& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_links(j.at("links").get<std::vector<LinkElement>>());
    }

    inline void to_json(json & j, const Specification & x) {
        j = json::object();
        j["links"] = x.get_links();
    }

    inline void from_json(const json & j, Format& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_formats(j.at("formats").get<std::shared_ptr<FormatsClass>>());
    }

    inline void to_json(json & j, const Format & x) {
        j = json::object();
        j["formats"] = x.get_formats();
    }

    inline void from_json(const json & j, FormatsClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("formats") != j.end() && j.at("formats").is_null()) throw std::runtime_error("Unexpected null");
        x.set_formats(get_stack_optional<std::vector<Format>>(j, "formats"));
        if (j.find("height") != j.end() && !j.at("height").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_height(j.at("height").get<int64_t>());
        x.set_url(j.at("url").get<std::string>());
        if (j.find("width") != j.end() && !j.at("width").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_width(j.at("width").get<int64_t>());
    }

    inline void to_json(json & j, const FormatsClass & x) {
        j = json::object();
        j["formats"] = x.get_formats();
        j["height"] = x.get_height();
        j["url"] = x.get_url();
        j["width"] = x.get_width();
    }

    inline void from_json(const json & j, ProductProduct& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("categoryid") != j.end() && !j.at("categoryid").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_categoryid(j.at("categoryid").get<int64_t>());
        x.set_currency(j.at("currency").get<Currency>());
        x.set_eco(j.at("eco").get<bool>());
        x.set_fulldescription(j.at("fulldescription").get<bool>());
        x.set_hasmetasearch(j.at("hasmetasearch").get<bool>());
        if (j.find("id") != j.end() && !j.at("id").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_id(j.at("id").get<int64_t>());
        x.set_links(j.at("links").get<std::vector<LinkElement>>());
        if (j.find("numoffers") != j.end() && !j.at("numoffers").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_numoffers(j.at("numoffers").get<int64_t>());
        x.set_pricemax(j.at("pricemax").get<std::string>());
        x.set_pricemin(j.at("pricemin").get<std::string>());
        x.set_productname(j.at("productname").get<std::string>());
        if (j.find("quantity") != j.end() && !j.at("quantity").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_quantity(j.at("quantity").get<int64_t>());
        x.set_rating(j.at("rating").get<Rating>());
        x.set_specification(j.at("specification").get<Specification>());
        x.set_thumbnail(j.at("thumbnail").get<std::shared_ptr<FormatsClass>>());
        if (j.find("totalsellers") != j.end() && !j.at("totalsellers").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_totalsellers(j.at("totalsellers").get<int64_t>());
    }

    inline void to_json(json & j, const ProductProduct & x) {
        j = json::object();
        j["categoryid"] = x.get_categoryid();
        j["currency"] = x.get_currency();
        j["eco"] = x.get_eco();
        j["fulldescription"] = x.get_fulldescription();
        j["hasmetasearch"] = x.get_hasmetasearch();
        j["id"] = x.get_id();
        j["links"] = x.get_links();
        j["numoffers"] = x.get_numoffers();
        j["pricemax"] = x.get_pricemax();
        j["pricemin"] = x.get_pricemin();
        j["productname"] = x.get_productname();
        j["quantity"] = x.get_quantity();
        j["rating"] = x.get_rating();
        j["specification"] = x.get_specification();
        j["thumbnail"] = x.get_thumbnail();
        j["totalsellers"] = x.get_totalsellers();
    }

    inline void from_json(const json & j, ProductElement& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_product(j.at("product").get<ProductProduct>());
    }

    inline void to_json(json & j, const ProductElement & x) {
        j = json::object();
        j["product"] = x.get_product();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_category(j.at("category").get<Category>());
        x.set_details(j.at("details").get<Details>());
        x.set_match(j.at("match").get<std::string>());
        if (j.find("page") != j.end() && !j.at("page").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_page(j.at("page").get<int64_t>());
        x.set_product(j.at("product").get<std::vector<ProductElement>>());
        x.set_schk(j.at("schk").get<bool>());
        if (j.find("totallooseoffers") != j.end() && !j.at("totallooseoffers").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_totallooseoffers(j.at("totallooseoffers").get<int64_t>());
        if (j.find("totalpages") != j.end() && !j.at("totalpages").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_totalpages(j.at("totalpages").get<int64_t>());
        if (j.find("totalresultsavailable") != j.end() && !j.at("totalresultsavailable").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_totalresultsavailable(j.at("totalresultsavailable").get<int64_t>());
        if (j.find("totalresultsreturned") != j.end() && !j.at("totalresultsreturned").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_totalresultsreturned(j.at("totalresultsreturned").get<int64_t>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["category"] = x.get_category();
        j["details"] = x.get_details();
        j["match"] = x.get_match();
        j["page"] = x.get_page();
        j["product"] = x.get_product();
        j["schk"] = x.get_schk();
        j["totallooseoffers"] = x.get_totallooseoffers();
        j["totalpages"] = x.get_totalpages();
        j["totalresultsavailable"] = x.get_totalresultsavailable();
        j["totalresultsreturned"] = x.get_totalresultsreturned();
    }
}
