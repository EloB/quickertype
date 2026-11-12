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

    class Collection {
        public:
        Collection() = default;
        virtual ~Collection() = default;

        private:
        int64_t id;
        std::vector<int64_t> movies;
        std::string name;
        std::string slug;

        public:
        const int64_t & get_id() const { return id; }
        int64_t & get_mutable_id() { return id; }
        void set_id(const int64_t & value) { this->id = value; }

        const std::vector<int64_t> & get_movies() const { return movies; }
        std::vector<int64_t> & get_mutable_movies() { return movies; }
        void set_movies(const std::vector<int64_t> & value) { this->movies = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const std::string & get_slug() const { return slug; }
        std::string & get_mutable_slug() { return slug; }
        void set_slug(const std::string & value) { this->slug = value; }
    };

    enum class DetailLanguage : int { EN, TH };

    class Detail {
        public:
        Detail() = default;
        virtual ~Detail() = default;

        private:
        std::string cast;
        std::string director;
        int64_t id;
        DetailLanguage language;
        std::string storyline;
        std::string tagline;
        std::string title;

        public:
        const std::string & get_cast() const { return cast; }
        std::string & get_mutable_cast() { return cast; }
        void set_cast(const std::string & value) { this->cast = value; }

        const std::string & get_director() const { return director; }
        std::string & get_mutable_director() { return director; }
        void set_director(const std::string & value) { this->director = value; }

        const int64_t & get_id() const { return id; }
        int64_t & get_mutable_id() { return id; }
        void set_id(const int64_t & value) { this->id = value; }

        const DetailLanguage & get_language() const { return language; }
        DetailLanguage & get_mutable_language() { return language; }
        void set_language(const DetailLanguage & value) { this->language = value; }

        const std::string & get_storyline() const { return storyline; }
        std::string & get_mutable_storyline() { return storyline; }
        void set_storyline(const std::string & value) { this->storyline = value; }

        const std::string & get_tagline() const { return tagline; }
        std::string & get_mutable_tagline() { return tagline; }
        void set_tagline(const std::string & value) { this->tagline = value; }

        const std::string & get_title() const { return title; }
        std::string & get_mutable_title() { return title; }
        void set_title(const std::string & value) { this->title = value; }
    };

    class FavMovie {
        public:
        FavMovie() = default;
        virtual ~FavMovie() = default;

        private:
        bool follow;
        bool star;
        bool watched;

        public:
        const bool & get_follow() const { return follow; }
        bool & get_mutable_follow() { return follow; }
        void set_follow(const bool & value) { this->follow = value; }

        const bool & get_star() const { return star; }
        bool & get_mutable_star() { return star; }
        void set_star(const bool & value) { this->star = value; }

        const bool & get_watched() const { return watched; }
        bool & get_mutable_watched() { return watched; }
        void set_watched(const bool & value) { this->watched = value; }
    };

    enum class Type : int { POSTER, BACKDROP };

    class Image {
        public:
        Image() = default;
        virtual ~Image() = default;

        private:
        int64_t favs;
        int64_t id;
        std::string thumbnail;
        Type type;
        std::string url;

        public:
        const int64_t & get_favs() const { return favs; }
        int64_t & get_mutable_favs() { return favs; }
        void set_favs(const int64_t & value) { this->favs = value; }

        const int64_t & get_id() const { return id; }
        int64_t & get_mutable_id() { return id; }
        void set_id(const int64_t & value) { this->id = value; }

        const std::string & get_thumbnail() const { return thumbnail; }
        std::string & get_mutable_thumbnail() { return thumbnail; }
        void set_thumbnail(const std::string & value) { this->thumbnail = value; }

        const Type & get_type() const { return type; }
        Type & get_mutable_type() { return type; }
        void set_type(const Type & value) { this->type = value; }

        const std::string & get_url() const { return url; }
        std::string & get_mutable_url() { return url; }
        void set_url(const std::string & value) { this->url = value; }
    };

    enum class ResultLanguage : int { EN, EMPTY };

    class Video {
        public:
        Video() = default;
        virtual ~Video() = default;

        private:
        std::string kind;
        ResultLanguage language;
        std::string source;
        std::string url;

        public:
        const std::string & get_kind() const { return kind; }
        std::string & get_mutable_kind() { return kind; }
        void set_kind(const std::string & value) { this->kind = value; }

        const ResultLanguage & get_language() const { return language; }
        ResultLanguage & get_mutable_language() { return language; }
        void set_language(const ResultLanguage & value) { this->language = value; }

        const std::string & get_source() const { return source; }
        std::string & get_mutable_source() { return source; }
        void set_source(const std::string & value) { this->source = value; }

        const std::string & get_url() const { return url; }
        std::string & get_mutable_url() { return url; }
        void set_url(const std::string & value) { this->url = value; }
    };

    class VoteScore {
        public:
        VoteScore() = default;
        virtual ~VoteScore() = default;

        private:
        int64_t avg;
        int64_t score;
        int64_t total;

        public:
        const int64_t & get_avg() const { return avg; }
        int64_t & get_mutable_avg() { return avg; }
        void set_avg(const int64_t & value) { this->avg = value; }

        const int64_t & get_score() const { return score; }
        int64_t & get_mutable_score() { return score; }
        void set_score(const int64_t & value) { this->score = value; }

        const int64_t & get_total() const { return total; }
        int64_t & get_mutable_total() { return total; }
        void set_total(const int64_t & value) { this->total = value; }
    };

    class Result {
        public:
        Result() = default;
        virtual ~Result() = default;

        private:
        int64_t active_screens;
        std::vector<Collection> collections;
        std::vector<Detail> details;
        int64_t duration;
        FavMovie fav_movie;
        int64_t id;
        std::vector<Image> images;
        ResultLanguage language;
        std::string release_date;
        int64_t stars;
        std::optional<std::vector<nlohmann::json>> tags;
        std::string title;
        std::vector<Video> videos;
        VoteScore vote_score;
        int64_t watches;

        public:
        const int64_t & get_active_screens() const { return active_screens; }
        int64_t & get_mutable_active_screens() { return active_screens; }
        void set_active_screens(const int64_t & value) { this->active_screens = value; }

        const std::vector<Collection> & get_collections() const { return collections; }
        std::vector<Collection> & get_mutable_collections() { return collections; }
        void set_collections(const std::vector<Collection> & value) { this->collections = value; }

        const std::vector<Detail> & get_details() const { return details; }
        std::vector<Detail> & get_mutable_details() { return details; }
        void set_details(const std::vector<Detail> & value) { this->details = value; }

        const int64_t & get_duration() const { return duration; }
        int64_t & get_mutable_duration() { return duration; }
        void set_duration(const int64_t & value) { this->duration = value; }

        const FavMovie & get_fav_movie() const { return fav_movie; }
        FavMovie & get_mutable_fav_movie() { return fav_movie; }
        void set_fav_movie(const FavMovie & value) { this->fav_movie = value; }

        const int64_t & get_id() const { return id; }
        int64_t & get_mutable_id() { return id; }
        void set_id(const int64_t & value) { this->id = value; }

        const std::vector<Image> & get_images() const { return images; }
        std::vector<Image> & get_mutable_images() { return images; }
        void set_images(const std::vector<Image> & value) { this->images = value; }

        const ResultLanguage & get_language() const { return language; }
        ResultLanguage & get_mutable_language() { return language; }
        void set_language(const ResultLanguage & value) { this->language = value; }

        const std::string & get_release_date() const { return release_date; }
        std::string & get_mutable_release_date() { return release_date; }
        void set_release_date(const std::string & value) { this->release_date = value; }

        const int64_t & get_stars() const { return stars; }
        int64_t & get_mutable_stars() { return stars; }
        void set_stars(const int64_t & value) { this->stars = value; }

        std::optional<std::vector<nlohmann::json>> get_tags() const { return tags; }
        void set_tags(std::optional<std::vector<nlohmann::json>> value) { this->tags = value; }

        const std::string & get_title() const { return title; }
        std::string & get_mutable_title() { return title; }
        void set_title(const std::string & value) { this->title = value; }

        const std::vector<Video> & get_videos() const { return videos; }
        std::vector<Video> & get_mutable_videos() { return videos; }
        void set_videos(const std::vector<Video> & value) { this->videos = value; }

        const VoteScore & get_vote_score() const { return vote_score; }
        VoteScore & get_mutable_vote_score() { return vote_score; }
        void set_vote_score(const VoteScore & value) { this->vote_score = value; }

        const int64_t & get_watches() const { return watches; }
        int64_t & get_mutable_watches() { return watches; }
        void set_watches(const int64_t & value) { this->watches = value; }
    };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        int64_t count;
        std::string next;
        nlohmann::json previous;
        std::vector<Result> results;

        public:
        const int64_t & get_count() const { return count; }
        int64_t & get_mutable_count() { return count; }
        void set_count(const int64_t & value) { this->count = value; }

        const std::string & get_next() const { return next; }
        std::string & get_mutable_next() { return next; }
        void set_next(const std::string & value) { this->next = value; }

        const nlohmann::json & get_previous() const { return previous; }
        nlohmann::json & get_mutable_previous() { return previous; }
        void set_previous(const nlohmann::json & value) { this->previous = value; }

        const std::vector<Result> & get_results() const { return results; }
        std::vector<Result> & get_mutable_results() { return results; }
        void set_results(const std::vector<Result> & value) { this->results = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, Collection & x);
    void to_json(json & j, const Collection & x);

    void from_json(const json & j, Detail & x);
    void to_json(json & j, const Detail & x);

    void from_json(const json & j, FavMovie & x);
    void to_json(json & j, const FavMovie & x);

    void from_json(const json & j, Image & x);
    void to_json(json & j, const Image & x);

    void from_json(const json & j, Video & x);
    void to_json(json & j, const Video & x);

    void from_json(const json & j, VoteScore & x);
    void to_json(json & j, const VoteScore & x);

    void from_json(const json & j, Result & x);
    void to_json(json & j, const Result & x);

    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    void from_json(const json & j, DetailLanguage & x);
    void to_json(json & j, const DetailLanguage & x);

    void from_json(const json & j, Type & x);
    void to_json(json & j, const Type & x);

    void from_json(const json & j, ResultLanguage & x);
    void to_json(json & j, const ResultLanguage & x);

    inline void from_json(const json & j, Collection& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("id") != j.end() && !j.at("id").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_id(j.at("id").get<int64_t>());
        x.set_movies(j.at("movies").get<std::vector<int64_t>>());
        x.set_name(j.at("name").get<std::string>());
        x.set_slug(j.at("slug").get<std::string>());
    }

    inline void to_json(json & j, const Collection & x) {
        j = json::object();
        j["id"] = x.get_id();
        j["movies"] = x.get_movies();
        j["name"] = x.get_name();
        j["slug"] = x.get_slug();
    }

    inline void from_json(const json & j, Detail& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_cast(j.at("cast").get<std::string>());
        x.set_director(j.at("director").get<std::string>());
        if (j.find("id") != j.end() && !j.at("id").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_id(j.at("id").get<int64_t>());
        x.set_language(j.at("language").get<DetailLanguage>());
        x.set_storyline(j.at("storyline").get<std::string>());
        x.set_tagline(j.at("tagline").get<std::string>());
        x.set_title(j.at("title").get<std::string>());
    }

    inline void to_json(json & j, const Detail & x) {
        j = json::object();
        j["cast"] = x.get_cast();
        j["director"] = x.get_director();
        j["id"] = x.get_id();
        j["language"] = x.get_language();
        j["storyline"] = x.get_storyline();
        j["tagline"] = x.get_tagline();
        j["title"] = x.get_title();
    }

    inline void from_json(const json & j, FavMovie& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_follow(j.at("follow").get<bool>());
        x.set_star(j.at("star").get<bool>());
        x.set_watched(j.at("watched").get<bool>());
    }

    inline void to_json(json & j, const FavMovie & x) {
        j = json::object();
        j["follow"] = x.get_follow();
        j["star"] = x.get_star();
        j["watched"] = x.get_watched();
    }

    inline void from_json(const json & j, Image& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("favs") != j.end() && !j.at("favs").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_favs(j.at("favs").get<int64_t>());
        if (j.find("id") != j.end() && !j.at("id").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_id(j.at("id").get<int64_t>());
        x.set_thumbnail(j.at("thumbnail").get<std::string>());
        x.set_type(j.at("type").get<Type>());
        x.set_url(j.at("url").get<std::string>());
    }

    inline void to_json(json & j, const Image & x) {
        j = json::object();
        j["favs"] = x.get_favs();
        j["id"] = x.get_id();
        j["thumbnail"] = x.get_thumbnail();
        j["type"] = x.get_type();
        j["url"] = x.get_url();
    }

    inline void from_json(const json & j, Video& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_kind(j.at("kind").get<std::string>());
        x.set_language(j.at("language").get<ResultLanguage>());
        x.set_source(j.at("source").get<std::string>());
        x.set_url(j.at("url").get<std::string>());
    }

    inline void to_json(json & j, const Video & x) {
        j = json::object();
        j["kind"] = x.get_kind();
        j["language"] = x.get_language();
        j["source"] = x.get_source();
        j["url"] = x.get_url();
    }

    inline void from_json(const json & j, VoteScore& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("avg") != j.end() && !j.at("avg").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_avg(j.at("avg").get<int64_t>());
        if (j.find("score") != j.end() && !j.at("score").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_score(j.at("score").get<int64_t>());
        if (j.find("total") != j.end() && !j.at("total").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_total(j.at("total").get<int64_t>());
    }

    inline void to_json(json & j, const VoteScore & x) {
        j = json::object();
        j["avg"] = x.get_avg();
        j["score"] = x.get_score();
        j["total"] = x.get_total();
    }

    inline void from_json(const json & j, Result& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("active_screens") != j.end() && !j.at("active_screens").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_active_screens(j.at("active_screens").get<int64_t>());
        x.set_collections(j.at("collections").get<std::vector<Collection>>());
        x.set_details(j.at("details").get<std::vector<Detail>>());
        if (j.find("duration") != j.end() && !j.at("duration").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_duration(j.at("duration").get<int64_t>());
        x.set_fav_movie(j.at("fav_movie").get<FavMovie>());
        if (j.find("id") != j.end() && !j.at("id").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_id(j.at("id").get<int64_t>());
        x.set_images(j.at("images").get<std::vector<Image>>());
        x.set_language(j.at("language").get<ResultLanguage>());
        x.set_release_date(j.at("release_date").get<std::string>());
        if (j.find("stars") != j.end() && !j.at("stars").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_stars(j.at("stars").get<int64_t>());
        j.at("tags");
        x.set_tags(get_stack_optional<std::vector<nlohmann::json>>(j, "tags"));
        x.set_title(j.at("title").get<std::string>());
        x.set_videos(j.at("videos").get<std::vector<Video>>());
        x.set_vote_score(j.at("vote_score").get<VoteScore>());
        if (j.find("watches") != j.end() && !j.at("watches").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_watches(j.at("watches").get<int64_t>());
    }

    inline void to_json(json & j, const Result & x) {
        j = json::object();
        j["active_screens"] = x.get_active_screens();
        j["collections"] = x.get_collections();
        j["details"] = x.get_details();
        j["duration"] = x.get_duration();
        j["fav_movie"] = x.get_fav_movie();
        j["id"] = x.get_id();
        j["images"] = x.get_images();
        j["language"] = x.get_language();
        j["release_date"] = x.get_release_date();
        j["stars"] = x.get_stars();
        j["tags"] = x.get_tags();
        j["title"] = x.get_title();
        j["videos"] = x.get_videos();
        j["vote_score"] = x.get_vote_score();
        j["watches"] = x.get_watches();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("count") != j.end() && !j.at("count").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_count(j.at("count").get<int64_t>());
        x.set_next(j.at("next").get<std::string>());
        x.set_previous(get_untyped(j, "previous"));
        x.set_results(j.at("results").get<std::vector<Result>>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["count"] = x.get_count();
        j["next"] = x.get_next();
        j["previous"] = x.get_previous();
        j["results"] = x.get_results();
    }

    inline void from_json(const json & j, DetailLanguage & x) {
        if (j == "en") x = DetailLanguage::EN;
        else if (j == "th") x = DetailLanguage::TH;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"DetailLanguage\""); }
    }

    inline void to_json(json & j, const DetailLanguage & x) {
        switch (x) {
            case DetailLanguage::EN: j = "en"; break;
            case DetailLanguage::TH: j = "th"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"DetailLanguage\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, Type & x) {
        if (j == "Poster") x = Type::POSTER;
        else if (j == "Backdrop") x = Type::BACKDROP;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Type\""); }
    }

    inline void to_json(json & j, const Type & x) {
        switch (x) {
            case Type::POSTER: j = "Poster"; break;
            case Type::BACKDROP: j = "Backdrop"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Type\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, ResultLanguage & x) {
        if (j == "en") x = ResultLanguage::EN;
        else if (j == "-") x = ResultLanguage::EMPTY;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"ResultLanguage\""); }
    }

    inline void to_json(json & j, const ResultLanguage & x) {
        switch (x) {
            case ResultLanguage::EN: j = "en"; break;
            case ResultLanguage::EMPTY: j = "-"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"ResultLanguage\": " + std::to_string(static_cast<int>(x)));
        }
    }
}
