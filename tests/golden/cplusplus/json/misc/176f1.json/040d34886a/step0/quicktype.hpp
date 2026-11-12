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

    class Footnote {
        public:
        Footnote() = default;
        virtual ~Footnote() = default;

        private:
        std::optional<std::string> code;
        std::optional<std::string> text;

        public:
        const std::optional<std::string> & get_code() const { return code; }
        std::optional<std::string> & get_mutable_code() { return code; }
        void set_code(const std::optional<std::string> & value) { this->code = value; }

        const std::optional<std::string> & get_text() const { return text; }
        std::optional<std::string> & get_mutable_text() { return text; }
        void set_text(const std::optional<std::string> & value) { this->text = value; }
    };

    class Datum {
        public:
        Datum() = default;
        virtual ~Datum() = default;

        private:
        std::vector<Footnote> footnotes;
        std::string period;
        std::string period_name;
        std::string value;
        std::string year;

        public:
        const std::vector<Footnote> & get_footnotes() const { return footnotes; }
        std::vector<Footnote> & get_mutable_footnotes() { return footnotes; }
        void set_footnotes(const std::vector<Footnote> & value) { this->footnotes = value; }

        const std::string & get_period() const { return period; }
        std::string & get_mutable_period() { return period; }
        void set_period(const std::string & value) { this->period = value; }

        const std::string & get_period_name() const { return period_name; }
        std::string & get_mutable_period_name() { return period_name; }
        void set_period_name(const std::string & value) { this->period_name = value; }

        const std::string & get_value() const { return value; }
        std::string & get_mutable_value() { return value; }
        void set_value(const std::string & value) { this->value = value; }

        const std::string & get_year() const { return year; }
        std::string & get_mutable_year() { return year; }
        void set_year(const std::string & value) { this->year = value; }
    };

    class Series {
        public:
        Series() = default;
        virtual ~Series() = default;

        private:
        std::vector<Datum> data;
        std::string series_id;

        public:
        const std::vector<Datum> & get_data() const { return data; }
        std::vector<Datum> & get_mutable_data() { return data; }
        void set_data(const std::vector<Datum> & value) { this->data = value; }

        const std::string & get_series_id() const { return series_id; }
        std::string & get_mutable_series_id() { return series_id; }
        void set_series_id(const std::string & value) { this->series_id = value; }
    };

    class Results {
        public:
        Results() = default;
        virtual ~Results() = default;

        private:
        std::vector<Series> series;

        public:
        const std::vector<Series> & get_series() const { return series; }
        std::vector<Series> & get_mutable_series() { return series; }
        void set_series(const std::vector<Series> & value) { this->series = value; }
    };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        std::vector<nlohmann::json> message;
        int64_t response_time;
        Results results;
        std::string status;

        public:
        const std::vector<nlohmann::json> & get_message() const { return message; }
        std::vector<nlohmann::json> & get_mutable_message() { return message; }
        void set_message(const std::vector<nlohmann::json> & value) { this->message = value; }

        const int64_t & get_response_time() const { return response_time; }
        int64_t & get_mutable_response_time() { return response_time; }
        void set_response_time(const int64_t & value) { this->response_time = value; }

        const Results & get_results() const { return results; }
        Results & get_mutable_results() { return results; }
        void set_results(const Results & value) { this->results = value; }

        const std::string & get_status() const { return status; }
        std::string & get_mutable_status() { return status; }
        void set_status(const std::string & value) { this->status = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, Footnote & x);
    void to_json(json & j, const Footnote & x);

    void from_json(const json & j, Datum & x);
    void to_json(json & j, const Datum & x);

    void from_json(const json & j, Series & x);
    void to_json(json & j, const Series & x);

    void from_json(const json & j, Results & x);
    void to_json(json & j, const Results & x);

    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    inline void from_json(const json & j, Footnote& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("code") != j.end() && j.at("code").is_null()) throw std::runtime_error("Unexpected null");
        x.set_code(get_stack_optional<std::string>(j, "code"));
        if (j.find("text") != j.end() && j.at("text").is_null()) throw std::runtime_error("Unexpected null");
        x.set_text(get_stack_optional<std::string>(j, "text"));
    }

    inline void to_json(json & j, const Footnote & x) {
        j = json::object();
        j["code"] = x.get_code();
        j["text"] = x.get_text();
    }

    inline void from_json(const json & j, Datum& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_footnotes(j.at("footnotes").get<std::vector<Footnote>>());
        x.set_period(j.at("period").get<std::string>());
        x.set_period_name(j.at("periodName").get<std::string>());
        x.set_value(j.at("value").get<std::string>());
        x.set_year(j.at("year").get<std::string>());
    }

    inline void to_json(json & j, const Datum & x) {
        j = json::object();
        j["footnotes"] = x.get_footnotes();
        j["period"] = x.get_period();
        j["periodName"] = x.get_period_name();
        j["value"] = x.get_value();
        j["year"] = x.get_year();
    }

    inline void from_json(const json & j, Series& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_data(j.at("data").get<std::vector<Datum>>());
        x.set_series_id(j.at("seriesID").get<std::string>());
    }

    inline void to_json(json & j, const Series & x) {
        j = json::object();
        j["data"] = x.get_data();
        j["seriesID"] = x.get_series_id();
    }

    inline void from_json(const json & j, Results& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_series(j.at("series").get<std::vector<Series>>());
    }

    inline void to_json(json & j, const Results & x) {
        j = json::object();
        j["series"] = x.get_series();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_message(j.at("message").get<std::vector<nlohmann::json>>());
        if (j.find("responseTime") != j.end() && !j.at("responseTime").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_response_time(j.at("responseTime").get<int64_t>());
        x.set_results(j.at("Results").get<Results>());
        x.set_status(j.at("status").get<std::string>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["message"] = x.get_message();
        j["responseTime"] = x.get_response_time();
        j["Results"] = x.get_results();
        j["status"] = x.get_status();
    }
}
