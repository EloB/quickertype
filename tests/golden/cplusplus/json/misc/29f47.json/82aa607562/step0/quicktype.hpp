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

    enum class Distinguished : int { ADMIN };

    enum class Domain : int { SELF_ANNOUNCEMENTS, I_REDD_IT };

    using Edited = std::variant<bool, double>;

    class MediaEmbed {
        public:
        MediaEmbed() = default;
        virtual ~MediaEmbed() = default;

        private:

        public:
    };

    enum class PostHint : int { SELF, IMAGE };

    class Source {
        public:
        Source() = default;
        virtual ~Source() = default;

        private:
        int64_t height;
        std::string url;
        int64_t width;

        public:
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

    class Gif {
        public:
        Gif() = default;
        virtual ~Gif() = default;

        private:
        std::vector<Source> resolutions;
        Source source;

        public:
        const std::vector<Source> & get_resolutions() const { return resolutions; }
        std::vector<Source> & get_mutable_resolutions() { return resolutions; }
        void set_resolutions(const std::vector<Source> & value) { this->resolutions = value; }

        const Source & get_source() const { return source; }
        Source & get_mutable_source() { return source; }
        void set_source(const Source & value) { this->source = value; }
    };

    class Variants {
        public:
        Variants() = default;
        virtual ~Variants() = default;

        private:
        std::optional<Gif> gif;
        std::optional<Gif> mp4;

        public:
        const std::optional<Gif> & get_gif() const { return gif; }
        std::optional<Gif> & get_mutable_gif() { return gif; }
        void set_gif(const std::optional<Gif> & value) { this->gif = value; }

        const std::optional<Gif> & get_mp4() const { return mp4; }
        std::optional<Gif> & get_mutable_mp4() { return mp4; }
        void set_mp4(const std::optional<Gif> & value) { this->mp4 = value; }
    };

    class Image {
        public:
        Image() = default;
        virtual ~Image() = default;

        private:
        std::string id;
        std::vector<Source> resolutions;
        Source source;
        Variants variants;

        public:
        const std::string & get_id() const { return id; }
        std::string & get_mutable_id() { return id; }
        void set_id(const std::string & value) { this->id = value; }

        const std::vector<Source> & get_resolutions() const { return resolutions; }
        std::vector<Source> & get_mutable_resolutions() { return resolutions; }
        void set_resolutions(const std::vector<Source> & value) { this->resolutions = value; }

        const Source & get_source() const { return source; }
        Source & get_mutable_source() { return source; }
        void set_source(const Source & value) { this->source = value; }

        const Variants & get_variants() const { return variants; }
        Variants & get_mutable_variants() { return variants; }
        void set_variants(const Variants & value) { this->variants = value; }
    };

    class Preview {
        public:
        Preview() = default;
        virtual ~Preview() = default;

        private:
        bool enabled;
        std::vector<Image> images;

        public:
        const bool & get_enabled() const { return enabled; }
        bool & get_mutable_enabled() { return enabled; }
        void set_enabled(const bool & value) { this->enabled = value; }

        const std::vector<Image> & get_images() const { return images; }
        std::vector<Image> & get_mutable_images() { return images; }
        void set_images(const std::vector<Image> & value) { this->images = value; }
    };

    enum class Subreddit : int { ANNOUNCEMENTS };

    enum class SubredditId : int { T5_2_R0_IJ };

    enum class SubredditNamePrefixed : int { R_ANNOUNCEMENTS };

    enum class SubredditType : int { RESTRICTED };

    class ChildData {
        public:
        ChildData() = default;
        virtual ~ChildData() = default;

        private:
        nlohmann::json approved_at_utc;
        nlohmann::json approved_by;
        bool archived;
        std::string author;
        nlohmann::json author_flair_css_class;
        nlohmann::json author_flair_text;
        nlohmann::json banned_at_utc;
        nlohmann::json banned_by;
        bool brand_safe;
        bool can_gild;
        bool can_mod_post;
        bool clicked;
        bool contest_mode;
        double created;
        double created_utc;
        Distinguished distinguished;
        Domain domain;
        int64_t downs;
        Edited edited;
        int64_t gilded;
        bool hidden;
        bool hide_score;
        std::string id;
        bool is_self;
        bool is_video;
        nlohmann::json likes;
        nlohmann::json link_flair_css_class;
        nlohmann::json link_flair_text;
        bool locked;
        nlohmann::json media;
        MediaEmbed media_embed;
        std::vector<nlohmann::json> mod_reports;
        std::string name;
        int64_t num_comments;
        nlohmann::json num_reports;
        bool over_18;
        std::string permalink;
        std::optional<PostHint> post_hint;
        std::optional<Preview> preview;
        bool quarantine;
        nlohmann::json removal_reason;
        nlohmann::json report_reasons;
        bool saved;
        int64_t score;
        nlohmann::json secure_media;
        MediaEmbed secure_media_embed;
        std::string selftext;
        std::optional<std::string> selftext_html;
        bool spoiler;
        bool stickied;
        Subreddit subreddit;
        SubredditId subreddit_id;
        SubredditNamePrefixed subreddit_name_prefixed;
        SubredditType subreddit_type;
        std::optional<std::string> suggested_sort;
        std::string thumbnail;
        std::optional<int64_t> thumbnail_height;
        std::optional<int64_t> thumbnail_width;
        std::string title;
        int64_t ups;
        std::string url;
        std::vector<nlohmann::json> user_reports;
        nlohmann::json view_count;
        bool visited;

        public:
        const nlohmann::json & get_approved_at_utc() const { return approved_at_utc; }
        nlohmann::json & get_mutable_approved_at_utc() { return approved_at_utc; }
        void set_approved_at_utc(const nlohmann::json & value) { this->approved_at_utc = value; }

        const nlohmann::json & get_approved_by() const { return approved_by; }
        nlohmann::json & get_mutable_approved_by() { return approved_by; }
        void set_approved_by(const nlohmann::json & value) { this->approved_by = value; }

        const bool & get_archived() const { return archived; }
        bool & get_mutable_archived() { return archived; }
        void set_archived(const bool & value) { this->archived = value; }

        const std::string & get_author() const { return author; }
        std::string & get_mutable_author() { return author; }
        void set_author(const std::string & value) { this->author = value; }

        const nlohmann::json & get_author_flair_css_class() const { return author_flair_css_class; }
        nlohmann::json & get_mutable_author_flair_css_class() { return author_flair_css_class; }
        void set_author_flair_css_class(const nlohmann::json & value) { this->author_flair_css_class = value; }

        const nlohmann::json & get_author_flair_text() const { return author_flair_text; }
        nlohmann::json & get_mutable_author_flair_text() { return author_flair_text; }
        void set_author_flair_text(const nlohmann::json & value) { this->author_flair_text = value; }

        const nlohmann::json & get_banned_at_utc() const { return banned_at_utc; }
        nlohmann::json & get_mutable_banned_at_utc() { return banned_at_utc; }
        void set_banned_at_utc(const nlohmann::json & value) { this->banned_at_utc = value; }

        const nlohmann::json & get_banned_by() const { return banned_by; }
        nlohmann::json & get_mutable_banned_by() { return banned_by; }
        void set_banned_by(const nlohmann::json & value) { this->banned_by = value; }

        const bool & get_brand_safe() const { return brand_safe; }
        bool & get_mutable_brand_safe() { return brand_safe; }
        void set_brand_safe(const bool & value) { this->brand_safe = value; }

        const bool & get_can_gild() const { return can_gild; }
        bool & get_mutable_can_gild() { return can_gild; }
        void set_can_gild(const bool & value) { this->can_gild = value; }

        const bool & get_can_mod_post() const { return can_mod_post; }
        bool & get_mutable_can_mod_post() { return can_mod_post; }
        void set_can_mod_post(const bool & value) { this->can_mod_post = value; }

        const bool & get_clicked() const { return clicked; }
        bool & get_mutable_clicked() { return clicked; }
        void set_clicked(const bool & value) { this->clicked = value; }

        const bool & get_contest_mode() const { return contest_mode; }
        bool & get_mutable_contest_mode() { return contest_mode; }
        void set_contest_mode(const bool & value) { this->contest_mode = value; }

        const double & get_created() const { return created; }
        double & get_mutable_created() { return created; }
        void set_created(const double & value) { this->created = value; }

        const double & get_created_utc() const { return created_utc; }
        double & get_mutable_created_utc() { return created_utc; }
        void set_created_utc(const double & value) { this->created_utc = value; }

        const Distinguished & get_distinguished() const { return distinguished; }
        Distinguished & get_mutable_distinguished() { return distinguished; }
        void set_distinguished(const Distinguished & value) { this->distinguished = value; }

        const Domain & get_domain() const { return domain; }
        Domain & get_mutable_domain() { return domain; }
        void set_domain(const Domain & value) { this->domain = value; }

        const int64_t & get_downs() const { return downs; }
        int64_t & get_mutable_downs() { return downs; }
        void set_downs(const int64_t & value) { this->downs = value; }

        const Edited & get_edited() const { return edited; }
        Edited & get_mutable_edited() { return edited; }
        void set_edited(const Edited & value) { this->edited = value; }

        const int64_t & get_gilded() const { return gilded; }
        int64_t & get_mutable_gilded() { return gilded; }
        void set_gilded(const int64_t & value) { this->gilded = value; }

        const bool & get_hidden() const { return hidden; }
        bool & get_mutable_hidden() { return hidden; }
        void set_hidden(const bool & value) { this->hidden = value; }

        const bool & get_hide_score() const { return hide_score; }
        bool & get_mutable_hide_score() { return hide_score; }
        void set_hide_score(const bool & value) { this->hide_score = value; }

        const std::string & get_id() const { return id; }
        std::string & get_mutable_id() { return id; }
        void set_id(const std::string & value) { this->id = value; }

        const bool & get_is_self() const { return is_self; }
        bool & get_mutable_is_self() { return is_self; }
        void set_is_self(const bool & value) { this->is_self = value; }

        const bool & get_is_video() const { return is_video; }
        bool & get_mutable_is_video() { return is_video; }
        void set_is_video(const bool & value) { this->is_video = value; }

        const nlohmann::json & get_likes() const { return likes; }
        nlohmann::json & get_mutable_likes() { return likes; }
        void set_likes(const nlohmann::json & value) { this->likes = value; }

        const nlohmann::json & get_link_flair_css_class() const { return link_flair_css_class; }
        nlohmann::json & get_mutable_link_flair_css_class() { return link_flair_css_class; }
        void set_link_flair_css_class(const nlohmann::json & value) { this->link_flair_css_class = value; }

        const nlohmann::json & get_link_flair_text() const { return link_flair_text; }
        nlohmann::json & get_mutable_link_flair_text() { return link_flair_text; }
        void set_link_flair_text(const nlohmann::json & value) { this->link_flair_text = value; }

        const bool & get_locked() const { return locked; }
        bool & get_mutable_locked() { return locked; }
        void set_locked(const bool & value) { this->locked = value; }

        const nlohmann::json & get_media() const { return media; }
        nlohmann::json & get_mutable_media() { return media; }
        void set_media(const nlohmann::json & value) { this->media = value; }

        const MediaEmbed & get_media_embed() const { return media_embed; }
        MediaEmbed & get_mutable_media_embed() { return media_embed; }
        void set_media_embed(const MediaEmbed & value) { this->media_embed = value; }

        const std::vector<nlohmann::json> & get_mod_reports() const { return mod_reports; }
        std::vector<nlohmann::json> & get_mutable_mod_reports() { return mod_reports; }
        void set_mod_reports(const std::vector<nlohmann::json> & value) { this->mod_reports = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const int64_t & get_num_comments() const { return num_comments; }
        int64_t & get_mutable_num_comments() { return num_comments; }
        void set_num_comments(const int64_t & value) { this->num_comments = value; }

        const nlohmann::json & get_num_reports() const { return num_reports; }
        nlohmann::json & get_mutable_num_reports() { return num_reports; }
        void set_num_reports(const nlohmann::json & value) { this->num_reports = value; }

        const bool & get_over_18() const { return over_18; }
        bool & get_mutable_over_18() { return over_18; }
        void set_over_18(const bool & value) { this->over_18 = value; }

        const std::string & get_permalink() const { return permalink; }
        std::string & get_mutable_permalink() { return permalink; }
        void set_permalink(const std::string & value) { this->permalink = value; }

        const std::optional<PostHint> & get_post_hint() const { return post_hint; }
        std::optional<PostHint> & get_mutable_post_hint() { return post_hint; }
        void set_post_hint(const std::optional<PostHint> & value) { this->post_hint = value; }

        const std::optional<Preview> & get_preview() const { return preview; }
        std::optional<Preview> & get_mutable_preview() { return preview; }
        void set_preview(const std::optional<Preview> & value) { this->preview = value; }

        const bool & get_quarantine() const { return quarantine; }
        bool & get_mutable_quarantine() { return quarantine; }
        void set_quarantine(const bool & value) { this->quarantine = value; }

        const nlohmann::json & get_removal_reason() const { return removal_reason; }
        nlohmann::json & get_mutable_removal_reason() { return removal_reason; }
        void set_removal_reason(const nlohmann::json & value) { this->removal_reason = value; }

        const nlohmann::json & get_report_reasons() const { return report_reasons; }
        nlohmann::json & get_mutable_report_reasons() { return report_reasons; }
        void set_report_reasons(const nlohmann::json & value) { this->report_reasons = value; }

        const bool & get_saved() const { return saved; }
        bool & get_mutable_saved() { return saved; }
        void set_saved(const bool & value) { this->saved = value; }

        const int64_t & get_score() const { return score; }
        int64_t & get_mutable_score() { return score; }
        void set_score(const int64_t & value) { this->score = value; }

        const nlohmann::json & get_secure_media() const { return secure_media; }
        nlohmann::json & get_mutable_secure_media() { return secure_media; }
        void set_secure_media(const nlohmann::json & value) { this->secure_media = value; }

        const MediaEmbed & get_secure_media_embed() const { return secure_media_embed; }
        MediaEmbed & get_mutable_secure_media_embed() { return secure_media_embed; }
        void set_secure_media_embed(const MediaEmbed & value) { this->secure_media_embed = value; }

        const std::string & get_selftext() const { return selftext; }
        std::string & get_mutable_selftext() { return selftext; }
        void set_selftext(const std::string & value) { this->selftext = value; }

        std::optional<std::string> get_selftext_html() const { return selftext_html; }
        void set_selftext_html(std::optional<std::string> value) { this->selftext_html = value; }

        const bool & get_spoiler() const { return spoiler; }
        bool & get_mutable_spoiler() { return spoiler; }
        void set_spoiler(const bool & value) { this->spoiler = value; }

        const bool & get_stickied() const { return stickied; }
        bool & get_mutable_stickied() { return stickied; }
        void set_stickied(const bool & value) { this->stickied = value; }

        const Subreddit & get_subreddit() const { return subreddit; }
        Subreddit & get_mutable_subreddit() { return subreddit; }
        void set_subreddit(const Subreddit & value) { this->subreddit = value; }

        const SubredditId & get_subreddit_id() const { return subreddit_id; }
        SubredditId & get_mutable_subreddit_id() { return subreddit_id; }
        void set_subreddit_id(const SubredditId & value) { this->subreddit_id = value; }

        const SubredditNamePrefixed & get_subreddit_name_prefixed() const { return subreddit_name_prefixed; }
        SubredditNamePrefixed & get_mutable_subreddit_name_prefixed() { return subreddit_name_prefixed; }
        void set_subreddit_name_prefixed(const SubredditNamePrefixed & value) { this->subreddit_name_prefixed = value; }

        const SubredditType & get_subreddit_type() const { return subreddit_type; }
        SubredditType & get_mutable_subreddit_type() { return subreddit_type; }
        void set_subreddit_type(const SubredditType & value) { this->subreddit_type = value; }

        std::optional<std::string> get_suggested_sort() const { return suggested_sort; }
        void set_suggested_sort(std::optional<std::string> value) { this->suggested_sort = value; }

        const std::string & get_thumbnail() const { return thumbnail; }
        std::string & get_mutable_thumbnail() { return thumbnail; }
        void set_thumbnail(const std::string & value) { this->thumbnail = value; }

        std::optional<int64_t> get_thumbnail_height() const { return thumbnail_height; }
        void set_thumbnail_height(std::optional<int64_t> value) { this->thumbnail_height = value; }

        std::optional<int64_t> get_thumbnail_width() const { return thumbnail_width; }
        void set_thumbnail_width(std::optional<int64_t> value) { this->thumbnail_width = value; }

        const std::string & get_title() const { return title; }
        std::string & get_mutable_title() { return title; }
        void set_title(const std::string & value) { this->title = value; }

        const int64_t & get_ups() const { return ups; }
        int64_t & get_mutable_ups() { return ups; }
        void set_ups(const int64_t & value) { this->ups = value; }

        const std::string & get_url() const { return url; }
        std::string & get_mutable_url() { return url; }
        void set_url(const std::string & value) { this->url = value; }

        const std::vector<nlohmann::json> & get_user_reports() const { return user_reports; }
        std::vector<nlohmann::json> & get_mutable_user_reports() { return user_reports; }
        void set_user_reports(const std::vector<nlohmann::json> & value) { this->user_reports = value; }

        const nlohmann::json & get_view_count() const { return view_count; }
        nlohmann::json & get_mutable_view_count() { return view_count; }
        void set_view_count(const nlohmann::json & value) { this->view_count = value; }

        const bool & get_visited() const { return visited; }
        bool & get_mutable_visited() { return visited; }
        void set_visited(const bool & value) { this->visited = value; }
    };

    enum class Kind : int { T3 };

    class Child {
        public:
        Child() = default;
        virtual ~Child() = default;

        private:
        ChildData data;
        Kind kind;

        public:
        const ChildData & get_data() const { return data; }
        ChildData & get_mutable_data() { return data; }
        void set_data(const ChildData & value) { this->data = value; }

        const Kind & get_kind() const { return kind; }
        Kind & get_mutable_kind() { return kind; }
        void set_kind(const Kind & value) { this->kind = value; }
    };

    class TopLevelData {
        public:
        TopLevelData() = default;
        virtual ~TopLevelData() = default;

        private:
        std::string after;
        nlohmann::json before;
        std::vector<Child> children;
        std::string modhash;

        public:
        const std::string & get_after() const { return after; }
        std::string & get_mutable_after() { return after; }
        void set_after(const std::string & value) { this->after = value; }

        const nlohmann::json & get_before() const { return before; }
        nlohmann::json & get_mutable_before() { return before; }
        void set_before(const nlohmann::json & value) { this->before = value; }

        const std::vector<Child> & get_children() const { return children; }
        std::vector<Child> & get_mutable_children() { return children; }
        void set_children(const std::vector<Child> & value) { this->children = value; }

        const std::string & get_modhash() const { return modhash; }
        std::string & get_mutable_modhash() { return modhash; }
        void set_modhash(const std::string & value) { this->modhash = value; }
    };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        TopLevelData data;
        std::string kind;

        public:
        const TopLevelData & get_data() const { return data; }
        TopLevelData & get_mutable_data() { return data; }
        void set_data(const TopLevelData & value) { this->data = value; }

        const std::string & get_kind() const { return kind; }
        std::string & get_mutable_kind() { return kind; }
        void set_kind(const std::string & value) { this->kind = value; }
    };
}

namespace quicktype {
void from_json(const json & j, MediaEmbed & x);
void to_json(json & j, const MediaEmbed & x);

void from_json(const json & j, Source & x);
void to_json(json & j, const Source & x);

void from_json(const json & j, Gif & x);
void to_json(json & j, const Gif & x);

void from_json(const json & j, Variants & x);
void to_json(json & j, const Variants & x);

void from_json(const json & j, Image & x);
void to_json(json & j, const Image & x);

void from_json(const json & j, Preview & x);
void to_json(json & j, const Preview & x);

void from_json(const json & j, ChildData & x);
void to_json(json & j, const ChildData & x);

void from_json(const json & j, Child & x);
void to_json(json & j, const Child & x);

void from_json(const json & j, TopLevelData & x);
void to_json(json & j, const TopLevelData & x);

void from_json(const json & j, TopLevel & x);
void to_json(json & j, const TopLevel & x);

void from_json(const json & j, Distinguished & x);
void to_json(json & j, const Distinguished & x);

void from_json(const json & j, Domain & x);
void to_json(json & j, const Domain & x);

void from_json(const json & j, PostHint & x);
void to_json(json & j, const PostHint & x);

void from_json(const json & j, Subreddit & x);
void to_json(json & j, const Subreddit & x);

void from_json(const json & j, SubredditId & x);
void to_json(json & j, const SubredditId & x);

void from_json(const json & j, SubredditNamePrefixed & x);
void to_json(json & j, const SubredditNamePrefixed & x);

void from_json(const json & j, SubredditType & x);
void to_json(json & j, const SubredditType & x);

void from_json(const json & j, Kind & x);
void to_json(json & j, const Kind & x);
}
namespace nlohmann {
template <>
struct adl_serializer<std::variant<bool, double>> {
    static void from_json(const json & j, std::variant<bool, double> & x);
    static void to_json(json & j, const std::variant<bool, double> & x);
};
}
namespace quicktype {
    inline void from_json(const json & j, MediaEmbed& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const MediaEmbed & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Source& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("height") != j.end() && !j.at("height").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_height(j.at("height").get<int64_t>());
        x.set_url(j.at("url").get<std::string>());
        if (j.find("width") != j.end() && !j.at("width").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_width(j.at("width").get<int64_t>());
    }

    inline void to_json(json & j, const Source & x) {
        j = json::object();
        j["height"] = x.get_height();
        j["url"] = x.get_url();
        j["width"] = x.get_width();
    }

    inline void from_json(const json & j, Gif& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_resolutions(j.at("resolutions").get<std::vector<Source>>());
        x.set_source(j.at("source").get<Source>());
    }

    inline void to_json(json & j, const Gif & x) {
        j = json::object();
        j["resolutions"] = x.get_resolutions();
        j["source"] = x.get_source();
    }

    inline void from_json(const json & j, Variants& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("gif") != j.end() && j.at("gif").is_null()) throw std::runtime_error("Unexpected null");
        x.set_gif(get_stack_optional<Gif>(j, "gif"));
        if (j.find("mp4") != j.end() && j.at("mp4").is_null()) throw std::runtime_error("Unexpected null");
        x.set_mp4(get_stack_optional<Gif>(j, "mp4"));
    }

    inline void to_json(json & j, const Variants & x) {
        j = json::object();
        j["gif"] = x.get_gif();
        j["mp4"] = x.get_mp4();
    }

    inline void from_json(const json & j, Image& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_id(j.at("id").get<std::string>());
        x.set_resolutions(j.at("resolutions").get<std::vector<Source>>());
        x.set_source(j.at("source").get<Source>());
        x.set_variants(j.at("variants").get<Variants>());
    }

    inline void to_json(json & j, const Image & x) {
        j = json::object();
        j["id"] = x.get_id();
        j["resolutions"] = x.get_resolutions();
        j["source"] = x.get_source();
        j["variants"] = x.get_variants();
    }

    inline void from_json(const json & j, Preview& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_enabled(j.at("enabled").get<bool>());
        x.set_images(j.at("images").get<std::vector<Image>>());
    }

    inline void to_json(json & j, const Preview & x) {
        j = json::object();
        j["enabled"] = x.get_enabled();
        j["images"] = x.get_images();
    }

    inline void from_json(const json & j, ChildData& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_approved_at_utc(get_untyped(j, "approved_at_utc"));
        x.set_approved_by(get_untyped(j, "approved_by"));
        x.set_archived(j.at("archived").get<bool>());
        x.set_author(j.at("author").get<std::string>());
        x.set_author_flair_css_class(get_untyped(j, "author_flair_css_class"));
        x.set_author_flair_text(get_untyped(j, "author_flair_text"));
        x.set_banned_at_utc(get_untyped(j, "banned_at_utc"));
        x.set_banned_by(get_untyped(j, "banned_by"));
        x.set_brand_safe(j.at("brand_safe").get<bool>());
        x.set_can_gild(j.at("can_gild").get<bool>());
        x.set_can_mod_post(j.at("can_mod_post").get<bool>());
        x.set_clicked(j.at("clicked").get<bool>());
        x.set_contest_mode(j.at("contest_mode").get<bool>());
        x.set_created(j.at("created").get<double>());
        x.set_created_utc(j.at("created_utc").get<double>());
        x.set_distinguished(j.at("distinguished").get<Distinguished>());
        x.set_domain(j.at("domain").get<Domain>());
        if (j.find("downs") != j.end() && !j.at("downs").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_downs(j.at("downs").get<int64_t>());
        x.set_edited(j.at("edited").get<Edited>());
        if (j.find("gilded") != j.end() && !j.at("gilded").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_gilded(j.at("gilded").get<int64_t>());
        x.set_hidden(j.at("hidden").get<bool>());
        x.set_hide_score(j.at("hide_score").get<bool>());
        x.set_id(j.at("id").get<std::string>());
        x.set_is_self(j.at("is_self").get<bool>());
        x.set_is_video(j.at("is_video").get<bool>());
        x.set_likes(get_untyped(j, "likes"));
        x.set_link_flair_css_class(get_untyped(j, "link_flair_css_class"));
        x.set_link_flair_text(get_untyped(j, "link_flair_text"));
        x.set_locked(j.at("locked").get<bool>());
        x.set_media(get_untyped(j, "media"));
        x.set_media_embed(j.at("media_embed").get<MediaEmbed>());
        x.set_mod_reports(j.at("mod_reports").get<std::vector<nlohmann::json>>());
        x.set_name(j.at("name").get<std::string>());
        if (j.find("num_comments") != j.end() && !j.at("num_comments").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_num_comments(j.at("num_comments").get<int64_t>());
        x.set_num_reports(get_untyped(j, "num_reports"));
        x.set_over_18(j.at("over_18").get<bool>());
        x.set_permalink(j.at("permalink").get<std::string>());
        if (j.find("post_hint") != j.end() && j.at("post_hint").is_null()) throw std::runtime_error("Unexpected null");
        x.set_post_hint(get_stack_optional<PostHint>(j, "post_hint"));
        if (j.find("preview") != j.end() && j.at("preview").is_null()) throw std::runtime_error("Unexpected null");
        x.set_preview(get_stack_optional<Preview>(j, "preview"));
        x.set_quarantine(j.at("quarantine").get<bool>());
        x.set_removal_reason(get_untyped(j, "removal_reason"));
        x.set_report_reasons(get_untyped(j, "report_reasons"));
        x.set_saved(j.at("saved").get<bool>());
        if (j.find("score") != j.end() && !j.at("score").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_score(j.at("score").get<int64_t>());
        x.set_secure_media(get_untyped(j, "secure_media"));
        x.set_secure_media_embed(j.at("secure_media_embed").get<MediaEmbed>());
        x.set_selftext(j.at("selftext").get<std::string>());
        j.at("selftext_html");
        x.set_selftext_html(get_stack_optional<std::string>(j, "selftext_html"));
        x.set_spoiler(j.at("spoiler").get<bool>());
        x.set_stickied(j.at("stickied").get<bool>());
        x.set_subreddit(j.at("subreddit").get<Subreddit>());
        x.set_subreddit_id(j.at("subreddit_id").get<SubredditId>());
        x.set_subreddit_name_prefixed(j.at("subreddit_name_prefixed").get<SubredditNamePrefixed>());
        x.set_subreddit_type(j.at("subreddit_type").get<SubredditType>());
        j.at("suggested_sort");
        x.set_suggested_sort(get_stack_optional<std::string>(j, "suggested_sort"));
        x.set_thumbnail(j.at("thumbnail").get<std::string>());
        j.at("thumbnail_height");
        x.set_thumbnail_height(get_stack_optional<int64_t>(j, "thumbnail_height"));
        j.at("thumbnail_width");
        x.set_thumbnail_width(get_stack_optional<int64_t>(j, "thumbnail_width"));
        x.set_title(j.at("title").get<std::string>());
        if (j.find("ups") != j.end() && !j.at("ups").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_ups(j.at("ups").get<int64_t>());
        x.set_url(j.at("url").get<std::string>());
        x.set_user_reports(j.at("user_reports").get<std::vector<nlohmann::json>>());
        x.set_view_count(get_untyped(j, "view_count"));
        x.set_visited(j.at("visited").get<bool>());
    }

    inline void to_json(json & j, const ChildData & x) {
        j = json::object();
        j["approved_at_utc"] = x.get_approved_at_utc();
        j["approved_by"] = x.get_approved_by();
        j["archived"] = x.get_archived();
        j["author"] = x.get_author();
        j["author_flair_css_class"] = x.get_author_flair_css_class();
        j["author_flair_text"] = x.get_author_flair_text();
        j["banned_at_utc"] = x.get_banned_at_utc();
        j["banned_by"] = x.get_banned_by();
        j["brand_safe"] = x.get_brand_safe();
        j["can_gild"] = x.get_can_gild();
        j["can_mod_post"] = x.get_can_mod_post();
        j["clicked"] = x.get_clicked();
        j["contest_mode"] = x.get_contest_mode();
        j["created"] = x.get_created();
        j["created_utc"] = x.get_created_utc();
        j["distinguished"] = x.get_distinguished();
        j["domain"] = x.get_domain();
        j["downs"] = x.get_downs();
        j["edited"] = x.get_edited();
        j["gilded"] = x.get_gilded();
        j["hidden"] = x.get_hidden();
        j["hide_score"] = x.get_hide_score();
        j["id"] = x.get_id();
        j["is_self"] = x.get_is_self();
        j["is_video"] = x.get_is_video();
        j["likes"] = x.get_likes();
        j["link_flair_css_class"] = x.get_link_flair_css_class();
        j["link_flair_text"] = x.get_link_flair_text();
        j["locked"] = x.get_locked();
        j["media"] = x.get_media();
        j["media_embed"] = x.get_media_embed();
        j["mod_reports"] = x.get_mod_reports();
        j["name"] = x.get_name();
        j["num_comments"] = x.get_num_comments();
        j["num_reports"] = x.get_num_reports();
        j["over_18"] = x.get_over_18();
        j["permalink"] = x.get_permalink();
        j["post_hint"] = x.get_post_hint();
        j["preview"] = x.get_preview();
        j["quarantine"] = x.get_quarantine();
        j["removal_reason"] = x.get_removal_reason();
        j["report_reasons"] = x.get_report_reasons();
        j["saved"] = x.get_saved();
        j["score"] = x.get_score();
        j["secure_media"] = x.get_secure_media();
        j["secure_media_embed"] = x.get_secure_media_embed();
        j["selftext"] = x.get_selftext();
        j["selftext_html"] = x.get_selftext_html();
        j["spoiler"] = x.get_spoiler();
        j["stickied"] = x.get_stickied();
        j["subreddit"] = x.get_subreddit();
        j["subreddit_id"] = x.get_subreddit_id();
        j["subreddit_name_prefixed"] = x.get_subreddit_name_prefixed();
        j["subreddit_type"] = x.get_subreddit_type();
        j["suggested_sort"] = x.get_suggested_sort();
        j["thumbnail"] = x.get_thumbnail();
        j["thumbnail_height"] = x.get_thumbnail_height();
        j["thumbnail_width"] = x.get_thumbnail_width();
        j["title"] = x.get_title();
        j["ups"] = x.get_ups();
        j["url"] = x.get_url();
        j["user_reports"] = x.get_user_reports();
        j["view_count"] = x.get_view_count();
        j["visited"] = x.get_visited();
    }

    inline void from_json(const json & j, Child& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_data(j.at("data").get<ChildData>());
        x.set_kind(j.at("kind").get<Kind>());
    }

    inline void to_json(json & j, const Child & x) {
        j = json::object();
        j["data"] = x.get_data();
        j["kind"] = x.get_kind();
    }

    inline void from_json(const json & j, TopLevelData& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_after(j.at("after").get<std::string>());
        x.set_before(get_untyped(j, "before"));
        x.set_children(j.at("children").get<std::vector<Child>>());
        x.set_modhash(j.at("modhash").get<std::string>());
    }

    inline void to_json(json & j, const TopLevelData & x) {
        j = json::object();
        j["after"] = x.get_after();
        j["before"] = x.get_before();
        j["children"] = x.get_children();
        j["modhash"] = x.get_modhash();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_data(j.at("data").get<TopLevelData>());
        x.set_kind(j.at("kind").get<std::string>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["data"] = x.get_data();
        j["kind"] = x.get_kind();
    }

    inline void from_json(const json & j, Distinguished & x) {
        if (j == "admin") x = Distinguished::ADMIN;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Distinguished\""); }
    }

    inline void to_json(json & j, const Distinguished & x) {
        switch (x) {
            case Distinguished::ADMIN: j = "admin"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Distinguished\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, Domain & x) {
        if (j == "self.announcements") x = Domain::SELF_ANNOUNCEMENTS;
        else if (j == "i.redd.it") x = Domain::I_REDD_IT;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Domain\""); }
    }

    inline void to_json(json & j, const Domain & x) {
        switch (x) {
            case Domain::SELF_ANNOUNCEMENTS: j = "self.announcements"; break;
            case Domain::I_REDD_IT: j = "i.redd.it"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Domain\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, PostHint & x) {
        if (j == "self") x = PostHint::SELF;
        else if (j == "image") x = PostHint::IMAGE;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"PostHint\""); }
    }

    inline void to_json(json & j, const PostHint & x) {
        switch (x) {
            case PostHint::SELF: j = "self"; break;
            case PostHint::IMAGE: j = "image"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"PostHint\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, Subreddit & x) {
        if (j == "announcements") x = Subreddit::ANNOUNCEMENTS;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Subreddit\""); }
    }

    inline void to_json(json & j, const Subreddit & x) {
        switch (x) {
            case Subreddit::ANNOUNCEMENTS: j = "announcements"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Subreddit\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, SubredditId & x) {
        if (j == "t5_2r0ij") x = SubredditId::T5_2_R0_IJ;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"SubredditId\""); }
    }

    inline void to_json(json & j, const SubredditId & x) {
        switch (x) {
            case SubredditId::T5_2_R0_IJ: j = "t5_2r0ij"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"SubredditId\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, SubredditNamePrefixed & x) {
        if (j == "r/announcements") x = SubredditNamePrefixed::R_ANNOUNCEMENTS;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"SubredditNamePrefixed\""); }
    }

    inline void to_json(json & j, const SubredditNamePrefixed & x) {
        switch (x) {
            case SubredditNamePrefixed::R_ANNOUNCEMENTS: j = "r/announcements"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"SubredditNamePrefixed\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, SubredditType & x) {
        if (j == "restricted") x = SubredditType::RESTRICTED;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"SubredditType\""); }
    }

    inline void to_json(json & j, const SubredditType & x) {
        switch (x) {
            case SubredditType::RESTRICTED: j = "restricted"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"SubredditType\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, Kind & x) {
        if (j == "t3") x = Kind::T3;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Kind\""); }
    }

    inline void to_json(json & j, const Kind & x) {
        switch (x) {
            case Kind::T3: j = "t3"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Kind\": " + std::to_string(static_cast<int>(x)));
        }
    }
}
namespace nlohmann {
    inline void adl_serializer<std::variant<bool, double>>::from_json(const json & j, std::variant<bool, double> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_number())
            x = j.get<double>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<bool, double>>::to_json(json & j, const std::variant<bool, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<bool>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }
}
