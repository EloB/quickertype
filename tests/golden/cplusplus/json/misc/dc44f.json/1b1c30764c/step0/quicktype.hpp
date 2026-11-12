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
#include <unordered_map>

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

    enum class Booster : int { RARE, UNCOMMON, COMMON };

    enum class ColorIdentity : int { U, B, W, G, R };

    enum class Color : int { BLUE, BLACK, WHITE, GREEN, RED };

    enum class Layout : int { NORMAL };

    enum class Format : int { COMMANDER, LEGACY, MODERN, VINTAGE, TIME_SPIRAL_BLOCK, RAVNICA_BLOCK, ICE_AGE_BLOCK, TEMPEST_BLOCK, ONSLAUGHT_BLOCK, MASQUES_BLOCK, MIRAGE_BLOCK, URZA_BLOCK, SCARS_OF_MIRRODIN_BLOCK, MIRRODIN_BLOCK, AMONKHET_BLOCK, BATTLE_FOR_ZENDIKAR_BLOCK, INNISTRAD_BLOCK, INVASION_BLOCK, KALADESH_BLOCK, KAMIGAWA_BLOCK, KHANS_OF_TARKIR_BLOCK, LORWYN_SHADOWMOOR_BLOCK, ODYSSEY_BLOCK, RETURN_TO_RAVNICA_BLOCK, SHADOWS_OVER_INNISTRAD_BLOCK, SHARDS_OF_ALARA_BLOCK, STANDARD, THEROS_BLOCK, UN_SETS, ZENDIKAR_BLOCK };

    enum class LegalityEnum : int { LEGAL, BANNED, RESTRICTED };

    class LegalityElement {
        public:
        LegalityElement() = default;
        virtual ~LegalityElement() = default;

        private:
        Format format;
        LegalityEnum legality;

        public:
        const Format & get_format() const { return format; }
        Format & get_mutable_format() { return format; }
        void set_format(const Format & value) { this->format = value; }

        const LegalityEnum & get_legality() const { return legality; }
        LegalityEnum & get_mutable_legality() { return legality; }
        void set_legality(const LegalityEnum & value) { this->legality = value; }
    };

    enum class Rarity : int { UNCOMMON, RARE, COMMON, BASIC_LAND };

    class Ruling {
        public:
        Ruling() = default;
        virtual ~Ruling() = default;

        private:
        std::string date;
        std::string text;

        public:
        const std::string & get_date() const { return date; }
        std::string & get_mutable_date() { return date; }
        void set_date(const std::string & value) { this->date = value; }

        const std::string & get_text() const { return text; }
        std::string & get_mutable_text() { return text; }
        void set_text(const std::string & value) { this->text = value; }
    };

    enum class Supertype : int { BASIC };

    enum class Type : int { CREATURE, INSTANT, ENCHANTMENT, ARTIFACT, SORCERY, LAND };

    class Card {
        public:
        Card() = default;
        virtual ~Card() = default;

        private:
        std::string artist;
        int64_t cmc;
        std::optional<std::vector<ColorIdentity>> color_identity;
        std::optional<std::vector<Color>> colors;
        std::optional<std::string> flavor;
        std::string id;
        std::string image_name;
        Layout layout;
        std::vector<LegalityElement> legalities;
        std::optional<std::string> mana_cost;
        std::optional<std::string> mci_number;
        int64_t multiverseid;
        std::string name;
        std::optional<std::string> original_text;
        std::string original_type;
        std::optional<std::string> power;
        std::vector<std::string> printings;
        Rarity rarity;
        std::optional<bool> reserved;
        std::optional<std::vector<Ruling>> rulings;
        std::optional<std::vector<std::string>> subtypes;
        std::optional<std::vector<Supertype>> supertypes;
        std::optional<std::string> text;
        std::optional<std::string> toughness;
        std::string type;
        std::vector<Type> types;
        std::optional<std::vector<int64_t>> variations;

        public:
        const std::string & get_artist() const { return artist; }
        std::string & get_mutable_artist() { return artist; }
        void set_artist(const std::string & value) { this->artist = value; }

        const int64_t & get_cmc() const { return cmc; }
        int64_t & get_mutable_cmc() { return cmc; }
        void set_cmc(const int64_t & value) { this->cmc = value; }

        const std::optional<std::vector<ColorIdentity>> & get_color_identity() const { return color_identity; }
        std::optional<std::vector<ColorIdentity>> & get_mutable_color_identity() { return color_identity; }
        void set_color_identity(const std::optional<std::vector<ColorIdentity>> & value) { this->color_identity = value; }

        const std::optional<std::vector<Color>> & get_colors() const { return colors; }
        std::optional<std::vector<Color>> & get_mutable_colors() { return colors; }
        void set_colors(const std::optional<std::vector<Color>> & value) { this->colors = value; }

        const std::optional<std::string> & get_flavor() const { return flavor; }
        std::optional<std::string> & get_mutable_flavor() { return flavor; }
        void set_flavor(const std::optional<std::string> & value) { this->flavor = value; }

        const std::string & get_id() const { return id; }
        std::string & get_mutable_id() { return id; }
        void set_id(const std::string & value) { this->id = value; }

        const std::string & get_image_name() const { return image_name; }
        std::string & get_mutable_image_name() { return image_name; }
        void set_image_name(const std::string & value) { this->image_name = value; }

        const Layout & get_layout() const { return layout; }
        Layout & get_mutable_layout() { return layout; }
        void set_layout(const Layout & value) { this->layout = value; }

        const std::vector<LegalityElement> & get_legalities() const { return legalities; }
        std::vector<LegalityElement> & get_mutable_legalities() { return legalities; }
        void set_legalities(const std::vector<LegalityElement> & value) { this->legalities = value; }

        const std::optional<std::string> & get_mana_cost() const { return mana_cost; }
        std::optional<std::string> & get_mutable_mana_cost() { return mana_cost; }
        void set_mana_cost(const std::optional<std::string> & value) { this->mana_cost = value; }

        const std::optional<std::string> & get_mci_number() const { return mci_number; }
        std::optional<std::string> & get_mutable_mci_number() { return mci_number; }
        void set_mci_number(const std::optional<std::string> & value) { this->mci_number = value; }

        const int64_t & get_multiverseid() const { return multiverseid; }
        int64_t & get_mutable_multiverseid() { return multiverseid; }
        void set_multiverseid(const int64_t & value) { this->multiverseid = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const std::optional<std::string> & get_original_text() const { return original_text; }
        std::optional<std::string> & get_mutable_original_text() { return original_text; }
        void set_original_text(const std::optional<std::string> & value) { this->original_text = value; }

        const std::string & get_original_type() const { return original_type; }
        std::string & get_mutable_original_type() { return original_type; }
        void set_original_type(const std::string & value) { this->original_type = value; }

        const std::optional<std::string> & get_power() const { return power; }
        std::optional<std::string> & get_mutable_power() { return power; }
        void set_power(const std::optional<std::string> & value) { this->power = value; }

        const std::vector<std::string> & get_printings() const { return printings; }
        std::vector<std::string> & get_mutable_printings() { return printings; }
        void set_printings(const std::vector<std::string> & value) { this->printings = value; }

        const Rarity & get_rarity() const { return rarity; }
        Rarity & get_mutable_rarity() { return rarity; }
        void set_rarity(const Rarity & value) { this->rarity = value; }

        const std::optional<bool> & get_reserved() const { return reserved; }
        std::optional<bool> & get_mutable_reserved() { return reserved; }
        void set_reserved(const std::optional<bool> & value) { this->reserved = value; }

        const std::optional<std::vector<Ruling>> & get_rulings() const { return rulings; }
        std::optional<std::vector<Ruling>> & get_mutable_rulings() { return rulings; }
        void set_rulings(const std::optional<std::vector<Ruling>> & value) { this->rulings = value; }

        const std::optional<std::vector<std::string>> & get_subtypes() const { return subtypes; }
        std::optional<std::vector<std::string>> & get_mutable_subtypes() { return subtypes; }
        void set_subtypes(const std::optional<std::vector<std::string>> & value) { this->subtypes = value; }

        const std::optional<std::vector<Supertype>> & get_supertypes() const { return supertypes; }
        std::optional<std::vector<Supertype>> & get_mutable_supertypes() { return supertypes; }
        void set_supertypes(const std::optional<std::vector<Supertype>> & value) { this->supertypes = value; }

        const std::optional<std::string> & get_text() const { return text; }
        std::optional<std::string> & get_mutable_text() { return text; }
        void set_text(const std::optional<std::string> & value) { this->text = value; }

        const std::optional<std::string> & get_toughness() const { return toughness; }
        std::optional<std::string> & get_mutable_toughness() { return toughness; }
        void set_toughness(const std::optional<std::string> & value) { this->toughness = value; }

        const std::string & get_type() const { return type; }
        std::string & get_mutable_type() { return type; }
        void set_type(const std::string & value) { this->type = value; }

        const std::vector<Type> & get_types() const { return types; }
        std::vector<Type> & get_mutable_types() { return types; }
        void set_types(const std::vector<Type> & value) { this->types = value; }

        const std::optional<std::vector<int64_t>> & get_variations() const { return variations; }
        std::optional<std::vector<int64_t>> & get_mutable_variations() { return variations; }
        void set_variations(const std::optional<std::vector<int64_t>> & value) { this->variations = value; }
    };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        std::vector<Booster> booster;
        std::string border;
        std::vector<Card> cards;
        std::string code;
        std::string gatherer_code;
        std::string magic_cards_info_code;
        int64_t mkm_id;
        std::string mkm_name;
        std::string name;
        std::string release_date;
        std::string type;

        public:
        const std::vector<Booster> & get_booster() const { return booster; }
        std::vector<Booster> & get_mutable_booster() { return booster; }
        void set_booster(const std::vector<Booster> & value) { this->booster = value; }

        const std::string & get_border() const { return border; }
        std::string & get_mutable_border() { return border; }
        void set_border(const std::string & value) { this->border = value; }

        const std::vector<Card> & get_cards() const { return cards; }
        std::vector<Card> & get_mutable_cards() { return cards; }
        void set_cards(const std::vector<Card> & value) { this->cards = value; }

        const std::string & get_code() const { return code; }
        std::string & get_mutable_code() { return code; }
        void set_code(const std::string & value) { this->code = value; }

        const std::string & get_gatherer_code() const { return gatherer_code; }
        std::string & get_mutable_gatherer_code() { return gatherer_code; }
        void set_gatherer_code(const std::string & value) { this->gatherer_code = value; }

        const std::string & get_magic_cards_info_code() const { return magic_cards_info_code; }
        std::string & get_mutable_magic_cards_info_code() { return magic_cards_info_code; }
        void set_magic_cards_info_code(const std::string & value) { this->magic_cards_info_code = value; }

        const int64_t & get_mkm_id() const { return mkm_id; }
        int64_t & get_mutable_mkm_id() { return mkm_id; }
        void set_mkm_id(const int64_t & value) { this->mkm_id = value; }

        const std::string & get_mkm_name() const { return mkm_name; }
        std::string & get_mutable_mkm_name() { return mkm_name; }
        void set_mkm_name(const std::string & value) { this->mkm_name = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const std::string & get_release_date() const { return release_date; }
        std::string & get_mutable_release_date() { return release_date; }
        void set_release_date(const std::string & value) { this->release_date = value; }

        const std::string & get_type() const { return type; }
        std::string & get_mutable_type() { return type; }
        void set_type(const std::string & value) { this->type = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, LegalityElement & x);
    void to_json(json & j, const LegalityElement & x);

    void from_json(const json & j, Ruling & x);
    void to_json(json & j, const Ruling & x);

    void from_json(const json & j, Card & x);
    void to_json(json & j, const Card & x);

    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    void from_json(const json & j, Booster & x);
    void to_json(json & j, const Booster & x);

    void from_json(const json & j, ColorIdentity & x);
    void to_json(json & j, const ColorIdentity & x);

    void from_json(const json & j, Color & x);
    void to_json(json & j, const Color & x);

    void from_json(const json & j, Layout & x);
    void to_json(json & j, const Layout & x);

    void from_json(const json & j, Format & x);
    void to_json(json & j, const Format & x);

    void from_json(const json & j, LegalityEnum & x);
    void to_json(json & j, const LegalityEnum & x);

    void from_json(const json & j, Rarity & x);
    void to_json(json & j, const Rarity & x);

    void from_json(const json & j, Supertype & x);
    void to_json(json & j, const Supertype & x);

    void from_json(const json & j, Type & x);
    void to_json(json & j, const Type & x);

    inline void from_json(const json & j, LegalityElement& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_format(j.at("format").get<Format>());
        x.set_legality(j.at("legality").get<LegalityEnum>());
    }

    inline void to_json(json & j, const LegalityElement & x) {
        j = json::object();
        j["format"] = x.get_format();
        j["legality"] = x.get_legality();
    }

    inline void from_json(const json & j, Ruling& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_date(j.at("date").get<std::string>());
        x.set_text(j.at("text").get<std::string>());
    }

    inline void to_json(json & j, const Ruling & x) {
        j = json::object();
        j["date"] = x.get_date();
        j["text"] = x.get_text();
    }

    inline void from_json(const json & j, Card& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_artist(j.at("artist").get<std::string>());
        if (j.find("cmc") != j.end() && !j.at("cmc").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_cmc(j.at("cmc").get<int64_t>());
        if (j.find("colorIdentity") != j.end() && j.at("colorIdentity").is_null()) throw std::runtime_error("Unexpected null");
        x.set_color_identity(get_stack_optional<std::vector<ColorIdentity>>(j, "colorIdentity"));
        if (j.find("colors") != j.end() && j.at("colors").is_null()) throw std::runtime_error("Unexpected null");
        x.set_colors(get_stack_optional<std::vector<Color>>(j, "colors"));
        if (j.find("flavor") != j.end() && j.at("flavor").is_null()) throw std::runtime_error("Unexpected null");
        x.set_flavor(get_stack_optional<std::string>(j, "flavor"));
        x.set_id(j.at("id").get<std::string>());
        x.set_image_name(j.at("imageName").get<std::string>());
        x.set_layout(j.at("layout").get<Layout>());
        x.set_legalities(j.at("legalities").get<std::vector<LegalityElement>>());
        if (j.find("manaCost") != j.end() && j.at("manaCost").is_null()) throw std::runtime_error("Unexpected null");
        x.set_mana_cost(get_stack_optional<std::string>(j, "manaCost"));
        if (j.find("mciNumber") != j.end() && j.at("mciNumber").is_null()) throw std::runtime_error("Unexpected null");
        x.set_mci_number(get_stack_optional<std::string>(j, "mciNumber"));
        if (j.find("multiverseid") != j.end() && !j.at("multiverseid").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_multiverseid(j.at("multiverseid").get<int64_t>());
        x.set_name(j.at("name").get<std::string>());
        if (j.find("originalText") != j.end() && j.at("originalText").is_null()) throw std::runtime_error("Unexpected null");
        x.set_original_text(get_stack_optional<std::string>(j, "originalText"));
        x.set_original_type(j.at("originalType").get<std::string>());
        if (j.find("power") != j.end() && j.at("power").is_null()) throw std::runtime_error("Unexpected null");
        x.set_power(get_stack_optional<std::string>(j, "power"));
        x.set_printings(j.at("printings").get<std::vector<std::string>>());
        x.set_rarity(j.at("rarity").get<Rarity>());
        if (j.find("reserved") != j.end() && j.at("reserved").is_null()) throw std::runtime_error("Unexpected null");
        x.set_reserved(get_stack_optional<bool>(j, "reserved"));
        if (j.find("rulings") != j.end() && j.at("rulings").is_null()) throw std::runtime_error("Unexpected null");
        x.set_rulings(get_stack_optional<std::vector<Ruling>>(j, "rulings"));
        if (j.find("subtypes") != j.end() && j.at("subtypes").is_null()) throw std::runtime_error("Unexpected null");
        x.set_subtypes(get_stack_optional<std::vector<std::string>>(j, "subtypes"));
        if (j.find("supertypes") != j.end() && j.at("supertypes").is_null()) throw std::runtime_error("Unexpected null");
        x.set_supertypes(get_stack_optional<std::vector<Supertype>>(j, "supertypes"));
        if (j.find("text") != j.end() && j.at("text").is_null()) throw std::runtime_error("Unexpected null");
        x.set_text(get_stack_optional<std::string>(j, "text"));
        if (j.find("toughness") != j.end() && j.at("toughness").is_null()) throw std::runtime_error("Unexpected null");
        x.set_toughness(get_stack_optional<std::string>(j, "toughness"));
        x.set_type(j.at("type").get<std::string>());
        x.set_types(j.at("types").get<std::vector<Type>>());
        if (j.find("variations") != j.end() && j.at("variations").is_null()) throw std::runtime_error("Unexpected null");
        x.set_variations(get_stack_optional<std::vector<int64_t>>(j, "variations"));
    }

    inline void to_json(json & j, const Card & x) {
        j = json::object();
        j["artist"] = x.get_artist();
        j["cmc"] = x.get_cmc();
        j["colorIdentity"] = x.get_color_identity();
        j["colors"] = x.get_colors();
        j["flavor"] = x.get_flavor();
        j["id"] = x.get_id();
        j["imageName"] = x.get_image_name();
        j["layout"] = x.get_layout();
        j["legalities"] = x.get_legalities();
        j["manaCost"] = x.get_mana_cost();
        j["mciNumber"] = x.get_mci_number();
        j["multiverseid"] = x.get_multiverseid();
        j["name"] = x.get_name();
        j["originalText"] = x.get_original_text();
        j["originalType"] = x.get_original_type();
        j["power"] = x.get_power();
        j["printings"] = x.get_printings();
        j["rarity"] = x.get_rarity();
        j["reserved"] = x.get_reserved();
        j["rulings"] = x.get_rulings();
        j["subtypes"] = x.get_subtypes();
        j["supertypes"] = x.get_supertypes();
        j["text"] = x.get_text();
        j["toughness"] = x.get_toughness();
        j["type"] = x.get_type();
        j["types"] = x.get_types();
        j["variations"] = x.get_variations();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_booster(j.at("booster").get<std::vector<Booster>>());
        x.set_border(j.at("border").get<std::string>());
        x.set_cards(j.at("cards").get<std::vector<Card>>());
        x.set_code(j.at("code").get<std::string>());
        x.set_gatherer_code(j.at("gathererCode").get<std::string>());
        x.set_magic_cards_info_code(j.at("magicCardsInfoCode").get<std::string>());
        if (j.find("mkm_id") != j.end() && !j.at("mkm_id").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_mkm_id(j.at("mkm_id").get<int64_t>());
        x.set_mkm_name(j.at("mkm_name").get<std::string>());
        x.set_name(j.at("name").get<std::string>());
        x.set_release_date(j.at("releaseDate").get<std::string>());
        x.set_type(j.at("type").get<std::string>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["booster"] = x.get_booster();
        j["border"] = x.get_border();
        j["cards"] = x.get_cards();
        j["code"] = x.get_code();
        j["gathererCode"] = x.get_gatherer_code();
        j["magicCardsInfoCode"] = x.get_magic_cards_info_code();
        j["mkm_id"] = x.get_mkm_id();
        j["mkm_name"] = x.get_mkm_name();
        j["name"] = x.get_name();
        j["releaseDate"] = x.get_release_date();
        j["type"] = x.get_type();
    }

    inline void from_json(const json & j, Booster & x) {
        if (j == "rare") x = Booster::RARE;
        else if (j == "uncommon") x = Booster::UNCOMMON;
        else if (j == "common") x = Booster::COMMON;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Booster\""); }
    }

    inline void to_json(json & j, const Booster & x) {
        switch (x) {
            case Booster::RARE: j = "rare"; break;
            case Booster::UNCOMMON: j = "uncommon"; break;
            case Booster::COMMON: j = "common"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Booster\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, ColorIdentity & x) {
        if (j == "U") x = ColorIdentity::U;
        else if (j == "B") x = ColorIdentity::B;
        else if (j == "W") x = ColorIdentity::W;
        else if (j == "G") x = ColorIdentity::G;
        else if (j == "R") x = ColorIdentity::R;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"ColorIdentity\""); }
    }

    inline void to_json(json & j, const ColorIdentity & x) {
        switch (x) {
            case ColorIdentity::U: j = "U"; break;
            case ColorIdentity::B: j = "B"; break;
            case ColorIdentity::W: j = "W"; break;
            case ColorIdentity::G: j = "G"; break;
            case ColorIdentity::R: j = "R"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"ColorIdentity\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, Color & x) {
        if (j == "Blue") x = Color::BLUE;
        else if (j == "Black") x = Color::BLACK;
        else if (j == "White") x = Color::WHITE;
        else if (j == "Green") x = Color::GREEN;
        else if (j == "Red") x = Color::RED;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Color\""); }
    }

    inline void to_json(json & j, const Color & x) {
        switch (x) {
            case Color::BLUE: j = "Blue"; break;
            case Color::BLACK: j = "Black"; break;
            case Color::WHITE: j = "White"; break;
            case Color::GREEN: j = "Green"; break;
            case Color::RED: j = "Red"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Color\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, Layout & x) {
        if (j == "normal") x = Layout::NORMAL;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Layout\""); }
    }

    inline void to_json(json & j, const Layout & x) {
        switch (x) {
            case Layout::NORMAL: j = "normal"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Layout\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, Format & x) {
        static std::unordered_map<std::string, Format> enumValues {
            {"Commander", Format::COMMANDER},
            {"Legacy", Format::LEGACY},
            {"Modern", Format::MODERN},
            {"Vintage", Format::VINTAGE},
            {"Time Spiral Block", Format::TIME_SPIRAL_BLOCK},
            {"Ravnica Block", Format::RAVNICA_BLOCK},
            {"Ice Age Block", Format::ICE_AGE_BLOCK},
            {"Tempest Block", Format::TEMPEST_BLOCK},
            {"Onslaught Block", Format::ONSLAUGHT_BLOCK},
            {"Masques Block", Format::MASQUES_BLOCK},
            {"Mirage Block", Format::MIRAGE_BLOCK},
            {"Urza Block", Format::URZA_BLOCK},
            {"Scars of Mirrodin Block", Format::SCARS_OF_MIRRODIN_BLOCK},
            {"Mirrodin Block", Format::MIRRODIN_BLOCK},
            {"Amonkhet Block", Format::AMONKHET_BLOCK},
            {"Battle for Zendikar Block", Format::BATTLE_FOR_ZENDIKAR_BLOCK},
            {"Innistrad Block", Format::INNISTRAD_BLOCK},
            {"Invasion Block", Format::INVASION_BLOCK},
            {"Kaladesh Block", Format::KALADESH_BLOCK},
            {"Kamigawa Block", Format::KAMIGAWA_BLOCK},
            {"Khans of Tarkir Block", Format::KHANS_OF_TARKIR_BLOCK},
            {"Lorwyn-Shadowmoor Block", Format::LORWYN_SHADOWMOOR_BLOCK},
            {"Odyssey Block", Format::ODYSSEY_BLOCK},
            {"Return to Ravnica Block", Format::RETURN_TO_RAVNICA_BLOCK},
            {"Shadows over Innistrad Block", Format::SHADOWS_OVER_INNISTRAD_BLOCK},
            {"Shards of Alara Block", Format::SHARDS_OF_ALARA_BLOCK},
            {"Standard", Format::STANDARD},
            {"Theros Block", Format::THEROS_BLOCK},
            {"Un-Sets", Format::UN_SETS},
            {"Zendikar Block", Format::ZENDIKAR_BLOCK},
        };
        auto iter = enumValues.find(j.get<std::string>());
        if (iter != enumValues.end()) {
            x = iter->second;
        }
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Format\""); }
    }

    inline void to_json(json & j, const Format & x) {
        switch (x) {
            case Format::COMMANDER: j = "Commander"; break;
            case Format::LEGACY: j = "Legacy"; break;
            case Format::MODERN: j = "Modern"; break;
            case Format::VINTAGE: j = "Vintage"; break;
            case Format::TIME_SPIRAL_BLOCK: j = "Time Spiral Block"; break;
            case Format::RAVNICA_BLOCK: j = "Ravnica Block"; break;
            case Format::ICE_AGE_BLOCK: j = "Ice Age Block"; break;
            case Format::TEMPEST_BLOCK: j = "Tempest Block"; break;
            case Format::ONSLAUGHT_BLOCK: j = "Onslaught Block"; break;
            case Format::MASQUES_BLOCK: j = "Masques Block"; break;
            case Format::MIRAGE_BLOCK: j = "Mirage Block"; break;
            case Format::URZA_BLOCK: j = "Urza Block"; break;
            case Format::SCARS_OF_MIRRODIN_BLOCK: j = "Scars of Mirrodin Block"; break;
            case Format::MIRRODIN_BLOCK: j = "Mirrodin Block"; break;
            case Format::AMONKHET_BLOCK: j = "Amonkhet Block"; break;
            case Format::BATTLE_FOR_ZENDIKAR_BLOCK: j = "Battle for Zendikar Block"; break;
            case Format::INNISTRAD_BLOCK: j = "Innistrad Block"; break;
            case Format::INVASION_BLOCK: j = "Invasion Block"; break;
            case Format::KALADESH_BLOCK: j = "Kaladesh Block"; break;
            case Format::KAMIGAWA_BLOCK: j = "Kamigawa Block"; break;
            case Format::KHANS_OF_TARKIR_BLOCK: j = "Khans of Tarkir Block"; break;
            case Format::LORWYN_SHADOWMOOR_BLOCK: j = "Lorwyn-Shadowmoor Block"; break;
            case Format::ODYSSEY_BLOCK: j = "Odyssey Block"; break;
            case Format::RETURN_TO_RAVNICA_BLOCK: j = "Return to Ravnica Block"; break;
            case Format::SHADOWS_OVER_INNISTRAD_BLOCK: j = "Shadows over Innistrad Block"; break;
            case Format::SHARDS_OF_ALARA_BLOCK: j = "Shards of Alara Block"; break;
            case Format::STANDARD: j = "Standard"; break;
            case Format::THEROS_BLOCK: j = "Theros Block"; break;
            case Format::UN_SETS: j = "Un-Sets"; break;
            case Format::ZENDIKAR_BLOCK: j = "Zendikar Block"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Format\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, LegalityEnum & x) {
        if (j == "Legal") x = LegalityEnum::LEGAL;
        else if (j == "Banned") x = LegalityEnum::BANNED;
        else if (j == "Restricted") x = LegalityEnum::RESTRICTED;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"LegalityEnum\""); }
    }

    inline void to_json(json & j, const LegalityEnum & x) {
        switch (x) {
            case LegalityEnum::LEGAL: j = "Legal"; break;
            case LegalityEnum::BANNED: j = "Banned"; break;
            case LegalityEnum::RESTRICTED: j = "Restricted"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"LegalityEnum\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, Rarity & x) {
        if (j == "Uncommon") x = Rarity::UNCOMMON;
        else if (j == "Rare") x = Rarity::RARE;
        else if (j == "Common") x = Rarity::COMMON;
        else if (j == "Basic Land") x = Rarity::BASIC_LAND;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Rarity\""); }
    }

    inline void to_json(json & j, const Rarity & x) {
        switch (x) {
            case Rarity::UNCOMMON: j = "Uncommon"; break;
            case Rarity::RARE: j = "Rare"; break;
            case Rarity::COMMON: j = "Common"; break;
            case Rarity::BASIC_LAND: j = "Basic Land"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Rarity\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, Supertype & x) {
        if (j == "Basic") x = Supertype::BASIC;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Supertype\""); }
    }

    inline void to_json(json & j, const Supertype & x) {
        switch (x) {
            case Supertype::BASIC: j = "Basic"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Supertype\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, Type & x) {
        if (j == "Creature") x = Type::CREATURE;
        else if (j == "Instant") x = Type::INSTANT;
        else if (j == "Enchantment") x = Type::ENCHANTMENT;
        else if (j == "Artifact") x = Type::ARTIFACT;
        else if (j == "Sorcery") x = Type::SORCERY;
        else if (j == "Land") x = Type::LAND;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Type\""); }
    }

    inline void to_json(json & j, const Type & x) {
        switch (x) {
            case Type::CREATURE: j = "Creature"; break;
            case Type::INSTANT: j = "Instant"; break;
            case Type::ENCHANTMENT: j = "Enchantment"; break;
            case Type::ARTIFACT: j = "Artifact"; break;
            case Type::SORCERY: j = "Sorcery"; break;
            case Type::LAND: j = "Land"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Type\": " + std::to_string(static_cast<int>(x)));
        }
    }
}
