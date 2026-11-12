//  To parse this JSON data, first install
//
//      json.hpp  https://github.com/nlohmann/json
//
//  Then include this file, and then do
//
//     TopLevel data = nlohmann::json::parse(jsonString);

#pragma once

#include "json.hpp"

#include <optional>
#include <stdexcept>
#include <regex>

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

    enum class Scheme : int { SPDX, TROVE, DEP5 };

    class Identifier {
        public:
        Identifier() = default;
        virtual ~Identifier() = default;

        private:
        std::string identifier;
        Scheme scheme;

        public:
        const std::string & get_identifier() const { return identifier; }
        std::string & get_mutable_identifier() { return identifier; }
        void set_identifier(const std::string & value) { this->identifier = value; }

        const Scheme & get_scheme() const { return scheme; }
        Scheme & get_mutable_scheme() { return scheme; }
        void set_scheme(const Scheme & value) { this->scheme = value; }
    };

    enum class Keyword : int { DISCOURAGED, NON_REUSABLE, OSI_APPROVED };

    enum class Note : int { OSI_PAGE };

    class Link {
        public:
        Link() = default;
        virtual ~Link() = default;

        private:
        Note note;
        std::string url;

        public:
        const Note & get_note() const { return note; }
        Note & get_mutable_note() { return note; }
        void set_note(const Note & value) { this->note = value; }

        const std::string & get_url() const { return url; }
        std::string & get_mutable_url() { return url; }
        void set_url(const std::string & value) { this->url = value; }
    };

    enum class MediaType : int { TEXT_HTML };

    enum class Title : int { HTML };

    class Text {
        public:
        Text() = default;
        virtual ~Text() = default;

        private:
        MediaType media_type;
        Title title;
        std::string url;

        public:
        const MediaType & get_media_type() const { return media_type; }
        MediaType & get_mutable_media_type() { return media_type; }
        void set_media_type(const MediaType & value) { this->media_type = value; }

        const Title & get_title() const { return title; }
        Title & get_mutable_title() { return title; }
        void set_title(const Title & value) { this->title = value; }

        const std::string & get_url() const { return url; }
        std::string & get_mutable_url() { return url; }
        void set_url(const std::string & value) { this->url = value; }
    };

    class TopLevelElement {
        public:
        TopLevelElement() = default;
        virtual ~TopLevelElement() = default;

        private:
        std::string id;
        std::vector<Identifier> identifiers;
        std::vector<Keyword> keywords;
        std::vector<Link> links;
        std::string name;
        std::vector<nlohmann::json> other_names;
        nlohmann::json superseded_by;
        std::vector<Text> text;

        public:
        const std::string & get_id() const { return id; }
        std::string & get_mutable_id() { return id; }
        void set_id(const std::string & value) { this->id = value; }

        const std::vector<Identifier> & get_identifiers() const { return identifiers; }
        std::vector<Identifier> & get_mutable_identifiers() { return identifiers; }
        void set_identifiers(const std::vector<Identifier> & value) { this->identifiers = value; }

        const std::vector<Keyword> & get_keywords() const { return keywords; }
        std::vector<Keyword> & get_mutable_keywords() { return keywords; }
        void set_keywords(const std::vector<Keyword> & value) { this->keywords = value; }

        const std::vector<Link> & get_links() const { return links; }
        std::vector<Link> & get_mutable_links() { return links; }
        void set_links(const std::vector<Link> & value) { this->links = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const std::vector<nlohmann::json> & get_other_names() const { return other_names; }
        std::vector<nlohmann::json> & get_mutable_other_names() { return other_names; }
        void set_other_names(const std::vector<nlohmann::json> & value) { this->other_names = value; }

        const nlohmann::json & get_superseded_by() const { return superseded_by; }
        nlohmann::json & get_mutable_superseded_by() { return superseded_by; }
        void set_superseded_by(const nlohmann::json & value) { this->superseded_by = value; }

        const std::vector<Text> & get_text() const { return text; }
        std::vector<Text> & get_mutable_text() { return text; }
        void set_text(const std::vector<Text> & value) { this->text = value; }
    };

    using TopLevel = std::vector<TopLevelElement>;
}

namespace quicktype {
    void from_json(const json & j, Identifier & x);
    void to_json(json & j, const Identifier & x);

    void from_json(const json & j, Link & x);
    void to_json(json & j, const Link & x);

    void from_json(const json & j, Text & x);
    void to_json(json & j, const Text & x);

    void from_json(const json & j, TopLevelElement & x);
    void to_json(json & j, const TopLevelElement & x);

    void from_json(const json & j, Scheme & x);
    void to_json(json & j, const Scheme & x);

    void from_json(const json & j, Keyword & x);
    void to_json(json & j, const Keyword & x);

    void from_json(const json & j, Note & x);
    void to_json(json & j, const Note & x);

    void from_json(const json & j, MediaType & x);
    void to_json(json & j, const MediaType & x);

    void from_json(const json & j, Title & x);
    void to_json(json & j, const Title & x);

    inline void from_json(const json & j, Identifier& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_identifier(j.at("identifier").get<std::string>());
        x.set_scheme(j.at("scheme").get<Scheme>());
    }

    inline void to_json(json & j, const Identifier & x) {
        j = json::object();
        j["identifier"] = x.get_identifier();
        j["scheme"] = x.get_scheme();
    }

    inline void from_json(const json & j, Link& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_note(j.at("note").get<Note>());
        x.set_url(j.at("url").get<std::string>());
    }

    inline void to_json(json & j, const Link & x) {
        j = json::object();
        j["note"] = x.get_note();
        j["url"] = x.get_url();
    }

    inline void from_json(const json & j, Text& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_media_type(j.at("media_type").get<MediaType>());
        x.set_title(j.at("title").get<Title>());
        x.set_url(j.at("url").get<std::string>());
    }

    inline void to_json(json & j, const Text & x) {
        j = json::object();
        j["media_type"] = x.get_media_type();
        j["title"] = x.get_title();
        j["url"] = x.get_url();
    }

    inline void from_json(const json & j, TopLevelElement& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_id(j.at("id").get<std::string>());
        x.set_identifiers(j.at("identifiers").get<std::vector<Identifier>>());
        x.set_keywords(j.at("keywords").get<std::vector<Keyword>>());
        x.set_links(j.at("links").get<std::vector<Link>>());
        x.set_name(j.at("name").get<std::string>());
        x.set_other_names(j.at("other_names").get<std::vector<nlohmann::json>>());
        x.set_superseded_by(get_untyped(j, "superseded_by"));
        x.set_text(j.at("text").get<std::vector<Text>>());
    }

    inline void to_json(json & j, const TopLevelElement & x) {
        j = json::object();
        j["id"] = x.get_id();
        j["identifiers"] = x.get_identifiers();
        j["keywords"] = x.get_keywords();
        j["links"] = x.get_links();
        j["name"] = x.get_name();
        j["other_names"] = x.get_other_names();
        j["superseded_by"] = x.get_superseded_by();
        j["text"] = x.get_text();
    }

    inline void from_json(const json & j, Scheme & x) {
        if (j == "SPDX") x = Scheme::SPDX;
        else if (j == "Trove") x = Scheme::TROVE;
        else if (j == "DEP5") x = Scheme::DEP5;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Scheme\""); }
    }

    inline void to_json(json & j, const Scheme & x) {
        switch (x) {
            case Scheme::SPDX: j = "SPDX"; break;
            case Scheme::TROVE: j = "Trove"; break;
            case Scheme::DEP5: j = "DEP5"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Scheme\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, Keyword & x) {
        if (j == "discouraged") x = Keyword::DISCOURAGED;
        else if (j == "non-reusable") x = Keyword::NON_REUSABLE;
        else if (j == "osi-approved") x = Keyword::OSI_APPROVED;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Keyword\""); }
    }

    inline void to_json(json & j, const Keyword & x) {
        switch (x) {
            case Keyword::DISCOURAGED: j = "discouraged"; break;
            case Keyword::NON_REUSABLE: j = "non-reusable"; break;
            case Keyword::OSI_APPROVED: j = "osi-approved"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Keyword\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, Note & x) {
        if (j == "OSI Page") x = Note::OSI_PAGE;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Note\""); }
    }

    inline void to_json(json & j, const Note & x) {
        switch (x) {
            case Note::OSI_PAGE: j = "OSI Page"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Note\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, MediaType & x) {
        if (j == "text/html") x = MediaType::TEXT_HTML;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"MediaType\""); }
    }

    inline void to_json(json & j, const MediaType & x) {
        switch (x) {
            case MediaType::TEXT_HTML: j = "text/html"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"MediaType\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, Title & x) {
        if (j == "HTML") x = Title::HTML;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Title\""); }
    }

    inline void to_json(json & j, const Title & x) {
        switch (x) {
            case Title::HTML: j = "HTML"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Title\": " + std::to_string(static_cast<int>(x)));
        }
    }
}
