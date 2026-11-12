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

    enum class ReactionContent : int { THUMBS_UP, THUMBS_DOWN, LAUGH, HOORAY, CONFUSED, HEART };

    class Reaction {
        public:
        Reaction() = default;
        virtual ~Reaction() = default;

        private:
        ReactionContent content;

        public:
        const ReactionContent & get_content() const { return content; }
        ReactionContent & get_mutable_content() { return content; }
        void set_content(const ReactionContent & value) { this->content = value; }
    };

    class Reactable {
        public:
        Reactable() = default;
        virtual ~Reactable() = default;

        private:
        bool viewer_can_react;
        std::optional<std::vector<Reaction>> reaction_groups;

        public:
        const bool & get_viewer_can_react() const { return viewer_can_react; }
        bool & get_mutable_viewer_can_react() { return viewer_can_react; }
        void set_viewer_can_react(const bool & value) { this->viewer_can_react = value; }

        std::optional<std::vector<Reaction>> get_reaction_groups() const { return reaction_groups; }
        void set_reaction_groups(std::optional<std::vector<Reaction>> value) { this->reaction_groups = value; }
    };

    class AddReactionPayload {
        public:
        AddReactionPayload() = default;
        virtual ~AddReactionPayload() = default;

        private:
        std::optional<std::string> client_mutation_id;
        Reaction reaction;
        Reactable subject;

        public:
        std::optional<std::string> get_client_mutation_id() const { return client_mutation_id; }
        void set_client_mutation_id(std::optional<std::string> value) { this->client_mutation_id = value; }

        const Reaction & get_reaction() const { return reaction; }
        Reaction & get_mutable_reaction() { return reaction; }
        void set_reaction(const Reaction & value) { this->reaction = value; }

        const Reactable & get_subject() const { return subject; }
        Reactable & get_mutable_subject() { return subject; }
        void set_subject(const Reactable & value) { this->subject = value; }
    };

    class Data {
        public:
        Data() = default;
        virtual ~Data() = default;

        private:
        std::optional<AddReactionPayload> add_reaction;

        public:
        std::optional<AddReactionPayload> get_add_reaction() const { return add_reaction; }
        void set_add_reaction(std::optional<AddReactionPayload> value) { this->add_reaction = value; }
    };

    class Error {
        public:
        Error() = default;
        virtual ~Error() = default;

        private:
        std::string message;

        public:
        const std::string & get_message() const { return message; }
        std::string & get_mutable_message() { return message; }
        void set_message(const std::string & value) { this->message = value; }
    };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        std::optional<Data> data;
        std::optional<std::vector<Error>> errors;

        public:
        std::optional<Data> get_data() const { return data; }
        void set_data(std::optional<Data> value) { this->data = value; }

        const std::optional<std::vector<Error>> & get_errors() const { return errors; }
        std::optional<std::vector<Error>> & get_mutable_errors() { return errors; }
        void set_errors(const std::optional<std::vector<Error>> & value) { this->errors = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, Reaction & x);
    void to_json(json & j, const Reaction & x);

    void from_json(const json & j, Reactable & x);
    void to_json(json & j, const Reactable & x);

    void from_json(const json & j, AddReactionPayload & x);
    void to_json(json & j, const AddReactionPayload & x);

    void from_json(const json & j, Data & x);
    void to_json(json & j, const Data & x);

    void from_json(const json & j, Error & x);
    void to_json(json & j, const Error & x);

    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    void from_json(const json & j, ReactionContent & x);
    void to_json(json & j, const ReactionContent & x);

    inline void from_json(const json & j, Reaction& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_content(j.at("content").get<ReactionContent>());
    }

    inline void to_json(json & j, const Reaction & x) {
        j = json::object();
        j["content"] = x.get_content();
    }

    inline void from_json(const json & j, Reactable& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_viewer_can_react(j.at("viewerCanReact").get<bool>());
        j.at("reactionGroups");
        x.set_reaction_groups(get_stack_optional<std::vector<Reaction>>(j, "reactionGroups"));
    }

    inline void to_json(json & j, const Reactable & x) {
        j = json::object();
        j["viewerCanReact"] = x.get_viewer_can_react();
        j["reactionGroups"] = x.get_reaction_groups();
    }

    inline void from_json(const json & j, AddReactionPayload& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        j.at("clientMutationId");
        x.set_client_mutation_id(get_stack_optional<std::string>(j, "clientMutationId"));
        x.set_reaction(j.at("reaction").get<Reaction>());
        x.set_subject(j.at("subject").get<Reactable>());
    }

    inline void to_json(json & j, const AddReactionPayload & x) {
        j = json::object();
        j["clientMutationId"] = x.get_client_mutation_id();
        j["reaction"] = x.get_reaction();
        j["subject"] = x.get_subject();
    }

    inline void from_json(const json & j, Data& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        j.at("addReaction");
        x.set_add_reaction(get_stack_optional<AddReactionPayload>(j, "addReaction"));
    }

    inline void to_json(json & j, const Data & x) {
        j = json::object();
        j["addReaction"] = x.get_add_reaction();
    }

    inline void from_json(const json & j, Error& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_message(j.at("message").get<std::string>());
    }

    inline void to_json(json & j, const Error & x) {
        j = json::object();
        j["message"] = x.get_message();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        j.at("data");
        x.set_data(get_stack_optional<Data>(j, "data"));
        if (j.find("errors") != j.end() && j.at("errors").is_null()) throw std::runtime_error("Unexpected null");
        x.set_errors(get_stack_optional<std::vector<Error>>(j, "errors"));
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["data"] = x.get_data();
        j["errors"] = x.get_errors();
    }

    inline void from_json(const json & j, ReactionContent & x) {
        if (j == "THUMBS_UP") x = ReactionContent::THUMBS_UP;
        else if (j == "THUMBS_DOWN") x = ReactionContent::THUMBS_DOWN;
        else if (j == "LAUGH") x = ReactionContent::LAUGH;
        else if (j == "HOORAY") x = ReactionContent::HOORAY;
        else if (j == "CONFUSED") x = ReactionContent::CONFUSED;
        else if (j == "HEART") x = ReactionContent::HEART;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"ReactionContent\""); }
    }

    inline void to_json(json & j, const ReactionContent & x) {
        switch (x) {
            case ReactionContent::THUMBS_UP: j = "THUMBS_UP"; break;
            case ReactionContent::THUMBS_DOWN: j = "THUMBS_DOWN"; break;
            case ReactionContent::LAUGH: j = "LAUGH"; break;
            case ReactionContent::HOORAY: j = "HOORAY"; break;
            case ReactionContent::CONFUSED: j = "CONFUSED"; break;
            case ReactionContent::HEART: j = "HEART"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"ReactionContent\": " + std::to_string(static_cast<int>(x)));
        }
    }
}
