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

    class The480_WStill {
        public:
        The480_WStill() = default;
        virtual ~The480_WStill() = default;

        private:
        std::string height;
        std::optional<std::string> size;
        std::string url;
        std::string width;

        public:
        const std::string & get_height() const { return height; }
        std::string & get_mutable_height() { return height; }
        void set_height(const std::string & value) { this->height = value; }

        const std::optional<std::string> & get_size() const { return size; }
        std::optional<std::string> & get_mutable_size() { return size; }
        void set_size(const std::optional<std::string> & value) { this->size = value; }

        const std::string & get_url() const { return url; }
        std::string & get_mutable_url() { return url; }
        void set_url(const std::string & value) { this->url = value; }

        const std::string & get_width() const { return width; }
        std::string & get_mutable_width() { return width; }
        void set_width(const std::string & value) { this->width = value; }
    };

    class DownsizedSmall {
        public:
        DownsizedSmall() = default;
        virtual ~DownsizedSmall() = default;

        private:
        std::string height;
        std::string mp4;
        std::string mp4_size;
        std::string width;

        public:
        const std::string & get_height() const { return height; }
        std::string & get_mutable_height() { return height; }
        void set_height(const std::string & value) { this->height = value; }

        const std::string & get_mp4() const { return mp4; }
        std::string & get_mutable_mp4() { return mp4; }
        void set_mp4(const std::string & value) { this->mp4 = value; }

        const std::string & get_mp4_size() const { return mp4_size; }
        std::string & get_mutable_mp4_size() { return mp4_size; }
        void set_mp4_size(const std::string & value) { this->mp4_size = value; }

        const std::string & get_width() const { return width; }
        std::string & get_mutable_width() { return width; }
        void set_width(const std::string & value) { this->width = value; }
    };

    class FixedHeight {
        public:
        FixedHeight() = default;
        virtual ~FixedHeight() = default;

        private:
        std::optional<std::string> frames;
        std::optional<std::string> hash;
        std::string height;
        std::optional<std::string> mp4;
        std::optional<std::string> mp4_size;
        std::string size;
        std::string url;
        std::string webp;
        std::string webp_size;
        std::string width;

        public:
        const std::optional<std::string> & get_frames() const { return frames; }
        std::optional<std::string> & get_mutable_frames() { return frames; }
        void set_frames(const std::optional<std::string> & value) { this->frames = value; }

        const std::optional<std::string> & get_hash() const { return hash; }
        std::optional<std::string> & get_mutable_hash() { return hash; }
        void set_hash(const std::optional<std::string> & value) { this->hash = value; }

        const std::string & get_height() const { return height; }
        std::string & get_mutable_height() { return height; }
        void set_height(const std::string & value) { this->height = value; }

        const std::optional<std::string> & get_mp4() const { return mp4; }
        std::optional<std::string> & get_mutable_mp4() { return mp4; }
        void set_mp4(const std::optional<std::string> & value) { this->mp4 = value; }

        const std::optional<std::string> & get_mp4_size() const { return mp4_size; }
        std::optional<std::string> & get_mutable_mp4_size() { return mp4_size; }
        void set_mp4_size(const std::optional<std::string> & value) { this->mp4_size = value; }

        const std::string & get_size() const { return size; }
        std::string & get_mutable_size() { return size; }
        void set_size(const std::string & value) { this->size = value; }

        const std::string & get_url() const { return url; }
        std::string & get_mutable_url() { return url; }
        void set_url(const std::string & value) { this->url = value; }

        const std::string & get_webp() const { return webp; }
        std::string & get_mutable_webp() { return webp; }
        void set_webp(const std::string & value) { this->webp = value; }

        const std::string & get_webp_size() const { return webp_size; }
        std::string & get_mutable_webp_size() { return webp_size; }
        void set_webp_size(const std::string & value) { this->webp_size = value; }

        const std::string & get_width() const { return width; }
        std::string & get_mutable_width() { return width; }
        void set_width(const std::string & value) { this->width = value; }
    };

    class Looping {
        public:
        Looping() = default;
        virtual ~Looping() = default;

        private:
        std::string mp4;
        std::string mp4_size;

        public:
        const std::string & get_mp4() const { return mp4; }
        std::string & get_mutable_mp4() { return mp4; }
        void set_mp4(const std::string & value) { this->mp4 = value; }

        const std::string & get_mp4_size() const { return mp4_size; }
        std::string & get_mutable_mp4_size() { return mp4_size; }
        void set_mp4_size(const std::string & value) { this->mp4_size = value; }
    };

    class Images {
        public:
        Images() = default;
        virtual ~Images() = default;

        private:
        The480_WStill downsized;
        The480_WStill downsized_large;
        The480_WStill downsized_medium;
        DownsizedSmall downsized_small;
        The480_WStill downsized_still;
        FixedHeight fixed_height;
        FixedHeight fixed_height_downsampled;
        FixedHeight fixed_height_small;
        The480_WStill fixed_height_small_still;
        The480_WStill fixed_height_still;
        FixedHeight fixed_width;
        FixedHeight fixed_width_downsampled;
        FixedHeight fixed_width_small;
        The480_WStill fixed_width_small_still;
        The480_WStill fixed_width_still;
        Looping looping;
        FixedHeight original;
        DownsizedSmall original_mp4;
        The480_WStill original_still;
        DownsizedSmall preview;
        The480_WStill preview_gif;
        The480_WStill preview_webp;
        std::optional<The480_WStill> the_480_w_still;

        public:
        const The480_WStill & get_downsized() const { return downsized; }
        The480_WStill & get_mutable_downsized() { return downsized; }
        void set_downsized(const The480_WStill & value) { this->downsized = value; }

        const The480_WStill & get_downsized_large() const { return downsized_large; }
        The480_WStill & get_mutable_downsized_large() { return downsized_large; }
        void set_downsized_large(const The480_WStill & value) { this->downsized_large = value; }

        const The480_WStill & get_downsized_medium() const { return downsized_medium; }
        The480_WStill & get_mutable_downsized_medium() { return downsized_medium; }
        void set_downsized_medium(const The480_WStill & value) { this->downsized_medium = value; }

        const DownsizedSmall & get_downsized_small() const { return downsized_small; }
        DownsizedSmall & get_mutable_downsized_small() { return downsized_small; }
        void set_downsized_small(const DownsizedSmall & value) { this->downsized_small = value; }

        const The480_WStill & get_downsized_still() const { return downsized_still; }
        The480_WStill & get_mutable_downsized_still() { return downsized_still; }
        void set_downsized_still(const The480_WStill & value) { this->downsized_still = value; }

        const FixedHeight & get_fixed_height() const { return fixed_height; }
        FixedHeight & get_mutable_fixed_height() { return fixed_height; }
        void set_fixed_height(const FixedHeight & value) { this->fixed_height = value; }

        const FixedHeight & get_fixed_height_downsampled() const { return fixed_height_downsampled; }
        FixedHeight & get_mutable_fixed_height_downsampled() { return fixed_height_downsampled; }
        void set_fixed_height_downsampled(const FixedHeight & value) { this->fixed_height_downsampled = value; }

        const FixedHeight & get_fixed_height_small() const { return fixed_height_small; }
        FixedHeight & get_mutable_fixed_height_small() { return fixed_height_small; }
        void set_fixed_height_small(const FixedHeight & value) { this->fixed_height_small = value; }

        const The480_WStill & get_fixed_height_small_still() const { return fixed_height_small_still; }
        The480_WStill & get_mutable_fixed_height_small_still() { return fixed_height_small_still; }
        void set_fixed_height_small_still(const The480_WStill & value) { this->fixed_height_small_still = value; }

        const The480_WStill & get_fixed_height_still() const { return fixed_height_still; }
        The480_WStill & get_mutable_fixed_height_still() { return fixed_height_still; }
        void set_fixed_height_still(const The480_WStill & value) { this->fixed_height_still = value; }

        const FixedHeight & get_fixed_width() const { return fixed_width; }
        FixedHeight & get_mutable_fixed_width() { return fixed_width; }
        void set_fixed_width(const FixedHeight & value) { this->fixed_width = value; }

        const FixedHeight & get_fixed_width_downsampled() const { return fixed_width_downsampled; }
        FixedHeight & get_mutable_fixed_width_downsampled() { return fixed_width_downsampled; }
        void set_fixed_width_downsampled(const FixedHeight & value) { this->fixed_width_downsampled = value; }

        const FixedHeight & get_fixed_width_small() const { return fixed_width_small; }
        FixedHeight & get_mutable_fixed_width_small() { return fixed_width_small; }
        void set_fixed_width_small(const FixedHeight & value) { this->fixed_width_small = value; }

        const The480_WStill & get_fixed_width_small_still() const { return fixed_width_small_still; }
        The480_WStill & get_mutable_fixed_width_small_still() { return fixed_width_small_still; }
        void set_fixed_width_small_still(const The480_WStill & value) { this->fixed_width_small_still = value; }

        const The480_WStill & get_fixed_width_still() const { return fixed_width_still; }
        The480_WStill & get_mutable_fixed_width_still() { return fixed_width_still; }
        void set_fixed_width_still(const The480_WStill & value) { this->fixed_width_still = value; }

        const Looping & get_looping() const { return looping; }
        Looping & get_mutable_looping() { return looping; }
        void set_looping(const Looping & value) { this->looping = value; }

        const FixedHeight & get_original() const { return original; }
        FixedHeight & get_mutable_original() { return original; }
        void set_original(const FixedHeight & value) { this->original = value; }

        const DownsizedSmall & get_original_mp4() const { return original_mp4; }
        DownsizedSmall & get_mutable_original_mp4() { return original_mp4; }
        void set_original_mp4(const DownsizedSmall & value) { this->original_mp4 = value; }

        const The480_WStill & get_original_still() const { return original_still; }
        The480_WStill & get_mutable_original_still() { return original_still; }
        void set_original_still(const The480_WStill & value) { this->original_still = value; }

        const DownsizedSmall & get_preview() const { return preview; }
        DownsizedSmall & get_mutable_preview() { return preview; }
        void set_preview(const DownsizedSmall & value) { this->preview = value; }

        const The480_WStill & get_preview_gif() const { return preview_gif; }
        The480_WStill & get_mutable_preview_gif() { return preview_gif; }
        void set_preview_gif(const The480_WStill & value) { this->preview_gif = value; }

        const The480_WStill & get_preview_webp() const { return preview_webp; }
        The480_WStill & get_mutable_preview_webp() { return preview_webp; }
        void set_preview_webp(const The480_WStill & value) { this->preview_webp = value; }

        const std::optional<The480_WStill> & get_the_480__w_still() const { return the_480_w_still; }
        std::optional<The480_WStill> & get_mutable_the_480__w_still() { return the_480_w_still; }
        void set_the_480__w_still(const std::optional<The480_WStill> & value) { this->the_480_w_still = value; }
    };

    enum class Rating : int { G, PG };

    enum class Type : int { GIF };

    enum class Username : int { CHEEZBURGER, EMPTY, NATGEOWILD, NOWTHIS };

    class User {
        public:
        User() = default;
        virtual ~User() = default;

        private:
        std::string avatar_url;
        std::string banner_url;
        std::string display_name;
        std::string profile_url;
        std::string twitter;
        Username username;

        public:
        const std::string & get_avatar_url() const { return avatar_url; }
        std::string & get_mutable_avatar_url() { return avatar_url; }
        void set_avatar_url(const std::string & value) { this->avatar_url = value; }

        const std::string & get_banner_url() const { return banner_url; }
        std::string & get_mutable_banner_url() { return banner_url; }
        void set_banner_url(const std::string & value) { this->banner_url = value; }

        const std::string & get_display_name() const { return display_name; }
        std::string & get_mutable_display_name() { return display_name; }
        void set_display_name(const std::string & value) { this->display_name = value; }

        const std::string & get_profile_url() const { return profile_url; }
        std::string & get_mutable_profile_url() { return profile_url; }
        void set_profile_url(const std::string & value) { this->profile_url = value; }

        const std::string & get_twitter() const { return twitter; }
        std::string & get_mutable_twitter() { return twitter; }
        void set_twitter(const std::string & value) { this->twitter = value; }

        const Username & get_username() const { return username; }
        Username & get_mutable_username() { return username; }
        void set_username(const Username & value) { this->username = value; }
    };

    class Datum {
        public:
        Datum() = default;
        virtual ~Datum() = default;

        private:
        std::string bitly_gif_url;
        std::string bitly_url;
        std::string content_url;
        std::string embed_url;
        std::string id;
        Images images;
        std::string import_datetime;
        int64_t is_indexable;
        Rating rating;
        std::string slug;
        std::string source;
        std::string source_post_url;
        std::string source_tld;
        std::string trending_datetime;
        Type type;
        std::string url;
        std::optional<User> user;
        Username username;

        public:
        const std::string & get_bitly_gif_url() const { return bitly_gif_url; }
        std::string & get_mutable_bitly_gif_url() { return bitly_gif_url; }
        void set_bitly_gif_url(const std::string & value) { this->bitly_gif_url = value; }

        const std::string & get_bitly_url() const { return bitly_url; }
        std::string & get_mutable_bitly_url() { return bitly_url; }
        void set_bitly_url(const std::string & value) { this->bitly_url = value; }

        const std::string & get_content_url() const { return content_url; }
        std::string & get_mutable_content_url() { return content_url; }
        void set_content_url(const std::string & value) { this->content_url = value; }

        const std::string & get_embed_url() const { return embed_url; }
        std::string & get_mutable_embed_url() { return embed_url; }
        void set_embed_url(const std::string & value) { this->embed_url = value; }

        const std::string & get_id() const { return id; }
        std::string & get_mutable_id() { return id; }
        void set_id(const std::string & value) { this->id = value; }

        const Images & get_images() const { return images; }
        Images & get_mutable_images() { return images; }
        void set_images(const Images & value) { this->images = value; }

        const std::string & get_import_datetime() const { return import_datetime; }
        std::string & get_mutable_import_datetime() { return import_datetime; }
        void set_import_datetime(const std::string & value) { this->import_datetime = value; }

        const int64_t & get_is_indexable() const { return is_indexable; }
        int64_t & get_mutable_is_indexable() { return is_indexable; }
        void set_is_indexable(const int64_t & value) { this->is_indexable = value; }

        const Rating & get_rating() const { return rating; }
        Rating & get_mutable_rating() { return rating; }
        void set_rating(const Rating & value) { this->rating = value; }

        const std::string & get_slug() const { return slug; }
        std::string & get_mutable_slug() { return slug; }
        void set_slug(const std::string & value) { this->slug = value; }

        const std::string & get_source() const { return source; }
        std::string & get_mutable_source() { return source; }
        void set_source(const std::string & value) { this->source = value; }

        const std::string & get_source_post_url() const { return source_post_url; }
        std::string & get_mutable_source_post_url() { return source_post_url; }
        void set_source_post_url(const std::string & value) { this->source_post_url = value; }

        const std::string & get_source_tld() const { return source_tld; }
        std::string & get_mutable_source_tld() { return source_tld; }
        void set_source_tld(const std::string & value) { this->source_tld = value; }

        const std::string & get_trending_datetime() const { return trending_datetime; }
        std::string & get_mutable_trending_datetime() { return trending_datetime; }
        void set_trending_datetime(const std::string & value) { this->trending_datetime = value; }

        const Type & get_type() const { return type; }
        Type & get_mutable_type() { return type; }
        void set_type(const Type & value) { this->type = value; }

        const std::string & get_url() const { return url; }
        std::string & get_mutable_url() { return url; }
        void set_url(const std::string & value) { this->url = value; }

        const std::optional<User> & get_user() const { return user; }
        std::optional<User> & get_mutable_user() { return user; }
        void set_user(const std::optional<User> & value) { this->user = value; }

        const Username & get_username() const { return username; }
        Username & get_mutable_username() { return username; }
        void set_username(const Username & value) { this->username = value; }
    };

    class Meta {
        public:
        Meta() = default;
        virtual ~Meta() = default;

        private:
        std::string msg;
        std::string response_id;
        int64_t status;

        public:
        const std::string & get_msg() const { return msg; }
        std::string & get_mutable_msg() { return msg; }
        void set_msg(const std::string & value) { this->msg = value; }

        const std::string & get_response_id() const { return response_id; }
        std::string & get_mutable_response_id() { return response_id; }
        void set_response_id(const std::string & value) { this->response_id = value; }

        const int64_t & get_status() const { return status; }
        int64_t & get_mutable_status() { return status; }
        void set_status(const int64_t & value) { this->status = value; }
    };

    class Pagination {
        public:
        Pagination() = default;
        virtual ~Pagination() = default;

        private:
        int64_t count;
        int64_t offset;
        int64_t total_count;

        public:
        const int64_t & get_count() const { return count; }
        int64_t & get_mutable_count() { return count; }
        void set_count(const int64_t & value) { this->count = value; }

        const int64_t & get_offset() const { return offset; }
        int64_t & get_mutable_offset() { return offset; }
        void set_offset(const int64_t & value) { this->offset = value; }

        const int64_t & get_total_count() const { return total_count; }
        int64_t & get_mutable_total_count() { return total_count; }
        void set_total_count(const int64_t & value) { this->total_count = value; }
    };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        std::vector<Datum> data;
        Meta meta;
        Pagination pagination;

        public:
        const std::vector<Datum> & get_data() const { return data; }
        std::vector<Datum> & get_mutable_data() { return data; }
        void set_data(const std::vector<Datum> & value) { this->data = value; }

        const Meta & get_meta() const { return meta; }
        Meta & get_mutable_meta() { return meta; }
        void set_meta(const Meta & value) { this->meta = value; }

        const Pagination & get_pagination() const { return pagination; }
        Pagination & get_mutable_pagination() { return pagination; }
        void set_pagination(const Pagination & value) { this->pagination = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, The480_WStill & x);
    void to_json(json & j, const The480_WStill & x);

    void from_json(const json & j, DownsizedSmall & x);
    void to_json(json & j, const DownsizedSmall & x);

    void from_json(const json & j, FixedHeight & x);
    void to_json(json & j, const FixedHeight & x);

    void from_json(const json & j, Looping & x);
    void to_json(json & j, const Looping & x);

    void from_json(const json & j, Images & x);
    void to_json(json & j, const Images & x);

    void from_json(const json & j, User & x);
    void to_json(json & j, const User & x);

    void from_json(const json & j, Datum & x);
    void to_json(json & j, const Datum & x);

    void from_json(const json & j, Meta & x);
    void to_json(json & j, const Meta & x);

    void from_json(const json & j, Pagination & x);
    void to_json(json & j, const Pagination & x);

    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    void from_json(const json & j, Rating & x);
    void to_json(json & j, const Rating & x);

    void from_json(const json & j, Type & x);
    void to_json(json & j, const Type & x);

    void from_json(const json & j, Username & x);
    void to_json(json & j, const Username & x);

    inline void from_json(const json & j, The480_WStill& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_height(j.at("height").get<std::string>());
        if (j.find("size") != j.end() && j.at("size").is_null()) throw std::runtime_error("Unexpected null");
        x.set_size(get_stack_optional<std::string>(j, "size"));
        x.set_url(j.at("url").get<std::string>());
        x.set_width(j.at("width").get<std::string>());
    }

    inline void to_json(json & j, const The480_WStill & x) {
        j = json::object();
        j["height"] = x.get_height();
        j["size"] = x.get_size();
        j["url"] = x.get_url();
        j["width"] = x.get_width();
    }

    inline void from_json(const json & j, DownsizedSmall& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_height(j.at("height").get<std::string>());
        x.set_mp4(j.at("mp4").get<std::string>());
        x.set_mp4_size(j.at("mp4_size").get<std::string>());
        x.set_width(j.at("width").get<std::string>());
    }

    inline void to_json(json & j, const DownsizedSmall & x) {
        j = json::object();
        j["height"] = x.get_height();
        j["mp4"] = x.get_mp4();
        j["mp4_size"] = x.get_mp4_size();
        j["width"] = x.get_width();
    }

    inline void from_json(const json & j, FixedHeight& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("frames") != j.end() && j.at("frames").is_null()) throw std::runtime_error("Unexpected null");
        x.set_frames(get_stack_optional<std::string>(j, "frames"));
        if (j.find("hash") != j.end() && j.at("hash").is_null()) throw std::runtime_error("Unexpected null");
        x.set_hash(get_stack_optional<std::string>(j, "hash"));
        x.set_height(j.at("height").get<std::string>());
        if (j.find("mp4") != j.end() && j.at("mp4").is_null()) throw std::runtime_error("Unexpected null");
        x.set_mp4(get_stack_optional<std::string>(j, "mp4"));
        if (j.find("mp4_size") != j.end() && j.at("mp4_size").is_null()) throw std::runtime_error("Unexpected null");
        x.set_mp4_size(get_stack_optional<std::string>(j, "mp4_size"));
        x.set_size(j.at("size").get<std::string>());
        x.set_url(j.at("url").get<std::string>());
        x.set_webp(j.at("webp").get<std::string>());
        x.set_webp_size(j.at("webp_size").get<std::string>());
        x.set_width(j.at("width").get<std::string>());
    }

    inline void to_json(json & j, const FixedHeight & x) {
        j = json::object();
        j["frames"] = x.get_frames();
        j["hash"] = x.get_hash();
        j["height"] = x.get_height();
        j["mp4"] = x.get_mp4();
        j["mp4_size"] = x.get_mp4_size();
        j["size"] = x.get_size();
        j["url"] = x.get_url();
        j["webp"] = x.get_webp();
        j["webp_size"] = x.get_webp_size();
        j["width"] = x.get_width();
    }

    inline void from_json(const json & j, Looping& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_mp4(j.at("mp4").get<std::string>());
        x.set_mp4_size(j.at("mp4_size").get<std::string>());
    }

    inline void to_json(json & j, const Looping & x) {
        j = json::object();
        j["mp4"] = x.get_mp4();
        j["mp4_size"] = x.get_mp4_size();
    }

    inline void from_json(const json & j, Images& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_downsized(j.at("downsized").get<The480_WStill>());
        x.set_downsized_large(j.at("downsized_large").get<The480_WStill>());
        x.set_downsized_medium(j.at("downsized_medium").get<The480_WStill>());
        x.set_downsized_small(j.at("downsized_small").get<DownsizedSmall>());
        x.set_downsized_still(j.at("downsized_still").get<The480_WStill>());
        x.set_fixed_height(j.at("fixed_height").get<FixedHeight>());
        x.set_fixed_height_downsampled(j.at("fixed_height_downsampled").get<FixedHeight>());
        x.set_fixed_height_small(j.at("fixed_height_small").get<FixedHeight>());
        x.set_fixed_height_small_still(j.at("fixed_height_small_still").get<The480_WStill>());
        x.set_fixed_height_still(j.at("fixed_height_still").get<The480_WStill>());
        x.set_fixed_width(j.at("fixed_width").get<FixedHeight>());
        x.set_fixed_width_downsampled(j.at("fixed_width_downsampled").get<FixedHeight>());
        x.set_fixed_width_small(j.at("fixed_width_small").get<FixedHeight>());
        x.set_fixed_width_small_still(j.at("fixed_width_small_still").get<The480_WStill>());
        x.set_fixed_width_still(j.at("fixed_width_still").get<The480_WStill>());
        x.set_looping(j.at("looping").get<Looping>());
        x.set_original(j.at("original").get<FixedHeight>());
        x.set_original_mp4(j.at("original_mp4").get<DownsizedSmall>());
        x.set_original_still(j.at("original_still").get<The480_WStill>());
        x.set_preview(j.at("preview").get<DownsizedSmall>());
        x.set_preview_gif(j.at("preview_gif").get<The480_WStill>());
        x.set_preview_webp(j.at("preview_webp").get<The480_WStill>());
        if (j.find("480w_still") != j.end() && j.at("480w_still").is_null()) throw std::runtime_error("Unexpected null");
        x.set_the_480__w_still(get_stack_optional<The480_WStill>(j, "480w_still"));
    }

    inline void to_json(json & j, const Images & x) {
        j = json::object();
        j["downsized"] = x.get_downsized();
        j["downsized_large"] = x.get_downsized_large();
        j["downsized_medium"] = x.get_downsized_medium();
        j["downsized_small"] = x.get_downsized_small();
        j["downsized_still"] = x.get_downsized_still();
        j["fixed_height"] = x.get_fixed_height();
        j["fixed_height_downsampled"] = x.get_fixed_height_downsampled();
        j["fixed_height_small"] = x.get_fixed_height_small();
        j["fixed_height_small_still"] = x.get_fixed_height_small_still();
        j["fixed_height_still"] = x.get_fixed_height_still();
        j["fixed_width"] = x.get_fixed_width();
        j["fixed_width_downsampled"] = x.get_fixed_width_downsampled();
        j["fixed_width_small"] = x.get_fixed_width_small();
        j["fixed_width_small_still"] = x.get_fixed_width_small_still();
        j["fixed_width_still"] = x.get_fixed_width_still();
        j["looping"] = x.get_looping();
        j["original"] = x.get_original();
        j["original_mp4"] = x.get_original_mp4();
        j["original_still"] = x.get_original_still();
        j["preview"] = x.get_preview();
        j["preview_gif"] = x.get_preview_gif();
        j["preview_webp"] = x.get_preview_webp();
        j["480w_still"] = x.get_the_480__w_still();
    }

    inline void from_json(const json & j, User& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_avatar_url(j.at("avatar_url").get<std::string>());
        x.set_banner_url(j.at("banner_url").get<std::string>());
        x.set_display_name(j.at("display_name").get<std::string>());
        x.set_profile_url(j.at("profile_url").get<std::string>());
        x.set_twitter(j.at("twitter").get<std::string>());
        x.set_username(j.at("username").get<Username>());
    }

    inline void to_json(json & j, const User & x) {
        j = json::object();
        j["avatar_url"] = x.get_avatar_url();
        j["banner_url"] = x.get_banner_url();
        j["display_name"] = x.get_display_name();
        j["profile_url"] = x.get_profile_url();
        j["twitter"] = x.get_twitter();
        j["username"] = x.get_username();
    }

    inline void from_json(const json & j, Datum& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_bitly_gif_url(j.at("bitly_gif_url").get<std::string>());
        x.set_bitly_url(j.at("bitly_url").get<std::string>());
        x.set_content_url(j.at("content_url").get<std::string>());
        x.set_embed_url(j.at("embed_url").get<std::string>());
        x.set_id(j.at("id").get<std::string>());
        x.set_images(j.at("images").get<Images>());
        x.set_import_datetime(j.at("import_datetime").get<std::string>());
        if (j.find("is_indexable") != j.end() && !j.at("is_indexable").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_is_indexable(j.at("is_indexable").get<int64_t>());
        x.set_rating(j.at("rating").get<Rating>());
        x.set_slug(j.at("slug").get<std::string>());
        x.set_source(j.at("source").get<std::string>());
        x.set_source_post_url(j.at("source_post_url").get<std::string>());
        x.set_source_tld(j.at("source_tld").get<std::string>());
        x.set_trending_datetime(j.at("trending_datetime").get<std::string>());
        x.set_type(j.at("type").get<Type>());
        x.set_url(j.at("url").get<std::string>());
        if (j.find("user") != j.end() && j.at("user").is_null()) throw std::runtime_error("Unexpected null");
        x.set_user(get_stack_optional<User>(j, "user"));
        x.set_username(j.at("username").get<Username>());
    }

    inline void to_json(json & j, const Datum & x) {
        j = json::object();
        j["bitly_gif_url"] = x.get_bitly_gif_url();
        j["bitly_url"] = x.get_bitly_url();
        j["content_url"] = x.get_content_url();
        j["embed_url"] = x.get_embed_url();
        j["id"] = x.get_id();
        j["images"] = x.get_images();
        j["import_datetime"] = x.get_import_datetime();
        j["is_indexable"] = x.get_is_indexable();
        j["rating"] = x.get_rating();
        j["slug"] = x.get_slug();
        j["source"] = x.get_source();
        j["source_post_url"] = x.get_source_post_url();
        j["source_tld"] = x.get_source_tld();
        j["trending_datetime"] = x.get_trending_datetime();
        j["type"] = x.get_type();
        j["url"] = x.get_url();
        j["user"] = x.get_user();
        j["username"] = x.get_username();
    }

    inline void from_json(const json & j, Meta& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_msg(j.at("msg").get<std::string>());
        x.set_response_id(j.at("response_id").get<std::string>());
        if (j.find("status") != j.end() && !j.at("status").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_status(j.at("status").get<int64_t>());
    }

    inline void to_json(json & j, const Meta & x) {
        j = json::object();
        j["msg"] = x.get_msg();
        j["response_id"] = x.get_response_id();
        j["status"] = x.get_status();
    }

    inline void from_json(const json & j, Pagination& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("count") != j.end() && !j.at("count").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_count(j.at("count").get<int64_t>());
        if (j.find("offset") != j.end() && !j.at("offset").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_offset(j.at("offset").get<int64_t>());
        if (j.find("total_count") != j.end() && !j.at("total_count").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_total_count(j.at("total_count").get<int64_t>());
    }

    inline void to_json(json & j, const Pagination & x) {
        j = json::object();
        j["count"] = x.get_count();
        j["offset"] = x.get_offset();
        j["total_count"] = x.get_total_count();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_data(j.at("data").get<std::vector<Datum>>());
        x.set_meta(j.at("meta").get<Meta>());
        x.set_pagination(j.at("pagination").get<Pagination>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["data"] = x.get_data();
        j["meta"] = x.get_meta();
        j["pagination"] = x.get_pagination();
    }

    inline void from_json(const json & j, Rating & x) {
        if (j == "g") x = Rating::G;
        else if (j == "pg") x = Rating::PG;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Rating\""); }
    }

    inline void to_json(json & j, const Rating & x) {
        switch (x) {
            case Rating::G: j = "g"; break;
            case Rating::PG: j = "pg"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Rating\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, Type & x) {
        if (j == "gif") x = Type::GIF;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Type\""); }
    }

    inline void to_json(json & j, const Type & x) {
        switch (x) {
            case Type::GIF: j = "gif"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Type\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, Username & x) {
        if (j == "cheezburger") x = Username::CHEEZBURGER;
        else if (j == "") x = Username::EMPTY;
        else if (j == "natgeowild") x = Username::NATGEOWILD;
        else if (j == "nowthis") x = Username::NOWTHIS;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Username\""); }
    }

    inline void to_json(json & j, const Username & x) {
        switch (x) {
            case Username::CHEEZBURGER: j = "cheezburger"; break;
            case Username::EMPTY: j = ""; break;
            case Username::NATGEOWILD: j = "natgeowild"; break;
            case Username::NOWTHIS: j = "nowthis"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Username\": " + std::to_string(static_cast<int>(x)));
        }
    }
}
