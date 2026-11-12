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

    class Meta {
        public:
        Meta() = default;
        virtual ~Meta() = default;

        private:
        int64_t limit;
        int64_t offset;
        int64_t total_count;

        public:
        const int64_t & get_limit() const { return limit; }
        int64_t & get_mutable_limit() { return limit; }
        void set_limit(const int64_t & value) { this->limit = value; }

        const int64_t & get_offset() const { return offset; }
        int64_t & get_mutable_offset() { return offset; }
        void set_offset(const int64_t & value) { this->offset = value; }

        const int64_t & get_total_count() const { return total_count; }
        int64_t & get_mutable_total_count() { return total_count; }
        void set_total_count(const int64_t & value) { this->total_count = value; }
    };

    class Extra {
        public:
        Extra() = default;
        virtual ~Extra() = default;

        private:
        std::string address;
        std::optional<std::string> contact_form;
        std::optional<std::string> fax;
        std::string office;
        std::optional<std::string> rss_url;

        public:
        const std::string & get_address() const { return address; }
        std::string & get_mutable_address() { return address; }
        void set_address(const std::string & value) { this->address = value; }

        const std::optional<std::string> & get_contact_form() const { return contact_form; }
        std::optional<std::string> & get_mutable_contact_form() { return contact_form; }
        void set_contact_form(const std::optional<std::string> & value) { this->contact_form = value; }

        std::optional<std::string> get_fax() const { return fax; }
        void set_fax(std::optional<std::string> value) { this->fax = value; }

        const std::string & get_office() const { return office; }
        std::string & get_mutable_office() { return office; }
        void set_office(const std::string & value) { this->office = value; }

        const std::optional<std::string> & get_rss_url() const { return rss_url; }
        std::optional<std::string> & get_mutable_rss_url() { return rss_url; }
        void set_rss_url(const std::optional<std::string> & value) { this->rss_url = value; }
    };

    enum class Party : int { REPUBLICAN, DEMOCRAT };

    enum class Gender : int { MALE, FEMALE };

    enum class GenderLabel : int { MALE, FEMALE };

    enum class Namemod : int { EMPTY, JR, II, III, IV };

    class Person {
        public:
        Person() = default;
        virtual ~Person() = default;

        private:
        std::string bioguideid;
        std::string birthday;
        int64_t cspanid;
        std::string firstname;
        Gender gender;
        GenderLabel gender_label;
        int64_t id;
        std::string lastname;
        std::string link;
        std::string middlename;
        std::string name;
        Namemod namemod;
        std::string nickname;
        std::string osid;
        std::optional<std::string> pvsid;
        std::string sortname;
        std::optional<std::string> twitterid;
        std::optional<std::string> youtubeid;

        public:
        const std::string & get_bioguideid() const { return bioguideid; }
        std::string & get_mutable_bioguideid() { return bioguideid; }
        void set_bioguideid(const std::string & value) { this->bioguideid = value; }

        const std::string & get_birthday() const { return birthday; }
        std::string & get_mutable_birthday() { return birthday; }
        void set_birthday(const std::string & value) { this->birthday = value; }

        const int64_t & get_cspanid() const { return cspanid; }
        int64_t & get_mutable_cspanid() { return cspanid; }
        void set_cspanid(const int64_t & value) { this->cspanid = value; }

        const std::string & get_firstname() const { return firstname; }
        std::string & get_mutable_firstname() { return firstname; }
        void set_firstname(const std::string & value) { this->firstname = value; }

        const Gender & get_gender() const { return gender; }
        Gender & get_mutable_gender() { return gender; }
        void set_gender(const Gender & value) { this->gender = value; }

        const GenderLabel & get_gender_label() const { return gender_label; }
        GenderLabel & get_mutable_gender_label() { return gender_label; }
        void set_gender_label(const GenderLabel & value) { this->gender_label = value; }

        const int64_t & get_id() const { return id; }
        int64_t & get_mutable_id() { return id; }
        void set_id(const int64_t & value) { this->id = value; }

        const std::string & get_lastname() const { return lastname; }
        std::string & get_mutable_lastname() { return lastname; }
        void set_lastname(const std::string & value) { this->lastname = value; }

        const std::string & get_link() const { return link; }
        std::string & get_mutable_link() { return link; }
        void set_link(const std::string & value) { this->link = value; }

        const std::string & get_middlename() const { return middlename; }
        std::string & get_mutable_middlename() { return middlename; }
        void set_middlename(const std::string & value) { this->middlename = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const Namemod & get_namemod() const { return namemod; }
        Namemod & get_mutable_namemod() { return namemod; }
        void set_namemod(const Namemod & value) { this->namemod = value; }

        const std::string & get_nickname() const { return nickname; }
        std::string & get_mutable_nickname() { return nickname; }
        void set_nickname(const std::string & value) { this->nickname = value; }

        const std::string & get_osid() const { return osid; }
        std::string & get_mutable_osid() { return osid; }
        void set_osid(const std::string & value) { this->osid = value; }

        std::optional<std::string> get_pvsid() const { return pvsid; }
        void set_pvsid(std::optional<std::string> value) { this->pvsid = value; }

        const std::string & get_sortname() const { return sortname; }
        std::string & get_mutable_sortname() { return sortname; }
        void set_sortname(const std::string & value) { this->sortname = value; }

        std::optional<std::string> get_twitterid() const { return twitterid; }
        void set_twitterid(std::optional<std::string> value) { this->twitterid = value; }

        std::optional<std::string> get_youtubeid() const { return youtubeid; }
        void set_youtubeid(std::optional<std::string> value) { this->youtubeid = value; }
    };

    enum class RoleType : int { REPRESENTATIVE };

    enum class RoleTypeLabel : int { REPRESENTATIVE, DELEGATE, RESIDENT_COMMISSIONER };

    enum class Title : int { REP, COMMISH };

    class Object {
        public:
        Object() = default;
        virtual ~Object() = default;

        private:
        nlohmann::json caucus;
        std::vector<int64_t> congress_numbers;
        bool current;
        std::string description;
        int64_t district;
        std::string enddate;
        Extra extra;
        int64_t id;
        std::optional<std::string> leadership_title;
        Party party;
        Person person;
        std::string phone;
        RoleType role_type;
        RoleTypeLabel role_type_label;
        nlohmann::json senator_class;
        nlohmann::json senator_rank;
        std::string startdate;
        std::string state;
        Title title;
        RoleTypeLabel title_long;
        std::string website;

        public:
        const nlohmann::json & get_caucus() const { return caucus; }
        nlohmann::json & get_mutable_caucus() { return caucus; }
        void set_caucus(const nlohmann::json & value) { this->caucus = value; }

        const std::vector<int64_t> & get_congress_numbers() const { return congress_numbers; }
        std::vector<int64_t> & get_mutable_congress_numbers() { return congress_numbers; }
        void set_congress_numbers(const std::vector<int64_t> & value) { this->congress_numbers = value; }

        const bool & get_current() const { return current; }
        bool & get_mutable_current() { return current; }
        void set_current(const bool & value) { this->current = value; }

        const std::string & get_description() const { return description; }
        std::string & get_mutable_description() { return description; }
        void set_description(const std::string & value) { this->description = value; }

        const int64_t & get_district() const { return district; }
        int64_t & get_mutable_district() { return district; }
        void set_district(const int64_t & value) { this->district = value; }

        const std::string & get_enddate() const { return enddate; }
        std::string & get_mutable_enddate() { return enddate; }
        void set_enddate(const std::string & value) { this->enddate = value; }

        const Extra & get_extra() const { return extra; }
        Extra & get_mutable_extra() { return extra; }
        void set_extra(const Extra & value) { this->extra = value; }

        const int64_t & get_id() const { return id; }
        int64_t & get_mutable_id() { return id; }
        void set_id(const int64_t & value) { this->id = value; }

        std::optional<std::string> get_leadership_title() const { return leadership_title; }
        void set_leadership_title(std::optional<std::string> value) { this->leadership_title = value; }

        const Party & get_party() const { return party; }
        Party & get_mutable_party() { return party; }
        void set_party(const Party & value) { this->party = value; }

        const Person & get_person() const { return person; }
        Person & get_mutable_person() { return person; }
        void set_person(const Person & value) { this->person = value; }

        const std::string & get_phone() const { return phone; }
        std::string & get_mutable_phone() { return phone; }
        void set_phone(const std::string & value) { this->phone = value; }

        const RoleType & get_role_type() const { return role_type; }
        RoleType & get_mutable_role_type() { return role_type; }
        void set_role_type(const RoleType & value) { this->role_type = value; }

        const RoleTypeLabel & get_role_type_label() const { return role_type_label; }
        RoleTypeLabel & get_mutable_role_type_label() { return role_type_label; }
        void set_role_type_label(const RoleTypeLabel & value) { this->role_type_label = value; }

        const nlohmann::json & get_senator_class() const { return senator_class; }
        nlohmann::json & get_mutable_senator_class() { return senator_class; }
        void set_senator_class(const nlohmann::json & value) { this->senator_class = value; }

        const nlohmann::json & get_senator_rank() const { return senator_rank; }
        nlohmann::json & get_mutable_senator_rank() { return senator_rank; }
        void set_senator_rank(const nlohmann::json & value) { this->senator_rank = value; }

        const std::string & get_startdate() const { return startdate; }
        std::string & get_mutable_startdate() { return startdate; }
        void set_startdate(const std::string & value) { this->startdate = value; }

        const std::string & get_state() const { return state; }
        std::string & get_mutable_state() { return state; }
        void set_state(const std::string & value) { this->state = value; }

        const Title & get_title() const { return title; }
        Title & get_mutable_title() { return title; }
        void set_title(const Title & value) { this->title = value; }

        const RoleTypeLabel & get_title_long() const { return title_long; }
        RoleTypeLabel & get_mutable_title_long() { return title_long; }
        void set_title_long(const RoleTypeLabel & value) { this->title_long = value; }

        const std::string & get_website() const { return website; }
        std::string & get_mutable_website() { return website; }
        void set_website(const std::string & value) { this->website = value; }
    };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        Meta meta;
        std::vector<Object> objects;

        public:
        const Meta & get_meta() const { return meta; }
        Meta & get_mutable_meta() { return meta; }
        void set_meta(const Meta & value) { this->meta = value; }

        const std::vector<Object> & get_objects() const { return objects; }
        std::vector<Object> & get_mutable_objects() { return objects; }
        void set_objects(const std::vector<Object> & value) { this->objects = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, Meta & x);
    void to_json(json & j, const Meta & x);

    void from_json(const json & j, Extra & x);
    void to_json(json & j, const Extra & x);

    void from_json(const json & j, Person & x);
    void to_json(json & j, const Person & x);

    void from_json(const json & j, Object & x);
    void to_json(json & j, const Object & x);

    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    void from_json(const json & j, Party & x);
    void to_json(json & j, const Party & x);

    void from_json(const json & j, Gender & x);
    void to_json(json & j, const Gender & x);

    void from_json(const json & j, GenderLabel & x);
    void to_json(json & j, const GenderLabel & x);

    void from_json(const json & j, Namemod & x);
    void to_json(json & j, const Namemod & x);

    void from_json(const json & j, RoleType & x);
    void to_json(json & j, const RoleType & x);

    void from_json(const json & j, RoleTypeLabel & x);
    void to_json(json & j, const RoleTypeLabel & x);

    void from_json(const json & j, Title & x);
    void to_json(json & j, const Title & x);

    inline void from_json(const json & j, Meta& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("limit") != j.end() && !j.at("limit").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_limit(j.at("limit").get<int64_t>());
        if (j.find("offset") != j.end() && !j.at("offset").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_offset(j.at("offset").get<int64_t>());
        if (j.find("total_count") != j.end() && !j.at("total_count").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_total_count(j.at("total_count").get<int64_t>());
    }

    inline void to_json(json & j, const Meta & x) {
        j = json::object();
        j["limit"] = x.get_limit();
        j["offset"] = x.get_offset();
        j["total_count"] = x.get_total_count();
    }

    inline void from_json(const json & j, Extra& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_address(j.at("address").get<std::string>());
        if (j.find("contact_form") != j.end() && j.at("contact_form").is_null()) throw std::runtime_error("Unexpected null");
        x.set_contact_form(get_stack_optional<std::string>(j, "contact_form"));
        x.set_fax(get_stack_optional<std::string>(j, "fax"));
        x.set_office(j.at("office").get<std::string>());
        if (j.find("rss_url") != j.end() && j.at("rss_url").is_null()) throw std::runtime_error("Unexpected null");
        x.set_rss_url(get_stack_optional<std::string>(j, "rss_url"));
    }

    inline void to_json(json & j, const Extra & x) {
        j = json::object();
        j["address"] = x.get_address();
        j["contact_form"] = x.get_contact_form();
        j["fax"] = x.get_fax();
        j["office"] = x.get_office();
        j["rss_url"] = x.get_rss_url();
    }

    inline void from_json(const json & j, Person& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_bioguideid(j.at("bioguideid").get<std::string>());
        x.set_birthday(j.at("birthday").get<std::string>());
        if (j.find("cspanid") != j.end() && !j.at("cspanid").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_cspanid(j.at("cspanid").get<int64_t>());
        x.set_firstname(j.at("firstname").get<std::string>());
        x.set_gender(j.at("gender").get<Gender>());
        x.set_gender_label(j.at("gender_label").get<GenderLabel>());
        if (j.find("id") != j.end() && !j.at("id").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_id(j.at("id").get<int64_t>());
        x.set_lastname(j.at("lastname").get<std::string>());
        x.set_link(j.at("link").get<std::string>());
        x.set_middlename(j.at("middlename").get<std::string>());
        x.set_name(j.at("name").get<std::string>());
        x.set_namemod(j.at("namemod").get<Namemod>());
        x.set_nickname(j.at("nickname").get<std::string>());
        x.set_osid(j.at("osid").get<std::string>());
        j.at("pvsid");
        x.set_pvsid(get_stack_optional<std::string>(j, "pvsid"));
        x.set_sortname(j.at("sortname").get<std::string>());
        j.at("twitterid");
        x.set_twitterid(get_stack_optional<std::string>(j, "twitterid"));
        j.at("youtubeid");
        x.set_youtubeid(get_stack_optional<std::string>(j, "youtubeid"));
    }

    inline void to_json(json & j, const Person & x) {
        j = json::object();
        j["bioguideid"] = x.get_bioguideid();
        j["birthday"] = x.get_birthday();
        j["cspanid"] = x.get_cspanid();
        j["firstname"] = x.get_firstname();
        j["gender"] = x.get_gender();
        j["gender_label"] = x.get_gender_label();
        j["id"] = x.get_id();
        j["lastname"] = x.get_lastname();
        j["link"] = x.get_link();
        j["middlename"] = x.get_middlename();
        j["name"] = x.get_name();
        j["namemod"] = x.get_namemod();
        j["nickname"] = x.get_nickname();
        j["osid"] = x.get_osid();
        j["pvsid"] = x.get_pvsid();
        j["sortname"] = x.get_sortname();
        j["twitterid"] = x.get_twitterid();
        j["youtubeid"] = x.get_youtubeid();
    }

    inline void from_json(const json & j, Object& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_caucus(get_untyped(j, "caucus"));
        x.set_congress_numbers(j.at("congress_numbers").get<std::vector<int64_t>>());
        x.set_current(j.at("current").get<bool>());
        x.set_description(j.at("description").get<std::string>());
        if (j.find("district") != j.end() && !j.at("district").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_district(j.at("district").get<int64_t>());
        x.set_enddate(j.at("enddate").get<std::string>());
        x.set_extra(j.at("extra").get<Extra>());
        if (j.find("id") != j.end() && !j.at("id").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_id(j.at("id").get<int64_t>());
        j.at("leadership_title");
        x.set_leadership_title(get_stack_optional<std::string>(j, "leadership_title"));
        x.set_party(j.at("party").get<Party>());
        x.set_person(j.at("person").get<Person>());
        x.set_phone(j.at("phone").get<std::string>());
        x.set_role_type(j.at("role_type").get<RoleType>());
        x.set_role_type_label(j.at("role_type_label").get<RoleTypeLabel>());
        x.set_senator_class(get_untyped(j, "senator_class"));
        x.set_senator_rank(get_untyped(j, "senator_rank"));
        x.set_startdate(j.at("startdate").get<std::string>());
        x.set_state(j.at("state").get<std::string>());
        x.set_title(j.at("title").get<Title>());
        x.set_title_long(j.at("title_long").get<RoleTypeLabel>());
        x.set_website(j.at("website").get<std::string>());
    }

    inline void to_json(json & j, const Object & x) {
        j = json::object();
        j["caucus"] = x.get_caucus();
        j["congress_numbers"] = x.get_congress_numbers();
        j["current"] = x.get_current();
        j["description"] = x.get_description();
        j["district"] = x.get_district();
        j["enddate"] = x.get_enddate();
        j["extra"] = x.get_extra();
        j["id"] = x.get_id();
        j["leadership_title"] = x.get_leadership_title();
        j["party"] = x.get_party();
        j["person"] = x.get_person();
        j["phone"] = x.get_phone();
        j["role_type"] = x.get_role_type();
        j["role_type_label"] = x.get_role_type_label();
        j["senator_class"] = x.get_senator_class();
        j["senator_rank"] = x.get_senator_rank();
        j["startdate"] = x.get_startdate();
        j["state"] = x.get_state();
        j["title"] = x.get_title();
        j["title_long"] = x.get_title_long();
        j["website"] = x.get_website();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_meta(j.at("meta").get<Meta>());
        x.set_objects(j.at("objects").get<std::vector<Object>>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["meta"] = x.get_meta();
        j["objects"] = x.get_objects();
    }

    inline void from_json(const json & j, Party & x) {
        if (j == "Republican") x = Party::REPUBLICAN;
        else if (j == "Democrat") x = Party::DEMOCRAT;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Party\""); }
    }

    inline void to_json(json & j, const Party & x) {
        switch (x) {
            case Party::REPUBLICAN: j = "Republican"; break;
            case Party::DEMOCRAT: j = "Democrat"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Party\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, Gender & x) {
        if (j == "male") x = Gender::MALE;
        else if (j == "female") x = Gender::FEMALE;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Gender\""); }
    }

    inline void to_json(json & j, const Gender & x) {
        switch (x) {
            case Gender::MALE: j = "male"; break;
            case Gender::FEMALE: j = "female"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Gender\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, GenderLabel & x) {
        if (j == "Male") x = GenderLabel::MALE;
        else if (j == "Female") x = GenderLabel::FEMALE;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"GenderLabel\""); }
    }

    inline void to_json(json & j, const GenderLabel & x) {
        switch (x) {
            case GenderLabel::MALE: j = "Male"; break;
            case GenderLabel::FEMALE: j = "Female"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"GenderLabel\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, Namemod & x) {
        if (j == "") x = Namemod::EMPTY;
        else if (j == "Jr.") x = Namemod::JR;
        else if (j == "II") x = Namemod::II;
        else if (j == "III") x = Namemod::III;
        else if (j == "IV") x = Namemod::IV;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Namemod\""); }
    }

    inline void to_json(json & j, const Namemod & x) {
        switch (x) {
            case Namemod::EMPTY: j = ""; break;
            case Namemod::JR: j = "Jr."; break;
            case Namemod::II: j = "II"; break;
            case Namemod::III: j = "III"; break;
            case Namemod::IV: j = "IV"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Namemod\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, RoleType & x) {
        if (j == "representative") x = RoleType::REPRESENTATIVE;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"RoleType\""); }
    }

    inline void to_json(json & j, const RoleType & x) {
        switch (x) {
            case RoleType::REPRESENTATIVE: j = "representative"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"RoleType\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, RoleTypeLabel & x) {
        if (j == "Representative") x = RoleTypeLabel::REPRESENTATIVE;
        else if (j == "Delegate") x = RoleTypeLabel::DELEGATE;
        else if (j == "Resident Commissioner") x = RoleTypeLabel::RESIDENT_COMMISSIONER;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"RoleTypeLabel\""); }
    }

    inline void to_json(json & j, const RoleTypeLabel & x) {
        switch (x) {
            case RoleTypeLabel::REPRESENTATIVE: j = "Representative"; break;
            case RoleTypeLabel::DELEGATE: j = "Delegate"; break;
            case RoleTypeLabel::RESIDENT_COMMISSIONER: j = "Resident Commissioner"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"RoleTypeLabel\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, Title & x) {
        if (j == "Rep.") x = Title::REP;
        else if (j == "Commish.") x = Title::COMMISH;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Title\""); }
    }

    inline void to_json(json & j, const Title & x) {
        switch (x) {
            case Title::REP: j = "Rep."; break;
            case Title::COMMISH: j = "Commish."; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Title\": " + std::to_string(static_cast<int>(x)));
        }
    }
}
