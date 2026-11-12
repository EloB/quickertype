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

    class Out {
        public:
        Out() = default;
        virtual ~Out() = default;

        private:
        std::string addr;
        int64_t n;
        std::string script;
        bool spent;
        int64_t tx_index;
        int64_t type;
        int64_t value;

        public:
        const std::string & get_addr() const { return addr; }
        std::string & get_mutable_addr() { return addr; }
        void set_addr(const std::string & value) { this->addr = value; }

        const int64_t & get_n() const { return n; }
        int64_t & get_mutable_n() { return n; }
        void set_n(const int64_t & value) { this->n = value; }

        const std::string & get_script() const { return script; }
        std::string & get_mutable_script() { return script; }
        void set_script(const std::string & value) { this->script = value; }

        const bool & get_spent() const { return spent; }
        bool & get_mutable_spent() { return spent; }
        void set_spent(const bool & value) { this->spent = value; }

        const int64_t & get_tx_index() const { return tx_index; }
        int64_t & get_mutable_tx_index() { return tx_index; }
        void set_tx_index(const int64_t & value) { this->tx_index = value; }

        const int64_t & get_type() const { return type; }
        int64_t & get_mutable_type() { return type; }
        void set_type(const int64_t & value) { this->type = value; }

        const int64_t & get_value() const { return value; }
        int64_t & get_mutable_value() { return value; }
        void set_value(const int64_t & value) { this->value = value; }
    };

    class Input {
        public:
        Input() = default;
        virtual ~Input() = default;

        private:
        Out prev_out;
        std::string script;
        int64_t sequence;

        public:
        const Out & get_prev_out() const { return prev_out; }
        Out & get_mutable_prev_out() { return prev_out; }
        void set_prev_out(const Out & value) { this->prev_out = value; }

        const std::string & get_script() const { return script; }
        std::string & get_mutable_script() { return script; }
        void set_script(const std::string & value) { this->script = value; }

        const int64_t & get_sequence() const { return sequence; }
        int64_t & get_mutable_sequence() { return sequence; }
        void set_sequence(const int64_t & value) { this->sequence = value; }
    };

    class Tx {
        public:
        Tx() = default;
        virtual ~Tx() = default;

        private:
        bool double_spend;
        std::string hash;
        std::vector<Input> inputs;
        int64_t lock_time;
        std::vector<Out> out;
        std::string relayed_by;
        int64_t size;
        int64_t time;
        int64_t tx_index;
        int64_t ver;
        int64_t vin_sz;
        int64_t vout_sz;

        public:
        const bool & get_double_spend() const { return double_spend; }
        bool & get_mutable_double_spend() { return double_spend; }
        void set_double_spend(const bool & value) { this->double_spend = value; }

        const std::string & get_hash() const { return hash; }
        std::string & get_mutable_hash() { return hash; }
        void set_hash(const std::string & value) { this->hash = value; }

        const std::vector<Input> & get_inputs() const { return inputs; }
        std::vector<Input> & get_mutable_inputs() { return inputs; }
        void set_inputs(const std::vector<Input> & value) { this->inputs = value; }

        const int64_t & get_lock_time() const { return lock_time; }
        int64_t & get_mutable_lock_time() { return lock_time; }
        void set_lock_time(const int64_t & value) { this->lock_time = value; }

        const std::vector<Out> & get_out() const { return out; }
        std::vector<Out> & get_mutable_out() { return out; }
        void set_out(const std::vector<Out> & value) { this->out = value; }

        const std::string & get_relayed_by() const { return relayed_by; }
        std::string & get_mutable_relayed_by() { return relayed_by; }
        void set_relayed_by(const std::string & value) { this->relayed_by = value; }

        const int64_t & get_size() const { return size; }
        int64_t & get_mutable_size() { return size; }
        void set_size(const int64_t & value) { this->size = value; }

        const int64_t & get_time() const { return time; }
        int64_t & get_mutable_time() { return time; }
        void set_time(const int64_t & value) { this->time = value; }

        const int64_t & get_tx_index() const { return tx_index; }
        int64_t & get_mutable_tx_index() { return tx_index; }
        void set_tx_index(const int64_t & value) { this->tx_index = value; }

        const int64_t & get_ver() const { return ver; }
        int64_t & get_mutable_ver() { return ver; }
        void set_ver(const int64_t & value) { this->ver = value; }

        const int64_t & get_vin_sz() const { return vin_sz; }
        int64_t & get_mutable_vin_sz() { return vin_sz; }
        void set_vin_sz(const int64_t & value) { this->vin_sz = value; }

        const int64_t & get_vout_sz() const { return vout_sz; }
        int64_t & get_mutable_vout_sz() { return vout_sz; }
        void set_vout_sz(const int64_t & value) { this->vout_sz = value; }
    };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        std::vector<Tx> txs;

        public:
        const std::vector<Tx> & get_txs() const { return txs; }
        std::vector<Tx> & get_mutable_txs() { return txs; }
        void set_txs(const std::vector<Tx> & value) { this->txs = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, Out & x);
    void to_json(json & j, const Out & x);

    void from_json(const json & j, Input & x);
    void to_json(json & j, const Input & x);

    void from_json(const json & j, Tx & x);
    void to_json(json & j, const Tx & x);

    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    inline void from_json(const json & j, Out& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_addr(j.at("addr").get<std::string>());
        if (j.find("n") != j.end() && !j.at("n").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_n(j.at("n").get<int64_t>());
        x.set_script(j.at("script").get<std::string>());
        x.set_spent(j.at("spent").get<bool>());
        if (j.find("tx_index") != j.end() && !j.at("tx_index").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_tx_index(j.at("tx_index").get<int64_t>());
        if (j.find("type") != j.end() && !j.at("type").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_type(j.at("type").get<int64_t>());
        if (j.find("value") != j.end() && !j.at("value").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_value(j.at("value").get<int64_t>());
    }

    inline void to_json(json & j, const Out & x) {
        j = json::object();
        j["addr"] = x.get_addr();
        j["n"] = x.get_n();
        j["script"] = x.get_script();
        j["spent"] = x.get_spent();
        j["tx_index"] = x.get_tx_index();
        j["type"] = x.get_type();
        j["value"] = x.get_value();
    }

    inline void from_json(const json & j, Input& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_prev_out(j.at("prev_out").get<Out>());
        x.set_script(j.at("script").get<std::string>());
        if (j.find("sequence") != j.end() && !j.at("sequence").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_sequence(j.at("sequence").get<int64_t>());
    }

    inline void to_json(json & j, const Input & x) {
        j = json::object();
        j["prev_out"] = x.get_prev_out();
        j["script"] = x.get_script();
        j["sequence"] = x.get_sequence();
    }

    inline void from_json(const json & j, Tx& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_double_spend(j.at("double_spend").get<bool>());
        x.set_hash(j.at("hash").get<std::string>());
        x.set_inputs(j.at("inputs").get<std::vector<Input>>());
        if (j.find("lock_time") != j.end() && !j.at("lock_time").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_lock_time(j.at("lock_time").get<int64_t>());
        x.set_out(j.at("out").get<std::vector<Out>>());
        x.set_relayed_by(j.at("relayed_by").get<std::string>());
        if (j.find("size") != j.end() && !j.at("size").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_size(j.at("size").get<int64_t>());
        if (j.find("time") != j.end() && !j.at("time").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_time(j.at("time").get<int64_t>());
        if (j.find("tx_index") != j.end() && !j.at("tx_index").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_tx_index(j.at("tx_index").get<int64_t>());
        if (j.find("ver") != j.end() && !j.at("ver").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_ver(j.at("ver").get<int64_t>());
        if (j.find("vin_sz") != j.end() && !j.at("vin_sz").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_vin_sz(j.at("vin_sz").get<int64_t>());
        if (j.find("vout_sz") != j.end() && !j.at("vout_sz").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_vout_sz(j.at("vout_sz").get<int64_t>());
    }

    inline void to_json(json & j, const Tx & x) {
        j = json::object();
        j["double_spend"] = x.get_double_spend();
        j["hash"] = x.get_hash();
        j["inputs"] = x.get_inputs();
        j["lock_time"] = x.get_lock_time();
        j["out"] = x.get_out();
        j["relayed_by"] = x.get_relayed_by();
        j["size"] = x.get_size();
        j["time"] = x.get_time();
        j["tx_index"] = x.get_tx_index();
        j["ver"] = x.get_ver();
        j["vin_sz"] = x.get_vin_sz();
        j["vout_sz"] = x.get_vout_sz();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_txs(j.at("txs").get<std::vector<Tx>>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["txs"] = x.get_txs();
    }
}
