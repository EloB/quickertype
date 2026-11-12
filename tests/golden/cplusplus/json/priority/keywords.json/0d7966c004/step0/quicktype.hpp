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

    class Abstract {
        public:
        Abstract() = default;
        virtual ~Abstract() = default;

        private:
        int64_t abstract;

        public:
        const int64_t & get_abstract() const { return abstract; }
        int64_t & get_mutable_abstract() { return abstract; }
        void set_abstract(const int64_t & value) { this->abstract = value; }
    };

    class Any {
        public:
        Any() = default;
        virtual ~Any() = default;

        private:
        int64_t any;

        public:
        const int64_t & get_any() const { return any; }
        int64_t & get_mutable_any() { return any; }
        void set_any(const int64_t & value) { this->any = value; }
    };

    class Array {
        public:
        Array() = default;
        virtual ~Array() = default;

        private:
        int64_t array;

        public:
        const int64_t & get_array() const { return array; }
        int64_t & get_mutable_array() { return array; }
        void set_array(const int64_t & value) { this->array = value; }
    };

    class ArrayNode {
        public:
        ArrayNode() = default;
        virtual ~ArrayNode() = default;

        private:
        int64_t array_node;

        public:
        const int64_t & get_array_node() const { return array_node; }
        int64_t & get_mutable_array_node() { return array_node; }
        void set_array_node(const int64_t & value) { this->array_node = value; }
    };

    class As {
        public:
        As() = default;
        virtual ~As() = default;

        private:
        int64_t as;

        public:
        const int64_t & get_as() const { return as; }
        int64_t & get_mutable_as() { return as; }
        void set_as(const int64_t & value) { this->as = value; }
    };

    class Assert {
        public:
        Assert() = default;
        virtual ~Assert() = default;

        private:
        int64_t assert;

        public:
        const int64_t & get_assert() const { return assert; }
        int64_t & get_mutable_assert() { return assert; }
        void set_assert(const int64_t & value) { this->assert = value; }
    };

    class Associatedtype {
        public:
        Associatedtype() = default;
        virtual ~Associatedtype() = default;

        private:
        int64_t associatedtype;

        public:
        const int64_t & get_associatedtype() const { return associatedtype; }
        int64_t & get_mutable_associatedtype() { return associatedtype; }
        void set_associatedtype(const int64_t & value) { this->associatedtype = value; }
    };

    class Associativity {
        public:
        Associativity() = default;
        virtual ~Associativity() = default;

        private:
        int64_t associativity;

        public:
        const int64_t & get_associativity() const { return associativity; }
        int64_t & get_mutable_associativity() { return associativity; }
        void set_associativity(const int64_t & value) { this->associativity = value; }
    };

    class Async {
        public:
        Async() = default;
        virtual ~Async() = default;

        private:
        int64_t async;

        public:
        const int64_t & get_async() const { return async; }
        int64_t & get_mutable_async() { return async; }
        void set_async(const int64_t & value) { this->async = value; }
    };

    class Atomic {
        public:
        Atomic() = default;
        virtual ~Atomic() = default;

        private:
        int64_t atomic;

        public:
        const int64_t & get_atomic() const { return atomic; }
        int64_t & get_mutable_atomic() { return atomic; }
        void set_atomic(const int64_t & value) { this->atomic = value; }
    };

    class Await {
        public:
        Await() = default;
        virtual ~Await() = default;

        private:
        int64_t await;

        public:
        const int64_t & get_await() const { return await; }
        int64_t & get_mutable_await() { return await; }
        void set_await(const int64_t & value) { this->await = value; }
    };

    class Base {
        public:
        Base() = default;
        virtual ~Base() = default;

        private:
        int64_t base;

        public:
        const int64_t & get_base() const { return base; }
        int64_t & get_mutable_base() { return base; }
        void set_base(const int64_t & value) { this->base = value; }
    };

    class Boolean {
        public:
        Boolean() = default;
        virtual ~Boolean() = default;

        private:
        int64_t boolean;

        public:
        const int64_t & get_boolean() const { return boolean; }
        int64_t & get_mutable_boolean() { return boolean; }
        void set_boolean(const int64_t & value) { this->boolean = value; }
    };

    class BooleanNode {
        public:
        BooleanNode() = default;
        virtual ~BooleanNode() = default;

        private:
        int64_t boolean_node;

        public:
        const int64_t & get_boolean_node() const { return boolean_node; }
        int64_t & get_mutable_boolean_node() { return boolean_node; }
        void set_boolean_node(const int64_t & value) { this->boolean_node = value; }
    };

    class Bycopy {
        public:
        Bycopy() = default;
        virtual ~Bycopy() = default;

        private:
        int64_t bycopy;

        public:
        const int64_t & get_bycopy() const { return bycopy; }
        int64_t & get_mutable_bycopy() { return bycopy; }
        void set_bycopy(const int64_t & value) { this->bycopy = value; }
    };

    class Byref {
        public:
        Byref() = default;
        virtual ~Byref() = default;

        private:
        int64_t byref;

        public:
        const int64_t & get_byref() const { return byref; }
        int64_t & get_mutable_byref() { return byref; }
        void set_byref(const int64_t & value) { this->byref = value; }
    };

    class Byte {
        public:
        Byte() = default;
        virtual ~Byte() = default;

        private:
        int64_t byte;

        public:
        const int64_t & get_byte() const { return byte; }
        int64_t & get_mutable_byte() { return byte; }
        void set_byte(const int64_t & value) { this->byte = value; }
    };

    class Calendar {
        public:
        Calendar() = default;
        virtual ~Calendar() = default;

        private:
        int64_t calendar;

        public:
        const int64_t & get_calendar() const { return calendar; }
        int64_t & get_mutable_calendar() { return calendar; }
        void set_calendar(const int64_t & value) { this->calendar = value; }
    };

    class Chan {
        public:
        Chan() = default;
        virtual ~Chan() = default;

        private:
        int64_t chan;

        public:
        const int64_t & get_chan() const { return chan; }
        int64_t & get_mutable_chan() { return chan; }
        void set_chan(const int64_t & value) { this->chan = value; }
    };

    class Checked {
        public:
        Checked() = default;
        virtual ~Checked() = default;

        private:
        int64_t checked;

        public:
        const int64_t & get_checked() const { return checked; }
        int64_t & get_mutable_checked() { return checked; }
        void set_checked(const int64_t & value) { this->checked = value; }
    };

    class Clone {
        public:
        Clone() = default;
        virtual ~Clone() = default;

        private:
        int64_t clone;

        public:
        const int64_t & get_clone() const { return clone; }
        int64_t & get_mutable_clone() { return clone; }
        void set_clone(const int64_t & value) { this->clone = value; }
    };

    class Codable {
        public:
        Codable() = default;
        virtual ~Codable() = default;

        private:
        int64_t codable;

        public:
        const int64_t & get_codable() const { return codable; }
        int64_t & get_mutable_codable() { return codable; }
        void set_codable(const int64_t & value) { this->codable = value; }
    };

    class CodingKey {
        public:
        CodingKey() = default;
        virtual ~CodingKey() = default;

        private:
        int64_t coding_key;

        public:
        const int64_t & get_coding_key() const { return coding_key; }
        int64_t & get_mutable_coding_key() { return coding_key; }
        void set_coding_key(const int64_t & value) { this->coding_key = value; }
    };

    class CodingKeys {
        public:
        CodingKeys() = default;
        virtual ~CodingKeys() = default;

        private:
        int64_t coding_keys;

        public:
        const int64_t & get_coding_keys() const { return coding_keys; }
        int64_t & get_mutable_coding_keys() { return coding_keys; }
        void set_coding_keys(const int64_t & value) { this->coding_keys = value; }
    };

    class Complex {
        public:
        Complex() = default;
        virtual ~Complex() = default;

        private:
        int64_t complex;

        public:
        const int64_t & get_complex() const { return complex; }
        int64_t & get_mutable_complex() { return complex; }
        void set_complex(const int64_t & value) { this->complex = value; }
    };

    class Console {
        public:
        Console() = default;
        virtual ~Console() = default;

        private:
        int64_t console;

        public:
        const int64_t & get_console() const { return console; }
        int64_t & get_mutable_console() { return console; }
        void set_console(const int64_t & value) { this->console = value; }
    };

    class Constructor {
        public:
        Constructor() = default;
        virtual ~Constructor() = default;

        private:
        int64_t constructor;

        public:
        const int64_t & get_constructor() const { return constructor; }
        int64_t & get_mutable_constructor() { return constructor; }
        void set_constructor(const int64_t & value) { this->constructor = value; }
    };

    class Convenience {
        public:
        Convenience() = default;
        virtual ~Convenience() = default;

        private:
        int64_t convenience;

        public:
        const int64_t & get_convenience() const { return convenience; }
        int64_t & get_mutable_convenience() { return convenience; }
        void set_convenience(const int64_t & value) { this->convenience = value; }
    };

    class Convert {
        public:
        Convert() = default;
        virtual ~Convert() = default;

        private:
        int64_t convert;

        public:
        const int64_t & get_convert() const { return convert; }
        int64_t & get_mutable_convert() { return convert; }
        void set_convert(const int64_t & value) { this->convert = value; }
    };

    class Converter {
        public:
        Converter() = default;
        virtual ~Converter() = default;

        private:
        int64_t converter;

        public:
        const int64_t & get_converter() const { return converter; }
        int64_t & get_mutable_converter() { return converter; }
        void set_converter(const int64_t & value) { this->converter = value; }
    };

    class Empty {
        public:
        Empty() = default;
        virtual ~Empty() = default;

        private:
        int64_t empty;

        public:
        const int64_t & get_empty() const { return empty; }
        int64_t & get_mutable_empty() { return empty; }
        void set_empty(const int64_t & value) { this->empty = value; }
    };

    class Obj1Bool {
        public:
        Obj1Bool() = default;
        virtual ~Obj1Bool() = default;

        private:
        int64_t bool_bool;

        public:
        const int64_t & get_bool_bool() const { return bool_bool; }
        int64_t & get_mutable_bool_bool() { return bool_bool; }
        void set_bool_bool(const int64_t & value) { this->bool_bool = value; }
    };

    class Imaginery {
        public:
        Imaginery() = default;
        virtual ~Imaginery() = default;

        private:
        int64_t imaginery;

        public:
        const int64_t & get_imaginery() const { return imaginery; }
        int64_t & get_mutable_imaginery() { return imaginery; }
        void set_imaginery(const int64_t & value) { this->imaginery = value; }
    };

    class Alignas {
        public:
        Alignas() = default;
        virtual ~Alignas() = default;

        private:
        int64_t alignas_alignas;

        public:
        const int64_t & get_alignas_alignas() const { return alignas_alignas; }
        int64_t & get_mutable_alignas_alignas() { return alignas_alignas; }
        void set_alignas_alignas(const int64_t & value) { this->alignas_alignas = value; }
    };

    class Alignof {
        public:
        Alignof() = default;
        virtual ~Alignof() = default;

        private:
        int64_t alignof_alignof;

        public:
        const int64_t & get_alignof_alignof() const { return alignof_alignof; }
        int64_t & get_mutable_alignof_alignof() { return alignof_alignof; }
        void set_alignof_alignof(const int64_t & value) { this->alignof_alignof = value; }
    };

    class And {
        public:
        And() = default;
        virtual ~And() = default;

        private:
        int64_t and_and;

        public:
        const int64_t & get_and_and() const { return and_and; }
        int64_t & get_mutable_and_and() { return and_and; }
        void set_and_and(const int64_t & value) { this->and_and = value; }
    };

    class AndEq {
        public:
        AndEq() = default;
        virtual ~AndEq() = default;

        private:
        int64_t and_eq_and_eq;

        public:
        const int64_t & get_and_eq_and_eq() const { return and_eq_and_eq; }
        int64_t & get_mutable_and_eq_and_eq() { return and_eq_and_eq; }
        void set_and_eq_and_eq(const int64_t & value) { this->and_eq_and_eq = value; }
    };

    class AnyClass {
        public:
        AnyClass() = default;
        virtual ~AnyClass() = default;

        private:
        int64_t any;

        public:
        const int64_t & get_any() const { return any; }
        int64_t & get_mutable_any() { return any; }
        void set_any(const int64_t & value) { this->any = value; }
    };

    class Asm {
        public:
        Asm() = default;
        virtual ~Asm() = default;

        private:
        int64_t asm_asm;

        public:
        const int64_t & get_asm_asm() const { return asm_asm; }
        int64_t & get_mutable_asm_asm() { return asm_asm; }
        void set_asm_asm(const int64_t & value) { this->asm_asm = value; }
    };

    class AtomicCancel {
        public:
        AtomicCancel() = default;
        virtual ~AtomicCancel() = default;

        private:
        int64_t atomic_cancel_atomic_cancel;

        public:
        const int64_t & get_atomic_cancel_atomic_cancel() const { return atomic_cancel_atomic_cancel; }
        int64_t & get_mutable_atomic_cancel_atomic_cancel() { return atomic_cancel_atomic_cancel; }
        void set_atomic_cancel_atomic_cancel(const int64_t & value) { this->atomic_cancel_atomic_cancel = value; }
    };

    class AtomicCommit {
        public:
        AtomicCommit() = default;
        virtual ~AtomicCommit() = default;

        private:
        int64_t atomic_commit_atomic_commit;

        public:
        const int64_t & get_atomic_commit_atomic_commit() const { return atomic_commit_atomic_commit; }
        int64_t & get_mutable_atomic_commit_atomic_commit() { return atomic_commit_atomic_commit; }
        void set_atomic_commit_atomic_commit(const int64_t & value) { this->atomic_commit_atomic_commit = value; }
    };

    class AtomicNoexcept {
        public:
        AtomicNoexcept() = default;
        virtual ~AtomicNoexcept() = default;

        private:
        int64_t atomic_noexcept_atomic_noexcept;

        public:
        const int64_t & get_atomic_noexcept_atomic_noexcept() const { return atomic_noexcept_atomic_noexcept; }
        int64_t & get_mutable_atomic_noexcept_atomic_noexcept() { return atomic_noexcept_atomic_noexcept; }
        void set_atomic_noexcept_atomic_noexcept(const int64_t & value) { this->atomic_noexcept_atomic_noexcept = value; }
    };

    class Auto {
        public:
        Auto() = default;
        virtual ~Auto() = default;

        private:
        int64_t auto_auto;

        public:
        const int64_t & get_auto_auto() const { return auto_auto; }
        int64_t & get_mutable_auto_auto() { return auto_auto; }
        void set_auto_auto(const int64_t & value) { this->auto_auto = value; }
    };

    class Bitand {
        public:
        Bitand() = default;
        virtual ~Bitand() = default;

        private:
        int64_t bitand_bitand;

        public:
        const int64_t & get_bitand_bitand() const { return bitand_bitand; }
        int64_t & get_mutable_bitand_bitand() { return bitand_bitand; }
        void set_bitand_bitand(const int64_t & value) { this->bitand_bitand = value; }
    };

    class Bitor {
        public:
        Bitor() = default;
        virtual ~Bitor() = default;

        private:
        int64_t bitor_bitor;

        public:
        const int64_t & get_bitor_bitor() const { return bitor_bitor; }
        int64_t & get_mutable_bitor_bitor() { return bitor_bitor; }
        void set_bitor_bitor(const int64_t & value) { this->bitor_bitor = value; }
    };

    class Bool {
        public:
        Bool() = default;
        virtual ~Bool() = default;

        private:
        int64_t bool_bool;

        public:
        const int64_t & get_bool_bool() const { return bool_bool; }
        int64_t & get_mutable_bool_bool() { return bool_bool; }
        void set_bool_bool(const int64_t & value) { this->bool_bool = value; }
    };

    class Break {
        public:
        Break() = default;
        virtual ~Break() = default;

        private:
        int64_t break_break;

        public:
        const int64_t & get_break_break() const { return break_break; }
        int64_t & get_mutable_break_break() { return break_break; }
        void set_break_break(const int64_t & value) { this->break_break = value; }
    };

    class Case {
        public:
        Case() = default;
        virtual ~Case() = default;

        private:
        int64_t case_case;

        public:
        const int64_t & get_case_case() const { return case_case; }
        int64_t & get_mutable_case_case() { return case_case; }
        void set_case_case(const int64_t & value) { this->case_case = value; }
    };

    class Catch {
        public:
        Catch() = default;
        virtual ~Catch() = default;

        private:
        int64_t catch_catch;

        public:
        const int64_t & get_catch_catch() const { return catch_catch; }
        int64_t & get_mutable_catch_catch() { return catch_catch; }
        void set_catch_catch(const int64_t & value) { this->catch_catch = value; }
    };

    class Char {
        public:
        Char() = default;
        virtual ~Char() = default;

        private:
        int64_t char_char;

        public:
        const int64_t & get_char_char() const { return char_char; }
        int64_t & get_mutable_char_char() { return char_char; }
        void set_char_char(const int64_t & value) { this->char_char = value; }
    };

    class Char16T {
        public:
        Char16T() = default;
        virtual ~Char16T() = default;

        private:
        int64_t char16_t_char16_t;

        public:
        const int64_t & get_char16_t_char16_t() const { return char16_t_char16_t; }
        int64_t & get_mutable_char16_t_char16_t() { return char16_t_char16_t; }
        void set_char16_t_char16_t(const int64_t & value) { this->char16_t_char16_t = value; }
    };

    class Char32T {
        public:
        Char32T() = default;
        virtual ~Char32T() = default;

        private:
        int64_t char32_t_char32_t;

        public:
        const int64_t & get_char32_t_char32_t() const { return char32_t_char32_t; }
        int64_t & get_mutable_char32_t_char32_t() { return char32_t_char32_t; }
        void set_char32_t_char32_t(const int64_t & value) { this->char32_t_char32_t = value; }
    };

    class Class {
        public:
        Class() = default;
        virtual ~Class() = default;

        private:
        int64_t class_class;

        public:
        const int64_t & get_class_class() const { return class_class; }
        int64_t & get_mutable_class_class() { return class_class; }
        void set_class_class(const int64_t & value) { this->class_class = value; }
    };

    class CoAwait {
        public:
        CoAwait() = default;
        virtual ~CoAwait() = default;

        private:
        int64_t co_await_co_await;

        public:
        const int64_t & get_co_await_co_await() const { return co_await_co_await; }
        int64_t & get_mutable_co_await_co_await() { return co_await_co_await; }
        void set_co_await_co_await(const int64_t & value) { this->co_await_co_await = value; }
    };

    class CoReturn {
        public:
        CoReturn() = default;
        virtual ~CoReturn() = default;

        private:
        int64_t co_return_co_return;

        public:
        const int64_t & get_co_return_co_return() const { return co_return_co_return; }
        int64_t & get_mutable_co_return_co_return() { return co_return_co_return; }
        void set_co_return_co_return(const int64_t & value) { this->co_return_co_return = value; }
    };

    class CoYield {
        public:
        CoYield() = default;
        virtual ~CoYield() = default;

        private:
        int64_t co_yield_co_yield;

        public:
        const int64_t & get_co_yield_co_yield() const { return co_yield_co_yield; }
        int64_t & get_mutable_co_yield_co_yield() { return co_yield_co_yield; }
        void set_co_yield_co_yield(const int64_t & value) { this->co_yield_co_yield = value; }
    };

    class Compl {
        public:
        Compl() = default;
        virtual ~Compl() = default;

        private:
        int64_t compl_compl;

        public:
        const int64_t & get_compl_compl() const { return compl_compl; }
        int64_t & get_mutable_compl_compl() { return compl_compl; }
        void set_compl_compl(const int64_t & value) { this->compl_compl = value; }
    };

    class Concept {
        public:
        Concept() = default;
        virtual ~Concept() = default;

        private:
        int64_t concept_concept;

        public:
        const int64_t & get_concept_concept() const { return concept_concept; }
        int64_t & get_mutable_concept_concept() { return concept_concept; }
        void set_concept_concept(const int64_t & value) { this->concept_concept = value; }
    };

    class Const {
        public:
        Const() = default;
        virtual ~Const() = default;

        private:
        int64_t const_const;

        public:
        const int64_t & get_const_const() const { return const_const; }
        int64_t & get_mutable_const_const() { return const_const; }
        void set_const_const(const int64_t & value) { this->const_const = value; }
    };

    class ConstCast {
        public:
        ConstCast() = default;
        virtual ~ConstCast() = default;

        private:
        int64_t const_cast_const_cast;

        public:
        const int64_t & get_const_cast_const_cast() const { return const_cast_const_cast; }
        int64_t & get_mutable_const_cast_const_cast() { return const_cast_const_cast; }
        void set_const_cast_const_cast(const int64_t & value) { this->const_cast_const_cast = value; }
    };

    class Constexpr {
        public:
        Constexpr() = default;
        virtual ~Constexpr() = default;

        private:
        int64_t constexpr_constexpr;

        public:
        const int64_t & get_constexpr_constexpr() const { return constexpr_constexpr; }
        int64_t & get_mutable_constexpr_constexpr() { return constexpr_constexpr; }
        void set_constexpr_constexpr(const int64_t & value) { this->constexpr_constexpr = value; }
    };

    class Continue {
        public:
        Continue() = default;
        virtual ~Continue() = default;

        private:
        int64_t continue_continue;

        public:
        const int64_t & get_continue_continue() const { return continue_continue; }
        int64_t & get_mutable_continue_continue() { return continue_continue; }
        void set_continue_continue(const int64_t & value) { this->continue_continue = value; }
    };

    class BoolClass {
        public:
        BoolClass() = default;
        virtual ~BoolClass() = default;

        private:
        int64_t bool_bool;

        public:
        const int64_t & get_bool_bool() const { return bool_bool; }
        int64_t & get_mutable_bool_bool() { return bool_bool; }
        void set_bool_bool(const int64_t & value) { this->bool_bool = value; }
    };

    class ClassClass {
        public:
        ClassClass() = default;
        virtual ~ClassClass() = default;

        private:
        int64_t class_class;

        public:
        const int64_t & get_class_class() const { return class_class; }
        int64_t & get_mutable_class_class() { return class_class; }
        void set_class_class(const int64_t & value) { this->class_class = value; }
    };

    class Obj1 {
        public:
        Obj1() = default;
        virtual ~Obj1() = default;

        private:
        Abstract abstract;
        Any any;
        Array array;
        ArrayNode array_node;
        As as;
        Assert assert;
        Associatedtype associatedtype;
        Associativity associativity;
        Async async;
        Atomic atomic;
        Await await;
        Base base;
        Boolean boolean;
        BooleanNode boolean_node;
        Bycopy bycopy;
        Byref byref;
        Byte byte;
        Calendar calendar;
        Chan chan;
        Checked checked;
        Clone clone;
        Codable codable;
        CodingKey coding_key;
        CodingKeys coding_keys;
        Complex complex;
        Console console;
        Constructor constructor;
        Convenience convenience;
        Convert convert;
        Converter converter;
        int64_t dummy;
        Empty empty;
        Obj1Bool fluffy_bool;
        Imaginery imaginery;
        Alignas obj1_alignas;
        Alignof obj1_alignof;
        And obj1_and;
        AndEq obj1_and_eq;
        AnyClass obj1_any;
        Asm obj1_asm;
        AtomicCancel obj1_atomic_cancel;
        AtomicCommit obj1_atomic_commit;
        AtomicNoexcept obj1_atomic_noexcept;
        Auto obj1_auto;
        Bitand obj1_bitand;
        Bitor obj1_bitor;
        Bool obj1_bool;
        Break obj1_break;
        Case obj1_case;
        Catch obj1_catch;
        Char obj1_char;
        Char16T obj1_char16_t;
        Char32T obj1_char32_t;
        Class obj1_class;
        CoAwait obj1_co_await;
        CoReturn obj1_co_return;
        CoYield obj1_co_yield;
        Compl obj1_compl;
        Concept obj1_concept;
        Const obj1_const;
        ConstCast obj1_const_cast;
        Constexpr obj1_constexpr;
        Continue obj1_continue;
        BoolClass purple_bool;
        ClassClass purple_class;

        public:
        const Abstract & get_abstract() const { return abstract; }
        Abstract & get_mutable_abstract() { return abstract; }
        void set_abstract(const Abstract & value) { this->abstract = value; }

        const Any & get_any() const { return any; }
        Any & get_mutable_any() { return any; }
        void set_any(const Any & value) { this->any = value; }

        const Array & get_array() const { return array; }
        Array & get_mutable_array() { return array; }
        void set_array(const Array & value) { this->array = value; }

        const ArrayNode & get_array_node() const { return array_node; }
        ArrayNode & get_mutable_array_node() { return array_node; }
        void set_array_node(const ArrayNode & value) { this->array_node = value; }

        const As & get_as() const { return as; }
        As & get_mutable_as() { return as; }
        void set_as(const As & value) { this->as = value; }

        const Assert & get_assert() const { return assert; }
        Assert & get_mutable_assert() { return assert; }
        void set_assert(const Assert & value) { this->assert = value; }

        const Associatedtype & get_associatedtype() const { return associatedtype; }
        Associatedtype & get_mutable_associatedtype() { return associatedtype; }
        void set_associatedtype(const Associatedtype & value) { this->associatedtype = value; }

        const Associativity & get_associativity() const { return associativity; }
        Associativity & get_mutable_associativity() { return associativity; }
        void set_associativity(const Associativity & value) { this->associativity = value; }

        const Async & get_async() const { return async; }
        Async & get_mutable_async() { return async; }
        void set_async(const Async & value) { this->async = value; }

        const Atomic & get_atomic() const { return atomic; }
        Atomic & get_mutable_atomic() { return atomic; }
        void set_atomic(const Atomic & value) { this->atomic = value; }

        const Await & get_await() const { return await; }
        Await & get_mutable_await() { return await; }
        void set_await(const Await & value) { this->await = value; }

        const Base & get_base() const { return base; }
        Base & get_mutable_base() { return base; }
        void set_base(const Base & value) { this->base = value; }

        const Boolean & get_boolean() const { return boolean; }
        Boolean & get_mutable_boolean() { return boolean; }
        void set_boolean(const Boolean & value) { this->boolean = value; }

        const BooleanNode & get_boolean_node() const { return boolean_node; }
        BooleanNode & get_mutable_boolean_node() { return boolean_node; }
        void set_boolean_node(const BooleanNode & value) { this->boolean_node = value; }

        const Bycopy & get_bycopy() const { return bycopy; }
        Bycopy & get_mutable_bycopy() { return bycopy; }
        void set_bycopy(const Bycopy & value) { this->bycopy = value; }

        const Byref & get_byref() const { return byref; }
        Byref & get_mutable_byref() { return byref; }
        void set_byref(const Byref & value) { this->byref = value; }

        const Byte & get_byte() const { return byte; }
        Byte & get_mutable_byte() { return byte; }
        void set_byte(const Byte & value) { this->byte = value; }

        const Calendar & get_calendar() const { return calendar; }
        Calendar & get_mutable_calendar() { return calendar; }
        void set_calendar(const Calendar & value) { this->calendar = value; }

        const Chan & get_chan() const { return chan; }
        Chan & get_mutable_chan() { return chan; }
        void set_chan(const Chan & value) { this->chan = value; }

        const Checked & get_checked() const { return checked; }
        Checked & get_mutable_checked() { return checked; }
        void set_checked(const Checked & value) { this->checked = value; }

        const Clone & get_clone() const { return clone; }
        Clone & get_mutable_clone() { return clone; }
        void set_clone(const Clone & value) { this->clone = value; }

        const Codable & get_codable() const { return codable; }
        Codable & get_mutable_codable() { return codable; }
        void set_codable(const Codable & value) { this->codable = value; }

        const CodingKey & get_coding_key() const { return coding_key; }
        CodingKey & get_mutable_coding_key() { return coding_key; }
        void set_coding_key(const CodingKey & value) { this->coding_key = value; }

        const CodingKeys & get_coding_keys() const { return coding_keys; }
        CodingKeys & get_mutable_coding_keys() { return coding_keys; }
        void set_coding_keys(const CodingKeys & value) { this->coding_keys = value; }

        const Complex & get_complex() const { return complex; }
        Complex & get_mutable_complex() { return complex; }
        void set_complex(const Complex & value) { this->complex = value; }

        const Console & get_console() const { return console; }
        Console & get_mutable_console() { return console; }
        void set_console(const Console & value) { this->console = value; }

        const Constructor & get_constructor() const { return constructor; }
        Constructor & get_mutable_constructor() { return constructor; }
        void set_constructor(const Constructor & value) { this->constructor = value; }

        const Convenience & get_convenience() const { return convenience; }
        Convenience & get_mutable_convenience() { return convenience; }
        void set_convenience(const Convenience & value) { this->convenience = value; }

        const Convert & get_convert() const { return convert; }
        Convert & get_mutable_convert() { return convert; }
        void set_convert(const Convert & value) { this->convert = value; }

        const Converter & get_converter() const { return converter; }
        Converter & get_mutable_converter() { return converter; }
        void set_converter(const Converter & value) { this->converter = value; }

        const int64_t & get_dummy() const { return dummy; }
        int64_t & get_mutable_dummy() { return dummy; }
        void set_dummy(const int64_t & value) { this->dummy = value; }

        const Empty & get_empty() const { return empty; }
        Empty & get_mutable_empty() { return empty; }
        void set_empty(const Empty & value) { this->empty = value; }

        const Obj1Bool & get_fluffy_bool() const { return fluffy_bool; }
        Obj1Bool & get_mutable_fluffy_bool() { return fluffy_bool; }
        void set_fluffy_bool(const Obj1Bool & value) { this->fluffy_bool = value; }

        const Imaginery & get_imaginery() const { return imaginery; }
        Imaginery & get_mutable_imaginery() { return imaginery; }
        void set_imaginery(const Imaginery & value) { this->imaginery = value; }

        const Alignas & get_obj1_alignas() const { return obj1_alignas; }
        Alignas & get_mutable_obj1_alignas() { return obj1_alignas; }
        void set_obj1_alignas(const Alignas & value) { this->obj1_alignas = value; }

        const Alignof & get_obj1_alignof() const { return obj1_alignof; }
        Alignof & get_mutable_obj1_alignof() { return obj1_alignof; }
        void set_obj1_alignof(const Alignof & value) { this->obj1_alignof = value; }

        const And & get_obj1_and() const { return obj1_and; }
        And & get_mutable_obj1_and() { return obj1_and; }
        void set_obj1_and(const And & value) { this->obj1_and = value; }

        const AndEq & get_obj1_and_eq() const { return obj1_and_eq; }
        AndEq & get_mutable_obj1_and_eq() { return obj1_and_eq; }
        void set_obj1_and_eq(const AndEq & value) { this->obj1_and_eq = value; }

        const AnyClass & get_obj1_any() const { return obj1_any; }
        AnyClass & get_mutable_obj1_any() { return obj1_any; }
        void set_obj1_any(const AnyClass & value) { this->obj1_any = value; }

        const Asm & get_obj1_asm() const { return obj1_asm; }
        Asm & get_mutable_obj1_asm() { return obj1_asm; }
        void set_obj1_asm(const Asm & value) { this->obj1_asm = value; }

        const AtomicCancel & get_obj1_atomic_cancel() const { return obj1_atomic_cancel; }
        AtomicCancel & get_mutable_obj1_atomic_cancel() { return obj1_atomic_cancel; }
        void set_obj1_atomic_cancel(const AtomicCancel & value) { this->obj1_atomic_cancel = value; }

        const AtomicCommit & get_obj1_atomic_commit() const { return obj1_atomic_commit; }
        AtomicCommit & get_mutable_obj1_atomic_commit() { return obj1_atomic_commit; }
        void set_obj1_atomic_commit(const AtomicCommit & value) { this->obj1_atomic_commit = value; }

        const AtomicNoexcept & get_obj1_atomic_noexcept() const { return obj1_atomic_noexcept; }
        AtomicNoexcept & get_mutable_obj1_atomic_noexcept() { return obj1_atomic_noexcept; }
        void set_obj1_atomic_noexcept(const AtomicNoexcept & value) { this->obj1_atomic_noexcept = value; }

        const Auto & get_obj1_auto() const { return obj1_auto; }
        Auto & get_mutable_obj1_auto() { return obj1_auto; }
        void set_obj1_auto(const Auto & value) { this->obj1_auto = value; }

        const Bitand & get_obj1_bitand() const { return obj1_bitand; }
        Bitand & get_mutable_obj1_bitand() { return obj1_bitand; }
        void set_obj1_bitand(const Bitand & value) { this->obj1_bitand = value; }

        const Bitor & get_obj1_bitor() const { return obj1_bitor; }
        Bitor & get_mutable_obj1_bitor() { return obj1_bitor; }
        void set_obj1_bitor(const Bitor & value) { this->obj1_bitor = value; }

        const Bool & get_obj1_bool() const { return obj1_bool; }
        Bool & get_mutable_obj1_bool() { return obj1_bool; }
        void set_obj1_bool(const Bool & value) { this->obj1_bool = value; }

        const Break & get_obj1_break() const { return obj1_break; }
        Break & get_mutable_obj1_break() { return obj1_break; }
        void set_obj1_break(const Break & value) { this->obj1_break = value; }

        const Case & get_obj1_case() const { return obj1_case; }
        Case & get_mutable_obj1_case() { return obj1_case; }
        void set_obj1_case(const Case & value) { this->obj1_case = value; }

        const Catch & get_obj1_catch() const { return obj1_catch; }
        Catch & get_mutable_obj1_catch() { return obj1_catch; }
        void set_obj1_catch(const Catch & value) { this->obj1_catch = value; }

        const Char & get_obj1_char() const { return obj1_char; }
        Char & get_mutable_obj1_char() { return obj1_char; }
        void set_obj1_char(const Char & value) { this->obj1_char = value; }

        const Char16T & get_obj1_char16_t() const { return obj1_char16_t; }
        Char16T & get_mutable_obj1_char16_t() { return obj1_char16_t; }
        void set_obj1_char16_t(const Char16T & value) { this->obj1_char16_t = value; }

        const Char32T & get_obj1_char32_t() const { return obj1_char32_t; }
        Char32T & get_mutable_obj1_char32_t() { return obj1_char32_t; }
        void set_obj1_char32_t(const Char32T & value) { this->obj1_char32_t = value; }

        const Class & get_obj1_class() const { return obj1_class; }
        Class & get_mutable_obj1_class() { return obj1_class; }
        void set_obj1_class(const Class & value) { this->obj1_class = value; }

        const CoAwait & get_obj1_co_await() const { return obj1_co_await; }
        CoAwait & get_mutable_obj1_co_await() { return obj1_co_await; }
        void set_obj1_co_await(const CoAwait & value) { this->obj1_co_await = value; }

        const CoReturn & get_obj1_co_return() const { return obj1_co_return; }
        CoReturn & get_mutable_obj1_co_return() { return obj1_co_return; }
        void set_obj1_co_return(const CoReturn & value) { this->obj1_co_return = value; }

        const CoYield & get_obj1_co_yield() const { return obj1_co_yield; }
        CoYield & get_mutable_obj1_co_yield() { return obj1_co_yield; }
        void set_obj1_co_yield(const CoYield & value) { this->obj1_co_yield = value; }

        const Compl & get_obj1_compl() const { return obj1_compl; }
        Compl & get_mutable_obj1_compl() { return obj1_compl; }
        void set_obj1_compl(const Compl & value) { this->obj1_compl = value; }

        const Concept & get_obj1_concept() const { return obj1_concept; }
        Concept & get_mutable_obj1_concept() { return obj1_concept; }
        void set_obj1_concept(const Concept & value) { this->obj1_concept = value; }

        const Const & get_obj1_const() const { return obj1_const; }
        Const & get_mutable_obj1_const() { return obj1_const; }
        void set_obj1_const(const Const & value) { this->obj1_const = value; }

        const ConstCast & get_obj1_const_cast() const { return obj1_const_cast; }
        ConstCast & get_mutable_obj1_const_cast() { return obj1_const_cast; }
        void set_obj1_const_cast(const ConstCast & value) { this->obj1_const_cast = value; }

        const Constexpr & get_obj1_constexpr() const { return obj1_constexpr; }
        Constexpr & get_mutable_obj1_constexpr() { return obj1_constexpr; }
        void set_obj1_constexpr(const Constexpr & value) { this->obj1_constexpr = value; }

        const Continue & get_obj1_continue() const { return obj1_continue; }
        Continue & get_mutable_obj1_continue() { return obj1_continue; }
        void set_obj1_continue(const Continue & value) { this->obj1_continue = value; }

        const BoolClass & get_purple_bool() const { return purple_bool; }
        BoolClass & get_mutable_purple_bool() { return purple_bool; }
        void set_purple_bool(const BoolClass & value) { this->purple_bool = value; }

        const ClassClass & get_purple_class() const { return purple_class; }
        ClassClass & get_mutable_purple_class() { return purple_class; }
        void set_purple_class(const ClassClass & value) { this->purple_class = value; }
    };

    class CultureInfo {
        public:
        CultureInfo() = default;
        virtual ~CultureInfo() = default;

        private:
        int64_t culture_info;

        public:
        const int64_t & get_culture_info() const { return culture_info; }
        int64_t & get_mutable_culture_info() { return culture_info; }
        void set_culture_info(const int64_t & value) { this->culture_info = value; }
    };

    class Date {
        public:
        Date() = default;
        virtual ~Date() = default;

        private:
        int64_t date;

        public:
        const int64_t & get_date() const { return date; }
        int64_t & get_mutable_date() { return date; }
        void set_date(const int64_t & value) { this->date = value; }
    };

    class DateFormatter {
        public:
        DateFormatter() = default;
        virtual ~DateFormatter() = default;

        private:
        int64_t date_formatter;

        public:
        const int64_t & get_date_formatter() const { return date_formatter; }
        int64_t & get_mutable_date_formatter() { return date_formatter; }
        void set_date_formatter(const int64_t & value) { this->date_formatter = value; }
    };

    class DateOnly {
        public:
        DateOnly() = default;
        virtual ~DateOnly() = default;

        private:
        int64_t date_only;

        public:
        const int64_t & get_date_only() const { return date_only; }
        int64_t & get_mutable_date_only() { return date_only; }
        void set_date_only(const int64_t & value) { this->date_only = value; }
    };

    class DateOnlyConverter {
        public:
        DateOnlyConverter() = default;
        virtual ~DateOnlyConverter() = default;

        private:
        int64_t date_only_converter;

        public:
        const int64_t & get_date_only_converter() const { return date_only_converter; }
        int64_t & get_mutable_date_only_converter() { return date_only_converter; }
        void set_date_only_converter(const int64_t & value) { this->date_only_converter = value; }
    };

    class DateParseHandling {
        public:
        DateParseHandling() = default;
        virtual ~DateParseHandling() = default;

        private:
        int64_t date_parse_handling;

        public:
        const int64_t & get_date_parse_handling() const { return date_parse_handling; }
        int64_t & get_mutable_date_parse_handling() { return date_parse_handling; }
        void set_date_parse_handling(const int64_t & value) { this->date_parse_handling = value; }
    };

    class DateTime {
        public:
        DateTime() = default;
        virtual ~DateTime() = default;

        private:
        std::string date_time;

        public:
        const std::string & get_date_time() const { return date_time; }
        std::string & get_mutable_date_time() { return date_time; }
        void set_date_time(const std::string & value) { this->date_time = value; }
    };

    class DateTimeStyles {
        public:
        DateTimeStyles() = default;
        virtual ~DateTimeStyles() = default;

        private:
        int64_t date_time_styles;

        public:
        const int64_t & get_date_time_styles() const { return date_time_styles; }
        int64_t & get_mutable_date_time_styles() { return date_time_styles; }
        void set_date_time_styles(const int64_t & value) { this->date_time_styles = value; }
    };

    class Debugger {
        public:
        Debugger() = default;
        virtual ~Debugger() = default;

        private:
        int64_t debugger;

        public:
        const int64_t & get_debugger() const { return debugger; }
        int64_t & get_mutable_debugger() { return debugger; }
        void set_debugger(const int64_t & value) { this->debugger = value; }
    };

    class Decimal {
        public:
        Decimal() = default;
        virtual ~Decimal() = default;

        private:
        int64_t decimal;

        public:
        const int64_t & get_decimal() const { return decimal; }
        int64_t & get_mutable_decimal() { return decimal; }
        void set_decimal(const int64_t & value) { this->decimal = value; }
    };

    class Declare {
        public:
        Declare() = default;
        virtual ~Declare() = default;

        private:
        int64_t declare;

        public:
        const int64_t & get_declare() const { return declare; }
        int64_t & get_mutable_declare() { return declare; }
        void set_declare(const int64_t & value) { this->declare = value; }
    };

    class DecodeString {
        public:
        DecodeString() = default;
        virtual ~DecodeString() = default;

        private:
        int64_t decode_string;

        public:
        const int64_t & get_decode_string() const { return decode_string; }
        int64_t & get_mutable_decode_string() { return decode_string; }
        void set_decode_string(const int64_t & value) { this->decode_string = value; }
    };

    class Decoder {
        public:
        Decoder() = default;
        virtual ~Decoder() = default;

        private:
        int64_t decoder;

        public:
        const int64_t & get_decoder() const { return decoder; }
        int64_t & get_mutable_decoder() { return decoder; }
        void set_decoder(const int64_t & value) { this->decoder = value; }
    };

    class DecodingError {
        public:
        DecodingError() = default;
        virtual ~DecodingError() = default;

        private:
        int64_t decoding_error;

        public:
        const int64_t & get_decoding_error() const { return decoding_error; }
        int64_t & get_mutable_decoding_error() { return decoding_error; }
        void set_decoding_error(const int64_t & value) { this->decoding_error = value; }
    };

    class Def {
        public:
        Def() = default;
        virtual ~Def() = default;

        private:
        int64_t def;

        public:
        const int64_t & get_def() const { return def; }
        int64_t & get_mutable_def() { return def; }
        void set_def(const int64_t & value) { this->def = value; }
    };

    class Defer {
        public:
        Defer() = default;
        virtual ~Defer() = default;

        private:
        int64_t defer;

        public:
        const int64_t & get_defer() const { return defer; }
        int64_t & get_mutable_defer() { return defer; }
        void set_defer(const int64_t & value) { this->defer = value; }
    };

    class Deinit {
        public:
        Deinit() = default;
        virtual ~Deinit() = default;

        private:
        int64_t deinit;

        public:
        const int64_t & get_deinit() const { return deinit; }
        int64_t & get_mutable_deinit() { return deinit; }
        void set_deinit(const int64_t & value) { this->deinit = value; }
    };

    class Del {
        public:
        Del() = default;
        virtual ~Del() = default;

        private:
        int64_t del;

        public:
        const int64_t & get_del() const { return del; }
        int64_t & get_mutable_del() { return del; }
        void set_del(const int64_t & value) { this->del = value; }
    };

    class Delegate {
        public:
        Delegate() = default;
        virtual ~Delegate() = default;

        private:
        int64_t delegate;

        public:
        const int64_t & get_delegate() const { return delegate; }
        int64_t & get_mutable_delegate() { return delegate; }
        void set_delegate(const int64_t & value) { this->delegate = value; }
    };

    class DeserializationFeature {
        public:
        DeserializationFeature() = default;
        virtual ~DeserializationFeature() = default;

        private:
        int64_t deserialization_feature;

        public:
        const int64_t & get_deserialization_feature() const { return deserialization_feature; }
        int64_t & get_mutable_deserialization_feature() { return deserialization_feature; }
        void set_deserialization_feature(const int64_t & value) { this->deserialization_feature = value; }
    };

    class Dict {
        public:
        Dict() = default;
        virtual ~Dict() = default;

        private:
        int64_t dict;

        public:
        const int64_t & get_dict() const { return dict; }
        int64_t & get_mutable_dict() { return dict; }
        void set_dict(const int64_t & value) { this->dict = value; }
    };

    class Dictionary {
        public:
        Dictionary() = default;
        virtual ~Dictionary() = default;

        private:
        int64_t dictionary;

        public:
        const int64_t & get_dictionary() const { return dictionary; }
        int64_t & get_mutable_dictionary() { return dictionary; }
        void set_dictionary(const int64_t & value) { this->dictionary = value; }
    };

    class DidSet {
        public:
        DidSet() = default;
        virtual ~DidSet() = default;

        private:
        int64_t did_set;

        public:
        const int64_t & get_did_set() const { return did_set; }
        int64_t & get_mutable_did_set() { return did_set; }
        void set_did_set(const int64_t & value) { this->did_set = value; }
    };

    class DoubleNode {
        public:
        DoubleNode() = default;
        virtual ~DoubleNode() = default;

        private:
        int64_t double_node;

        public:
        const int64_t & get_double_node() const { return double_node; }
        int64_t & get_mutable_double_node() { return double_node; }
        void set_double_node(const int64_t & value) { this->double_node = value; }
    };

    class Dynamic {
        public:
        Dynamic() = default;
        virtual ~Dynamic() = default;

        private:
        int64_t dynamic;

        public:
        const int64_t & get_dynamic() const { return dynamic; }
        int64_t & get_mutable_dynamic() { return dynamic; }
        void set_dynamic(const int64_t & value) { this->dynamic = value; }
    };

    class Elif {
        public:
        Elif() = default;
        virtual ~Elif() = default;

        private:
        int64_t elif;

        public:
        const int64_t & get_elif() const { return elif; }
        int64_t & get_mutable_elif() { return elif; }
        void set_elif(const int64_t & value) { this->elif = value; }
    };

    class EncodeQuickType {
        public:
        EncodeQuickType() = default;
        virtual ~EncodeQuickType() = default;

        private:
        int64_t encode_quick_type;

        public:
        const int64_t & get_encode_quick_type() const { return encode_quick_type; }
        int64_t & get_mutable_encode_quick_type() { return encode_quick_type; }
        void set_encode_quick_type(const int64_t & value) { this->encode_quick_type = value; }
    };

    class Encoder {
        public:
        Encoder() = default;
        virtual ~Encoder() = default;

        private:
        int64_t encoder;

        public:
        const int64_t & get_encoder() const { return encoder; }
        int64_t & get_mutable_encoder() { return encoder; }
        void set_encoder(const int64_t & value) { this->encoder = value; }
    };

    enum class EnumValue : int { READY, DONE };

    class EnumValues {
        public:
        EnumValues() = default;
        virtual ~EnumValues() = default;

        private:
        std::vector<EnumValue> enum_values;

        public:
        const std::vector<EnumValue> & get_enum_values() const { return enum_values; }
        std::vector<EnumValue> & get_mutable_enum_values() { return enum_values; }
        void set_enum_values(const std::vector<EnumValue> & value) { this->enum_values = value; }
    };

    class EqualityContract {
        public:
        EqualityContract() = default;
        virtual ~EqualityContract() = default;

        private:
        int64_t equality_contract;

        public:
        const int64_t & get_equality_contract() const { return equality_contract; }
        int64_t & get_mutable_equality_contract() { return equality_contract; }
        void set_equality_contract(const int64_t & value) { this->equality_contract = value; }
    };

    class Equatable {
        public:
        Equatable() = default;
        virtual ~Equatable() = default;

        private:
        int64_t equatable;

        public:
        const int64_t & get_equatable() const { return equatable; }
        int64_t & get_mutable_equatable() { return equatable; }
        void set_equatable(const int64_t & value) { this->equatable = value; }
    };

    class Event {
        public:
        Event() = default;
        virtual ~Event() = default;

        private:
        int64_t event;

        public:
        const int64_t & get_event() const { return event; }
        int64_t & get_mutable_event() { return event; }
        void set_event(const int64_t & value) { this->event = value; }
    };

    class Except {
        public:
        Except() = default;
        virtual ~Except() = default;

        private:
        int64_t except;

        public:
        const int64_t & get_except() const { return except; }
        int64_t & get_mutable_except() { return except; }
        void set_except(const int64_t & value) { this->except = value; }
    };

    class Exception {
        public:
        Exception() = default;
        virtual ~Exception() = default;

        private:
        int64_t exception;

        public:
        const int64_t & get_exception() const { return exception; }
        int64_t & get_mutable_exception() { return exception; }
        void set_exception(const int64_t & value) { this->exception = value; }
    };

    class Exposing {
        public:
        Exposing() = default;
        virtual ~Exposing() = default;

        private:
        int64_t exposing;

        public:
        const int64_t & get_exposing() const { return exposing; }
        int64_t & get_mutable_exposing() { return exposing; }
        void set_exposing(const int64_t & value) { this->exposing = value; }
    };

    class Extends {
        public:
        Extends() = default;
        virtual ~Extends() = default;

        private:
        int64_t extends;

        public:
        const int64_t & get_extends() const { return extends; }
        int64_t & get_mutable_extends() { return extends; }
        void set_extends(const int64_t & value) { this->extends = value; }
    };

    class Extension {
        public:
        Extension() = default;
        virtual ~Extension() = default;

        private:
        int64_t extension;

        public:
        const int64_t & get_extension() const { return extension; }
        int64_t & get_mutable_extension() { return extension; }
        void set_extension(const int64_t & value) { this->extension = value; }
    };

    class Fallthrough {
        public:
        Fallthrough() = default;
        virtual ~Fallthrough() = default;

        private:
        int64_t fallthrough;

        public:
        const int64_t & get_fallthrough() const { return fallthrough; }
        int64_t & get_mutable_fallthrough() { return fallthrough; }
        void set_fallthrough(const int64_t & value) { this->fallthrough = value; }
    };

    class Fileprivate {
        public:
        Fileprivate() = default;
        virtual ~Fileprivate() = default;

        private:
        int64_t fileprivate;

        public:
        const int64_t & get_fileprivate() const { return fileprivate; }
        int64_t & get_mutable_fileprivate() { return fileprivate; }
        void set_fileprivate(const int64_t & value) { this->fileprivate = value; }
    };

    class Finally {
        public:
        Finally() = default;
        virtual ~Finally() = default;

        private:
        int64_t finally;

        public:
        const int64_t & get_finally() const { return finally; }
        int64_t & get_mutable_finally() { return finally; }
        void set_finally(const int64_t & value) { this->finally = value; }
    };

    class Fixed {
        public:
        Fixed() = default;
        virtual ~Fixed() = default;

        private:
        int64_t fixed;

        public:
        const int64_t & get_fixed() const { return fixed; }
        int64_t & get_mutable_fixed() { return fixed; }
        void set_fixed(const int64_t & value) { this->fixed = value; }
    };

    class Foreach {
        public:
        Foreach() = default;
        virtual ~Foreach() = default;

        private:
        int64_t foreach;

        public:
        const int64_t & get_foreach() const { return foreach; }
        int64_t & get_mutable_foreach() { return foreach; }
        void set_foreach(const int64_t & value) { this->foreach = value; }
    };

    class FormatException {
        public:
        FormatException() = default;
        virtual ~FormatException() = default;

        private:
        int64_t format_exception;

        public:
        const int64_t & get_format_exception() const { return format_exception; }
        int64_t & get_mutable_format_exception() { return format_exception; }
        void set_format_exception(const int64_t & value) { this->format_exception = value; }
    };

    class From {
        public:
        From() = default;
        virtual ~From() = default;

        private:
        int64_t from;

        public:
        const int64_t & get_from() const { return from; }
        int64_t & get_mutable_from() { return from; }
        void set_from(const int64_t & value) { this->from = value; }
    };

    class FromDict {
        public:
        FromDict() = default;
        virtual ~FromDict() = default;

        private:
        int64_t from_dict;

        public:
        const int64_t & get_from_dict() const { return from_dict; }
        int64_t & get_mutable_from_dict() { return from_dict; }
        void set_from_dict(const int64_t & value) { this->from_dict = value; }
    };

    class FromJson {
        public:
        FromJson() = default;
        virtual ~FromJson() = default;

        private:
        int64_t from_json;

        public:
        const int64_t & get_from_json() const { return from_json; }
        int64_t & get_mutable_from_json() { return from_json; }
        void set_from_json(const int64_t & value) { this->from_json = value; }
    };

    class Func {
        public:
        Func() = default;
        virtual ~Func() = default;

        private:
        int64_t func;

        public:
        const int64_t & get_func() const { return func; }
        int64_t & get_mutable_func() { return func; }
        void set_func(const int64_t & value) { this->func = value; }
    };

    class Decltype {
        public:
        Decltype() = default;
        virtual ~Decltype() = default;

        private:
        int64_t decltype_decltype;

        public:
        const int64_t & get_decltype_decltype() const { return decltype_decltype; }
        int64_t & get_mutable_decltype_decltype() { return decltype_decltype; }
        void set_decltype_decltype(const int64_t & value) { this->decltype_decltype = value; }
    };

    class Default {
        public:
        Default() = default;
        virtual ~Default() = default;

        private:
        int64_t default_default;

        public:
        const int64_t & get_default_default() const { return default_default; }
        int64_t & get_mutable_default_default() { return default_default; }
        void set_default_default(const int64_t & value) { this->default_default = value; }
    };

    class Delete {
        public:
        Delete() = default;
        virtual ~Delete() = default;

        private:
        int64_t delete_delete;

        public:
        const int64_t & get_delete_delete() const { return delete_delete; }
        int64_t & get_mutable_delete_delete() { return delete_delete; }
        void set_delete_delete(const int64_t & value) { this->delete_delete = value; }
    };

    class Do {
        public:
        Do() = default;
        virtual ~Do() = default;

        private:
        int64_t do_do;

        public:
        const int64_t & get_do_do() const { return do_do; }
        int64_t & get_mutable_do_do() { return do_do; }
        void set_do_do(const int64_t & value) { this->do_do = value; }
    };

    class Double {
        public:
        Double() = default;
        virtual ~Double() = default;

        private:
        int64_t double_double;

        public:
        const int64_t & get_double_double() const { return double_double; }
        int64_t & get_mutable_double_double() { return double_double; }
        void set_double_double(const int64_t & value) { this->double_double = value; }
    };

    class DynamicCast {
        public:
        DynamicCast() = default;
        virtual ~DynamicCast() = default;

        private:
        int64_t dynamic_cast_dynamic_cast;

        public:
        const int64_t & get_dynamic_cast_dynamic_cast() const { return dynamic_cast_dynamic_cast; }
        int64_t & get_mutable_dynamic_cast_dynamic_cast() { return dynamic_cast_dynamic_cast; }
        void set_dynamic_cast_dynamic_cast(const int64_t & value) { this->dynamic_cast_dynamic_cast = value; }
    };

    class Else {
        public:
        Else() = default;
        virtual ~Else() = default;

        private:
        int64_t else_else;

        public:
        const int64_t & get_else_else() const { return else_else; }
        int64_t & get_mutable_else_else() { return else_else; }
        void set_else_else(const int64_t & value) { this->else_else = value; }
    };

    class Enum {
        public:
        Enum() = default;
        virtual ~Enum() = default;

        private:
        int64_t enum_enum;

        public:
        const int64_t & get_enum_enum() const { return enum_enum; }
        int64_t & get_mutable_enum_enum() { return enum_enum; }
        void set_enum_enum(const int64_t & value) { this->enum_enum = value; }
    };

    class Explicit {
        public:
        Explicit() = default;
        virtual ~Explicit() = default;

        private:
        int64_t explicit_explicit;

        public:
        const int64_t & get_explicit_explicit() const { return explicit_explicit; }
        int64_t & get_mutable_explicit_explicit() { return explicit_explicit; }
        void set_explicit_explicit(const int64_t & value) { this->explicit_explicit = value; }
    };

    class Export {
        public:
        Export() = default;
        virtual ~Export() = default;

        private:
        int64_t export_export;

        public:
        const int64_t & get_export_export() const { return export_export; }
        int64_t & get_mutable_export_export() { return export_export; }
        void set_export_export(const int64_t & value) { this->export_export = value; }
    };

    class Extern {
        public:
        Extern() = default;
        virtual ~Extern() = default;

        private:
        int64_t extern_extern;

        public:
        const int64_t & get_extern_extern() const { return extern_extern; }
        int64_t & get_mutable_extern_extern() { return extern_extern; }
        void set_extern_extern(const int64_t & value) { this->extern_extern = value; }
    };

    class False {
        public:
        False() = default;
        virtual ~False() = default;

        private:
        int64_t false_false;

        public:
        const int64_t & get_false_false() const { return false_false; }
        int64_t & get_mutable_false_false() { return false_false; }
        void set_false_false(const int64_t & value) { this->false_false = value; }
    };

    class Final {
        public:
        Final() = default;
        virtual ~Final() = default;

        private:
        int64_t final_final;

        public:
        const int64_t & get_final_final() const { return final_final; }
        int64_t & get_mutable_final_final() { return final_final; }
        void set_final_final(const int64_t & value) { this->final_final = value; }
    };

    class Float {
        public:
        Float() = default;
        virtual ~Float() = default;

        private:
        int64_t float_float;

        public:
        const int64_t & get_float_float() const { return float_float; }
        int64_t & get_mutable_float_float() { return float_float; }
        void set_float_float(const int64_t & value) { this->float_float = value; }
    };

    class For {
        public:
        For() = default;
        virtual ~For() = default;

        private:
        int64_t for_for;

        public:
        const int64_t & get_for_for() const { return for_for; }
        int64_t & get_mutable_for_for() { return for_for; }
        void set_for_for(const int64_t & value) { this->for_for = value; }
    };

    class Friend {
        public:
        Friend() = default;
        virtual ~Friend() = default;

        private:
        int64_t friend_friend;

        public:
        const int64_t & get_friend_friend() const { return friend_friend; }
        int64_t & get_mutable_friend_friend() { return friend_friend; }
        void set_friend_friend(const int64_t & value) { this->friend_friend = value; }
    };

    class FalseClass {
        public:
        FalseClass() = default;
        virtual ~FalseClass() = default;

        private:
        int64_t false_false;

        public:
        const int64_t & get_false_false() const { return false_false; }
        int64_t & get_mutable_false_false() { return false_false; }
        void set_false_false(const int64_t & value) { this->false_false = value; }
    };

    class Obj2 {
        public:
        Obj2() = default;
        virtual ~Obj2() = default;

        private:
        CultureInfo culture_info;
        Date date;
        DateFormatter date_formatter;
        DateOnly date_only;
        DateOnlyConverter date_only_converter;
        DateParseHandling date_parse_handling;
        DateTime date_time;
        DateTimeStyles date_time_styles;
        Debugger debugger;
        Decimal decimal;
        Declare declare;
        DecodeString decode_string;
        Decoder decoder;
        DecodingError decoding_error;
        Def def;
        Defer defer;
        Deinit deinit;
        Del del;
        Delegate delegate;
        DeserializationFeature deserialization_feature;
        Dict dict;
        Dictionary dictionary;
        DidSet did_set;
        DoubleNode double_node;
        int64_t dummy;
        Dynamic dynamic;
        Elif elif;
        EncodeQuickType encode_quick_type;
        Encoder encoder;
        EnumValues enum_values;
        EqualityContract equality_contract;
        Equatable equatable;
        Event event;
        Except except;
        Exception exception;
        Exposing exposing;
        Extends extends;
        Extension extension;
        Fallthrough fallthrough;
        Fileprivate fileprivate;
        Finally finally;
        Fixed fixed;
        Foreach foreach;
        FormatException format_exception;
        From from;
        FromDict from_dict;
        FromJson from_json;
        Func func;
        Decltype obj2_decltype;
        Default obj2_default;
        Delete obj2_delete;
        Do obj2_do;
        Double obj2_double;
        DynamicCast obj2_dynamic_cast;
        Else obj2_else;
        Enum obj2_enum;
        Explicit obj2_explicit;
        Export obj2_export;
        Extern obj2_extern;
        False obj2_false;
        Final obj2_final;
        Float obj2_float;
        For obj2_for;
        Friend obj2_friend;
        FalseClass purple_false;

        public:
        const CultureInfo & get_culture_info() const { return culture_info; }
        CultureInfo & get_mutable_culture_info() { return culture_info; }
        void set_culture_info(const CultureInfo & value) { this->culture_info = value; }

        const Date & get_date() const { return date; }
        Date & get_mutable_date() { return date; }
        void set_date(const Date & value) { this->date = value; }

        const DateFormatter & get_date_formatter() const { return date_formatter; }
        DateFormatter & get_mutable_date_formatter() { return date_formatter; }
        void set_date_formatter(const DateFormatter & value) { this->date_formatter = value; }

        const DateOnly & get_date_only() const { return date_only; }
        DateOnly & get_mutable_date_only() { return date_only; }
        void set_date_only(const DateOnly & value) { this->date_only = value; }

        const DateOnlyConverter & get_date_only_converter() const { return date_only_converter; }
        DateOnlyConverter & get_mutable_date_only_converter() { return date_only_converter; }
        void set_date_only_converter(const DateOnlyConverter & value) { this->date_only_converter = value; }

        const DateParseHandling & get_date_parse_handling() const { return date_parse_handling; }
        DateParseHandling & get_mutable_date_parse_handling() { return date_parse_handling; }
        void set_date_parse_handling(const DateParseHandling & value) { this->date_parse_handling = value; }

        const DateTime & get_date_time() const { return date_time; }
        DateTime & get_mutable_date_time() { return date_time; }
        void set_date_time(const DateTime & value) { this->date_time = value; }

        const DateTimeStyles & get_date_time_styles() const { return date_time_styles; }
        DateTimeStyles & get_mutable_date_time_styles() { return date_time_styles; }
        void set_date_time_styles(const DateTimeStyles & value) { this->date_time_styles = value; }

        const Debugger & get_debugger() const { return debugger; }
        Debugger & get_mutable_debugger() { return debugger; }
        void set_debugger(const Debugger & value) { this->debugger = value; }

        const Decimal & get_decimal() const { return decimal; }
        Decimal & get_mutable_decimal() { return decimal; }
        void set_decimal(const Decimal & value) { this->decimal = value; }

        const Declare & get_declare() const { return declare; }
        Declare & get_mutable_declare() { return declare; }
        void set_declare(const Declare & value) { this->declare = value; }

        const DecodeString & get_decode_string() const { return decode_string; }
        DecodeString & get_mutable_decode_string() { return decode_string; }
        void set_decode_string(const DecodeString & value) { this->decode_string = value; }

        const Decoder & get_decoder() const { return decoder; }
        Decoder & get_mutable_decoder() { return decoder; }
        void set_decoder(const Decoder & value) { this->decoder = value; }

        const DecodingError & get_decoding_error() const { return decoding_error; }
        DecodingError & get_mutable_decoding_error() { return decoding_error; }
        void set_decoding_error(const DecodingError & value) { this->decoding_error = value; }

        const Def & get_def() const { return def; }
        Def & get_mutable_def() { return def; }
        void set_def(const Def & value) { this->def = value; }

        const Defer & get_defer() const { return defer; }
        Defer & get_mutable_defer() { return defer; }
        void set_defer(const Defer & value) { this->defer = value; }

        const Deinit & get_deinit() const { return deinit; }
        Deinit & get_mutable_deinit() { return deinit; }
        void set_deinit(const Deinit & value) { this->deinit = value; }

        const Del & get_del() const { return del; }
        Del & get_mutable_del() { return del; }
        void set_del(const Del & value) { this->del = value; }

        const Delegate & get_delegate() const { return delegate; }
        Delegate & get_mutable_delegate() { return delegate; }
        void set_delegate(const Delegate & value) { this->delegate = value; }

        const DeserializationFeature & get_deserialization_feature() const { return deserialization_feature; }
        DeserializationFeature & get_mutable_deserialization_feature() { return deserialization_feature; }
        void set_deserialization_feature(const DeserializationFeature & value) { this->deserialization_feature = value; }

        const Dict & get_dict() const { return dict; }
        Dict & get_mutable_dict() { return dict; }
        void set_dict(const Dict & value) { this->dict = value; }

        const Dictionary & get_dictionary() const { return dictionary; }
        Dictionary & get_mutable_dictionary() { return dictionary; }
        void set_dictionary(const Dictionary & value) { this->dictionary = value; }

        const DidSet & get_did_set() const { return did_set; }
        DidSet & get_mutable_did_set() { return did_set; }
        void set_did_set(const DidSet & value) { this->did_set = value; }

        const DoubleNode & get_double_node() const { return double_node; }
        DoubleNode & get_mutable_double_node() { return double_node; }
        void set_double_node(const DoubleNode & value) { this->double_node = value; }

        const int64_t & get_dummy() const { return dummy; }
        int64_t & get_mutable_dummy() { return dummy; }
        void set_dummy(const int64_t & value) { this->dummy = value; }

        const Dynamic & get_dynamic() const { return dynamic; }
        Dynamic & get_mutable_dynamic() { return dynamic; }
        void set_dynamic(const Dynamic & value) { this->dynamic = value; }

        const Elif & get_elif() const { return elif; }
        Elif & get_mutable_elif() { return elif; }
        void set_elif(const Elif & value) { this->elif = value; }

        const EncodeQuickType & get_encode_quick_type() const { return encode_quick_type; }
        EncodeQuickType & get_mutable_encode_quick_type() { return encode_quick_type; }
        void set_encode_quick_type(const EncodeQuickType & value) { this->encode_quick_type = value; }

        const Encoder & get_encoder() const { return encoder; }
        Encoder & get_mutable_encoder() { return encoder; }
        void set_encoder(const Encoder & value) { this->encoder = value; }

        const EnumValues & get_enum_values() const { return enum_values; }
        EnumValues & get_mutable_enum_values() { return enum_values; }
        void set_enum_values(const EnumValues & value) { this->enum_values = value; }

        const EqualityContract & get_equality_contract() const { return equality_contract; }
        EqualityContract & get_mutable_equality_contract() { return equality_contract; }
        void set_equality_contract(const EqualityContract & value) { this->equality_contract = value; }

        const Equatable & get_equatable() const { return equatable; }
        Equatable & get_mutable_equatable() { return equatable; }
        void set_equatable(const Equatable & value) { this->equatable = value; }

        const Event & get_event() const { return event; }
        Event & get_mutable_event() { return event; }
        void set_event(const Event & value) { this->event = value; }

        const Except & get_except() const { return except; }
        Except & get_mutable_except() { return except; }
        void set_except(const Except & value) { this->except = value; }

        const Exception & get_exception() const { return exception; }
        Exception & get_mutable_exception() { return exception; }
        void set_exception(const Exception & value) { this->exception = value; }

        const Exposing & get_exposing() const { return exposing; }
        Exposing & get_mutable_exposing() { return exposing; }
        void set_exposing(const Exposing & value) { this->exposing = value; }

        const Extends & get_extends() const { return extends; }
        Extends & get_mutable_extends() { return extends; }
        void set_extends(const Extends & value) { this->extends = value; }

        const Extension & get_extension() const { return extension; }
        Extension & get_mutable_extension() { return extension; }
        void set_extension(const Extension & value) { this->extension = value; }

        const Fallthrough & get_fallthrough() const { return fallthrough; }
        Fallthrough & get_mutable_fallthrough() { return fallthrough; }
        void set_fallthrough(const Fallthrough & value) { this->fallthrough = value; }

        const Fileprivate & get_fileprivate() const { return fileprivate; }
        Fileprivate & get_mutable_fileprivate() { return fileprivate; }
        void set_fileprivate(const Fileprivate & value) { this->fileprivate = value; }

        const Finally & get_finally() const { return finally; }
        Finally & get_mutable_finally() { return finally; }
        void set_finally(const Finally & value) { this->finally = value; }

        const Fixed & get_fixed() const { return fixed; }
        Fixed & get_mutable_fixed() { return fixed; }
        void set_fixed(const Fixed & value) { this->fixed = value; }

        const Foreach & get_foreach() const { return foreach; }
        Foreach & get_mutable_foreach() { return foreach; }
        void set_foreach(const Foreach & value) { this->foreach = value; }

        const FormatException & get_format_exception() const { return format_exception; }
        FormatException & get_mutable_format_exception() { return format_exception; }
        void set_format_exception(const FormatException & value) { this->format_exception = value; }

        const From & get_from() const { return from; }
        From & get_mutable_from() { return from; }
        void set_from(const From & value) { this->from = value; }

        const FromDict & get_from_dict() const { return from_dict; }
        FromDict & get_mutable_from_dict() { return from_dict; }
        void set_from_dict(const FromDict & value) { this->from_dict = value; }

        const FromJson & get_from_json() const { return from_json; }
        FromJson & get_mutable_from_json() { return from_json; }
        void set_from_json(const FromJson & value) { this->from_json = value; }

        const Func & get_func() const { return func; }
        Func & get_mutable_func() { return func; }
        void set_func(const Func & value) { this->func = value; }

        const Decltype & get_obj2_decltype() const { return obj2_decltype; }
        Decltype & get_mutable_obj2_decltype() { return obj2_decltype; }
        void set_obj2_decltype(const Decltype & value) { this->obj2_decltype = value; }

        const Default & get_obj2_default() const { return obj2_default; }
        Default & get_mutable_obj2_default() { return obj2_default; }
        void set_obj2_default(const Default & value) { this->obj2_default = value; }

        const Delete & get_obj2_delete() const { return obj2_delete; }
        Delete & get_mutable_obj2_delete() { return obj2_delete; }
        void set_obj2_delete(const Delete & value) { this->obj2_delete = value; }

        const Do & get_obj2_do() const { return obj2_do; }
        Do & get_mutable_obj2_do() { return obj2_do; }
        void set_obj2_do(const Do & value) { this->obj2_do = value; }

        const Double & get_obj2_double() const { return obj2_double; }
        Double & get_mutable_obj2_double() { return obj2_double; }
        void set_obj2_double(const Double & value) { this->obj2_double = value; }

        const DynamicCast & get_obj2_dynamic_cast() const { return obj2_dynamic_cast; }
        DynamicCast & get_mutable_obj2_dynamic_cast() { return obj2_dynamic_cast; }
        void set_obj2_dynamic_cast(const DynamicCast & value) { this->obj2_dynamic_cast = value; }

        const Else & get_obj2_else() const { return obj2_else; }
        Else & get_mutable_obj2_else() { return obj2_else; }
        void set_obj2_else(const Else & value) { this->obj2_else = value; }

        const Enum & get_obj2_enum() const { return obj2_enum; }
        Enum & get_mutable_obj2_enum() { return obj2_enum; }
        void set_obj2_enum(const Enum & value) { this->obj2_enum = value; }

        const Explicit & get_obj2_explicit() const { return obj2_explicit; }
        Explicit & get_mutable_obj2_explicit() { return obj2_explicit; }
        void set_obj2_explicit(const Explicit & value) { this->obj2_explicit = value; }

        const Export & get_obj2_export() const { return obj2_export; }
        Export & get_mutable_obj2_export() { return obj2_export; }
        void set_obj2_export(const Export & value) { this->obj2_export = value; }

        const Extern & get_obj2_extern() const { return obj2_extern; }
        Extern & get_mutable_obj2_extern() { return obj2_extern; }
        void set_obj2_extern(const Extern & value) { this->obj2_extern = value; }

        const False & get_obj2_false() const { return obj2_false; }
        False & get_mutable_obj2_false() { return obj2_false; }
        void set_obj2_false(const False & value) { this->obj2_false = value; }

        const Final & get_obj2_final() const { return obj2_final; }
        Final & get_mutable_obj2_final() { return obj2_final; }
        void set_obj2_final(const Final & value) { this->obj2_final = value; }

        const Float & get_obj2_float() const { return obj2_float; }
        Float & get_mutable_obj2_float() { return obj2_float; }
        void set_obj2_float(const Float & value) { this->obj2_float = value; }

        const For & get_obj2_for() const { return obj2_for; }
        For & get_mutable_obj2_for() { return obj2_for; }
        void set_obj2_for(const For & value) { this->obj2_for = value; }

        const Friend & get_obj2_friend() const { return obj2_friend; }
        Friend & get_mutable_obj2_friend() { return obj2_friend; }
        void set_obj2_friend(const Friend & value) { this->obj2_friend = value; }

        const FalseClass & get_purple_false() const { return purple_false; }
        FalseClass & get_mutable_purple_false() { return purple_false; }
        void set_purple_false(const FalseClass & value) { this->purple_false = value; }
    };

    class Function {
        public:
        Function() = default;
        virtual ~Function() = default;

        private:
        int64_t function;

        public:
        const int64_t & get_function() const { return function; }
        int64_t & get_mutable_function() { return function; }
        void set_function(const int64_t & value) { this->function = value; }
    };

    class Get {
        public:
        Get() = default;
        virtual ~Get() = default;

        private:
        int64_t get;

        public:
        const int64_t & get_get() const { return get; }
        int64_t & get_mutable_get() { return get; }
        void set_get(const int64_t & value) { this->get = value; }
    };

    class Global {
        public:
        Global() = default;
        virtual ~Global() = default;

        private:
        int64_t global;

        public:
        const int64_t & get_global() const { return global; }
        int64_t & get_mutable_global() { return global; }
        void set_global(const int64_t & value) { this->global = value; }
    };

    class Go {
        public:
        Go() = default;
        virtual ~Go() = default;

        private:
        int64_t go;

        public:
        const int64_t & get_go() const { return go; }
        int64_t & get_mutable_go() { return go; }
        void set_go(const int64_t & value) { this->go = value; }
    };

    class Guard {
        public:
        Guard() = default;
        virtual ~Guard() = default;

        private:
        int64_t guard;

        public:
        const int64_t & get_guard() const { return guard; }
        int64_t & get_mutable_guard() { return guard; }
        void set_guard(const int64_t & value) { this->guard = value; }
    };

    class HasOwnProperty {
        public:
        HasOwnProperty() = default;
        virtual ~HasOwnProperty() = default;

        private:
        int64_t has_own_property;

        public:
        const int64_t & get_has_own_property() const { return has_own_property; }
        int64_t & get_mutable_has_own_property() { return has_own_property; }
        void set_has_own_property(const int64_t & value) { this->has_own_property = value; }
    };

    class HashCode {
        public:
        HashCode() = default;
        virtual ~HashCode() = default;

        private:
        int64_t hash_code;

        public:
        const int64_t & get_hash_code() const { return hash_code; }
        int64_t & get_mutable_hash_code() { return hash_code; }
        void set_hash_code(const int64_t & value) { this->hash_code = value; }
    };

    class Hashable {
        public:
        Hashable() = default;
        virtual ~Hashable() = default;

        private:
        int64_t hashable;

        public:
        const int64_t & get_hashable() const { return hashable; }
        int64_t & get_mutable_hashable() { return hashable; }
        void set_hashable(const int64_t & value) { this->hashable = value; }
    };

    class Hasher {
        public:
        Hasher() = default;
        virtual ~Hasher() = default;

        private:
        int64_t hasher;

        public:
        const int64_t & get_hasher() const { return hasher; }
        int64_t & get_mutable_hasher() { return hasher; }
        void set_hasher(const int64_t & value) { this->hasher = value; }
    };

    class Id {
        public:
        Id() = default;
        virtual ~Id() = default;

        private:
        int64_t id;

        public:
        const int64_t & get_id() const { return id; }
        int64_t & get_mutable_id() { return id; }
        void set_id(const int64_t & value) { this->id = value; }
    };

    class Imp {
        public:
        Imp() = default;
        virtual ~Imp() = default;

        private:
        int64_t imp;

        public:
        const int64_t & get_imp() const { return imp; }
        int64_t & get_mutable_imp() { return imp; }
        void set_imp(const int64_t & value) { this->imp = value; }
    };

    class Implements {
        public:
        Implements() = default;
        virtual ~Implements() = default;

        private:
        int64_t implements;

        public:
        const int64_t & get_implements() const { return implements; }
        int64_t & get_mutable_implements() { return implements; }
        void set_implements(const int64_t & value) { this->implements = value; }
    };

    class Implicit {
        public:
        Implicit() = default;
        virtual ~Implicit() = default;

        private:
        int64_t implicit;

        public:
        const int64_t & get_implicit() const { return implicit; }
        int64_t & get_mutable_implicit() { return implicit; }
        void set_implicit(const int64_t & value) { this->implicit = value; }
    };

    class In {
        public:
        In() = default;
        virtual ~In() = default;

        private:
        int64_t in;

        public:
        const int64_t & get_in() const { return in; }
        int64_t & get_mutable_in() { return in; }
        void set_in(const int64_t & value) { this->in = value; }
    };

    class Indirect {
        public:
        Indirect() = default;
        virtual ~Indirect() = default;

        private:
        int64_t indirect;

        public:
        const int64_t & get_indirect() const { return indirect; }
        int64_t & get_mutable_indirect() { return indirect; }
        void set_indirect(const int64_t & value) { this->indirect = value; }
    };

    class Infix {
        public:
        Infix() = default;
        virtual ~Infix() = default;

        private:
        int64_t infix;

        public:
        const int64_t & get_infix() const { return infix; }
        int64_t & get_mutable_infix() { return infix; }
        void set_infix(const int64_t & value) { this->infix = value; }
    };

    class Init {
        public:
        Init() = default;
        virtual ~Init() = default;

        private:
        int64_t init;

        public:
        const int64_t & get_init() const { return init; }
        int64_t & get_mutable_init() { return init; }
        void set_init(const int64_t & value) { this->init = value; }
    };

    class Inout {
        public:
        Inout() = default;
        virtual ~Inout() = default;

        private:
        int64_t inout;

        public:
        const int64_t & get_inout() const { return inout; }
        int64_t & get_mutable_inout() { return inout; }
        void set_inout(const int64_t & value) { this->inout = value; }
    };

    class Instanceof {
        public:
        Instanceof() = default;
        virtual ~Instanceof() = default;

        private:
        int64_t instanceof;

        public:
        const int64_t & get_instanceof() const { return instanceof; }
        int64_t & get_mutable_instanceof() { return instanceof; }
        void set_instanceof(const int64_t & value) { this->instanceof = value; }
    };

    class IntNode {
        public:
        IntNode() = default;
        virtual ~IntNode() = default;

        private:
        int64_t int_node;

        public:
        const int64_t & get_int_node() const { return int_node; }
        int64_t & get_mutable_int_node() { return int_node; }
        void set_int_node(const int64_t & value) { this->int_node = value; }
    };

    class Interface {
        public:
        Interface() = default;
        virtual ~Interface() = default;

        private:
        int64_t interface;

        public:
        const int64_t & get_interface() const { return interface; }
        int64_t & get_mutable_interface() { return interface; }
        void set_interface(const int64_t & value) { this->interface = value; }
    };

    class Internal {
        public:
        Internal() = default;
        virtual ~Internal() = default;

        private:
        int64_t internal;

        public:
        const int64_t & get_internal() const { return internal; }
        int64_t & get_mutable_internal() { return internal; }
        void set_internal(const int64_t & value) { this->internal = value; }
    };

    class Is {
        public:
        Is() = default;
        virtual ~Is() = default;

        private:
        int64_t is;

        public:
        const int64_t & get_is() const { return is; }
        int64_t & get_mutable_is() { return is; }
        void set_is(const int64_t & value) { this->is = value; }
    };

    class IsoDateTimeOffsetConverter {
        public:
        IsoDateTimeOffsetConverter() = default;
        virtual ~IsoDateTimeOffsetConverter() = default;

        private:
        int64_t iso_date_time_offset_converter;

        public:
        const int64_t & get_iso_date_time_offset_converter() const { return iso_date_time_offset_converter; }
        int64_t & get_mutable_iso_date_time_offset_converter() { return iso_date_time_offset_converter; }
        void set_iso_date_time_offset_converter(const int64_t & value) { this->iso_date_time_offset_converter = value; }
    };

    class Iterable {
        public:
        Iterable() = default;
        virtual ~Iterable() = default;

        private:
        int64_t iterable;

        public:
        const int64_t & get_iterable() const { return iterable; }
        int64_t & get_mutable_iterable() { return iterable; }
        void set_iterable(const int64_t & value) { this->iterable = value; }
    };

    class Jdec {
        public:
        Jdec() = default;
        virtual ~Jdec() = default;

        private:
        int64_t jdec;

        public:
        const int64_t & get_jdec() const { return jdec; }
        int64_t & get_mutable_jdec() { return jdec; }
        void set_jdec(const int64_t & value) { this->jdec = value; }
    };

    class Jenc {
        public:
        Jenc() = default;
        virtual ~Jenc() = default;

        private:
        int64_t jenc;

        public:
        const int64_t & get_jenc() const { return jenc; }
        int64_t & get_mutable_jenc() { return jenc; }
        void set_jenc(const int64_t & value) { this->jenc = value; }
    };

    class Jpipe {
        public:
        Jpipe() = default;
        virtual ~Jpipe() = default;

        private:
        int64_t jpipe;

        public:
        const int64_t & get_jpipe() const { return jpipe; }
        int64_t & get_mutable_jpipe() { return jpipe; }
        void set_jpipe(const int64_t & value) { this->jpipe = value; }
    };

    class Json {
        public:
        Json() = default;
        virtual ~Json() = default;

        private:
        int64_t json;

        public:
        const int64_t & get_json() const { return json; }
        int64_t & get_mutable_json() { return json; }
        void set_json(const int64_t & value) { this->json = value; }
    };

    class JsonAny {
        public:
        JsonAny() = default;
        virtual ~JsonAny() = default;

        private:
        nlohmann::json json_any;

        public:
        const nlohmann::json & get_json_any() const { return json_any; }
        nlohmann::json & get_mutable_json_any() { return json_any; }
        void set_json_any(const nlohmann::json & value) { this->json_any = value; }
    };

    class JsonCodingKey {
        public:
        JsonCodingKey() = default;
        virtual ~JsonCodingKey() = default;

        private:
        int64_t json_coding_key;

        public:
        const int64_t & get_json_coding_key() const { return json_coding_key; }
        int64_t & get_mutable_json_coding_key() { return json_coding_key; }
        void set_json_coding_key(const int64_t & value) { this->json_coding_key = value; }
    };

    class JsonConverter {
        public:
        JsonConverter() = default;
        virtual ~JsonConverter() = default;

        private:
        int64_t json_converter;

        public:
        const int64_t & get_json_converter() const { return json_converter; }
        int64_t & get_mutable_json_converter() { return json_converter; }
        void set_json_converter(const int64_t & value) { this->json_converter = value; }
    };

    class JsonDecoder {
        public:
        JsonDecoder() = default;
        virtual ~JsonDecoder() = default;

        private:
        int64_t json_decoder;

        public:
        const int64_t & get_json_decoder() const { return json_decoder; }
        int64_t & get_mutable_json_decoder() { return json_decoder; }
        void set_json_decoder(const int64_t & value) { this->json_decoder = value; }
    };

    class JsonEncoder {
        public:
        JsonEncoder() = default;
        virtual ~JsonEncoder() = default;

        private:
        int64_t json_encoder;

        public:
        const int64_t & get_json_encoder() const { return json_encoder; }
        int64_t & get_mutable_json_encoder() { return json_encoder; }
        void set_json_encoder(const int64_t & value) { this->json_encoder = value; }
    };

    class JsonException {
        public:
        JsonException() = default;
        virtual ~JsonException() = default;

        private:
        int64_t json_exception;

        public:
        const int64_t & get_json_exception() const { return json_exception; }
        int64_t & get_mutable_json_exception() { return json_exception; }
        void set_json_exception(const int64_t & value) { this->json_exception = value; }
    };

    class JsonGenerator {
        public:
        JsonGenerator() = default;
        virtual ~JsonGenerator() = default;

        private:
        int64_t json_generator;

        public:
        const int64_t & get_json_generator() const { return json_generator; }
        int64_t & get_mutable_json_generator() { return json_generator; }
        void set_json_generator(const int64_t & value) { this->json_generator = value; }
    };

    class JsonNode {
        public:
        JsonNode() = default;
        virtual ~JsonNode() = default;

        private:
        int64_t json_node;

        public:
        const int64_t & get_json_node() const { return json_node; }
        int64_t & get_mutable_json_node() { return json_node; }
        void set_json_node(const int64_t & value) { this->json_node = value; }
    };

    class JsonNull {
        public:
        JsonNull() = default;
        virtual ~JsonNull() = default;

        private:
        int64_t json_null;

        public:
        const int64_t & get_json_null() const { return json_null; }
        int64_t & get_mutable_json_null() { return json_null; }
        void set_json_null(const int64_t & value) { this->json_null = value; }
    };

    class JsonParser {
        public:
        JsonParser() = default;
        virtual ~JsonParser() = default;

        private:
        int64_t json_parser;

        public:
        const int64_t & get_json_parser() const { return json_parser; }
        int64_t & get_mutable_json_parser() { return json_parser; }
        void set_json_parser(const int64_t & value) { this->json_parser = value; }
    };

    class JsonReader {
        public:
        JsonReader() = default;
        virtual ~JsonReader() = default;

        private:
        int64_t json_reader;

        public:
        const int64_t & get_json_reader() const { return json_reader; }
        int64_t & get_mutable_json_reader() { return json_reader; }
        void set_json_reader(const int64_t & value) { this->json_reader = value; }
    };

    class JsonSerializer {
        public:
        JsonSerializer() = default;
        virtual ~JsonSerializer() = default;

        private:
        int64_t json_serializer;

        public:
        const int64_t & get_json_serializer() const { return json_serializer; }
        int64_t & get_mutable_json_serializer() { return json_serializer; }
        void set_json_serializer(const int64_t & value) { this->json_serializer = value; }
    };

    class JsonToken {
        public:
        JsonToken() = default;
        virtual ~JsonToken() = default;

        private:
        int64_t json_token;

        public:
        const int64_t & get_json_token() const { return json_token; }
        int64_t & get_mutable_json_token() { return json_token; }
        void set_json_token(const int64_t & value) { this->json_token = value; }
    };

    class JsonTokenType {
        public:
        JsonTokenType() = default;
        virtual ~JsonTokenType() = default;

        private:
        int64_t json_token_type;

        public:
        const int64_t & get_json_token_type() const { return json_token_type; }
        int64_t & get_mutable_json_token_type() { return json_token_type; }
        void set_json_token_type(const int64_t & value) { this->json_token_type = value; }
    };

    class JsonWriter {
        public:
        JsonWriter() = default;
        virtual ~JsonWriter() = default;

        private:
        int64_t json_writer;

        public:
        const int64_t & get_json_writer() const { return json_writer; }
        int64_t & get_mutable_json_writer() { return json_writer; }
        void set_json_writer(const int64_t & value) { this->json_writer = value; }
    };

    class Lambda {
        public:
        Lambda() = default;
        virtual ~Lambda() = default;

        private:
        int64_t lambda;

        public:
        const int64_t & get_lambda() const { return lambda; }
        int64_t & get_mutable_lambda() { return lambda; }
        void set_lambda(const int64_t & value) { this->lambda = value; }
    };

    class Lazy {
        public:
        Lazy() = default;
        virtual ~Lazy() = default;

        private:
        int64_t lazy;

        public:
        const int64_t & get_lazy() const { return lazy; }
        int64_t & get_mutable_lazy() { return lazy; }
        void set_lazy(const int64_t & value) { this->lazy = value; }
    };

    class Left {
        public:
        Left() = default;
        virtual ~Left() = default;

        private:
        int64_t left;

        public:
        const int64_t & get_left() const { return left; }
        int64_t & get_mutable_left() { return left; }
        void set_left(const int64_t & value) { this->left = value; }
    };

    class Let {
        public:
        Let() = default;
        virtual ~Let() = default;

        private:
        int64_t let;

        public:
        const int64_t & get_let() const { return let; }
        int64_t & get_mutable_let() { return let; }
        void set_let(const int64_t & value) { this->let = value; }
    };

    class List {
        public:
        List() = default;
        virtual ~List() = default;

        private:
        int64_t list;

        public:
        const int64_t & get_list() const { return list; }
        int64_t & get_mutable_list() { return list; }
        void set_list(const int64_t & value) { this->list = value; }
    };

    class LocalDate {
        public:
        LocalDate() = default;
        virtual ~LocalDate() = default;

        private:
        int64_t local_date;

        public:
        const int64_t & get_local_date() const { return local_date; }
        int64_t & get_mutable_local_date() { return local_date; }
        void set_local_date(const int64_t & value) { this->local_date = value; }
    };

    class Locale {
        public:
        Locale() = default;
        virtual ~Locale() = default;

        private:
        int64_t locale;

        public:
        const int64_t & get_locale() const { return locale; }
        int64_t & get_mutable_locale() { return locale; }
        void set_locale(const int64_t & value) { this->locale = value; }
    };

    class Lock {
        public:
        Lock() = default;
        virtual ~Lock() = default;

        private:
        int64_t lock;

        public:
        const int64_t & get_lock() const { return lock; }
        int64_t & get_mutable_lock() { return lock; }
        void set_lock(const int64_t & value) { this->lock = value; }
    };

    class LongNode {
        public:
        LongNode() = default;
        virtual ~LongNode() = default;

        private:
        int64_t long_node;

        public:
        const int64_t & get_long_node() const { return long_node; }
        int64_t & get_mutable_long_node() { return long_node; }
        void set_long_node(const int64_t & value) { this->long_node = value; }
    };

    class Map {
        public:
        Map() = default;
        virtual ~Map() = default;

        private:
        int64_t map;

        public:
        const int64_t & get_map() const { return map; }
        int64_t & get_mutable_map() { return map; }
        void set_map(const int64_t & value) { this->map = value; }
    };

    class MapEntry {
        public:
        MapEntry() = default;
        virtual ~MapEntry() = default;

        private:
        int64_t map_entry;

        public:
        const int64_t & get_map_entry() const { return map_entry; }
        int64_t & get_mutable_map_entry() { return map_entry; }
        void set_map_entry(const int64_t & value) { this->map_entry = value; }
    };

    class MarshalJson {
        public:
        MarshalJson() = default;
        virtual ~MarshalJson() = default;

        private:
        int64_t marshal_json;

        public:
        const int64_t & get_marshal_json() const { return marshal_json; }
        int64_t & get_mutable_marshal_json() { return marshal_json; }
        void set_marshal_json(const int64_t & value) { this->marshal_json = value; }
    };

    class MetadataPropertyHandling {
        public:
        MetadataPropertyHandling() = default;
        virtual ~MetadataPropertyHandling() = default;

        private:
        int64_t metadata_property_handling;

        public:
        const int64_t & get_metadata_property_handling() const { return metadata_property_handling; }
        int64_t & get_mutable_metadata_property_handling() { return metadata_property_handling; }
        void set_metadata_property_handling(const int64_t & value) { this->metadata_property_handling = value; }
    };

    class Goto {
        public:
        Goto() = default;
        virtual ~Goto() = default;

        private:
        int64_t goto_goto;

        public:
        const int64_t & get_goto_goto() const { return goto_goto; }
        int64_t & get_mutable_goto_goto() { return goto_goto; }
        void set_goto_goto(const int64_t & value) { this->goto_goto = value; }
    };

    class If {
        public:
        If() = default;
        virtual ~If() = default;

        private:
        int64_t if_if;

        public:
        const int64_t & get_if_if() const { return if_if; }
        int64_t & get_mutable_if_if() { return if_if; }
        void set_if_if(const int64_t & value) { this->if_if = value; }
    };

    class Import {
        public:
        Import() = default;
        virtual ~Import() = default;

        private:
        int64_t import_import;

        public:
        const int64_t & get_import_import() const { return import_import; }
        int64_t & get_mutable_import_import() { return import_import; }
        void set_import_import(const int64_t & value) { this->import_import = value; }
    };

    class Inline {
        public:
        Inline() = default;
        virtual ~Inline() = default;

        private:
        int64_t inline_inline;

        public:
        const int64_t & get_inline_inline() const { return inline_inline; }
        int64_t & get_mutable_inline_inline() { return inline_inline; }
        void set_inline_inline(const int64_t & value) { this->inline_inline = value; }
    };

    class Int {
        public:
        Int() = default;
        virtual ~Int() = default;

        private:
        int64_t int_int;

        public:
        const int64_t & get_int_int() const { return int_int; }
        int64_t & get_mutable_int_int() { return int_int; }
        void set_int_int(const int64_t & value) { this->int_int = value; }
    };

    class Long {
        public:
        Long() = default;
        virtual ~Long() = default;

        private:
        int64_t long_long;

        public:
        const int64_t & get_long_long() const { return long_long; }
        int64_t & get_mutable_long_long() { return long_long; }
        void set_long_long(const int64_t & value) { this->long_long = value; }
    };

    class Module {
        public:
        Module() = default;
        virtual ~Module() = default;

        private:
        int64_t module_module;

        public:
        const int64_t & get_module_module() const { return module_module; }
        int64_t & get_mutable_module_module() { return module_module; }
        void set_module_module(const int64_t & value) { this->module_module = value; }
    };

    class Obj3 {
        public:
        Obj3() = default;
        virtual ~Obj3() = default;

        private:
        int64_t dummy;
        Function function;
        Get get;
        Global global;
        Go go;
        Guard guard;
        HasOwnProperty has_own_property;
        HashCode hash_code;
        Hashable hashable;
        Hasher hasher;
        Id id;
        Imp imp;
        Implements implements;
        Implicit implicit;
        In in;
        Indirect indirect;
        Infix infix;
        Init init;
        Inout inout;
        Instanceof instanceof;
        IntNode int_node;
        Interface interface;
        Internal internal;
        Is is;
        IsoDateTimeOffsetConverter iso_date_time_offset_converter;
        Iterable iterable;
        Jdec jdec;
        Jenc jenc;
        Jpipe jpipe;
        Json json;
        JsonAny json_any;
        JsonCodingKey json_coding_key;
        JsonConverter json_converter;
        JsonDecoder json_decoder;
        JsonEncoder json_encoder;
        JsonException json_exception;
        JsonGenerator json_generator;
        JsonNode json_node;
        JsonNull json_null;
        JsonParser json_parser;
        JsonReader json_reader;
        JsonSerializer json_serializer;
        JsonToken json_token;
        JsonTokenType json_token_type;
        JsonWriter json_writer;
        Lambda lambda;
        Lazy lazy;
        Left left;
        Let let;
        List list;
        LocalDate local_date;
        Locale locale;
        Lock lock;
        LongNode long_node;
        Map map;
        MapEntry map_entry;
        MarshalJson marshal_json;
        MetadataPropertyHandling metadata_property_handling;
        Goto obj3_goto;
        If obj3_if;
        Import obj3_import;
        Inline obj3_inline;
        Int obj3_int;
        Long obj3_long;
        Module obj3_module;

        public:
        const int64_t & get_dummy() const { return dummy; }
        int64_t & get_mutable_dummy() { return dummy; }
        void set_dummy(const int64_t & value) { this->dummy = value; }

        const Function & get_function() const { return function; }
        Function & get_mutable_function() { return function; }
        void set_function(const Function & value) { this->function = value; }

        const Get & get_get() const { return get; }
        Get & get_mutable_get() { return get; }
        void set_get(const Get & value) { this->get = value; }

        const Global & get_global() const { return global; }
        Global & get_mutable_global() { return global; }
        void set_global(const Global & value) { this->global = value; }

        const Go & get_go() const { return go; }
        Go & get_mutable_go() { return go; }
        void set_go(const Go & value) { this->go = value; }

        const Guard & get_guard() const { return guard; }
        Guard & get_mutable_guard() { return guard; }
        void set_guard(const Guard & value) { this->guard = value; }

        const HasOwnProperty & get_has_own_property() const { return has_own_property; }
        HasOwnProperty & get_mutable_has_own_property() { return has_own_property; }
        void set_has_own_property(const HasOwnProperty & value) { this->has_own_property = value; }

        const HashCode & get_hash_code() const { return hash_code; }
        HashCode & get_mutable_hash_code() { return hash_code; }
        void set_hash_code(const HashCode & value) { this->hash_code = value; }

        const Hashable & get_hashable() const { return hashable; }
        Hashable & get_mutable_hashable() { return hashable; }
        void set_hashable(const Hashable & value) { this->hashable = value; }

        const Hasher & get_hasher() const { return hasher; }
        Hasher & get_mutable_hasher() { return hasher; }
        void set_hasher(const Hasher & value) { this->hasher = value; }

        const Id & get_id() const { return id; }
        Id & get_mutable_id() { return id; }
        void set_id(const Id & value) { this->id = value; }

        const Imp & get_imp() const { return imp; }
        Imp & get_mutable_imp() { return imp; }
        void set_imp(const Imp & value) { this->imp = value; }

        const Implements & get_implements() const { return implements; }
        Implements & get_mutable_implements() { return implements; }
        void set_implements(const Implements & value) { this->implements = value; }

        const Implicit & get_implicit() const { return implicit; }
        Implicit & get_mutable_implicit() { return implicit; }
        void set_implicit(const Implicit & value) { this->implicit = value; }

        const In & get_in() const { return in; }
        In & get_mutable_in() { return in; }
        void set_in(const In & value) { this->in = value; }

        const Indirect & get_indirect() const { return indirect; }
        Indirect & get_mutable_indirect() { return indirect; }
        void set_indirect(const Indirect & value) { this->indirect = value; }

        const Infix & get_infix() const { return infix; }
        Infix & get_mutable_infix() { return infix; }
        void set_infix(const Infix & value) { this->infix = value; }

        const Init & get_init() const { return init; }
        Init & get_mutable_init() { return init; }
        void set_init(const Init & value) { this->init = value; }

        const Inout & get_inout() const { return inout; }
        Inout & get_mutable_inout() { return inout; }
        void set_inout(const Inout & value) { this->inout = value; }

        const Instanceof & get_instanceof() const { return instanceof; }
        Instanceof & get_mutable_instanceof() { return instanceof; }
        void set_instanceof(const Instanceof & value) { this->instanceof = value; }

        const IntNode & get_int_node() const { return int_node; }
        IntNode & get_mutable_int_node() { return int_node; }
        void set_int_node(const IntNode & value) { this->int_node = value; }

        const Interface & get_interface() const { return interface; }
        Interface & get_mutable_interface() { return interface; }
        void set_interface(const Interface & value) { this->interface = value; }

        const Internal & get_internal() const { return internal; }
        Internal & get_mutable_internal() { return internal; }
        void set_internal(const Internal & value) { this->internal = value; }

        const Is & get_is() const { return is; }
        Is & get_mutable_is() { return is; }
        void set_is(const Is & value) { this->is = value; }

        const IsoDateTimeOffsetConverter & get_iso_date_time_offset_converter() const { return iso_date_time_offset_converter; }
        IsoDateTimeOffsetConverter & get_mutable_iso_date_time_offset_converter() { return iso_date_time_offset_converter; }
        void set_iso_date_time_offset_converter(const IsoDateTimeOffsetConverter & value) { this->iso_date_time_offset_converter = value; }

        const Iterable & get_iterable() const { return iterable; }
        Iterable & get_mutable_iterable() { return iterable; }
        void set_iterable(const Iterable & value) { this->iterable = value; }

        const Jdec & get_jdec() const { return jdec; }
        Jdec & get_mutable_jdec() { return jdec; }
        void set_jdec(const Jdec & value) { this->jdec = value; }

        const Jenc & get_jenc() const { return jenc; }
        Jenc & get_mutable_jenc() { return jenc; }
        void set_jenc(const Jenc & value) { this->jenc = value; }

        const Jpipe & get_jpipe() const { return jpipe; }
        Jpipe & get_mutable_jpipe() { return jpipe; }
        void set_jpipe(const Jpipe & value) { this->jpipe = value; }

        const Json & get_json() const { return json; }
        Json & get_mutable_json() { return json; }
        void set_json(const Json & value) { this->json = value; }

        const JsonAny & get_json_any() const { return json_any; }
        JsonAny & get_mutable_json_any() { return json_any; }
        void set_json_any(const JsonAny & value) { this->json_any = value; }

        const JsonCodingKey & get_json_coding_key() const { return json_coding_key; }
        JsonCodingKey & get_mutable_json_coding_key() { return json_coding_key; }
        void set_json_coding_key(const JsonCodingKey & value) { this->json_coding_key = value; }

        const JsonConverter & get_json_converter() const { return json_converter; }
        JsonConverter & get_mutable_json_converter() { return json_converter; }
        void set_json_converter(const JsonConverter & value) { this->json_converter = value; }

        const JsonDecoder & get_json_decoder() const { return json_decoder; }
        JsonDecoder & get_mutable_json_decoder() { return json_decoder; }
        void set_json_decoder(const JsonDecoder & value) { this->json_decoder = value; }

        const JsonEncoder & get_json_encoder() const { return json_encoder; }
        JsonEncoder & get_mutable_json_encoder() { return json_encoder; }
        void set_json_encoder(const JsonEncoder & value) { this->json_encoder = value; }

        const JsonException & get_json_exception() const { return json_exception; }
        JsonException & get_mutable_json_exception() { return json_exception; }
        void set_json_exception(const JsonException & value) { this->json_exception = value; }

        const JsonGenerator & get_json_generator() const { return json_generator; }
        JsonGenerator & get_mutable_json_generator() { return json_generator; }
        void set_json_generator(const JsonGenerator & value) { this->json_generator = value; }

        const JsonNode & get_json_node() const { return json_node; }
        JsonNode & get_mutable_json_node() { return json_node; }
        void set_json_node(const JsonNode & value) { this->json_node = value; }

        const JsonNull & get_json_null() const { return json_null; }
        JsonNull & get_mutable_json_null() { return json_null; }
        void set_json_null(const JsonNull & value) { this->json_null = value; }

        const JsonParser & get_json_parser() const { return json_parser; }
        JsonParser & get_mutable_json_parser() { return json_parser; }
        void set_json_parser(const JsonParser & value) { this->json_parser = value; }

        const JsonReader & get_json_reader() const { return json_reader; }
        JsonReader & get_mutable_json_reader() { return json_reader; }
        void set_json_reader(const JsonReader & value) { this->json_reader = value; }

        const JsonSerializer & get_json_serializer() const { return json_serializer; }
        JsonSerializer & get_mutable_json_serializer() { return json_serializer; }
        void set_json_serializer(const JsonSerializer & value) { this->json_serializer = value; }

        const JsonToken & get_json_token() const { return json_token; }
        JsonToken & get_mutable_json_token() { return json_token; }
        void set_json_token(const JsonToken & value) { this->json_token = value; }

        const JsonTokenType & get_json_token_type() const { return json_token_type; }
        JsonTokenType & get_mutable_json_token_type() { return json_token_type; }
        void set_json_token_type(const JsonTokenType & value) { this->json_token_type = value; }

        const JsonWriter & get_json_writer() const { return json_writer; }
        JsonWriter & get_mutable_json_writer() { return json_writer; }
        void set_json_writer(const JsonWriter & value) { this->json_writer = value; }

        const Lambda & get_lambda() const { return lambda; }
        Lambda & get_mutable_lambda() { return lambda; }
        void set_lambda(const Lambda & value) { this->lambda = value; }

        const Lazy & get_lazy() const { return lazy; }
        Lazy & get_mutable_lazy() { return lazy; }
        void set_lazy(const Lazy & value) { this->lazy = value; }

        const Left & get_left() const { return left; }
        Left & get_mutable_left() { return left; }
        void set_left(const Left & value) { this->left = value; }

        const Let & get_let() const { return let; }
        Let & get_mutable_let() { return let; }
        void set_let(const Let & value) { this->let = value; }

        const List & get_list() const { return list; }
        List & get_mutable_list() { return list; }
        void set_list(const List & value) { this->list = value; }

        const LocalDate & get_local_date() const { return local_date; }
        LocalDate & get_mutable_local_date() { return local_date; }
        void set_local_date(const LocalDate & value) { this->local_date = value; }

        const Locale & get_locale() const { return locale; }
        Locale & get_mutable_locale() { return locale; }
        void set_locale(const Locale & value) { this->locale = value; }

        const Lock & get_lock() const { return lock; }
        Lock & get_mutable_lock() { return lock; }
        void set_lock(const Lock & value) { this->lock = value; }

        const LongNode & get_long_node() const { return long_node; }
        LongNode & get_mutable_long_node() { return long_node; }
        void set_long_node(const LongNode & value) { this->long_node = value; }

        const Map & get_map() const { return map; }
        Map & get_mutable_map() { return map; }
        void set_map(const Map & value) { this->map = value; }

        const MapEntry & get_map_entry() const { return map_entry; }
        MapEntry & get_mutable_map_entry() { return map_entry; }
        void set_map_entry(const MapEntry & value) { this->map_entry = value; }

        const MarshalJson & get_marshal_json() const { return marshal_json; }
        MarshalJson & get_mutable_marshal_json() { return marshal_json; }
        void set_marshal_json(const MarshalJson & value) { this->marshal_json = value; }

        const MetadataPropertyHandling & get_metadata_property_handling() const { return metadata_property_handling; }
        MetadataPropertyHandling & get_mutable_metadata_property_handling() { return metadata_property_handling; }
        void set_metadata_property_handling(const MetadataPropertyHandling & value) { this->metadata_property_handling = value; }

        const Goto & get_obj3_goto() const { return obj3_goto; }
        Goto & get_mutable_obj3_goto() { return obj3_goto; }
        void set_obj3_goto(const Goto & value) { this->obj3_goto = value; }

        const If & get_obj3_if() const { return obj3_if; }
        If & get_mutable_obj3_if() { return obj3_if; }
        void set_obj3_if(const If & value) { this->obj3_if = value; }

        const Import & get_obj3_import() const { return obj3_import; }
        Import & get_mutable_obj3_import() { return obj3_import; }
        void set_obj3_import(const Import & value) { this->obj3_import = value; }

        const Inline & get_obj3_inline() const { return obj3_inline; }
        Inline & get_mutable_obj3_inline() { return obj3_inline; }
        void set_obj3_inline(const Inline & value) { this->obj3_inline = value; }

        const Int & get_obj3_int() const { return obj3_int; }
        Int & get_mutable_obj3_int() { return obj3_int; }
        void set_obj3_int(const Int & value) { this->obj3_int = value; }

        const Long & get_obj3_long() const { return obj3_long; }
        Long & get_mutable_obj3_long() { return obj3_long; }
        void set_obj3_long(const Long & value) { this->obj3_long = value; }

        const Module & get_obj3_module() const { return obj3_module; }
        Module & get_mutable_obj3_module() { return obj3_module; }
        void set_obj3_module(const Module & value) { this->obj3_module = value; }
    };

    class Mutating {
        public:
        Mutating() = default;
        virtual ~Mutating() = default;

        private:
        int64_t mutating;

        public:
        const int64_t & get_mutating() const { return mutating; }
        int64_t & get_mutable_mutating() { return mutating; }
        void set_mutating(const int64_t & value) { this->mutating = value; }
    };

    class Native {
        public:
        Native() = default;
        virtual ~Native() = default;

        private:
        int64_t native;

        public:
        const int64_t & get_native() const { return native; }
        int64_t & get_mutable_native() { return native; }
        void set_native(const int64_t & value) { this->native = value; }
    };

    class Newtonsoft {
        public:
        Newtonsoft() = default;
        virtual ~Newtonsoft() = default;

        private:
        int64_t newtonsoft;

        public:
        const int64_t & get_newtonsoft() const { return newtonsoft; }
        int64_t & get_mutable_newtonsoft() { return newtonsoft; }
        void set_newtonsoft(const int64_t & value) { this->newtonsoft = value; }
    };

    class Nil {
        public:
        Nil() = default;
        virtual ~Nil() = default;

        private:
        int64_t nil;

        public:
        const int64_t & get_nil() const { return nil; }
        int64_t & get_mutable_nil() { return nil; }
        void set_nil(const int64_t & value) { this->nil = value; }
    };

    class No {
        public:
        No() = default;
        virtual ~No() = default;

        private:
        int64_t no;

        public:
        const int64_t & get_no() const { return no; }
        int64_t & get_mutable_no() { return no; }
        void set_no(const int64_t & value) { this->no = value; }
    };

    class NoSuchMethod {
        public:
        NoSuchMethod() = default;
        virtual ~NoSuchMethod() = default;

        private:
        int64_t no_such_method;

        public:
        const int64_t & get_no_such_method() const { return no_such_method; }
        int64_t & get_mutable_no_such_method() { return no_such_method; }
        void set_no_such_method(const int64_t & value) { this->no_such_method = value; }
    };

    class Nonatomic {
        public:
        Nonatomic() = default;
        virtual ~Nonatomic() = default;

        private:
        int64_t nonatomic;

        public:
        const int64_t & get_nonatomic() const { return nonatomic; }
        int64_t & get_mutable_nonatomic() { return nonatomic; }
        void set_nonatomic(const int64_t & value) { this->nonatomic = value; }
    };

    class None {
        public:
        None() = default;
        virtual ~None() = default;

        private:
        int64_t none;

        public:
        const int64_t & get_none() const { return none; }
        int64_t & get_mutable_none() { return none; }
        void set_none(const int64_t & value) { this->none = value; }
    };

    class Nonlocal {
        public:
        Nonlocal() = default;
        virtual ~Nonlocal() = default;

        private:
        int64_t nonlocal;

        public:
        const int64_t & get_nonlocal() const { return nonlocal; }
        int64_t & get_mutable_nonlocal() { return nonlocal; }
        void set_nonlocal(const int64_t & value) { this->nonlocal = value; }
    };

    class Nonmutating {
        public:
        Nonmutating() = default;
        virtual ~Nonmutating() = default;

        private:
        int64_t nonmutating;

        public:
        const int64_t & get_nonmutating() const { return nonmutating; }
        int64_t & get_mutable_nonmutating() { return nonmutating; }
        void set_nonmutating(const int64_t & value) { this->nonmutating = value; }
    };

    class NsError {
        public:
        NsError() = default;
        virtual ~NsError() = default;

        private:
        int64_t ns_error;

        public:
        const int64_t & get_ns_error() const { return ns_error; }
        int64_t & get_mutable_ns_error() { return ns_error; }
        void set_ns_error(const int64_t & value) { this->ns_error = value; }
    };

    class NsObject {
        public:
        NsObject() = default;
        virtual ~NsObject() = default;

        private:
        int64_t ns_object;

        public:
        const int64_t & get_ns_object() const { return ns_object; }
        int64_t & get_mutable_ns_object() { return ns_object; }
        void set_ns_object(const int64_t & value) { this->ns_object = value; }
    };

    class NsString {
        public:
        NsString() = default;
        virtual ~NsString() = default;

        private:
        int64_t ns_string;

        public:
        const int64_t & get_ns_string() const { return ns_string; }
        int64_t & get_mutable_ns_string() { return ns_string; }
        void set_ns_string(const int64_t & value) { this->ns_string = value; }
    };

    class Null {
        public:
        Null() = default;
        virtual ~Null() = default;

        private:
        int64_t null;

        public:
        const int64_t & get_null() const { return null; }
        int64_t & get_mutable_null() { return null; }
        void set_null(const int64_t & value) { this->null = value; }
    };

    class NullNode {
        public:
        NullNode() = default;
        virtual ~NullNode() = default;

        private:
        int64_t null_node;

        public:
        const int64_t & get_null_node() const { return null_node; }
        int64_t & get_mutable_null_node() { return null_node; }
        void set_null_node(const int64_t & value) { this->null_node = value; }
    };

    class Number {
        public:
        Number() = default;
        virtual ~Number() = default;

        private:
        int64_t number;

        public:
        const int64_t & get_number() const { return number; }
        int64_t & get_mutable_number() { return number; }
        void set_number(const int64_t & value) { this->number = value; }
    };

    class Mutable {
        public:
        Mutable() = default;
        virtual ~Mutable() = default;

        private:
        int64_t mutable_mutable;

        public:
        const int64_t & get_mutable_mutable() const { return mutable_mutable; }
        int64_t & get_mutable_mutable_mutable() { return mutable_mutable; }
        void set_mutable_mutable(const int64_t & value) { this->mutable_mutable = value; }
    };

    class Namespace {
        public:
        Namespace() = default;
        virtual ~Namespace() = default;

        private:
        int64_t namespace_namespace;

        public:
        const int64_t & get_namespace_namespace() const { return namespace_namespace; }
        int64_t & get_mutable_namespace_namespace() { return namespace_namespace; }
        void set_namespace_namespace(const int64_t & value) { this->namespace_namespace = value; }
    };

    class New {
        public:
        New() = default;
        virtual ~New() = default;

        private:
        int64_t new_new;

        public:
        const int64_t & get_new_new() const { return new_new; }
        int64_t & get_mutable_new_new() { return new_new; }
        void set_new_new(const int64_t & value) { this->new_new = value; }
    };

    class Noexcept {
        public:
        Noexcept() = default;
        virtual ~Noexcept() = default;

        private:
        int64_t noexcept_noexcept;

        public:
        const int64_t & get_noexcept_noexcept() const { return noexcept_noexcept; }
        int64_t & get_mutable_noexcept_noexcept() { return noexcept_noexcept; }
        void set_noexcept_noexcept(const int64_t & value) { this->noexcept_noexcept = value; }
    };

    class NoneClass {
        public:
        NoneClass() = default;
        virtual ~NoneClass() = default;

        private:
        int64_t none;

        public:
        const int64_t & get_none() const { return none; }
        int64_t & get_mutable_none() { return none; }
        void set_none(const int64_t & value) { this->none = value; }
    };

    class Not {
        public:
        Not() = default;
        virtual ~Not() = default;

        private:
        int64_t not_not;

        public:
        const int64_t & get_not_not() const { return not_not; }
        int64_t & get_mutable_not_not() { return not_not; }
        void set_not_not(const int64_t & value) { this->not_not = value; }
    };

    class NotEq {
        public:
        NotEq() = default;
        virtual ~NotEq() = default;

        private:
        int64_t not_eq_not_eq;

        public:
        const int64_t & get_not_eq_not_eq() const { return not_eq_not_eq; }
        int64_t & get_mutable_not_eq_not_eq() { return not_eq_not_eq; }
        void set_not_eq_not_eq(const int64_t & value) { this->not_eq_not_eq = value; }
    };

    class NullClass {
        public:
        NullClass() = default;
        virtual ~NullClass() = default;

        private:
        int64_t null;

        public:
        const int64_t & get_null() const { return null; }
        int64_t & get_mutable_null() { return null; }
        void set_null(const int64_t & value) { this->null = value; }
    };

    class Nullptr {
        public:
        Nullptr() = default;
        virtual ~Nullptr() = default;

        private:
        int64_t nullptr_nullptr;

        public:
        const int64_t & get_nullptr_nullptr() const { return nullptr_nullptr; }
        int64_t & get_mutable_nullptr_nullptr() { return nullptr_nullptr; }
        void set_nullptr_nullptr(const int64_t & value) { this->nullptr_nullptr = value; }
    };

    class Operator {
        public:
        Operator() = default;
        virtual ~Operator() = default;

        private:
        int64_t operator_operator;

        public:
        const int64_t & get_operator_operator() const { return operator_operator; }
        int64_t & get_mutable_operator_operator() { return operator_operator; }
        void set_operator_operator(const int64_t & value) { this->operator_operator = value; }
    };

    class Or {
        public:
        Or() = default;
        virtual ~Or() = default;

        private:
        int64_t or_or;

        public:
        const int64_t & get_or_or() const { return or_or; }
        int64_t & get_mutable_or_or() { return or_or; }
        void set_or_or(const int64_t & value) { this->or_or = value; }
    };

    class OrEq {
        public:
        OrEq() = default;
        virtual ~OrEq() = default;

        private:
        int64_t or_eq_or_eq;

        public:
        const int64_t & get_or_eq_or_eq() const { return or_eq_or_eq; }
        int64_t & get_mutable_or_eq_or_eq() { return or_eq_or_eq; }
        void set_or_eq_or_eq(const int64_t & value) { this->or_eq_or_eq = value; }
    };

    class Override {
        public:
        Override() = default;
        virtual ~Override() = default;

        private:
        int64_t override_override;

        public:
        const int64_t & get_override_override() const { return override_override; }
        int64_t & get_mutable_override_override() { return override_override; }
        void set_override_override(const int64_t & value) { this->override_override = value; }
    };

    class Private {
        public:
        Private() = default;
        virtual ~Private() = default;

        private:
        int64_t private_private;

        public:
        const int64_t & get_private_private() const { return private_private; }
        int64_t & get_mutable_private_private() { return private_private; }
        void set_private_private(const int64_t & value) { this->private_private = value; }
    };

    class Protected {
        public:
        Protected() = default;
        virtual ~Protected() = default;

        private:
        int64_t protected_protected;

        public:
        const int64_t & get_protected_protected() const { return protected_protected; }
        int64_t & get_mutable_protected_protected() { return protected_protected; }
        void set_protected_protected(const int64_t & value) { this->protected_protected = value; }
    };

    class ProtocolClass {
        public:
        ProtocolClass() = default;
        virtual ~ProtocolClass() = default;

        private:
        int64_t protocol;

        public:
        const int64_t & get_protocol() const { return protocol; }
        int64_t & get_mutable_protocol() { return protocol; }
        void set_protocol(const int64_t & value) { this->protocol = value; }
    };

    class Public {
        public:
        Public() = default;
        virtual ~Public() = default;

        private:
        int64_t public_public;

        public:
        const int64_t & get_public_public() const { return public_public; }
        int64_t & get_mutable_public_public() { return public_public; }
        void set_public_public(const int64_t & value) { this->public_public = value; }
    };

    class Register {
        public:
        Register() = default;
        virtual ~Register() = default;

        private:
        int64_t register_register;

        public:
        const int64_t & get_register_register() const { return register_register; }
        int64_t & get_mutable_register_register() { return register_register; }
        void set_register_register(const int64_t & value) { this->register_register = value; }
    };

    class ReinterpretCast {
        public:
        ReinterpretCast() = default;
        virtual ~ReinterpretCast() = default;

        private:
        int64_t reinterpret_cast_reinterpret_cast;

        public:
        const int64_t & get_reinterpret_cast_reinterpret_cast() const { return reinterpret_cast_reinterpret_cast; }
        int64_t & get_mutable_reinterpret_cast_reinterpret_cast() { return reinterpret_cast_reinterpret_cast; }
        void set_reinterpret_cast_reinterpret_cast(const int64_t & value) { this->reinterpret_cast_reinterpret_cast = value; }
    };

    class Object {
        public:
        Object() = default;
        virtual ~Object() = default;

        private:
        int64_t object;

        public:
        const int64_t & get_object() const { return object; }
        int64_t & get_mutable_object() { return object; }
        void set_object(const int64_t & value) { this->object = value; }
    };

    class ObjectMapper {
        public:
        ObjectMapper() = default;
        virtual ~ObjectMapper() = default;

        private:
        int64_t object_mapper;

        public:
        const int64_t & get_object_mapper() const { return object_mapper; }
        int64_t & get_mutable_object_mapper() { return object_mapper; }
        void set_object_mapper(const int64_t & value) { this->object_mapper = value; }
    };

    class ObjectNode {
        public:
        ObjectNode() = default;
        virtual ~ObjectNode() = default;

        private:
        int64_t object_node;

        public:
        const int64_t & get_object_node() const { return object_node; }
        int64_t & get_mutable_object_node() { return object_node; }
        void set_object_node(const int64_t & value) { this->object_node = value; }
    };

    class ObjectReader {
        public:
        ObjectReader() = default;
        virtual ~ObjectReader() = default;

        private:
        int64_t object_reader;

        public:
        const int64_t & get_object_reader() const { return object_reader; }
        int64_t & get_mutable_object_reader() { return object_reader; }
        void set_object_reader(const int64_t & value) { this->object_reader = value; }
    };

    class ObjectWriter {
        public:
        ObjectWriter() = default;
        virtual ~ObjectWriter() = default;

        private:
        int64_t object_writer;

        public:
        const int64_t & get_object_writer() const { return object_writer; }
        int64_t & get_mutable_object_writer() { return object_writer; }
        void set_object_writer(const int64_t & value) { this->object_writer = value; }
    };

    class Of {
        public:
        Of() = default;
        virtual ~Of() = default;

        private:
        int64_t of;

        public:
        const int64_t & get_of() const { return of; }
        int64_t & get_mutable_of() { return of; }
        void set_of(const int64_t & value) { this->of = value; }
    };

    class OffsetDateTime {
        public:
        OffsetDateTime() = default;
        virtual ~OffsetDateTime() = default;

        private:
        int64_t offset_date_time;

        public:
        const int64_t & get_offset_date_time() const { return offset_date_time; }
        int64_t & get_mutable_offset_date_time() { return offset_date_time; }
        void set_offset_date_time(const int64_t & value) { this->offset_date_time = value; }
    };

    class OffsetTime {
        public:
        OffsetTime() = default;
        virtual ~OffsetTime() = default;

        private:
        int64_t offset_time;

        public:
        const int64_t & get_offset_time() const { return offset_time; }
        int64_t & get_mutable_offset_time() { return offset_time; }
        void set_offset_time(const int64_t & value) { this->offset_time = value; }
    };

    class Oneway {
        public:
        Oneway() = default;
        virtual ~Oneway() = default;

        private:
        int64_t oneway;

        public:
        const int64_t & get_oneway() const { return oneway; }
        int64_t & get_mutable_oneway() { return oneway; }
        void set_oneway(const int64_t & value) { this->oneway = value; }
    };

    class Open {
        public:
        Open() = default;
        virtual ~Open() = default;

        private:
        int64_t open;

        public:
        const int64_t & get_open() const { return open; }
        int64_t & get_mutable_open() { return open; }
        void set_open(const int64_t & value) { this->open = value; }
    };

    class Optional {
        public:
        Optional() = default;
        virtual ~Optional() = default;

        private:
        int64_t optional;

        public:
        const int64_t & get_optional() const { return optional; }
        int64_t & get_mutable_optional() { return optional; }
        void set_optional(const int64_t & value) { this->optional = value; }
    };

    class Out {
        public:
        Out() = default;
        virtual ~Out() = default;

        private:
        int64_t out;

        public:
        const int64_t & get_out() const { return out; }
        int64_t & get_mutable_out() { return out; }
        void set_out(const int64_t & value) { this->out = value; }
    };

    class Package {
        public:
        Package() = default;
        virtual ~Package() = default;

        private:
        int64_t package;

        public:
        const int64_t & get_package() const { return package; }
        int64_t & get_mutable_package() { return package; }
        void set_package(const int64_t & value) { this->package = value; }
    };

    class Params {
        public:
        Params() = default;
        virtual ~Params() = default;

        private:
        int64_t params;

        public:
        const int64_t & get_params() const { return params; }
        int64_t & get_mutable_params() { return params; }
        void set_params(const int64_t & value) { this->params = value; }
    };

    class Pass {
        public:
        Pass() = default;
        virtual ~Pass() = default;

        private:
        int64_t pass;

        public:
        const int64_t & get_pass() const { return pass; }
        int64_t & get_mutable_pass() { return pass; }
        void set_pass(const int64_t & value) { this->pass = value; }
    };

    class Port {
        public:
        Port() = default;
        virtual ~Port() = default;

        private:
        int64_t port;

        public:
        const int64_t & get_port() const { return port; }
        int64_t & get_mutable_port() { return port; }
        void set_port(const int64_t & value) { this->port = value; }
    };

    class Postfix {
        public:
        Postfix() = default;
        virtual ~Postfix() = default;

        private:
        int64_t postfix;

        public:
        const int64_t & get_postfix() const { return postfix; }
        int64_t & get_mutable_postfix() { return postfix; }
        void set_postfix(const int64_t & value) { this->postfix = value; }
    };

    class Precedence {
        public:
        Precedence() = default;
        virtual ~Precedence() = default;

        private:
        int64_t precedence;

        public:
        const int64_t & get_precedence() const { return precedence; }
        int64_t & get_mutable_precedence() { return precedence; }
        void set_precedence(const int64_t & value) { this->precedence = value; }
    };

    class Prefix {
        public:
        Prefix() = default;
        virtual ~Prefix() = default;

        private:
        int64_t prefix;

        public:
        const int64_t & get_prefix() const { return prefix; }
        int64_t & get_mutable_prefix() { return prefix; }
        void set_prefix(const int64_t & value) { this->prefix = value; }
    };

    class Print {
        public:
        Print() = default;
        virtual ~Print() = default;

        private:
        int64_t print;

        public:
        const int64_t & get_print() const { return print; }
        int64_t & get_mutable_print() { return print; }
        void set_print(const int64_t & value) { this->print = value; }
    };

    class PrintMembers {
        public:
        PrintMembers() = default;
        virtual ~PrintMembers() = default;

        private:
        int64_t print_members;

        public:
        const int64_t & get_print_members() const { return print_members; }
        int64_t & get_mutable_print_members() { return print_members; }
        void set_print_members(const int64_t & value) { this->print_members = value; }
    };

    class Printf {
        public:
        Printf() = default;
        virtual ~Printf() = default;

        private:
        int64_t printf;

        public:
        const int64_t & get_printf() const { return printf; }
        int64_t & get_mutable_printf() { return printf; }
        void set_printf(const int64_t & value) { this->printf = value; }
    };

    class Protocol {
        public:
        Protocol() = default;
        virtual ~Protocol() = default;

        private:
        int64_t protocol;

        public:
        const int64_t & get_protocol() const { return protocol; }
        int64_t & get_mutable_protocol() { return protocol; }
        void set_protocol(const int64_t & value) { this->protocol = value; }
    };

    class Quicktype {
        public:
        Quicktype() = default;
        virtual ~Quicktype() = default;

        private:
        int64_t quicktype;

        public:
        const int64_t & get_quicktype() const { return quicktype; }
        int64_t & get_mutable_quicktype() { return quicktype; }
        void set_quicktype(const int64_t & value) { this->quicktype = value; }
    };

    class Raise {
        public:
        Raise() = default;
        virtual ~Raise() = default;

        private:
        int64_t raise;

        public:
        const int64_t & get_raise() const { return raise; }
        int64_t & get_mutable_raise() { return raise; }
        void set_raise(const int64_t & value) { this->raise = value; }
    };

    class Range {
        public:
        Range() = default;
        virtual ~Range() = default;

        private:
        int64_t range;

        public:
        const int64_t & get_range() const { return range; }
        int64_t & get_mutable_range() { return range; }
        void set_range(const int64_t & value) { this->range = value; }
    };

    class Readonly {
        public:
        Readonly() = default;
        virtual ~Readonly() = default;

        private:
        int64_t readonly;

        public:
        const int64_t & get_readonly() const { return readonly; }
        int64_t & get_mutable_readonly() { return readonly; }
        void set_readonly(const int64_t & value) { this->readonly = value; }
    };

    class Ref {
        public:
        Ref() = default;
        virtual ~Ref() = default;

        private:
        int64_t ref;

        public:
        const int64_t & get_ref() const { return ref; }
        int64_t & get_mutable_ref() { return ref; }
        void set_ref(const int64_t & value) { this->ref = value; }
    };

    class RegExp {
        public:
        RegExp() = default;
        virtual ~RegExp() = default;

        private:
        std::string reg_exp;

        public:
        const std::string & get_reg_exp() const { return reg_exp; }
        std::string & get_mutable_reg_exp() { return reg_exp; }
        void set_reg_exp(const std::string & value) { this->reg_exp = value; }
    };

    class Obj4 {
        public:
        Obj4() = default;
        virtual ~Obj4() = default;

        private:
        int64_t dummy;
        Mutating mutating;
        Native native;
        Newtonsoft newtonsoft;
        Nil nil;
        No no;
        NoSuchMethod no_such_method;
        Nonatomic nonatomic;
        None none;
        Nonlocal nonlocal;
        Nonmutating nonmutating;
        NsError ns_error;
        NsObject ns_object;
        NsString ns_string;
        Null null;
        NullNode null_node;
        Number number;
        Mutable obj4_mutable;
        Namespace obj4_namespace;
        New obj4_new;
        Noexcept obj4_noexcept;
        NoneClass obj4_none;
        Not obj4_not;
        NotEq obj4_not_eq;
        NullClass obj4_null;
        Nullptr obj4_nullptr;
        Operator obj4_operator;
        Or obj4_or;
        OrEq obj4_or_eq;
        Override obj4_override;
        Private obj4_private;
        Protected obj4_protected;
        ProtocolClass obj4_protocol;
        Public obj4_public;
        Register obj4_register;
        ReinterpretCast obj4_reinterpret_cast;
        Object object;
        ObjectMapper object_mapper;
        ObjectNode object_node;
        ObjectReader object_reader;
        ObjectWriter object_writer;
        Of of;
        OffsetDateTime offset_date_time;
        OffsetTime offset_time;
        Oneway oneway;
        Open open;
        Optional optional;
        Out out;
        Package package;
        Params params;
        Pass pass;
        Port port;
        Postfix postfix;
        Precedence precedence;
        Prefix prefix;
        Print print;
        PrintMembers print_members;
        Printf printf;
        Protocol protocol;
        Quicktype quicktype;
        Raise raise;
        Range range;
        Readonly readonly;
        Ref ref;
        RegExp reg_exp;

        public:
        const int64_t & get_dummy() const { return dummy; }
        int64_t & get_mutable_dummy() { return dummy; }
        void set_dummy(const int64_t & value) { this->dummy = value; }

        const Mutating & get_mutating() const { return mutating; }
        Mutating & get_mutable_mutating() { return mutating; }
        void set_mutating(const Mutating & value) { this->mutating = value; }

        const Native & get_native() const { return native; }
        Native & get_mutable_native() { return native; }
        void set_native(const Native & value) { this->native = value; }

        const Newtonsoft & get_newtonsoft() const { return newtonsoft; }
        Newtonsoft & get_mutable_newtonsoft() { return newtonsoft; }
        void set_newtonsoft(const Newtonsoft & value) { this->newtonsoft = value; }

        const Nil & get_nil() const { return nil; }
        Nil & get_mutable_nil() { return nil; }
        void set_nil(const Nil & value) { this->nil = value; }

        const No & get_no() const { return no; }
        No & get_mutable_no() { return no; }
        void set_no(const No & value) { this->no = value; }

        const NoSuchMethod & get_no_such_method() const { return no_such_method; }
        NoSuchMethod & get_mutable_no_such_method() { return no_such_method; }
        void set_no_such_method(const NoSuchMethod & value) { this->no_such_method = value; }

        const Nonatomic & get_nonatomic() const { return nonatomic; }
        Nonatomic & get_mutable_nonatomic() { return nonatomic; }
        void set_nonatomic(const Nonatomic & value) { this->nonatomic = value; }

        const None & get_none() const { return none; }
        None & get_mutable_none() { return none; }
        void set_none(const None & value) { this->none = value; }

        const Nonlocal & get_nonlocal() const { return nonlocal; }
        Nonlocal & get_mutable_nonlocal() { return nonlocal; }
        void set_nonlocal(const Nonlocal & value) { this->nonlocal = value; }

        const Nonmutating & get_nonmutating() const { return nonmutating; }
        Nonmutating & get_mutable_nonmutating() { return nonmutating; }
        void set_nonmutating(const Nonmutating & value) { this->nonmutating = value; }

        const NsError & get_ns_error() const { return ns_error; }
        NsError & get_mutable_ns_error() { return ns_error; }
        void set_ns_error(const NsError & value) { this->ns_error = value; }

        const NsObject & get_ns_object() const { return ns_object; }
        NsObject & get_mutable_ns_object() { return ns_object; }
        void set_ns_object(const NsObject & value) { this->ns_object = value; }

        const NsString & get_ns_string() const { return ns_string; }
        NsString & get_mutable_ns_string() { return ns_string; }
        void set_ns_string(const NsString & value) { this->ns_string = value; }

        const Null & get_null() const { return null; }
        Null & get_mutable_null() { return null; }
        void set_null(const Null & value) { this->null = value; }

        const NullNode & get_null_node() const { return null_node; }
        NullNode & get_mutable_null_node() { return null_node; }
        void set_null_node(const NullNode & value) { this->null_node = value; }

        const Number & get_number() const { return number; }
        Number & get_mutable_number() { return number; }
        void set_number(const Number & value) { this->number = value; }

        const Mutable & get_obj4_mutable() const { return obj4_mutable; }
        Mutable & get_mutable_obj4_mutable() { return obj4_mutable; }
        void set_obj4_mutable(const Mutable & value) { this->obj4_mutable = value; }

        const Namespace & get_obj4_namespace() const { return obj4_namespace; }
        Namespace & get_mutable_obj4_namespace() { return obj4_namespace; }
        void set_obj4_namespace(const Namespace & value) { this->obj4_namespace = value; }

        const New & get_obj4_new() const { return obj4_new; }
        New & get_mutable_obj4_new() { return obj4_new; }
        void set_obj4_new(const New & value) { this->obj4_new = value; }

        const Noexcept & get_obj4_noexcept() const { return obj4_noexcept; }
        Noexcept & get_mutable_obj4_noexcept() { return obj4_noexcept; }
        void set_obj4_noexcept(const Noexcept & value) { this->obj4_noexcept = value; }

        const NoneClass & get_obj4_none() const { return obj4_none; }
        NoneClass & get_mutable_obj4_none() { return obj4_none; }
        void set_obj4_none(const NoneClass & value) { this->obj4_none = value; }

        const Not & get_obj4_not() const { return obj4_not; }
        Not & get_mutable_obj4_not() { return obj4_not; }
        void set_obj4_not(const Not & value) { this->obj4_not = value; }

        const NotEq & get_obj4_not_eq() const { return obj4_not_eq; }
        NotEq & get_mutable_obj4_not_eq() { return obj4_not_eq; }
        void set_obj4_not_eq(const NotEq & value) { this->obj4_not_eq = value; }

        const NullClass & get_obj4_null() const { return obj4_null; }
        NullClass & get_mutable_obj4_null() { return obj4_null; }
        void set_obj4_null(const NullClass & value) { this->obj4_null = value; }

        const Nullptr & get_obj4_nullptr() const { return obj4_nullptr; }
        Nullptr & get_mutable_obj4_nullptr() { return obj4_nullptr; }
        void set_obj4_nullptr(const Nullptr & value) { this->obj4_nullptr = value; }

        const Operator & get_obj4_operator() const { return obj4_operator; }
        Operator & get_mutable_obj4_operator() { return obj4_operator; }
        void set_obj4_operator(const Operator & value) { this->obj4_operator = value; }

        const Or & get_obj4_or() const { return obj4_or; }
        Or & get_mutable_obj4_or() { return obj4_or; }
        void set_obj4_or(const Or & value) { this->obj4_or = value; }

        const OrEq & get_obj4_or_eq() const { return obj4_or_eq; }
        OrEq & get_mutable_obj4_or_eq() { return obj4_or_eq; }
        void set_obj4_or_eq(const OrEq & value) { this->obj4_or_eq = value; }

        const Override & get_obj4_override() const { return obj4_override; }
        Override & get_mutable_obj4_override() { return obj4_override; }
        void set_obj4_override(const Override & value) { this->obj4_override = value; }

        const Private & get_obj4_private() const { return obj4_private; }
        Private & get_mutable_obj4_private() { return obj4_private; }
        void set_obj4_private(const Private & value) { this->obj4_private = value; }

        const Protected & get_obj4_protected() const { return obj4_protected; }
        Protected & get_mutable_obj4_protected() { return obj4_protected; }
        void set_obj4_protected(const Protected & value) { this->obj4_protected = value; }

        const ProtocolClass & get_obj4_protocol() const { return obj4_protocol; }
        ProtocolClass & get_mutable_obj4_protocol() { return obj4_protocol; }
        void set_obj4_protocol(const ProtocolClass & value) { this->obj4_protocol = value; }

        const Public & get_obj4_public() const { return obj4_public; }
        Public & get_mutable_obj4_public() { return obj4_public; }
        void set_obj4_public(const Public & value) { this->obj4_public = value; }

        const Register & get_obj4_register() const { return obj4_register; }
        Register & get_mutable_obj4_register() { return obj4_register; }
        void set_obj4_register(const Register & value) { this->obj4_register = value; }

        const ReinterpretCast & get_obj4_reinterpret_cast() const { return obj4_reinterpret_cast; }
        ReinterpretCast & get_mutable_obj4_reinterpret_cast() { return obj4_reinterpret_cast; }
        void set_obj4_reinterpret_cast(const ReinterpretCast & value) { this->obj4_reinterpret_cast = value; }

        const Object & get_object() const { return object; }
        Object & get_mutable_object() { return object; }
        void set_object(const Object & value) { this->object = value; }

        const ObjectMapper & get_object_mapper() const { return object_mapper; }
        ObjectMapper & get_mutable_object_mapper() { return object_mapper; }
        void set_object_mapper(const ObjectMapper & value) { this->object_mapper = value; }

        const ObjectNode & get_object_node() const { return object_node; }
        ObjectNode & get_mutable_object_node() { return object_node; }
        void set_object_node(const ObjectNode & value) { this->object_node = value; }

        const ObjectReader & get_object_reader() const { return object_reader; }
        ObjectReader & get_mutable_object_reader() { return object_reader; }
        void set_object_reader(const ObjectReader & value) { this->object_reader = value; }

        const ObjectWriter & get_object_writer() const { return object_writer; }
        ObjectWriter & get_mutable_object_writer() { return object_writer; }
        void set_object_writer(const ObjectWriter & value) { this->object_writer = value; }

        const Of & get_of() const { return of; }
        Of & get_mutable_of() { return of; }
        void set_of(const Of & value) { this->of = value; }

        const OffsetDateTime & get_offset_date_time() const { return offset_date_time; }
        OffsetDateTime & get_mutable_offset_date_time() { return offset_date_time; }
        void set_offset_date_time(const OffsetDateTime & value) { this->offset_date_time = value; }

        const OffsetTime & get_offset_time() const { return offset_time; }
        OffsetTime & get_mutable_offset_time() { return offset_time; }
        void set_offset_time(const OffsetTime & value) { this->offset_time = value; }

        const Oneway & get_oneway() const { return oneway; }
        Oneway & get_mutable_oneway() { return oneway; }
        void set_oneway(const Oneway & value) { this->oneway = value; }

        const Open & get_open() const { return open; }
        Open & get_mutable_open() { return open; }
        void set_open(const Open & value) { this->open = value; }

        const Optional & get_optional() const { return optional; }
        Optional & get_mutable_optional() { return optional; }
        void set_optional(const Optional & value) { this->optional = value; }

        const Out & get_out() const { return out; }
        Out & get_mutable_out() { return out; }
        void set_out(const Out & value) { this->out = value; }

        const Package & get_package() const { return package; }
        Package & get_mutable_package() { return package; }
        void set_package(const Package & value) { this->package = value; }

        const Params & get_params() const { return params; }
        Params & get_mutable_params() { return params; }
        void set_params(const Params & value) { this->params = value; }

        const Pass & get_pass() const { return pass; }
        Pass & get_mutable_pass() { return pass; }
        void set_pass(const Pass & value) { this->pass = value; }

        const Port & get_port() const { return port; }
        Port & get_mutable_port() { return port; }
        void set_port(const Port & value) { this->port = value; }

        const Postfix & get_postfix() const { return postfix; }
        Postfix & get_mutable_postfix() { return postfix; }
        void set_postfix(const Postfix & value) { this->postfix = value; }

        const Precedence & get_precedence() const { return precedence; }
        Precedence & get_mutable_precedence() { return precedence; }
        void set_precedence(const Precedence & value) { this->precedence = value; }

        const Prefix & get_prefix() const { return prefix; }
        Prefix & get_mutable_prefix() { return prefix; }
        void set_prefix(const Prefix & value) { this->prefix = value; }

        const Print & get_print() const { return print; }
        Print & get_mutable_print() { return print; }
        void set_print(const Print & value) { this->print = value; }

        const PrintMembers & get_print_members() const { return print_members; }
        PrintMembers & get_mutable_print_members() { return print_members; }
        void set_print_members(const PrintMembers & value) { this->print_members = value; }

        const Printf & get_printf() const { return printf; }
        Printf & get_mutable_printf() { return printf; }
        void set_printf(const Printf & value) { this->printf = value; }

        const Protocol & get_protocol() const { return protocol; }
        Protocol & get_mutable_protocol() { return protocol; }
        void set_protocol(const Protocol & value) { this->protocol = value; }

        const Quicktype & get_quicktype() const { return quicktype; }
        Quicktype & get_mutable_quicktype() { return quicktype; }
        void set_quicktype(const Quicktype & value) { this->quicktype = value; }

        const Raise & get_raise() const { return raise; }
        Raise & get_mutable_raise() { return raise; }
        void set_raise(const Raise & value) { this->raise = value; }

        const Range & get_range() const { return range; }
        Range & get_mutable_range() { return range; }
        void set_range(const Range & value) { this->range = value; }

        const Readonly & get_readonly() const { return readonly; }
        Readonly & get_mutable_readonly() { return readonly; }
        void set_readonly(const Readonly & value) { this->readonly = value; }

        const Ref & get_ref() const { return ref; }
        Ref & get_mutable_ref() { return ref; }
        void set_ref(const Ref & value) { this->ref = value; }

        const RegExp & get_reg_exp() const { return reg_exp; }
        RegExp & get_mutable_reg_exp() { return reg_exp; }
        void set_reg_exp(const RegExp & value) { this->reg_exp = value; }
    };

    class KSerializer {
        public:
        KSerializer() = default;
        virtual ~KSerializer() = default;

        private:
        int64_t k_serializer;

        public:
        const int64_t & get_k_serializer() const { return k_serializer; }
        int64_t & get_mutable_k_serializer() { return k_serializer; }
        void set_k_serializer(const int64_t & value) { this->k_serializer = value; }
    };

    class Requires {
        public:
        Requires() = default;
        virtual ~Requires() = default;

        private:
        int64_t requires_requires;

        public:
        const int64_t & get_requires_requires() const { return requires_requires; }
        int64_t & get_mutable_requires_requires() { return requires_requires; }
        void set_requires_requires(const int64_t & value) { this->requires_requires = value; }
    };

    class Return {
        public:
        Return() = default;
        virtual ~Return() = default;

        private:
        int64_t return_return;

        public:
        const int64_t & get_return_return() const { return return_return; }
        int64_t & get_mutable_return_return() { return return_return; }
        void set_return_return(const int64_t & value) { this->return_return = value; }
    };

    class SelfClass {
        public:
        SelfClass() = default;
        virtual ~SelfClass() = default;

        private:
        int64_t self;

        public:
        const int64_t & get_self() const { return self; }
        int64_t & get_mutable_self() { return self; }
        void set_self(const int64_t & value) { this->self = value; }
    };

    class Short {
        public:
        Short() = default;
        virtual ~Short() = default;

        private:
        int64_t short_short;

        public:
        const int64_t & get_short_short() const { return short_short; }
        int64_t & get_mutable_short_short() { return short_short; }
        void set_short_short(const int64_t & value) { this->short_short = value; }
    };

    class Signed {
        public:
        Signed() = default;
        virtual ~Signed() = default;

        private:
        int64_t signed_signed;

        public:
        const int64_t & get_signed_signed() const { return signed_signed; }
        int64_t & get_mutable_signed_signed() { return signed_signed; }
        void set_signed_signed(const int64_t & value) { this->signed_signed = value; }
    };

    class Sizeof {
        public:
        Sizeof() = default;
        virtual ~Sizeof() = default;

        private:
        int64_t sizeof_sizeof;

        public:
        const int64_t & get_sizeof_sizeof() const { return sizeof_sizeof; }
        int64_t & get_mutable_sizeof_sizeof() { return sizeof_sizeof; }
        void set_sizeof_sizeof(const int64_t & value) { this->sizeof_sizeof = value; }
    };

    class Static {
        public:
        Static() = default;
        virtual ~Static() = default;

        private:
        int64_t static_static;

        public:
        const int64_t & get_static_static() const { return static_static; }
        int64_t & get_mutable_static_static() { return static_static; }
        void set_static_static(const int64_t & value) { this->static_static = value; }
    };

    class StaticAssert {
        public:
        StaticAssert() = default;
        virtual ~StaticAssert() = default;

        private:
        int64_t static_assert_static_assert;

        public:
        const int64_t & get_static_assert_static_assert() const { return static_assert_static_assert; }
        int64_t & get_mutable_static_assert_static_assert() { return static_assert_static_assert; }
        void set_static_assert_static_assert(const int64_t & value) { this->static_assert_static_assert = value; }
    };

    class StaticCast {
        public:
        StaticCast() = default;
        virtual ~StaticCast() = default;

        private:
        int64_t static_cast_static_cast;

        public:
        const int64_t & get_static_cast_static_cast() const { return static_cast_static_cast; }
        int64_t & get_mutable_static_cast_static_cast() { return static_cast_static_cast; }
        void set_static_cast_static_cast(const int64_t & value) { this->static_cast_static_cast = value; }
    };

    class Struct {
        public:
        Struct() = default;
        virtual ~Struct() = default;

        private:
        int64_t struct_struct;

        public:
        const int64_t & get_struct_struct() const { return struct_struct; }
        int64_t & get_mutable_struct_struct() { return struct_struct; }
        void set_struct_struct(const int64_t & value) { this->struct_struct = value; }
    };

    class Switch {
        public:
        Switch() = default;
        virtual ~Switch() = default;

        private:
        int64_t switch_switch;

        public:
        const int64_t & get_switch_switch() const { return switch_switch; }
        int64_t & get_mutable_switch_switch() { return switch_switch; }
        void set_switch_switch(const int64_t & value) { this->switch_switch = value; }
    };

    class Synchronized {
        public:
        Synchronized() = default;
        virtual ~Synchronized() = default;

        private:
        int64_t synchronized_synchronized;

        public:
        const int64_t & get_synchronized_synchronized() const { return synchronized_synchronized; }
        int64_t & get_mutable_synchronized_synchronized() { return synchronized_synchronized; }
        void set_synchronized_synchronized(const int64_t & value) { this->synchronized_synchronized = value; }
    };

    class Template {
        public:
        Template() = default;
        virtual ~Template() = default;

        private:
        int64_t template_template;

        public:
        const int64_t & get_template_template() const { return template_template; }
        int64_t & get_mutable_template_template() { return template_template; }
        void set_template_template(const int64_t & value) { this->template_template = value; }
    };

    class This {
        public:
        This() = default;
        virtual ~This() = default;

        private:
        int64_t this_this;

        public:
        const int64_t & get_this_this() const { return this_this; }
        int64_t & get_mutable_this_this() { return this_this; }
        void set_this_this(const int64_t & value) { this->this_this = value; }
    };

    class ThreadLocal {
        public:
        ThreadLocal() = default;
        virtual ~ThreadLocal() = default;

        private:
        int64_t thread_local_thread_local;

        public:
        const int64_t & get_thread_local_thread_local() const { return thread_local_thread_local; }
        int64_t & get_mutable_thread_local_thread_local() { return thread_local_thread_local; }
        void set_thread_local_thread_local(const int64_t & value) { this->thread_local_thread_local = value; }
    };

    class Throw {
        public:
        Throw() = default;
        virtual ~Throw() = default;

        private:
        int64_t throw_throw;

        public:
        const int64_t & get_throw_throw() const { return throw_throw; }
        int64_t & get_mutable_throw_throw() { return throw_throw; }
        void set_throw_throw(const int64_t & value) { this->throw_throw = value; }
    };

    class True {
        public:
        True() = default;
        virtual ~True() = default;

        private:
        int64_t true_true;

        public:
        const int64_t & get_true_true() const { return true_true; }
        int64_t & get_mutable_true_true() { return true_true; }
        void set_true_true(const int64_t & value) { this->true_true = value; }
    };

    class PrimitiveKind {
        public:
        PrimitiveKind() = default;
        virtual ~PrimitiveKind() = default;

        private:
        int64_t primitive_kind;

        public:
        const int64_t & get_primitive_kind() const { return primitive_kind; }
        int64_t & get_mutable_primitive_kind() { return primitive_kind; }
        void set_primitive_kind(const int64_t & value) { this->primitive_kind = value; }
    };

    class TrueClass {
        public:
        TrueClass() = default;
        virtual ~TrueClass() = default;

        private:
        int64_t true_true;

        public:
        const int64_t & get_true_true() const { return true_true; }
        int64_t & get_mutable_true_true() { return true_true; }
        void set_true_true(const int64_t & value) { this->true_true = value; }
    };

    class Repeat {
        public:
        Repeat() = default;
        virtual ~Repeat() = default;

        private:
        int64_t repeat;

        public:
        const int64_t & get_repeat() const { return repeat; }
        int64_t & get_mutable_repeat() { return repeat; }
        void set_repeat(const int64_t & value) { this->repeat = value; }
    };

    class Require {
        public:
        Require() = default;
        virtual ~Require() = default;

        private:
        int64_t require;

        public:
        const int64_t & get_require() const { return require; }
        int64_t & get_mutable_require() { return require; }
        void set_require(const int64_t & value) { this->require = value; }
    };

    class Required {
        public:
        Required() = default;
        virtual ~Required() = default;

        private:
        int64_t required;

        public:
        const int64_t & get_required() const { return required; }
        int64_t & get_mutable_required() { return required; }
        void set_required(const int64_t & value) { this->required = value; }
    };

    class Restrict {
        public:
        Restrict() = default;
        virtual ~Restrict() = default;

        private:
        int64_t restrict;

        public:
        const int64_t & get_restrict() const { return restrict; }
        int64_t & get_mutable_restrict() { return restrict; }
        void set_restrict(const int64_t & value) { this->restrict = value; }
    };

    class Retain {
        public:
        Retain() = default;
        virtual ~Retain() = default;

        private:
        int64_t retain;

        public:
        const int64_t & get_retain() const { return retain; }
        int64_t & get_mutable_retain() { return retain; }
        void set_retain(const int64_t & value) { this->retain = value; }
    };

    class Rethrows {
        public:
        Rethrows() = default;
        virtual ~Rethrows() = default;

        private:
        int64_t rethrows;

        public:
        const int64_t & get_rethrows() const { return rethrows; }
        int64_t & get_mutable_rethrows() { return rethrows; }
        void set_rethrows(const int64_t & value) { this->rethrows = value; }
    };

    class Right {
        public:
        Right() = default;
        virtual ~Right() = default;

        private:
        int64_t right;

        public:
        const int64_t & get_right() const { return right; }
        int64_t & get_mutable_right() { return right; }
        void set_right(const int64_t & value) { this->right = value; }
    };

    class RuntimeType {
        public:
        RuntimeType() = default;
        virtual ~RuntimeType() = default;

        private:
        int64_t runtime_type;

        public:
        const int64_t & get_runtime_type() const { return runtime_type; }
        int64_t & get_mutable_runtime_type() { return runtime_type; }
        void set_runtime_type(const int64_t & value) { this->runtime_type = value; }
    };

    class S {
        public:
        S() = default;
        virtual ~S() = default;

        private:
        int64_t s;

        public:
        const int64_t & get_s() const { return s; }
        int64_t & get_mutable_s() { return s; }
        void set_s(const int64_t & value) { this->s = value; }
    };

    class Sbyte {
        public:
        Sbyte() = default;
        virtual ~Sbyte() = default;

        private:
        int64_t sbyte;

        public:
        const int64_t & get_sbyte() const { return sbyte; }
        int64_t & get_mutable_sbyte() { return sbyte; }
        void set_sbyte(const int64_t & value) { this->sbyte = value; }
    };

    class Sealed {
        public:
        Sealed() = default;
        virtual ~Sealed() = default;

        private:
        int64_t sealed;

        public:
        const int64_t & get_sealed() const { return sealed; }
        int64_t & get_mutable_sealed() { return sealed; }
        void set_sealed(const int64_t & value) { this->sealed = value; }
    };

    class Sel {
        public:
        Sel() = default;
        virtual ~Sel() = default;

        private:
        int64_t sel;

        public:
        const int64_t & get_sel() const { return sel; }
        int64_t & get_mutable_sel() { return sel; }
        void set_sel(const int64_t & value) { this->sel = value; }
    };

    class Select {
        public:
        Select() = default;
        virtual ~Select() = default;

        private:
        int64_t select;

        public:
        const int64_t & get_select() const { return select; }
        int64_t & get_mutable_select() { return select; }
        void set_select(const int64_t & value) { this->select = value; }
    };

    class Self {
        public:
        Self() = default;
        virtual ~Self() = default;

        private:
        int64_t self;

        public:
        const int64_t & get_self() const { return self; }
        int64_t & get_mutable_self() { return self; }
        void set_self(const int64_t & value) { this->self = value; }
    };

    class Sendable {
        public:
        Sendable() = default;
        virtual ~Sendable() = default;

        private:
        int64_t sendable;

        public:
        const int64_t & get_sendable() const { return sendable; }
        int64_t & get_mutable_sendable() { return sendable; }
        void set_sendable(const int64_t & value) { this->sendable = value; }
    };

    class SerialDescriptor {
        public:
        SerialDescriptor() = default;
        virtual ~SerialDescriptor() = default;

        private:
        int64_t serial_descriptor;

        public:
        const int64_t & get_serial_descriptor() const { return serial_descriptor; }
        int64_t & get_mutable_serial_descriptor() { return serial_descriptor; }
        void set_serial_descriptor(const int64_t & value) { this->serial_descriptor = value; }
    };

    class SerialName {
        public:
        SerialName() = default;
        virtual ~SerialName() = default;

        private:
        int64_t serial_name;

        public:
        const int64_t & get_serial_name() const { return serial_name; }
        int64_t & get_mutable_serial_name() { return serial_name; }
        void set_serial_name(const int64_t & value) { this->serial_name = value; }
    };

    class Serializable {
        public:
        Serializable() = default;
        virtual ~Serializable() = default;

        private:
        int64_t serializable;

        public:
        const int64_t & get_serializable() const { return serializable; }
        int64_t & get_mutable_serializable() { return serializable; }
        void set_serializable(const int64_t & value) { this->serializable = value; }
    };

    class SerializationFeature {
        public:
        SerializationFeature() = default;
        virtual ~SerializationFeature() = default;

        private:
        int64_t serialization_feature;

        public:
        const int64_t & get_serialization_feature() const { return serialization_feature; }
        int64_t & get_mutable_serialization_feature() { return serialization_feature; }
        void set_serialization_feature(const int64_t & value) { this->serialization_feature = value; }
    };

    class Serialize {
        public:
        Serialize() = default;
        virtual ~Serialize() = default;

        private:
        int64_t serialize;

        public:
        const int64_t & get_serialize() const { return serialize; }
        int64_t & get_mutable_serialize() { return serialize; }
        void set_serialize(const int64_t & value) { this->serialize = value; }
    };

    class SerializerProvider {
        public:
        SerializerProvider() = default;
        virtual ~SerializerProvider() = default;

        private:
        int64_t serializer_provider;

        public:
        const int64_t & get_serializer_provider() const { return serializer_provider; }
        int64_t & get_mutable_serializer_provider() { return serializer_provider; }
        void set_serializer_provider(const int64_t & value) { this->serializer_provider = value; }
    };

    class Set {
        public:
        Set() = default;
        virtual ~Set() = default;

        private:
        int64_t set;

        public:
        const int64_t & get_set() const { return set; }
        int64_t & get_mutable_set() { return set; }
        void set_set(const int64_t & value) { this->set = value; }
    };

    class SimpleModule {
        public:
        SimpleModule() = default;
        virtual ~SimpleModule() = default;

        private:
        int64_t simple_module;

        public:
        const int64_t & get_simple_module() const { return simple_module; }
        int64_t & get_mutable_simple_module() { return simple_module; }
        void set_simple_module(const int64_t & value) { this->simple_module = value; }
    };

    class Stackalloc {
        public:
        Stackalloc() = default;
        virtual ~Stackalloc() = default;

        private:
        int64_t stackalloc;

        public:
        const int64_t & get_stackalloc() const { return stackalloc; }
        int64_t & get_mutable_stackalloc() { return stackalloc; }
        void set_stackalloc(const int64_t & value) { this->stackalloc = value; }
    };

    class Standards {
        public:
        Standards() = default;
        virtual ~Standards() = default;

        private:
        int64_t standards;

        public:
        const int64_t & get_standards() const { return standards; }
        int64_t & get_mutable_standards() { return standards; }
        void set_standards(const int64_t & value) { this->standards = value; }
    };

    class StdDeserializer {
        public:
        StdDeserializer() = default;
        virtual ~StdDeserializer() = default;

        private:
        int64_t std_deserializer;

        public:
        const int64_t & get_std_deserializer() const { return std_deserializer; }
        int64_t & get_mutable_std_deserializer() { return std_deserializer; }
        void set_std_deserializer(const int64_t & value) { this->std_deserializer = value; }
    };

    class StdSerializer {
        public:
        StdSerializer() = default;
        virtual ~StdSerializer() = default;

        private:
        int64_t std_serializer;

        public:
        const int64_t & get_std_serializer() const { return std_serializer; }
        int64_t & get_mutable_std_serializer() { return std_serializer; }
        void set_std_serializer(const int64_t & value) { this->std_serializer = value; }
    };

    class Strictfp {
        public:
        Strictfp() = default;
        virtual ~Strictfp() = default;

        private:
        int64_t strictfp;

        public:
        const int64_t & get_strictfp() const { return strictfp; }
        int64_t & get_mutable_strictfp() { return strictfp; }
        void set_strictfp(const int64_t & value) { this->strictfp = value; }
    };

    class String {
        public:
        String() = default;
        virtual ~String() = default;

        private:
        int64_t string;

        public:
        const int64_t & get_string() const { return string; }
        int64_t & get_mutable_string() { return string; }
        void set_string(const int64_t & value) { this->string = value; }
    };

    class Subscript {
        public:
        Subscript() = default;
        virtual ~Subscript() = default;

        private:
        int64_t subscript;

        public:
        const int64_t & get_subscript() const { return subscript; }
        int64_t & get_mutable_subscript() { return subscript; }
        void set_subscript(const int64_t & value) { this->subscript = value; }
    };

    class Super {
        public:
        Super() = default;
        virtual ~Super() = default;

        private:
        int64_t super;

        public:
        const int64_t & get_super() const { return super; }
        int64_t & get_mutable_super() { return super; }
        void set_super(const int64_t & value) { this->super = value; }
    };

    class Symbol {
        public:
        Symbol() = default;
        virtual ~Symbol() = default;

        private:
        int64_t symbol;

        public:
        const int64_t & get_symbol() const { return symbol; }
        int64_t & get_mutable_symbol() { return symbol; }
        void set_symbol(const int64_t & value) { this->symbol = value; }
    };

    class System {
        public:
        System() = default;
        virtual ~System() = default;

        private:
        int64_t system;

        public:
        const int64_t & get_system() const { return system; }
        int64_t & get_mutable_system() { return system; }
        void set_system(const int64_t & value) { this->system = value; }
    };

    class TextNode {
        public:
        TextNode() = default;
        virtual ~TextNode() = default;

        private:
        int64_t text_node;

        public:
        const int64_t & get_text_node() const { return text_node; }
        int64_t & get_mutable_text_node() { return text_node; }
        void set_text_node(const int64_t & value) { this->text_node = value; }
    };

    class Then {
        public:
        Then() = default;
        virtual ~Then() = default;

        private:
        int64_t then;

        public:
        const int64_t & get_then() const { return then; }
        int64_t & get_mutable_then() { return then; }
        void set_then(const int64_t & value) { this->then = value; }
    };

    class Throws {
        public:
        Throws() = default;
        virtual ~Throws() = default;

        private:
        int64_t throws;

        public:
        const int64_t & get_throws() const { return throws; }
        int64_t & get_mutable_throws() { return throws; }
        void set_throws(const int64_t & value) { this->throws = value; }
    };

    class TimeOnly {
        public:
        TimeOnly() = default;
        virtual ~TimeOnly() = default;

        private:
        int64_t time_only;

        public:
        const int64_t & get_time_only() const { return time_only; }
        int64_t & get_mutable_time_only() { return time_only; }
        void set_time_only(const int64_t & value) { this->time_only = value; }
    };

    class TimeOnlyConverter {
        public:
        TimeOnlyConverter() = default;
        virtual ~TimeOnlyConverter() = default;

        private:
        int64_t time_only_converter;

        public:
        const int64_t & get_time_only_converter() const { return time_only_converter; }
        int64_t & get_mutable_time_only_converter() { return time_only_converter; }
        void set_time_only_converter(const int64_t & value) { this->time_only_converter = value; }
    };

    class TimeZone {
        public:
        TimeZone() = default;
        virtual ~TimeZone() = default;

        private:
        int64_t time_zone;

        public:
        const int64_t & get_time_zone() const { return time_zone; }
        int64_t & get_mutable_time_zone() { return time_zone; }
        void set_time_zone(const int64_t & value) { this->time_zone = value; }
    };

    class ToDict {
        public:
        ToDict() = default;
        virtual ~ToDict() = default;

        private:
        int64_t to_dict;

        public:
        const int64_t & get_to_dict() const { return to_dict; }
        int64_t & get_mutable_to_dict() { return to_dict; }
        void set_to_dict(const int64_t & value) { this->to_dict = value; }
    };

    class ToJson {
        public:
        ToJson() = default;
        virtual ~ToJson() = default;

        private:
        int64_t to_json;

        public:
        const int64_t & get_to_json() const { return to_json; }
        int64_t & get_mutable_to_json() { return to_json; }
        void set_to_json(const int64_t & value) { this->to_json = value; }
    };

    class ToString {
        public:
        ToString() = default;
        virtual ~ToString() = default;

        private:
        int64_t to_string;

        public:
        const int64_t & get_to_string() const { return to_string; }
        int64_t & get_mutable_to_string() { return to_string; }
        void set_to_string(const int64_t & value) { this->to_string = value; }
    };

    class TopLevelClass {
        public:
        TopLevelClass() = default;
        virtual ~TopLevelClass() = default;

        private:
        int64_t top_level;

        public:
        const int64_t & get_top_level() const { return top_level; }
        int64_t & get_mutable_top_level() { return top_level; }
        void set_top_level(const int64_t & value) { this->top_level = value; }
    };

    class Transient {
        public:
        Transient() = default;
        virtual ~Transient() = default;

        private:
        int64_t transient;

        public:
        const int64_t & get_transient() const { return transient; }
        int64_t & get_mutable_transient() { return transient; }
        void set_transient(const int64_t & value) { this->transient = value; }
    };

    class Obj5 {
        public:
        Obj5() = default;
        virtual ~Obj5() = default;

        private:
        int64_t dummy;
        KSerializer k_serializer;
        Requires obj5_requires;
        Return obj5_return;
        SelfClass obj5_self;
        Short obj5_short;
        Signed obj5_signed;
        Sizeof obj5_sizeof;
        Static obj5_static;
        StaticAssert obj5_static_assert;
        StaticCast obj5_static_cast;
        Struct obj5_struct;
        Switch obj5_switch;
        Synchronized obj5_synchronized;
        Template obj5_template;
        This obj5_this;
        ThreadLocal obj5_thread_local;
        Throw obj5_throw;
        True obj5_true;
        PrimitiveKind primitive_kind;
        TrueClass purple_true;
        Repeat repeat;
        Require require;
        Required required;
        Restrict restrict;
        Retain retain;
        Rethrows rethrows;
        Right right;
        RuntimeType runtime_type;
        S s;
        Sbyte sbyte;
        Sealed sealed;
        Sel sel;
        Select select;
        Self self;
        Sendable sendable;
        SerialDescriptor serial_descriptor;
        SerialName serial_name;
        Serializable serializable;
        SerializationFeature serialization_feature;
        Serialize serialize;
        SerializerProvider serializer_provider;
        Set set;
        SimpleModule simple_module;
        Stackalloc stackalloc;
        Standards standards;
        StdDeserializer std_deserializer;
        StdSerializer std_serializer;
        Strictfp strictfp;
        String string;
        Subscript subscript;
        Super super;
        Symbol symbol;
        System system;
        TextNode text_node;
        Then then;
        Throws throws;
        TimeOnly time_only;
        TimeOnlyConverter time_only_converter;
        TimeZone time_zone;
        ToDict to_dict;
        ToJson to_json;
        ToString to_string;
        TopLevelClass top_level;
        Transient transient;

        public:
        const int64_t & get_dummy() const { return dummy; }
        int64_t & get_mutable_dummy() { return dummy; }
        void set_dummy(const int64_t & value) { this->dummy = value; }

        const KSerializer & get_k_serializer() const { return k_serializer; }
        KSerializer & get_mutable_k_serializer() { return k_serializer; }
        void set_k_serializer(const KSerializer & value) { this->k_serializer = value; }

        const Requires & get_obj5_requires() const { return obj5_requires; }
        Requires & get_mutable_obj5_requires() { return obj5_requires; }
        void set_obj5_requires(const Requires & value) { this->obj5_requires = value; }

        const Return & get_obj5_return() const { return obj5_return; }
        Return & get_mutable_obj5_return() { return obj5_return; }
        void set_obj5_return(const Return & value) { this->obj5_return = value; }

        const SelfClass & get_obj5_self() const { return obj5_self; }
        SelfClass & get_mutable_obj5_self() { return obj5_self; }
        void set_obj5_self(const SelfClass & value) { this->obj5_self = value; }

        const Short & get_obj5_short() const { return obj5_short; }
        Short & get_mutable_obj5_short() { return obj5_short; }
        void set_obj5_short(const Short & value) { this->obj5_short = value; }

        const Signed & get_obj5_signed() const { return obj5_signed; }
        Signed & get_mutable_obj5_signed() { return obj5_signed; }
        void set_obj5_signed(const Signed & value) { this->obj5_signed = value; }

        const Sizeof & get_obj5_sizeof() const { return obj5_sizeof; }
        Sizeof & get_mutable_obj5_sizeof() { return obj5_sizeof; }
        void set_obj5_sizeof(const Sizeof & value) { this->obj5_sizeof = value; }

        const Static & get_obj5_static() const { return obj5_static; }
        Static & get_mutable_obj5_static() { return obj5_static; }
        void set_obj5_static(const Static & value) { this->obj5_static = value; }

        const StaticAssert & get_obj5_static_assert() const { return obj5_static_assert; }
        StaticAssert & get_mutable_obj5_static_assert() { return obj5_static_assert; }
        void set_obj5_static_assert(const StaticAssert & value) { this->obj5_static_assert = value; }

        const StaticCast & get_obj5_static_cast() const { return obj5_static_cast; }
        StaticCast & get_mutable_obj5_static_cast() { return obj5_static_cast; }
        void set_obj5_static_cast(const StaticCast & value) { this->obj5_static_cast = value; }

        const Struct & get_obj5_struct() const { return obj5_struct; }
        Struct & get_mutable_obj5_struct() { return obj5_struct; }
        void set_obj5_struct(const Struct & value) { this->obj5_struct = value; }

        const Switch & get_obj5_switch() const { return obj5_switch; }
        Switch & get_mutable_obj5_switch() { return obj5_switch; }
        void set_obj5_switch(const Switch & value) { this->obj5_switch = value; }

        const Synchronized & get_obj5_synchronized() const { return obj5_synchronized; }
        Synchronized & get_mutable_obj5_synchronized() { return obj5_synchronized; }
        void set_obj5_synchronized(const Synchronized & value) { this->obj5_synchronized = value; }

        const Template & get_obj5_template() const { return obj5_template; }
        Template & get_mutable_obj5_template() { return obj5_template; }
        void set_obj5_template(const Template & value) { this->obj5_template = value; }

        const This & get_obj5_this() const { return obj5_this; }
        This & get_mutable_obj5_this() { return obj5_this; }
        void set_obj5_this(const This & value) { this->obj5_this = value; }

        const ThreadLocal & get_obj5_thread_local() const { return obj5_thread_local; }
        ThreadLocal & get_mutable_obj5_thread_local() { return obj5_thread_local; }
        void set_obj5_thread_local(const ThreadLocal & value) { this->obj5_thread_local = value; }

        const Throw & get_obj5_throw() const { return obj5_throw; }
        Throw & get_mutable_obj5_throw() { return obj5_throw; }
        void set_obj5_throw(const Throw & value) { this->obj5_throw = value; }

        const True & get_obj5_true() const { return obj5_true; }
        True & get_mutable_obj5_true() { return obj5_true; }
        void set_obj5_true(const True & value) { this->obj5_true = value; }

        const PrimitiveKind & get_primitive_kind() const { return primitive_kind; }
        PrimitiveKind & get_mutable_primitive_kind() { return primitive_kind; }
        void set_primitive_kind(const PrimitiveKind & value) { this->primitive_kind = value; }

        const TrueClass & get_purple_true() const { return purple_true; }
        TrueClass & get_mutable_purple_true() { return purple_true; }
        void set_purple_true(const TrueClass & value) { this->purple_true = value; }

        const Repeat & get_repeat() const { return repeat; }
        Repeat & get_mutable_repeat() { return repeat; }
        void set_repeat(const Repeat & value) { this->repeat = value; }

        const Require & get_require() const { return require; }
        Require & get_mutable_require() { return require; }
        void set_require(const Require & value) { this->require = value; }

        const Required & get_required() const { return required; }
        Required & get_mutable_required() { return required; }
        void set_required(const Required & value) { this->required = value; }

        const Restrict & get_restrict() const { return restrict; }
        Restrict & get_mutable_restrict() { return restrict; }
        void set_restrict(const Restrict & value) { this->restrict = value; }

        const Retain & get_retain() const { return retain; }
        Retain & get_mutable_retain() { return retain; }
        void set_retain(const Retain & value) { this->retain = value; }

        const Rethrows & get_rethrows() const { return rethrows; }
        Rethrows & get_mutable_rethrows() { return rethrows; }
        void set_rethrows(const Rethrows & value) { this->rethrows = value; }

        const Right & get_right() const { return right; }
        Right & get_mutable_right() { return right; }
        void set_right(const Right & value) { this->right = value; }

        const RuntimeType & get_runtime_type() const { return runtime_type; }
        RuntimeType & get_mutable_runtime_type() { return runtime_type; }
        void set_runtime_type(const RuntimeType & value) { this->runtime_type = value; }

        const S & get_s() const { return s; }
        S & get_mutable_s() { return s; }
        void set_s(const S & value) { this->s = value; }

        const Sbyte & get_sbyte() const { return sbyte; }
        Sbyte & get_mutable_sbyte() { return sbyte; }
        void set_sbyte(const Sbyte & value) { this->sbyte = value; }

        const Sealed & get_sealed() const { return sealed; }
        Sealed & get_mutable_sealed() { return sealed; }
        void set_sealed(const Sealed & value) { this->sealed = value; }

        const Sel & get_sel() const { return sel; }
        Sel & get_mutable_sel() { return sel; }
        void set_sel(const Sel & value) { this->sel = value; }

        const Select & get_select() const { return select; }
        Select & get_mutable_select() { return select; }
        void set_select(const Select & value) { this->select = value; }

        const Self & get_self() const { return self; }
        Self & get_mutable_self() { return self; }
        void set_self(const Self & value) { this->self = value; }

        const Sendable & get_sendable() const { return sendable; }
        Sendable & get_mutable_sendable() { return sendable; }
        void set_sendable(const Sendable & value) { this->sendable = value; }

        const SerialDescriptor & get_serial_descriptor() const { return serial_descriptor; }
        SerialDescriptor & get_mutable_serial_descriptor() { return serial_descriptor; }
        void set_serial_descriptor(const SerialDescriptor & value) { this->serial_descriptor = value; }

        const SerialName & get_serial_name() const { return serial_name; }
        SerialName & get_mutable_serial_name() { return serial_name; }
        void set_serial_name(const SerialName & value) { this->serial_name = value; }

        const Serializable & get_serializable() const { return serializable; }
        Serializable & get_mutable_serializable() { return serializable; }
        void set_serializable(const Serializable & value) { this->serializable = value; }

        const SerializationFeature & get_serialization_feature() const { return serialization_feature; }
        SerializationFeature & get_mutable_serialization_feature() { return serialization_feature; }
        void set_serialization_feature(const SerializationFeature & value) { this->serialization_feature = value; }

        const Serialize & get_serialize() const { return serialize; }
        Serialize & get_mutable_serialize() { return serialize; }
        void set_serialize(const Serialize & value) { this->serialize = value; }

        const SerializerProvider & get_serializer_provider() const { return serializer_provider; }
        SerializerProvider & get_mutable_serializer_provider() { return serializer_provider; }
        void set_serializer_provider(const SerializerProvider & value) { this->serializer_provider = value; }

        const Set & get_set() const { return set; }
        Set & get_mutable_set() { return set; }
        void set_set(const Set & value) { this->set = value; }

        const SimpleModule & get_simple_module() const { return simple_module; }
        SimpleModule & get_mutable_simple_module() { return simple_module; }
        void set_simple_module(const SimpleModule & value) { this->simple_module = value; }

        const Stackalloc & get_stackalloc() const { return stackalloc; }
        Stackalloc & get_mutable_stackalloc() { return stackalloc; }
        void set_stackalloc(const Stackalloc & value) { this->stackalloc = value; }

        const Standards & get_standards() const { return standards; }
        Standards & get_mutable_standards() { return standards; }
        void set_standards(const Standards & value) { this->standards = value; }

        const StdDeserializer & get_std_deserializer() const { return std_deserializer; }
        StdDeserializer & get_mutable_std_deserializer() { return std_deserializer; }
        void set_std_deserializer(const StdDeserializer & value) { this->std_deserializer = value; }

        const StdSerializer & get_std_serializer() const { return std_serializer; }
        StdSerializer & get_mutable_std_serializer() { return std_serializer; }
        void set_std_serializer(const StdSerializer & value) { this->std_serializer = value; }

        const Strictfp & get_strictfp() const { return strictfp; }
        Strictfp & get_mutable_strictfp() { return strictfp; }
        void set_strictfp(const Strictfp & value) { this->strictfp = value; }

        const String & get_string() const { return string; }
        String & get_mutable_string() { return string; }
        void set_string(const String & value) { this->string = value; }

        const Subscript & get_subscript() const { return subscript; }
        Subscript & get_mutable_subscript() { return subscript; }
        void set_subscript(const Subscript & value) { this->subscript = value; }

        const Super & get_super() const { return super; }
        Super & get_mutable_super() { return super; }
        void set_super(const Super & value) { this->super = value; }

        const Symbol & get_symbol() const { return symbol; }
        Symbol & get_mutable_symbol() { return symbol; }
        void set_symbol(const Symbol & value) { this->symbol = value; }

        const System & get_system() const { return system; }
        System & get_mutable_system() { return system; }
        void set_system(const System & value) { this->system = value; }

        const TextNode & get_text_node() const { return text_node; }
        TextNode & get_mutable_text_node() { return text_node; }
        void set_text_node(const TextNode & value) { this->text_node = value; }

        const Then & get_then() const { return then; }
        Then & get_mutable_then() { return then; }
        void set_then(const Then & value) { this->then = value; }

        const Throws & get_throws() const { return throws; }
        Throws & get_mutable_throws() { return throws; }
        void set_throws(const Throws & value) { this->throws = value; }

        const TimeOnly & get_time_only() const { return time_only; }
        TimeOnly & get_mutable_time_only() { return time_only; }
        void set_time_only(const TimeOnly & value) { this->time_only = value; }

        const TimeOnlyConverter & get_time_only_converter() const { return time_only_converter; }
        TimeOnlyConverter & get_mutable_time_only_converter() { return time_only_converter; }
        void set_time_only_converter(const TimeOnlyConverter & value) { this->time_only_converter = value; }

        const TimeZone & get_time_zone() const { return time_zone; }
        TimeZone & get_mutable_time_zone() { return time_zone; }
        void set_time_zone(const TimeZone & value) { this->time_zone = value; }

        const ToDict & get_to_dict() const { return to_dict; }
        ToDict & get_mutable_to_dict() { return to_dict; }
        void set_to_dict(const ToDict & value) { this->to_dict = value; }

        const ToJson & get_to_json() const { return to_json; }
        ToJson & get_mutable_to_json() { return to_json; }
        void set_to_json(const ToJson & value) { this->to_json = value; }

        const ToString & get_to_string() const { return to_string; }
        ToString & get_mutable_to_string() { return to_string; }
        void set_to_string(const ToString & value) { this->to_string = value; }

        const TopLevelClass & get_top_level() const { return top_level; }
        TopLevelClass & get_mutable_top_level() { return top_level; }
        void set_top_level(const TopLevelClass & value) { this->top_level = value; }

        const Transient & get_transient() const { return transient; }
        Transient & get_mutable_transient() { return transient; }
        void set_transient(const Transient & value) { this->transient = value; }
    };

    class Try {
        public:
        Try() = default;
        virtual ~Try() = default;

        private:
        int64_t try_try;

        public:
        const int64_t & get_try_try() const { return try_try; }
        int64_t & get_mutable_try_try() { return try_try; }
        void set_try_try(const int64_t & value) { this->try_try = value; }
    };

    class TypeClass {
        public:
        TypeClass() = default;
        virtual ~TypeClass() = default;

        private:
        int64_t type;

        public:
        const int64_t & get_type() const { return type; }
        int64_t & get_mutable_type() { return type; }
        void set_type(const int64_t & value) { this->type = value; }
    };

    class Typedef {
        public:
        Typedef() = default;
        virtual ~Typedef() = default;

        private:
        int64_t typedef_typedef;

        public:
        const int64_t & get_typedef_typedef() const { return typedef_typedef; }
        int64_t & get_mutable_typedef_typedef() { return typedef_typedef; }
        void set_typedef_typedef(const int64_t & value) { this->typedef_typedef = value; }
    };

    class Typeid {
        public:
        Typeid() = default;
        virtual ~Typeid() = default;

        private:
        int64_t typeid_typeid;

        public:
        const int64_t & get_typeid_typeid() const { return typeid_typeid; }
        int64_t & get_mutable_typeid_typeid() { return typeid_typeid; }
        void set_typeid_typeid(const int64_t & value) { this->typeid_typeid = value; }
    };

    class Typename {
        public:
        Typename() = default;
        virtual ~Typename() = default;

        private:
        int64_t typename_typename;

        public:
        const int64_t & get_typename_typename() const { return typename_typename; }
        int64_t & get_mutable_typename_typename() { return typename_typename; }
        void set_typename_typename(const int64_t & value) { this->typename_typename = value; }
    };

    class Union {
        public:
        Union() = default;
        virtual ~Union() = default;

        private:
        int64_t union_union;

        public:
        const int64_t & get_union_union() const { return union_union; }
        int64_t & get_mutable_union_union() { return union_union; }
        void set_union_union(const int64_t & value) { this->union_union = value; }
    };

    class Unsigned {
        public:
        Unsigned() = default;
        virtual ~Unsigned() = default;

        private:
        int64_t unsigned_unsigned;

        public:
        const int64_t & get_unsigned_unsigned() const { return unsigned_unsigned; }
        int64_t & get_mutable_unsigned_unsigned() { return unsigned_unsigned; }
        void set_unsigned_unsigned(const int64_t & value) { this->unsigned_unsigned = value; }
    };

    class Using {
        public:
        Using() = default;
        virtual ~Using() = default;

        private:
        int64_t using_using;

        public:
        const int64_t & get_using_using() const { return using_using; }
        int64_t & get_mutable_using_using() { return using_using; }
        void set_using_using(const int64_t & value) { this->using_using = value; }
    };

    class Virtual {
        public:
        Virtual() = default;
        virtual ~Virtual() = default;

        private:
        int64_t virtual_virtual;

        public:
        const int64_t & get_virtual_virtual() const { return virtual_virtual; }
        int64_t & get_mutable_virtual_virtual() { return virtual_virtual; }
        void set_virtual_virtual(const int64_t & value) { this->virtual_virtual = value; }
    };

    class Void {
        public:
        Void() = default;
        virtual ~Void() = default;

        private:
        int64_t void_void;

        public:
        const int64_t & get_void_void() const { return void_void; }
        int64_t & get_mutable_void_void() { return void_void; }
        void set_void_void(const int64_t & value) { this->void_void = value; }
    };

    class Volatile {
        public:
        Volatile() = default;
        virtual ~Volatile() = default;

        private:
        int64_t volatile_volatile;

        public:
        const int64_t & get_volatile_volatile() const { return volatile_volatile; }
        int64_t & get_mutable_volatile_volatile() { return volatile_volatile; }
        void set_volatile_volatile(const int64_t & value) { this->volatile_volatile = value; }
    };

    class WcharT {
        public:
        WcharT() = default;
        virtual ~WcharT() = default;

        private:
        int64_t wchar_t_wchar_t;

        public:
        const int64_t & get_wchar_t_wchar_t() const { return wchar_t_wchar_t; }
        int64_t & get_mutable_wchar_t_wchar_t() { return wchar_t_wchar_t; }
        void set_wchar_t_wchar_t(const int64_t & value) { this->wchar_t_wchar_t = value; }
    };

    class While {
        public:
        While() = default;
        virtual ~While() = default;

        private:
        int64_t while_while;

        public:
        const int64_t & get_while_while() const { return while_while; }
        int64_t & get_mutable_while_while() { return while_while; }
        void set_while_while(const int64_t & value) { this->while_while = value; }
    };

    class Xor {
        public:
        Xor() = default;
        virtual ~Xor() = default;

        private:
        int64_t xor_xor;

        public:
        const int64_t & get_xor_xor() const { return xor_xor; }
        int64_t & get_mutable_xor_xor() { return xor_xor; }
        void set_xor_xor(const int64_t & value) { this->xor_xor = value; }
    };

    class XorEq {
        public:
        XorEq() = default;
        virtual ~XorEq() = default;

        private:
        int64_t xor_eq_xor_eq;

        public:
        const int64_t & get_xor_eq_xor_eq() const { return xor_eq_xor_eq; }
        int64_t & get_mutable_xor_eq_xor_eq() { return xor_eq_xor_eq; }
        void set_xor_eq_xor_eq(const int64_t & value) { this->xor_eq_xor_eq = value; }
    };

    class Type {
        public:
        Type() = default;
        virtual ~Type() = default;

        private:
        int64_t type;

        public:
        const int64_t & get_type() const { return type; }
        int64_t & get_mutable_type() { return type; }
        void set_type(const int64_t & value) { this->type = value; }
    };

    class Typealias {
        public:
        Typealias() = default;
        virtual ~Typealias() = default;

        private:
        int64_t typealias;

        public:
        const int64_t & get_typealias() const { return typealias; }
        int64_t & get_mutable_typealias() { return typealias; }
        void set_typealias(const int64_t & value) { this->typealias = value; }
    };

    class Typeof {
        public:
        Typeof() = default;
        virtual ~Typeof() = default;

        private:
        int64_t typeof;

        public:
        const int64_t & get_typeof() const { return typeof; }
        int64_t & get_mutable_typeof() { return typeof; }
        void set_typeof(const int64_t & value) { this->typeof = value; }
    };

    class Uint {
        public:
        Uint() = default;
        virtual ~Uint() = default;

        private:
        int64_t uint;

        public:
        const int64_t & get_uint() const { return uint; }
        int64_t & get_mutable_uint() { return uint; }
        void set_uint(const int64_t & value) { this->uint = value; }
    };

    class Ulong {
        public:
        Ulong() = default;
        virtual ~Ulong() = default;

        private:
        int64_t ulong;

        public:
        const int64_t & get_ulong() const { return ulong; }
        int64_t & get_mutable_ulong() { return ulong; }
        void set_ulong(const int64_t & value) { this->ulong = value; }
    };

    class Unchecked {
        public:
        Unchecked() = default;
        virtual ~Unchecked() = default;

        private:
        int64_t unchecked;

        public:
        const int64_t & get_unchecked() const { return unchecked; }
        int64_t & get_mutable_unchecked() { return unchecked; }
        void set_unchecked(const int64_t & value) { this->unchecked = value; }
    };

    class Undefined {
        public:
        Undefined() = default;
        virtual ~Undefined() = default;

        private:
        int64_t undefined;

        public:
        const int64_t & get_undefined() const { return undefined; }
        int64_t & get_mutable_undefined() { return undefined; }
        void set_undefined(const int64_t & value) { this->undefined = value; }
    };

    class UnmarshalJson {
        public:
        UnmarshalJson() = default;
        virtual ~UnmarshalJson() = default;

        private:
        int64_t unmarshal_json;

        public:
        const int64_t & get_unmarshal_json() const { return unmarshal_json; }
        int64_t & get_mutable_unmarshal_json() { return unmarshal_json; }
        void set_unmarshal_json(const int64_t & value) { this->unmarshal_json = value; }
    };

    class Unowned {
        public:
        Unowned() = default;
        virtual ~Unowned() = default;

        private:
        int64_t unowned;

        public:
        const int64_t & get_unowned() const { return unowned; }
        int64_t & get_mutable_unowned() { return unowned; }
        void set_unowned(const int64_t & value) { this->unowned = value; }
    };

    class Unsafe {
        public:
        Unsafe() = default;
        virtual ~Unsafe() = default;

        private:
        int64_t unsafe;

        public:
        const int64_t & get_unsafe() const { return unsafe; }
        int64_t & get_mutable_unsafe() { return unsafe; }
        void set_unsafe(const int64_t & value) { this->unsafe = value; }
    };

    class UseSerializers {
        public:
        UseSerializers() = default;
        virtual ~UseSerializers() = default;

        private:
        int64_t use_serializers;

        public:
        const int64_t & get_use_serializers() const { return use_serializers; }
        int64_t & get_mutable_use_serializers() { return use_serializers; }
        void set_use_serializers(const int64_t & value) { this->use_serializers = value; }
    };

    class Ushort {
        public:
        Ushort() = default;
        virtual ~Ushort() = default;

        private:
        int64_t ushort;

        public:
        const int64_t & get_ushort() const { return ushort; }
        int64_t & get_mutable_ushort() { return ushort; }
        void set_ushort(const int64_t & value) { this->ushort = value; }
    };

    class Utf8JsonReader {
        public:
        Utf8JsonReader() = default;
        virtual ~Utf8JsonReader() = default;

        private:
        int64_t utf8_json_reader;

        public:
        const int64_t & get_utf8_json_reader() const { return utf8_json_reader; }
        int64_t & get_mutable_utf8_json_reader() { return utf8_json_reader; }
        void set_utf8_json_reader(const int64_t & value) { this->utf8_json_reader = value; }
    };

    class Utf8JsonWriter {
        public:
        Utf8JsonWriter() = default;
        virtual ~Utf8JsonWriter() = default;

        private:
        int64_t utf8_json_writer;

        public:
        const int64_t & get_utf8_json_writer() const { return utf8_json_writer; }
        int64_t & get_mutable_utf8_json_writer() { return utf8_json_writer; }
        void set_utf8_json_writer(const int64_t & value) { this->utf8_json_writer = value; }
    };

    class Uuid {
        public:
        Uuid() = default;
        virtual ~Uuid() = default;

        private:
        int64_t uuid;

        public:
        const int64_t & get_uuid() const { return uuid; }
        int64_t & get_mutable_uuid() { return uuid; }
        void set_uuid(const int64_t & value) { this->uuid = value; }
    };

    class Var {
        public:
        Var() = default;
        virtual ~Var() = default;

        private:
        int64_t var;

        public:
        const int64_t & get_var() const { return var; }
        int64_t & get_mutable_var() { return var; }
        void set_var(const int64_t & value) { this->var = value; }
    };

    class Weak {
        public:
        Weak() = default;
        virtual ~Weak() = default;

        private:
        int64_t weak;

        public:
        const int64_t & get_weak() const { return weak; }
        int64_t & get_mutable_weak() { return weak; }
        void set_weak(const int64_t & value) { this->weak = value; }
    };

    class Where {
        public:
        Where() = default;
        virtual ~Where() = default;

        private:
        int64_t where;

        public:
        const int64_t & get_where() const { return where; }
        int64_t & get_mutable_where() { return where; }
        void set_where(const int64_t & value) { this->where = value; }
    };

    class WillSet {
        public:
        WillSet() = default;
        virtual ~WillSet() = default;

        private:
        int64_t will_set;

        public:
        const int64_t & get_will_set() const { return will_set; }
        int64_t & get_mutable_will_set() { return will_set; }
        void set_will_set(const int64_t & value) { this->will_set = value; }
    };

    class With {
        public:
        With() = default;
        virtual ~With() = default;

        private:
        int64_t with;

        public:
        const int64_t & get_with() const { return with; }
        int64_t & get_mutable_with() { return with; }
        void set_with(const int64_t & value) { this->with = value; }
    };

    class Yes {
        public:
        Yes() = default;
        virtual ~Yes() = default;

        private:
        int64_t yes;

        public:
        const int64_t & get_yes() const { return yes; }
        int64_t & get_mutable_yes() { return yes; }
        void set_yes(const int64_t & value) { this->yes = value; }
    };

    class Yield {
        public:
        Yield() = default;
        virtual ~Yield() = default;

        private:
        int64_t yield;

        public:
        const int64_t & get_yield() const { return yield; }
        int64_t & get_mutable_yield() { return yield; }
        void set_yield(const int64_t & value) { this->yield = value; }
    };

    class Obj6 {
        public:
        Obj6() = default;
        virtual ~Obj6() = default;

        private:
        int64_t dummy;
        Try obj6_try;
        TypeClass obj6_type;
        Typedef obj6_typedef;
        Typeid obj6_typeid;
        Typename obj6_typename;
        Union obj6_union;
        Unsigned obj6_unsigned;
        Using obj6_using;
        Virtual obj6_virtual;
        Void obj6_void;
        Volatile obj6_volatile;
        WcharT obj6_wchar_t;
        While obj6_while;
        Xor obj6_xor;
        XorEq obj6_xor_eq;
        Type type;
        Typealias typealias;
        Typeof typeof;
        Uint uint;
        Ulong ulong;
        Unchecked unchecked;
        Undefined undefined;
        UnmarshalJson unmarshal_json;
        Unowned unowned;
        Unsafe unsafe;
        UseSerializers use_serializers;
        Ushort ushort;
        Utf8JsonReader utf8_json_reader;
        Utf8JsonWriter utf8_json_writer;
        Uuid uuid;
        Var var;
        Weak weak;
        Where where;
        WillSet will_set;
        With with;
        Yes yes;
        Yield yield;

        public:
        const int64_t & get_dummy() const { return dummy; }
        int64_t & get_mutable_dummy() { return dummy; }
        void set_dummy(const int64_t & value) { this->dummy = value; }

        const Try & get_obj6_try() const { return obj6_try; }
        Try & get_mutable_obj6_try() { return obj6_try; }
        void set_obj6_try(const Try & value) { this->obj6_try = value; }

        const TypeClass & get_obj6_type() const { return obj6_type; }
        TypeClass & get_mutable_obj6_type() { return obj6_type; }
        void set_obj6_type(const TypeClass & value) { this->obj6_type = value; }

        const Typedef & get_obj6_typedef() const { return obj6_typedef; }
        Typedef & get_mutable_obj6_typedef() { return obj6_typedef; }
        void set_obj6_typedef(const Typedef & value) { this->obj6_typedef = value; }

        const Typeid & get_obj6_typeid() const { return obj6_typeid; }
        Typeid & get_mutable_obj6_typeid() { return obj6_typeid; }
        void set_obj6_typeid(const Typeid & value) { this->obj6_typeid = value; }

        const Typename & get_obj6_typename() const { return obj6_typename; }
        Typename & get_mutable_obj6_typename() { return obj6_typename; }
        void set_obj6_typename(const Typename & value) { this->obj6_typename = value; }

        const Union & get_obj6_union() const { return obj6_union; }
        Union & get_mutable_obj6_union() { return obj6_union; }
        void set_obj6_union(const Union & value) { this->obj6_union = value; }

        const Unsigned & get_obj6_unsigned() const { return obj6_unsigned; }
        Unsigned & get_mutable_obj6_unsigned() { return obj6_unsigned; }
        void set_obj6_unsigned(const Unsigned & value) { this->obj6_unsigned = value; }

        const Using & get_obj6_using() const { return obj6_using; }
        Using & get_mutable_obj6_using() { return obj6_using; }
        void set_obj6_using(const Using & value) { this->obj6_using = value; }

        const Virtual & get_obj6_virtual() const { return obj6_virtual; }
        Virtual & get_mutable_obj6_virtual() { return obj6_virtual; }
        void set_obj6_virtual(const Virtual & value) { this->obj6_virtual = value; }

        const Void & get_obj6_void() const { return obj6_void; }
        Void & get_mutable_obj6_void() { return obj6_void; }
        void set_obj6_void(const Void & value) { this->obj6_void = value; }

        const Volatile & get_obj6_volatile() const { return obj6_volatile; }
        Volatile & get_mutable_obj6_volatile() { return obj6_volatile; }
        void set_obj6_volatile(const Volatile & value) { this->obj6_volatile = value; }

        const WcharT & get_obj6_wchar_t() const { return obj6_wchar_t; }
        WcharT & get_mutable_obj6_wchar_t() { return obj6_wchar_t; }
        void set_obj6_wchar_t(const WcharT & value) { this->obj6_wchar_t = value; }

        const While & get_obj6_while() const { return obj6_while; }
        While & get_mutable_obj6_while() { return obj6_while; }
        void set_obj6_while(const While & value) { this->obj6_while = value; }

        const Xor & get_obj6_xor() const { return obj6_xor; }
        Xor & get_mutable_obj6_xor() { return obj6_xor; }
        void set_obj6_xor(const Xor & value) { this->obj6_xor = value; }

        const XorEq & get_obj6_xor_eq() const { return obj6_xor_eq; }
        XorEq & get_mutable_obj6_xor_eq() { return obj6_xor_eq; }
        void set_obj6_xor_eq(const XorEq & value) { this->obj6_xor_eq = value; }

        const Type & get_type() const { return type; }
        Type & get_mutable_type() { return type; }
        void set_type(const Type & value) { this->type = value; }

        const Typealias & get_typealias() const { return typealias; }
        Typealias & get_mutable_typealias() { return typealias; }
        void set_typealias(const Typealias & value) { this->typealias = value; }

        const Typeof & get_typeof() const { return typeof; }
        Typeof & get_mutable_typeof() { return typeof; }
        void set_typeof(const Typeof & value) { this->typeof = value; }

        const Uint & get_uint() const { return uint; }
        Uint & get_mutable_uint() { return uint; }
        void set_uint(const Uint & value) { this->uint = value; }

        const Ulong & get_ulong() const { return ulong; }
        Ulong & get_mutable_ulong() { return ulong; }
        void set_ulong(const Ulong & value) { this->ulong = value; }

        const Unchecked & get_unchecked() const { return unchecked; }
        Unchecked & get_mutable_unchecked() { return unchecked; }
        void set_unchecked(const Unchecked & value) { this->unchecked = value; }

        const Undefined & get_undefined() const { return undefined; }
        Undefined & get_mutable_undefined() { return undefined; }
        void set_undefined(const Undefined & value) { this->undefined = value; }

        const UnmarshalJson & get_unmarshal_json() const { return unmarshal_json; }
        UnmarshalJson & get_mutable_unmarshal_json() { return unmarshal_json; }
        void set_unmarshal_json(const UnmarshalJson & value) { this->unmarshal_json = value; }

        const Unowned & get_unowned() const { return unowned; }
        Unowned & get_mutable_unowned() { return unowned; }
        void set_unowned(const Unowned & value) { this->unowned = value; }

        const Unsafe & get_unsafe() const { return unsafe; }
        Unsafe & get_mutable_unsafe() { return unsafe; }
        void set_unsafe(const Unsafe & value) { this->unsafe = value; }

        const UseSerializers & get_use_serializers() const { return use_serializers; }
        UseSerializers & get_mutable_use_serializers() { return use_serializers; }
        void set_use_serializers(const UseSerializers & value) { this->use_serializers = value; }

        const Ushort & get_ushort() const { return ushort; }
        Ushort & get_mutable_ushort() { return ushort; }
        void set_ushort(const Ushort & value) { this->ushort = value; }

        const Utf8JsonReader & get_utf8_json_reader() const { return utf8_json_reader; }
        Utf8JsonReader & get_mutable_utf8_json_reader() { return utf8_json_reader; }
        void set_utf8_json_reader(const Utf8JsonReader & value) { this->utf8_json_reader = value; }

        const Utf8JsonWriter & get_utf8_json_writer() const { return utf8_json_writer; }
        Utf8JsonWriter & get_mutable_utf8_json_writer() { return utf8_json_writer; }
        void set_utf8_json_writer(const Utf8JsonWriter & value) { this->utf8_json_writer = value; }

        const Uuid & get_uuid() const { return uuid; }
        Uuid & get_mutable_uuid() { return uuid; }
        void set_uuid(const Uuid & value) { this->uuid = value; }

        const Var & get_var() const { return var; }
        Var & get_mutable_var() { return var; }
        void set_var(const Var & value) { this->var = value; }

        const Weak & get_weak() const { return weak; }
        Weak & get_mutable_weak() { return weak; }
        void set_weak(const Weak & value) { this->weak = value; }

        const Where & get_where() const { return where; }
        Where & get_mutable_where() { return where; }
        void set_where(const Where & value) { this->where = value; }

        const WillSet & get_will_set() const { return will_set; }
        WillSet & get_mutable_will_set() { return will_set; }
        void set_will_set(const WillSet & value) { this->will_set = value; }

        const With & get_with() const { return with; }
        With & get_mutable_with() { return with; }
        void set_with(const With & value) { this->with = value; }

        const Yes & get_yes() const { return yes; }
        Yes & get_mutable_yes() { return yes; }
        void set_yes(const Yes & value) { this->yes = value; }

        const Yield & get_yield() const { return yield; }
        Yield & get_mutable_yield() { return yield; }
        void set_yield(const Yield & value) { this->yield = value; }
    };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        int64_t dummy;
        Obj1 obj1;
        Obj2 obj2;
        Obj3 obj3;
        Obj4 obj4;
        Obj5 obj5;
        Obj6 obj6;

        public:
        const int64_t & get_dummy() const { return dummy; }
        int64_t & get_mutable_dummy() { return dummy; }
        void set_dummy(const int64_t & value) { this->dummy = value; }

        const Obj1 & get_obj1() const { return obj1; }
        Obj1 & get_mutable_obj1() { return obj1; }
        void set_obj1(const Obj1 & value) { this->obj1 = value; }

        const Obj2 & get_obj2() const { return obj2; }
        Obj2 & get_mutable_obj2() { return obj2; }
        void set_obj2(const Obj2 & value) { this->obj2 = value; }

        const Obj3 & get_obj3() const { return obj3; }
        Obj3 & get_mutable_obj3() { return obj3; }
        void set_obj3(const Obj3 & value) { this->obj3 = value; }

        const Obj4 & get_obj4() const { return obj4; }
        Obj4 & get_mutable_obj4() { return obj4; }
        void set_obj4(const Obj4 & value) { this->obj4 = value; }

        const Obj5 & get_obj5() const { return obj5; }
        Obj5 & get_mutable_obj5() { return obj5; }
        void set_obj5(const Obj5 & value) { this->obj5 = value; }

        const Obj6 & get_obj6() const { return obj6; }
        Obj6 & get_mutable_obj6() { return obj6; }
        void set_obj6(const Obj6 & value) { this->obj6 = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, Abstract & x);
    void to_json(json & j, const Abstract & x);

    void from_json(const json & j, Any & x);
    void to_json(json & j, const Any & x);

    void from_json(const json & j, Array & x);
    void to_json(json & j, const Array & x);

    void from_json(const json & j, ArrayNode & x);
    void to_json(json & j, const ArrayNode & x);

    void from_json(const json & j, As & x);
    void to_json(json & j, const As & x);

    void from_json(const json & j, Assert & x);
    void to_json(json & j, const Assert & x);

    void from_json(const json & j, Associatedtype & x);
    void to_json(json & j, const Associatedtype & x);

    void from_json(const json & j, Associativity & x);
    void to_json(json & j, const Associativity & x);

    void from_json(const json & j, Async & x);
    void to_json(json & j, const Async & x);

    void from_json(const json & j, Atomic & x);
    void to_json(json & j, const Atomic & x);

    void from_json(const json & j, Await & x);
    void to_json(json & j, const Await & x);

    void from_json(const json & j, Base & x);
    void to_json(json & j, const Base & x);

    void from_json(const json & j, Boolean & x);
    void to_json(json & j, const Boolean & x);

    void from_json(const json & j, BooleanNode & x);
    void to_json(json & j, const BooleanNode & x);

    void from_json(const json & j, Bycopy & x);
    void to_json(json & j, const Bycopy & x);

    void from_json(const json & j, Byref & x);
    void to_json(json & j, const Byref & x);

    void from_json(const json & j, Byte & x);
    void to_json(json & j, const Byte & x);

    void from_json(const json & j, Calendar & x);
    void to_json(json & j, const Calendar & x);

    void from_json(const json & j, Chan & x);
    void to_json(json & j, const Chan & x);

    void from_json(const json & j, Checked & x);
    void to_json(json & j, const Checked & x);

    void from_json(const json & j, Clone & x);
    void to_json(json & j, const Clone & x);

    void from_json(const json & j, Codable & x);
    void to_json(json & j, const Codable & x);

    void from_json(const json & j, CodingKey & x);
    void to_json(json & j, const CodingKey & x);

    void from_json(const json & j, CodingKeys & x);
    void to_json(json & j, const CodingKeys & x);

    void from_json(const json & j, Complex & x);
    void to_json(json & j, const Complex & x);

    void from_json(const json & j, Console & x);
    void to_json(json & j, const Console & x);

    void from_json(const json & j, Constructor & x);
    void to_json(json & j, const Constructor & x);

    void from_json(const json & j, Convenience & x);
    void to_json(json & j, const Convenience & x);

    void from_json(const json & j, Convert & x);
    void to_json(json & j, const Convert & x);

    void from_json(const json & j, Converter & x);
    void to_json(json & j, const Converter & x);

    void from_json(const json & j, Empty & x);
    void to_json(json & j, const Empty & x);

    void from_json(const json & j, Obj1Bool & x);
    void to_json(json & j, const Obj1Bool & x);

    void from_json(const json & j, Imaginery & x);
    void to_json(json & j, const Imaginery & x);

    void from_json(const json & j, Alignas & x);
    void to_json(json & j, const Alignas & x);

    void from_json(const json & j, Alignof & x);
    void to_json(json & j, const Alignof & x);

    void from_json(const json & j, And & x);
    void to_json(json & j, const And & x);

    void from_json(const json & j, AndEq & x);
    void to_json(json & j, const AndEq & x);

    void from_json(const json & j, AnyClass & x);
    void to_json(json & j, const AnyClass & x);

    void from_json(const json & j, Asm & x);
    void to_json(json & j, const Asm & x);

    void from_json(const json & j, AtomicCancel & x);
    void to_json(json & j, const AtomicCancel & x);

    void from_json(const json & j, AtomicCommit & x);
    void to_json(json & j, const AtomicCommit & x);

    void from_json(const json & j, AtomicNoexcept & x);
    void to_json(json & j, const AtomicNoexcept & x);

    void from_json(const json & j, Auto & x);
    void to_json(json & j, const Auto & x);

    void from_json(const json & j, Bitand & x);
    void to_json(json & j, const Bitand & x);

    void from_json(const json & j, Bitor & x);
    void to_json(json & j, const Bitor & x);

    void from_json(const json & j, Bool & x);
    void to_json(json & j, const Bool & x);

    void from_json(const json & j, Break & x);
    void to_json(json & j, const Break & x);

    void from_json(const json & j, Case & x);
    void to_json(json & j, const Case & x);

    void from_json(const json & j, Catch & x);
    void to_json(json & j, const Catch & x);

    void from_json(const json & j, Char & x);
    void to_json(json & j, const Char & x);

    void from_json(const json & j, Char16T & x);
    void to_json(json & j, const Char16T & x);

    void from_json(const json & j, Char32T & x);
    void to_json(json & j, const Char32T & x);

    void from_json(const json & j, Class & x);
    void to_json(json & j, const Class & x);

    void from_json(const json & j, CoAwait & x);
    void to_json(json & j, const CoAwait & x);

    void from_json(const json & j, CoReturn & x);
    void to_json(json & j, const CoReturn & x);

    void from_json(const json & j, CoYield & x);
    void to_json(json & j, const CoYield & x);

    void from_json(const json & j, Compl & x);
    void to_json(json & j, const Compl & x);

    void from_json(const json & j, Concept & x);
    void to_json(json & j, const Concept & x);

    void from_json(const json & j, Const & x);
    void to_json(json & j, const Const & x);

    void from_json(const json & j, ConstCast & x);
    void to_json(json & j, const ConstCast & x);

    void from_json(const json & j, Constexpr & x);
    void to_json(json & j, const Constexpr & x);

    void from_json(const json & j, Continue & x);
    void to_json(json & j, const Continue & x);

    void from_json(const json & j, BoolClass & x);
    void to_json(json & j, const BoolClass & x);

    void from_json(const json & j, ClassClass & x);
    void to_json(json & j, const ClassClass & x);

    void from_json(const json & j, Obj1 & x);
    void to_json(json & j, const Obj1 & x);

    void from_json(const json & j, CultureInfo & x);
    void to_json(json & j, const CultureInfo & x);

    void from_json(const json & j, Date & x);
    void to_json(json & j, const Date & x);

    void from_json(const json & j, DateFormatter & x);
    void to_json(json & j, const DateFormatter & x);

    void from_json(const json & j, DateOnly & x);
    void to_json(json & j, const DateOnly & x);

    void from_json(const json & j, DateOnlyConverter & x);
    void to_json(json & j, const DateOnlyConverter & x);

    void from_json(const json & j, DateParseHandling & x);
    void to_json(json & j, const DateParseHandling & x);

    void from_json(const json & j, DateTime & x);
    void to_json(json & j, const DateTime & x);

    void from_json(const json & j, DateTimeStyles & x);
    void to_json(json & j, const DateTimeStyles & x);

    void from_json(const json & j, Debugger & x);
    void to_json(json & j, const Debugger & x);

    void from_json(const json & j, Decimal & x);
    void to_json(json & j, const Decimal & x);

    void from_json(const json & j, Declare & x);
    void to_json(json & j, const Declare & x);

    void from_json(const json & j, DecodeString & x);
    void to_json(json & j, const DecodeString & x);

    void from_json(const json & j, Decoder & x);
    void to_json(json & j, const Decoder & x);

    void from_json(const json & j, DecodingError & x);
    void to_json(json & j, const DecodingError & x);

    void from_json(const json & j, Def & x);
    void to_json(json & j, const Def & x);

    void from_json(const json & j, Defer & x);
    void to_json(json & j, const Defer & x);

    void from_json(const json & j, Deinit & x);
    void to_json(json & j, const Deinit & x);

    void from_json(const json & j, Del & x);
    void to_json(json & j, const Del & x);

    void from_json(const json & j, Delegate & x);
    void to_json(json & j, const Delegate & x);

    void from_json(const json & j, DeserializationFeature & x);
    void to_json(json & j, const DeserializationFeature & x);

    void from_json(const json & j, Dict & x);
    void to_json(json & j, const Dict & x);

    void from_json(const json & j, Dictionary & x);
    void to_json(json & j, const Dictionary & x);

    void from_json(const json & j, DidSet & x);
    void to_json(json & j, const DidSet & x);

    void from_json(const json & j, DoubleNode & x);
    void to_json(json & j, const DoubleNode & x);

    void from_json(const json & j, Dynamic & x);
    void to_json(json & j, const Dynamic & x);

    void from_json(const json & j, Elif & x);
    void to_json(json & j, const Elif & x);

    void from_json(const json & j, EncodeQuickType & x);
    void to_json(json & j, const EncodeQuickType & x);

    void from_json(const json & j, Encoder & x);
    void to_json(json & j, const Encoder & x);

    void from_json(const json & j, EnumValues & x);
    void to_json(json & j, const EnumValues & x);

    void from_json(const json & j, EqualityContract & x);
    void to_json(json & j, const EqualityContract & x);

    void from_json(const json & j, Equatable & x);
    void to_json(json & j, const Equatable & x);

    void from_json(const json & j, Event & x);
    void to_json(json & j, const Event & x);

    void from_json(const json & j, Except & x);
    void to_json(json & j, const Except & x);

    void from_json(const json & j, Exception & x);
    void to_json(json & j, const Exception & x);

    void from_json(const json & j, Exposing & x);
    void to_json(json & j, const Exposing & x);

    void from_json(const json & j, Extends & x);
    void to_json(json & j, const Extends & x);

    void from_json(const json & j, Extension & x);
    void to_json(json & j, const Extension & x);

    void from_json(const json & j, Fallthrough & x);
    void to_json(json & j, const Fallthrough & x);

    void from_json(const json & j, Fileprivate & x);
    void to_json(json & j, const Fileprivate & x);

    void from_json(const json & j, Finally & x);
    void to_json(json & j, const Finally & x);

    void from_json(const json & j, Fixed & x);
    void to_json(json & j, const Fixed & x);

    void from_json(const json & j, Foreach & x);
    void to_json(json & j, const Foreach & x);

    void from_json(const json & j, FormatException & x);
    void to_json(json & j, const FormatException & x);

    void from_json(const json & j, From & x);
    void to_json(json & j, const From & x);

    void from_json(const json & j, FromDict & x);
    void to_json(json & j, const FromDict & x);

    void from_json(const json & j, FromJson & x);
    void to_json(json & j, const FromJson & x);

    void from_json(const json & j, Func & x);
    void to_json(json & j, const Func & x);

    void from_json(const json & j, Decltype & x);
    void to_json(json & j, const Decltype & x);

    void from_json(const json & j, Default & x);
    void to_json(json & j, const Default & x);

    void from_json(const json & j, Delete & x);
    void to_json(json & j, const Delete & x);

    void from_json(const json & j, Do & x);
    void to_json(json & j, const Do & x);

    void from_json(const json & j, Double & x);
    void to_json(json & j, const Double & x);

    void from_json(const json & j, DynamicCast & x);
    void to_json(json & j, const DynamicCast & x);

    void from_json(const json & j, Else & x);
    void to_json(json & j, const Else & x);

    void from_json(const json & j, Enum & x);
    void to_json(json & j, const Enum & x);

    void from_json(const json & j, Explicit & x);
    void to_json(json & j, const Explicit & x);

    void from_json(const json & j, Export & x);
    void to_json(json & j, const Export & x);

    void from_json(const json & j, Extern & x);
    void to_json(json & j, const Extern & x);

    void from_json(const json & j, False & x);
    void to_json(json & j, const False & x);

    void from_json(const json & j, Final & x);
    void to_json(json & j, const Final & x);

    void from_json(const json & j, Float & x);
    void to_json(json & j, const Float & x);

    void from_json(const json & j, For & x);
    void to_json(json & j, const For & x);

    void from_json(const json & j, Friend & x);
    void to_json(json & j, const Friend & x);

    void from_json(const json & j, FalseClass & x);
    void to_json(json & j, const FalseClass & x);

    void from_json(const json & j, Obj2 & x);
    void to_json(json & j, const Obj2 & x);

    void from_json(const json & j, Function & x);
    void to_json(json & j, const Function & x);

    void from_json(const json & j, Get & x);
    void to_json(json & j, const Get & x);

    void from_json(const json & j, Global & x);
    void to_json(json & j, const Global & x);

    void from_json(const json & j, Go & x);
    void to_json(json & j, const Go & x);

    void from_json(const json & j, Guard & x);
    void to_json(json & j, const Guard & x);

    void from_json(const json & j, HasOwnProperty & x);
    void to_json(json & j, const HasOwnProperty & x);

    void from_json(const json & j, HashCode & x);
    void to_json(json & j, const HashCode & x);

    void from_json(const json & j, Hashable & x);
    void to_json(json & j, const Hashable & x);

    void from_json(const json & j, Hasher & x);
    void to_json(json & j, const Hasher & x);

    void from_json(const json & j, Id & x);
    void to_json(json & j, const Id & x);

    void from_json(const json & j, Imp & x);
    void to_json(json & j, const Imp & x);

    void from_json(const json & j, Implements & x);
    void to_json(json & j, const Implements & x);

    void from_json(const json & j, Implicit & x);
    void to_json(json & j, const Implicit & x);

    void from_json(const json & j, In & x);
    void to_json(json & j, const In & x);

    void from_json(const json & j, Indirect & x);
    void to_json(json & j, const Indirect & x);

    void from_json(const json & j, Infix & x);
    void to_json(json & j, const Infix & x);

    void from_json(const json & j, Init & x);
    void to_json(json & j, const Init & x);

    void from_json(const json & j, Inout & x);
    void to_json(json & j, const Inout & x);

    void from_json(const json & j, Instanceof & x);
    void to_json(json & j, const Instanceof & x);

    void from_json(const json & j, IntNode & x);
    void to_json(json & j, const IntNode & x);

    void from_json(const json & j, Interface & x);
    void to_json(json & j, const Interface & x);

    void from_json(const json & j, Internal & x);
    void to_json(json & j, const Internal & x);

    void from_json(const json & j, Is & x);
    void to_json(json & j, const Is & x);

    void from_json(const json & j, IsoDateTimeOffsetConverter & x);
    void to_json(json & j, const IsoDateTimeOffsetConverter & x);

    void from_json(const json & j, Iterable & x);
    void to_json(json & j, const Iterable & x);

    void from_json(const json & j, Jdec & x);
    void to_json(json & j, const Jdec & x);

    void from_json(const json & j, Jenc & x);
    void to_json(json & j, const Jenc & x);

    void from_json(const json & j, Jpipe & x);
    void to_json(json & j, const Jpipe & x);

    void from_json(const json & j, Json & x);
    void to_json(json & j, const Json & x);

    void from_json(const json & j, JsonAny & x);
    void to_json(json & j, const JsonAny & x);

    void from_json(const json & j, JsonCodingKey & x);
    void to_json(json & j, const JsonCodingKey & x);

    void from_json(const json & j, JsonConverter & x);
    void to_json(json & j, const JsonConverter & x);

    void from_json(const json & j, JsonDecoder & x);
    void to_json(json & j, const JsonDecoder & x);

    void from_json(const json & j, JsonEncoder & x);
    void to_json(json & j, const JsonEncoder & x);

    void from_json(const json & j, JsonException & x);
    void to_json(json & j, const JsonException & x);

    void from_json(const json & j, JsonGenerator & x);
    void to_json(json & j, const JsonGenerator & x);

    void from_json(const json & j, JsonNode & x);
    void to_json(json & j, const JsonNode & x);

    void from_json(const json & j, JsonNull & x);
    void to_json(json & j, const JsonNull & x);

    void from_json(const json & j, JsonParser & x);
    void to_json(json & j, const JsonParser & x);

    void from_json(const json & j, JsonReader & x);
    void to_json(json & j, const JsonReader & x);

    void from_json(const json & j, JsonSerializer & x);
    void to_json(json & j, const JsonSerializer & x);

    void from_json(const json & j, JsonToken & x);
    void to_json(json & j, const JsonToken & x);

    void from_json(const json & j, JsonTokenType & x);
    void to_json(json & j, const JsonTokenType & x);

    void from_json(const json & j, JsonWriter & x);
    void to_json(json & j, const JsonWriter & x);

    void from_json(const json & j, Lambda & x);
    void to_json(json & j, const Lambda & x);

    void from_json(const json & j, Lazy & x);
    void to_json(json & j, const Lazy & x);

    void from_json(const json & j, Left & x);
    void to_json(json & j, const Left & x);

    void from_json(const json & j, Let & x);
    void to_json(json & j, const Let & x);

    void from_json(const json & j, List & x);
    void to_json(json & j, const List & x);

    void from_json(const json & j, LocalDate & x);
    void to_json(json & j, const LocalDate & x);

    void from_json(const json & j, Locale & x);
    void to_json(json & j, const Locale & x);

    void from_json(const json & j, Lock & x);
    void to_json(json & j, const Lock & x);

    void from_json(const json & j, LongNode & x);
    void to_json(json & j, const LongNode & x);

    void from_json(const json & j, Map & x);
    void to_json(json & j, const Map & x);

    void from_json(const json & j, MapEntry & x);
    void to_json(json & j, const MapEntry & x);

    void from_json(const json & j, MarshalJson & x);
    void to_json(json & j, const MarshalJson & x);

    void from_json(const json & j, MetadataPropertyHandling & x);
    void to_json(json & j, const MetadataPropertyHandling & x);

    void from_json(const json & j, Goto & x);
    void to_json(json & j, const Goto & x);

    void from_json(const json & j, If & x);
    void to_json(json & j, const If & x);

    void from_json(const json & j, Import & x);
    void to_json(json & j, const Import & x);

    void from_json(const json & j, Inline & x);
    void to_json(json & j, const Inline & x);

    void from_json(const json & j, Int & x);
    void to_json(json & j, const Int & x);

    void from_json(const json & j, Long & x);
    void to_json(json & j, const Long & x);

    void from_json(const json & j, Module & x);
    void to_json(json & j, const Module & x);

    void from_json(const json & j, Obj3 & x);
    void to_json(json & j, const Obj3 & x);

    void from_json(const json & j, Mutating & x);
    void to_json(json & j, const Mutating & x);

    void from_json(const json & j, Native & x);
    void to_json(json & j, const Native & x);

    void from_json(const json & j, Newtonsoft & x);
    void to_json(json & j, const Newtonsoft & x);

    void from_json(const json & j, Nil & x);
    void to_json(json & j, const Nil & x);

    void from_json(const json & j, No & x);
    void to_json(json & j, const No & x);

    void from_json(const json & j, NoSuchMethod & x);
    void to_json(json & j, const NoSuchMethod & x);

    void from_json(const json & j, Nonatomic & x);
    void to_json(json & j, const Nonatomic & x);

    void from_json(const json & j, None & x);
    void to_json(json & j, const None & x);

    void from_json(const json & j, Nonlocal & x);
    void to_json(json & j, const Nonlocal & x);

    void from_json(const json & j, Nonmutating & x);
    void to_json(json & j, const Nonmutating & x);

    void from_json(const json & j, NsError & x);
    void to_json(json & j, const NsError & x);

    void from_json(const json & j, NsObject & x);
    void to_json(json & j, const NsObject & x);

    void from_json(const json & j, NsString & x);
    void to_json(json & j, const NsString & x);

    void from_json(const json & j, Null & x);
    void to_json(json & j, const Null & x);

    void from_json(const json & j, NullNode & x);
    void to_json(json & j, const NullNode & x);

    void from_json(const json & j, Number & x);
    void to_json(json & j, const Number & x);

    void from_json(const json & j, Mutable & x);
    void to_json(json & j, const Mutable & x);

    void from_json(const json & j, Namespace & x);
    void to_json(json & j, const Namespace & x);

    void from_json(const json & j, New & x);
    void to_json(json & j, const New & x);

    void from_json(const json & j, Noexcept & x);
    void to_json(json & j, const Noexcept & x);

    void from_json(const json & j, NoneClass & x);
    void to_json(json & j, const NoneClass & x);

    void from_json(const json & j, Not & x);
    void to_json(json & j, const Not & x);

    void from_json(const json & j, NotEq & x);
    void to_json(json & j, const NotEq & x);

    void from_json(const json & j, NullClass & x);
    void to_json(json & j, const NullClass & x);

    void from_json(const json & j, Nullptr & x);
    void to_json(json & j, const Nullptr & x);

    void from_json(const json & j, Operator & x);
    void to_json(json & j, const Operator & x);

    void from_json(const json & j, Or & x);
    void to_json(json & j, const Or & x);

    void from_json(const json & j, OrEq & x);
    void to_json(json & j, const OrEq & x);

    void from_json(const json & j, Override & x);
    void to_json(json & j, const Override & x);

    void from_json(const json & j, Private & x);
    void to_json(json & j, const Private & x);

    void from_json(const json & j, Protected & x);
    void to_json(json & j, const Protected & x);

    void from_json(const json & j, ProtocolClass & x);
    void to_json(json & j, const ProtocolClass & x);

    void from_json(const json & j, Public & x);
    void to_json(json & j, const Public & x);

    void from_json(const json & j, Register & x);
    void to_json(json & j, const Register & x);

    void from_json(const json & j, ReinterpretCast & x);
    void to_json(json & j, const ReinterpretCast & x);

    void from_json(const json & j, Object & x);
    void to_json(json & j, const Object & x);

    void from_json(const json & j, ObjectMapper & x);
    void to_json(json & j, const ObjectMapper & x);

    void from_json(const json & j, ObjectNode & x);
    void to_json(json & j, const ObjectNode & x);

    void from_json(const json & j, ObjectReader & x);
    void to_json(json & j, const ObjectReader & x);

    void from_json(const json & j, ObjectWriter & x);
    void to_json(json & j, const ObjectWriter & x);

    void from_json(const json & j, Of & x);
    void to_json(json & j, const Of & x);

    void from_json(const json & j, OffsetDateTime & x);
    void to_json(json & j, const OffsetDateTime & x);

    void from_json(const json & j, OffsetTime & x);
    void to_json(json & j, const OffsetTime & x);

    void from_json(const json & j, Oneway & x);
    void to_json(json & j, const Oneway & x);

    void from_json(const json & j, Open & x);
    void to_json(json & j, const Open & x);

    void from_json(const json & j, Optional & x);
    void to_json(json & j, const Optional & x);

    void from_json(const json & j, Out & x);
    void to_json(json & j, const Out & x);

    void from_json(const json & j, Package & x);
    void to_json(json & j, const Package & x);

    void from_json(const json & j, Params & x);
    void to_json(json & j, const Params & x);

    void from_json(const json & j, Pass & x);
    void to_json(json & j, const Pass & x);

    void from_json(const json & j, Port & x);
    void to_json(json & j, const Port & x);

    void from_json(const json & j, Postfix & x);
    void to_json(json & j, const Postfix & x);

    void from_json(const json & j, Precedence & x);
    void to_json(json & j, const Precedence & x);

    void from_json(const json & j, Prefix & x);
    void to_json(json & j, const Prefix & x);

    void from_json(const json & j, Print & x);
    void to_json(json & j, const Print & x);

    void from_json(const json & j, PrintMembers & x);
    void to_json(json & j, const PrintMembers & x);

    void from_json(const json & j, Printf & x);
    void to_json(json & j, const Printf & x);

    void from_json(const json & j, Protocol & x);
    void to_json(json & j, const Protocol & x);

    void from_json(const json & j, Quicktype & x);
    void to_json(json & j, const Quicktype & x);

    void from_json(const json & j, Raise & x);
    void to_json(json & j, const Raise & x);

    void from_json(const json & j, Range & x);
    void to_json(json & j, const Range & x);

    void from_json(const json & j, Readonly & x);
    void to_json(json & j, const Readonly & x);

    void from_json(const json & j, Ref & x);
    void to_json(json & j, const Ref & x);

    void from_json(const json & j, RegExp & x);
    void to_json(json & j, const RegExp & x);

    void from_json(const json & j, Obj4 & x);
    void to_json(json & j, const Obj4 & x);

    void from_json(const json & j, KSerializer & x);
    void to_json(json & j, const KSerializer & x);

    void from_json(const json & j, Requires & x);
    void to_json(json & j, const Requires & x);

    void from_json(const json & j, Return & x);
    void to_json(json & j, const Return & x);

    void from_json(const json & j, SelfClass & x);
    void to_json(json & j, const SelfClass & x);

    void from_json(const json & j, Short & x);
    void to_json(json & j, const Short & x);

    void from_json(const json & j, Signed & x);
    void to_json(json & j, const Signed & x);

    void from_json(const json & j, Sizeof & x);
    void to_json(json & j, const Sizeof & x);

    void from_json(const json & j, Static & x);
    void to_json(json & j, const Static & x);

    void from_json(const json & j, StaticAssert & x);
    void to_json(json & j, const StaticAssert & x);

    void from_json(const json & j, StaticCast & x);
    void to_json(json & j, const StaticCast & x);

    void from_json(const json & j, Struct & x);
    void to_json(json & j, const Struct & x);

    void from_json(const json & j, Switch & x);
    void to_json(json & j, const Switch & x);

    void from_json(const json & j, Synchronized & x);
    void to_json(json & j, const Synchronized & x);

    void from_json(const json & j, Template & x);
    void to_json(json & j, const Template & x);

    void from_json(const json & j, This & x);
    void to_json(json & j, const This & x);

    void from_json(const json & j, ThreadLocal & x);
    void to_json(json & j, const ThreadLocal & x);

    void from_json(const json & j, Throw & x);
    void to_json(json & j, const Throw & x);

    void from_json(const json & j, True & x);
    void to_json(json & j, const True & x);

    void from_json(const json & j, PrimitiveKind & x);
    void to_json(json & j, const PrimitiveKind & x);

    void from_json(const json & j, TrueClass & x);
    void to_json(json & j, const TrueClass & x);

    void from_json(const json & j, Repeat & x);
    void to_json(json & j, const Repeat & x);

    void from_json(const json & j, Require & x);
    void to_json(json & j, const Require & x);

    void from_json(const json & j, Required & x);
    void to_json(json & j, const Required & x);

    void from_json(const json & j, Restrict & x);
    void to_json(json & j, const Restrict & x);

    void from_json(const json & j, Retain & x);
    void to_json(json & j, const Retain & x);

    void from_json(const json & j, Rethrows & x);
    void to_json(json & j, const Rethrows & x);

    void from_json(const json & j, Right & x);
    void to_json(json & j, const Right & x);

    void from_json(const json & j, RuntimeType & x);
    void to_json(json & j, const RuntimeType & x);

    void from_json(const json & j, S & x);
    void to_json(json & j, const S & x);

    void from_json(const json & j, Sbyte & x);
    void to_json(json & j, const Sbyte & x);

    void from_json(const json & j, Sealed & x);
    void to_json(json & j, const Sealed & x);

    void from_json(const json & j, Sel & x);
    void to_json(json & j, const Sel & x);

    void from_json(const json & j, Select & x);
    void to_json(json & j, const Select & x);

    void from_json(const json & j, Self & x);
    void to_json(json & j, const Self & x);

    void from_json(const json & j, Sendable & x);
    void to_json(json & j, const Sendable & x);

    void from_json(const json & j, SerialDescriptor & x);
    void to_json(json & j, const SerialDescriptor & x);

    void from_json(const json & j, SerialName & x);
    void to_json(json & j, const SerialName & x);

    void from_json(const json & j, Serializable & x);
    void to_json(json & j, const Serializable & x);

    void from_json(const json & j, SerializationFeature & x);
    void to_json(json & j, const SerializationFeature & x);

    void from_json(const json & j, Serialize & x);
    void to_json(json & j, const Serialize & x);

    void from_json(const json & j, SerializerProvider & x);
    void to_json(json & j, const SerializerProvider & x);

    void from_json(const json & j, Set & x);
    void to_json(json & j, const Set & x);

    void from_json(const json & j, SimpleModule & x);
    void to_json(json & j, const SimpleModule & x);

    void from_json(const json & j, Stackalloc & x);
    void to_json(json & j, const Stackalloc & x);

    void from_json(const json & j, Standards & x);
    void to_json(json & j, const Standards & x);

    void from_json(const json & j, StdDeserializer & x);
    void to_json(json & j, const StdDeserializer & x);

    void from_json(const json & j, StdSerializer & x);
    void to_json(json & j, const StdSerializer & x);

    void from_json(const json & j, Strictfp & x);
    void to_json(json & j, const Strictfp & x);

    void from_json(const json & j, String & x);
    void to_json(json & j, const String & x);

    void from_json(const json & j, Subscript & x);
    void to_json(json & j, const Subscript & x);

    void from_json(const json & j, Super & x);
    void to_json(json & j, const Super & x);

    void from_json(const json & j, Symbol & x);
    void to_json(json & j, const Symbol & x);

    void from_json(const json & j, System & x);
    void to_json(json & j, const System & x);

    void from_json(const json & j, TextNode & x);
    void to_json(json & j, const TextNode & x);

    void from_json(const json & j, Then & x);
    void to_json(json & j, const Then & x);

    void from_json(const json & j, Throws & x);
    void to_json(json & j, const Throws & x);

    void from_json(const json & j, TimeOnly & x);
    void to_json(json & j, const TimeOnly & x);

    void from_json(const json & j, TimeOnlyConverter & x);
    void to_json(json & j, const TimeOnlyConverter & x);

    void from_json(const json & j, TimeZone & x);
    void to_json(json & j, const TimeZone & x);

    void from_json(const json & j, ToDict & x);
    void to_json(json & j, const ToDict & x);

    void from_json(const json & j, ToJson & x);
    void to_json(json & j, const ToJson & x);

    void from_json(const json & j, ToString & x);
    void to_json(json & j, const ToString & x);

    void from_json(const json & j, TopLevelClass & x);
    void to_json(json & j, const TopLevelClass & x);

    void from_json(const json & j, Transient & x);
    void to_json(json & j, const Transient & x);

    void from_json(const json & j, Obj5 & x);
    void to_json(json & j, const Obj5 & x);

    void from_json(const json & j, Try & x);
    void to_json(json & j, const Try & x);

    void from_json(const json & j, TypeClass & x);
    void to_json(json & j, const TypeClass & x);

    void from_json(const json & j, Typedef & x);
    void to_json(json & j, const Typedef & x);

    void from_json(const json & j, Typeid & x);
    void to_json(json & j, const Typeid & x);

    void from_json(const json & j, Typename & x);
    void to_json(json & j, const Typename & x);

    void from_json(const json & j, Union & x);
    void to_json(json & j, const Union & x);

    void from_json(const json & j, Unsigned & x);
    void to_json(json & j, const Unsigned & x);

    void from_json(const json & j, Using & x);
    void to_json(json & j, const Using & x);

    void from_json(const json & j, Virtual & x);
    void to_json(json & j, const Virtual & x);

    void from_json(const json & j, Void & x);
    void to_json(json & j, const Void & x);

    void from_json(const json & j, Volatile & x);
    void to_json(json & j, const Volatile & x);

    void from_json(const json & j, WcharT & x);
    void to_json(json & j, const WcharT & x);

    void from_json(const json & j, While & x);
    void to_json(json & j, const While & x);

    void from_json(const json & j, Xor & x);
    void to_json(json & j, const Xor & x);

    void from_json(const json & j, XorEq & x);
    void to_json(json & j, const XorEq & x);

    void from_json(const json & j, Type & x);
    void to_json(json & j, const Type & x);

    void from_json(const json & j, Typealias & x);
    void to_json(json & j, const Typealias & x);

    void from_json(const json & j, Typeof & x);
    void to_json(json & j, const Typeof & x);

    void from_json(const json & j, Uint & x);
    void to_json(json & j, const Uint & x);

    void from_json(const json & j, Ulong & x);
    void to_json(json & j, const Ulong & x);

    void from_json(const json & j, Unchecked & x);
    void to_json(json & j, const Unchecked & x);

    void from_json(const json & j, Undefined & x);
    void to_json(json & j, const Undefined & x);

    void from_json(const json & j, UnmarshalJson & x);
    void to_json(json & j, const UnmarshalJson & x);

    void from_json(const json & j, Unowned & x);
    void to_json(json & j, const Unowned & x);

    void from_json(const json & j, Unsafe & x);
    void to_json(json & j, const Unsafe & x);

    void from_json(const json & j, UseSerializers & x);
    void to_json(json & j, const UseSerializers & x);

    void from_json(const json & j, Ushort & x);
    void to_json(json & j, const Ushort & x);

    void from_json(const json & j, Utf8JsonReader & x);
    void to_json(json & j, const Utf8JsonReader & x);

    void from_json(const json & j, Utf8JsonWriter & x);
    void to_json(json & j, const Utf8JsonWriter & x);

    void from_json(const json & j, Uuid & x);
    void to_json(json & j, const Uuid & x);

    void from_json(const json & j, Var & x);
    void to_json(json & j, const Var & x);

    void from_json(const json & j, Weak & x);
    void to_json(json & j, const Weak & x);

    void from_json(const json & j, Where & x);
    void to_json(json & j, const Where & x);

    void from_json(const json & j, WillSet & x);
    void to_json(json & j, const WillSet & x);

    void from_json(const json & j, With & x);
    void to_json(json & j, const With & x);

    void from_json(const json & j, Yes & x);
    void to_json(json & j, const Yes & x);

    void from_json(const json & j, Yield & x);
    void to_json(json & j, const Yield & x);

    void from_json(const json & j, Obj6 & x);
    void to_json(json & j, const Obj6 & x);

    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    void from_json(const json & j, EnumValue & x);
    void to_json(json & j, const EnumValue & x);

    inline void from_json(const json & j, Abstract& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("abstract") != j.end() && !j.at("abstract").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_abstract(j.at("abstract").get<int64_t>());
    }

    inline void to_json(json & j, const Abstract & x) {
        j = json::object();
        j["abstract"] = x.get_abstract();
    }

    inline void from_json(const json & j, Any& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("Any") != j.end() && !j.at("Any").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_any(j.at("Any").get<int64_t>());
    }

    inline void to_json(json & j, const Any & x) {
        j = json::object();
        j["Any"] = x.get_any();
    }

    inline void from_json(const json & j, Array& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("array") != j.end() && !j.at("array").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_array(j.at("array").get<int64_t>());
    }

    inline void to_json(json & j, const Array & x) {
        j = json::object();
        j["array"] = x.get_array();
    }

    inline void from_json(const json & j, ArrayNode& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("ArrayNode") != j.end() && !j.at("ArrayNode").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_array_node(j.at("ArrayNode").get<int64_t>());
    }

    inline void to_json(json & j, const ArrayNode & x) {
        j = json::object();
        j["ArrayNode"] = x.get_array_node();
    }

    inline void from_json(const json & j, As& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("as") != j.end() && !j.at("as").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_as(j.at("as").get<int64_t>());
    }

    inline void to_json(json & j, const As & x) {
        j = json::object();
        j["as"] = x.get_as();
    }

    inline void from_json(const json & j, Assert& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("assert") != j.end() && !j.at("assert").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_assert(j.at("assert").get<int64_t>());
    }

    inline void to_json(json & j, const Assert & x) {
        j = json::object();
        j["assert"] = x.get_assert();
    }

    inline void from_json(const json & j, Associatedtype& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("associatedtype") != j.end() && !j.at("associatedtype").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_associatedtype(j.at("associatedtype").get<int64_t>());
    }

    inline void to_json(json & j, const Associatedtype & x) {
        j = json::object();
        j["associatedtype"] = x.get_associatedtype();
    }

    inline void from_json(const json & j, Associativity& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("associativity") != j.end() && !j.at("associativity").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_associativity(j.at("associativity").get<int64_t>());
    }

    inline void to_json(json & j, const Associativity & x) {
        j = json::object();
        j["associativity"] = x.get_associativity();
    }

    inline void from_json(const json & j, Async& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("async") != j.end() && !j.at("async").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_async(j.at("async").get<int64_t>());
    }

    inline void to_json(json & j, const Async & x) {
        j = json::object();
        j["async"] = x.get_async();
    }

    inline void from_json(const json & j, Atomic& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("atomic") != j.end() && !j.at("atomic").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_atomic(j.at("atomic").get<int64_t>());
    }

    inline void to_json(json & j, const Atomic & x) {
        j = json::object();
        j["atomic"] = x.get_atomic();
    }

    inline void from_json(const json & j, Await& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("await") != j.end() && !j.at("await").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_await(j.at("await").get<int64_t>());
    }

    inline void to_json(json & j, const Await & x) {
        j = json::object();
        j["await"] = x.get_await();
    }

    inline void from_json(const json & j, Base& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("base") != j.end() && !j.at("base").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_base(j.at("base").get<int64_t>());
    }

    inline void to_json(json & j, const Base & x) {
        j = json::object();
        j["base"] = x.get_base();
    }

    inline void from_json(const json & j, Boolean& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("boolean") != j.end() && !j.at("boolean").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_boolean(j.at("boolean").get<int64_t>());
    }

    inline void to_json(json & j, const Boolean & x) {
        j = json::object();
        j["boolean"] = x.get_boolean();
    }

    inline void from_json(const json & j, BooleanNode& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("BooleanNode") != j.end() && !j.at("BooleanNode").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_boolean_node(j.at("BooleanNode").get<int64_t>());
    }

    inline void to_json(json & j, const BooleanNode & x) {
        j = json::object();
        j["BooleanNode"] = x.get_boolean_node();
    }

    inline void from_json(const json & j, Bycopy& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("bycopy") != j.end() && !j.at("bycopy").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_bycopy(j.at("bycopy").get<int64_t>());
    }

    inline void to_json(json & j, const Bycopy & x) {
        j = json::object();
        j["bycopy"] = x.get_bycopy();
    }

    inline void from_json(const json & j, Byref& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("byref") != j.end() && !j.at("byref").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_byref(j.at("byref").get<int64_t>());
    }

    inline void to_json(json & j, const Byref & x) {
        j = json::object();
        j["byref"] = x.get_byref();
    }

    inline void from_json(const json & j, Byte& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("byte") != j.end() && !j.at("byte").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_byte(j.at("byte").get<int64_t>());
    }

    inline void to_json(json & j, const Byte & x) {
        j = json::object();
        j["byte"] = x.get_byte();
    }

    inline void from_json(const json & j, Calendar& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("Calendar") != j.end() && !j.at("Calendar").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_calendar(j.at("Calendar").get<int64_t>());
    }

    inline void to_json(json & j, const Calendar & x) {
        j = json::object();
        j["Calendar"] = x.get_calendar();
    }

    inline void from_json(const json & j, Chan& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("chan") != j.end() && !j.at("chan").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_chan(j.at("chan").get<int64_t>());
    }

    inline void to_json(json & j, const Chan & x) {
        j = json::object();
        j["chan"] = x.get_chan();
    }

    inline void from_json(const json & j, Checked& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("checked") != j.end() && !j.at("checked").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_checked(j.at("checked").get<int64_t>());
    }

    inline void to_json(json & j, const Checked & x) {
        j = json::object();
        j["checked"] = x.get_checked();
    }

    inline void from_json(const json & j, Clone& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("clone") != j.end() && !j.at("clone").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_clone(j.at("clone").get<int64_t>());
    }

    inline void to_json(json & j, const Clone & x) {
        j = json::object();
        j["clone"] = x.get_clone();
    }

    inline void from_json(const json & j, Codable& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("Codable") != j.end() && !j.at("Codable").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_codable(j.at("Codable").get<int64_t>());
    }

    inline void to_json(json & j, const Codable & x) {
        j = json::object();
        j["Codable"] = x.get_codable();
    }

    inline void from_json(const json & j, CodingKey& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("CodingKey") != j.end() && !j.at("CodingKey").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_coding_key(j.at("CodingKey").get<int64_t>());
    }

    inline void to_json(json & j, const CodingKey & x) {
        j = json::object();
        j["CodingKey"] = x.get_coding_key();
    }

    inline void from_json(const json & j, CodingKeys& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("CodingKeys") != j.end() && !j.at("CodingKeys").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_coding_keys(j.at("CodingKeys").get<int64_t>());
    }

    inline void to_json(json & j, const CodingKeys & x) {
        j = json::object();
        j["CodingKeys"] = x.get_coding_keys();
    }

    inline void from_json(const json & j, Complex& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("_Complex") != j.end() && !j.at("_Complex").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_complex(j.at("_Complex").get<int64_t>());
    }

    inline void to_json(json & j, const Complex & x) {
        j = json::object();
        j["_Complex"] = x.get_complex();
    }

    inline void from_json(const json & j, Console& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("console") != j.end() && !j.at("console").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_console(j.at("console").get<int64_t>());
    }

    inline void to_json(json & j, const Console & x) {
        j = json::object();
        j["console"] = x.get_console();
    }

    inline void from_json(const json & j, Constructor& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("constructor") != j.end() && !j.at("constructor").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_constructor(j.at("constructor").get<int64_t>());
    }

    inline void to_json(json & j, const Constructor & x) {
        j = json::object();
        j["constructor"] = x.get_constructor();
    }

    inline void from_json(const json & j, Convenience& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("convenience") != j.end() && !j.at("convenience").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_convenience(j.at("convenience").get<int64_t>());
    }

    inline void to_json(json & j, const Convenience & x) {
        j = json::object();
        j["convenience"] = x.get_convenience();
    }

    inline void from_json(const json & j, Convert& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("convert") != j.end() && !j.at("convert").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_convert(j.at("convert").get<int64_t>());
    }

    inline void to_json(json & j, const Convert & x) {
        j = json::object();
        j["convert"] = x.get_convert();
    }

    inline void from_json(const json & j, Converter& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("converter") != j.end() && !j.at("converter").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_converter(j.at("converter").get<int64_t>());
    }

    inline void to_json(json & j, const Converter & x) {
        j = json::object();
        j["converter"] = x.get_converter();
    }

    inline void from_json(const json & j, Empty& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("_") != j.end() && !j.at("_").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_empty(j.at("_").get<int64_t>());
    }

    inline void to_json(json & j, const Empty & x) {
        j = json::object();
        j["_"] = x.get_empty();
    }

    inline void from_json(const json & j, Obj1Bool& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("bool") != j.end() && !j.at("bool").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_bool_bool(j.at("bool").get<int64_t>());
    }

    inline void to_json(json & j, const Obj1Bool & x) {
        j = json::object();
        j["bool"] = x.get_bool_bool();
    }

    inline void from_json(const json & j, Imaginery& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("_Imaginery") != j.end() && !j.at("_Imaginery").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_imaginery(j.at("_Imaginery").get<int64_t>());
    }

    inline void to_json(json & j, const Imaginery & x) {
        j = json::object();
        j["_Imaginery"] = x.get_imaginery();
    }

    inline void from_json(const json & j, Alignas& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("alignas") != j.end() && !j.at("alignas").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_alignas_alignas(j.at("alignas").get<int64_t>());
    }

    inline void to_json(json & j, const Alignas & x) {
        j = json::object();
        j["alignas"] = x.get_alignas_alignas();
    }

    inline void from_json(const json & j, Alignof& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("alignof") != j.end() && !j.at("alignof").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_alignof_alignof(j.at("alignof").get<int64_t>());
    }

    inline void to_json(json & j, const Alignof & x) {
        j = json::object();
        j["alignof"] = x.get_alignof_alignof();
    }

    inline void from_json(const json & j, And& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("and") != j.end() && !j.at("and").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_and_and(j.at("and").get<int64_t>());
    }

    inline void to_json(json & j, const And & x) {
        j = json::object();
        j["and"] = x.get_and_and();
    }

    inline void from_json(const json & j, AndEq& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("and_eq") != j.end() && !j.at("and_eq").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_and_eq_and_eq(j.at("and_eq").get<int64_t>());
    }

    inline void to_json(json & j, const AndEq & x) {
        j = json::object();
        j["and_eq"] = x.get_and_eq_and_eq();
    }

    inline void from_json(const json & j, AnyClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("any") != j.end() && !j.at("any").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_any(j.at("any").get<int64_t>());
    }

    inline void to_json(json & j, const AnyClass & x) {
        j = json::object();
        j["any"] = x.get_any();
    }

    inline void from_json(const json & j, Asm& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("asm") != j.end() && !j.at("asm").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_asm_asm(j.at("asm").get<int64_t>());
    }

    inline void to_json(json & j, const Asm & x) {
        j = json::object();
        j["asm"] = x.get_asm_asm();
    }

    inline void from_json(const json & j, AtomicCancel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("atomic_cancel") != j.end() && !j.at("atomic_cancel").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_atomic_cancel_atomic_cancel(j.at("atomic_cancel").get<int64_t>());
    }

    inline void to_json(json & j, const AtomicCancel & x) {
        j = json::object();
        j["atomic_cancel"] = x.get_atomic_cancel_atomic_cancel();
    }

    inline void from_json(const json & j, AtomicCommit& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("atomic_commit") != j.end() && !j.at("atomic_commit").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_atomic_commit_atomic_commit(j.at("atomic_commit").get<int64_t>());
    }

    inline void to_json(json & j, const AtomicCommit & x) {
        j = json::object();
        j["atomic_commit"] = x.get_atomic_commit_atomic_commit();
    }

    inline void from_json(const json & j, AtomicNoexcept& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("atomic_noexcept") != j.end() && !j.at("atomic_noexcept").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_atomic_noexcept_atomic_noexcept(j.at("atomic_noexcept").get<int64_t>());
    }

    inline void to_json(json & j, const AtomicNoexcept & x) {
        j = json::object();
        j["atomic_noexcept"] = x.get_atomic_noexcept_atomic_noexcept();
    }

    inline void from_json(const json & j, Auto& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("auto") != j.end() && !j.at("auto").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_auto_auto(j.at("auto").get<int64_t>());
    }

    inline void to_json(json & j, const Auto & x) {
        j = json::object();
        j["auto"] = x.get_auto_auto();
    }

    inline void from_json(const json & j, Bitand& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("bitand") != j.end() && !j.at("bitand").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_bitand_bitand(j.at("bitand").get<int64_t>());
    }

    inline void to_json(json & j, const Bitand & x) {
        j = json::object();
        j["bitand"] = x.get_bitand_bitand();
    }

    inline void from_json(const json & j, Bitor& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("bitor") != j.end() && !j.at("bitor").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_bitor_bitor(j.at("bitor").get<int64_t>());
    }

    inline void to_json(json & j, const Bitor & x) {
        j = json::object();
        j["bitor"] = x.get_bitor_bitor();
    }

    inline void from_json(const json & j, Bool& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("BOOL") != j.end() && !j.at("BOOL").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_bool_bool(j.at("BOOL").get<int64_t>());
    }

    inline void to_json(json & j, const Bool & x) {
        j = json::object();
        j["BOOL"] = x.get_bool_bool();
    }

    inline void from_json(const json & j, Break& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("break") != j.end() && !j.at("break").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_break_break(j.at("break").get<int64_t>());
    }

    inline void to_json(json & j, const Break & x) {
        j = json::object();
        j["break"] = x.get_break_break();
    }

    inline void from_json(const json & j, Case& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("case") != j.end() && !j.at("case").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_case_case(j.at("case").get<int64_t>());
    }

    inline void to_json(json & j, const Case & x) {
        j = json::object();
        j["case"] = x.get_case_case();
    }

    inline void from_json(const json & j, Catch& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("catch") != j.end() && !j.at("catch").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_catch_catch(j.at("catch").get<int64_t>());
    }

    inline void to_json(json & j, const Catch & x) {
        j = json::object();
        j["catch"] = x.get_catch_catch();
    }

    inline void from_json(const json & j, Char& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("char") != j.end() && !j.at("char").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_char_char(j.at("char").get<int64_t>());
    }

    inline void to_json(json & j, const Char & x) {
        j = json::object();
        j["char"] = x.get_char_char();
    }

    inline void from_json(const json & j, Char16T& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("char16_t") != j.end() && !j.at("char16_t").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_char16_t_char16_t(j.at("char16_t").get<int64_t>());
    }

    inline void to_json(json & j, const Char16T & x) {
        j = json::object();
        j["char16_t"] = x.get_char16_t_char16_t();
    }

    inline void from_json(const json & j, Char32T& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("char32_t") != j.end() && !j.at("char32_t").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_char32_t_char32_t(j.at("char32_t").get<int64_t>());
    }

    inline void to_json(json & j, const Char32T & x) {
        j = json::object();
        j["char32_t"] = x.get_char32_t_char32_t();
    }

    inline void from_json(const json & j, Class& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("Class") != j.end() && !j.at("Class").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_class_class(j.at("Class").get<int64_t>());
    }

    inline void to_json(json & j, const Class & x) {
        j = json::object();
        j["Class"] = x.get_class_class();
    }

    inline void from_json(const json & j, CoAwait& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("co_await") != j.end() && !j.at("co_await").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_co_await_co_await(j.at("co_await").get<int64_t>());
    }

    inline void to_json(json & j, const CoAwait & x) {
        j = json::object();
        j["co_await"] = x.get_co_await_co_await();
    }

    inline void from_json(const json & j, CoReturn& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("co_return") != j.end() && !j.at("co_return").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_co_return_co_return(j.at("co_return").get<int64_t>());
    }

    inline void to_json(json & j, const CoReturn & x) {
        j = json::object();
        j["co_return"] = x.get_co_return_co_return();
    }

    inline void from_json(const json & j, CoYield& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("co_yield") != j.end() && !j.at("co_yield").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_co_yield_co_yield(j.at("co_yield").get<int64_t>());
    }

    inline void to_json(json & j, const CoYield & x) {
        j = json::object();
        j["co_yield"] = x.get_co_yield_co_yield();
    }

    inline void from_json(const json & j, Compl& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("compl") != j.end() && !j.at("compl").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_compl_compl(j.at("compl").get<int64_t>());
    }

    inline void to_json(json & j, const Compl & x) {
        j = json::object();
        j["compl"] = x.get_compl_compl();
    }

    inline void from_json(const json & j, Concept& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("concept") != j.end() && !j.at("concept").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_concept_concept(j.at("concept").get<int64_t>());
    }

    inline void to_json(json & j, const Concept & x) {
        j = json::object();
        j["concept"] = x.get_concept_concept();
    }

    inline void from_json(const json & j, Const& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("const") != j.end() && !j.at("const").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_const_const(j.at("const").get<int64_t>());
    }

    inline void to_json(json & j, const Const & x) {
        j = json::object();
        j["const"] = x.get_const_const();
    }

    inline void from_json(const json & j, ConstCast& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("const_cast") != j.end() && !j.at("const_cast").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_const_cast_const_cast(j.at("const_cast").get<int64_t>());
    }

    inline void to_json(json & j, const ConstCast & x) {
        j = json::object();
        j["const_cast"] = x.get_const_cast_const_cast();
    }

    inline void from_json(const json & j, Constexpr& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("constexpr") != j.end() && !j.at("constexpr").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_constexpr_constexpr(j.at("constexpr").get<int64_t>());
    }

    inline void to_json(json & j, const Constexpr & x) {
        j = json::object();
        j["constexpr"] = x.get_constexpr_constexpr();
    }

    inline void from_json(const json & j, Continue& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("continue") != j.end() && !j.at("continue").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_continue_continue(j.at("continue").get<int64_t>());
    }

    inline void to_json(json & j, const Continue & x) {
        j = json::object();
        j["continue"] = x.get_continue_continue();
    }

    inline void from_json(const json & j, BoolClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("_Bool") != j.end() && !j.at("_Bool").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_bool_bool(j.at("_Bool").get<int64_t>());
    }

    inline void to_json(json & j, const BoolClass & x) {
        j = json::object();
        j["_Bool"] = x.get_bool_bool();
    }

    inline void from_json(const json & j, ClassClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("class") != j.end() && !j.at("class").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_class_class(j.at("class").get<int64_t>());
    }

    inline void to_json(json & j, const ClassClass & x) {
        j = json::object();
        j["class"] = x.get_class_class();
    }

    inline void from_json(const json & j, Obj1& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_abstract(j.at("abstract").get<Abstract>());
        x.set_any(j.at("Any").get<Any>());
        x.set_array(j.at("array").get<Array>());
        x.set_array_node(j.at("ArrayNode").get<ArrayNode>());
        x.set_as(j.at("as").get<As>());
        x.set_assert(j.at("assert").get<Assert>());
        x.set_associatedtype(j.at("associatedtype").get<Associatedtype>());
        x.set_associativity(j.at("associativity").get<Associativity>());
        x.set_async(j.at("async").get<Async>());
        x.set_atomic(j.at("atomic").get<Atomic>());
        x.set_await(j.at("await").get<Await>());
        x.set_base(j.at("base").get<Base>());
        x.set_boolean(j.at("boolean").get<Boolean>());
        x.set_boolean_node(j.at("BooleanNode").get<BooleanNode>());
        x.set_bycopy(j.at("bycopy").get<Bycopy>());
        x.set_byref(j.at("byref").get<Byref>());
        x.set_byte(j.at("byte").get<Byte>());
        x.set_calendar(j.at("Calendar").get<Calendar>());
        x.set_chan(j.at("chan").get<Chan>());
        x.set_checked(j.at("checked").get<Checked>());
        x.set_clone(j.at("clone").get<Clone>());
        x.set_codable(j.at("Codable").get<Codable>());
        x.set_coding_key(j.at("CodingKey").get<CodingKey>());
        x.set_coding_keys(j.at("CodingKeys").get<CodingKeys>());
        x.set_complex(j.at("_Complex").get<Complex>());
        x.set_console(j.at("console").get<Console>());
        x.set_constructor(j.at("constructor").get<Constructor>());
        x.set_convenience(j.at("convenience").get<Convenience>());
        x.set_convert(j.at("convert").get<Convert>());
        x.set_converter(j.at("converter").get<Converter>());
        if (j.find("dummy") != j.end() && !j.at("dummy").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_dummy(j.at("dummy").get<int64_t>());
        x.set_empty(j.at("_").get<Empty>());
        x.set_fluffy_bool(j.at("bool").get<Obj1Bool>());
        x.set_imaginery(j.at("_Imaginery").get<Imaginery>());
        x.set_obj1_alignas(j.at("alignas").get<Alignas>());
        x.set_obj1_alignof(j.at("alignof").get<Alignof>());
        x.set_obj1_and(j.at("and").get<And>());
        x.set_obj1_and_eq(j.at("and_eq").get<AndEq>());
        x.set_obj1_any(j.at("any").get<AnyClass>());
        x.set_obj1_asm(j.at("asm").get<Asm>());
        x.set_obj1_atomic_cancel(j.at("atomic_cancel").get<AtomicCancel>());
        x.set_obj1_atomic_commit(j.at("atomic_commit").get<AtomicCommit>());
        x.set_obj1_atomic_noexcept(j.at("atomic_noexcept").get<AtomicNoexcept>());
        x.set_obj1_auto(j.at("auto").get<Auto>());
        x.set_obj1_bitand(j.at("bitand").get<Bitand>());
        x.set_obj1_bitor(j.at("bitor").get<Bitor>());
        x.set_obj1_bool(j.at("BOOL").get<Bool>());
        x.set_obj1_break(j.at("break").get<Break>());
        x.set_obj1_case(j.at("case").get<Case>());
        x.set_obj1_catch(j.at("catch").get<Catch>());
        x.set_obj1_char(j.at("char").get<Char>());
        x.set_obj1_char16_t(j.at("char16_t").get<Char16T>());
        x.set_obj1_char32_t(j.at("char32_t").get<Char32T>());
        x.set_obj1_class(j.at("Class").get<Class>());
        x.set_obj1_co_await(j.at("co_await").get<CoAwait>());
        x.set_obj1_co_return(j.at("co_return").get<CoReturn>());
        x.set_obj1_co_yield(j.at("co_yield").get<CoYield>());
        x.set_obj1_compl(j.at("compl").get<Compl>());
        x.set_obj1_concept(j.at("concept").get<Concept>());
        x.set_obj1_const(j.at("const").get<Const>());
        x.set_obj1_const_cast(j.at("const_cast").get<ConstCast>());
        x.set_obj1_constexpr(j.at("constexpr").get<Constexpr>());
        x.set_obj1_continue(j.at("continue").get<Continue>());
        x.set_purple_bool(j.at("_Bool").get<BoolClass>());
        x.set_purple_class(j.at("class").get<ClassClass>());
    }

    inline void to_json(json & j, const Obj1 & x) {
        j = json::object();
        j["abstract"] = x.get_abstract();
        j["Any"] = x.get_any();
        j["array"] = x.get_array();
        j["ArrayNode"] = x.get_array_node();
        j["as"] = x.get_as();
        j["assert"] = x.get_assert();
        j["associatedtype"] = x.get_associatedtype();
        j["associativity"] = x.get_associativity();
        j["async"] = x.get_async();
        j["atomic"] = x.get_atomic();
        j["await"] = x.get_await();
        j["base"] = x.get_base();
        j["boolean"] = x.get_boolean();
        j["BooleanNode"] = x.get_boolean_node();
        j["bycopy"] = x.get_bycopy();
        j["byref"] = x.get_byref();
        j["byte"] = x.get_byte();
        j["Calendar"] = x.get_calendar();
        j["chan"] = x.get_chan();
        j["checked"] = x.get_checked();
        j["clone"] = x.get_clone();
        j["Codable"] = x.get_codable();
        j["CodingKey"] = x.get_coding_key();
        j["CodingKeys"] = x.get_coding_keys();
        j["_Complex"] = x.get_complex();
        j["console"] = x.get_console();
        j["constructor"] = x.get_constructor();
        j["convenience"] = x.get_convenience();
        j["convert"] = x.get_convert();
        j["converter"] = x.get_converter();
        j["dummy"] = x.get_dummy();
        j["_"] = x.get_empty();
        j["bool"] = x.get_fluffy_bool();
        j["_Imaginery"] = x.get_imaginery();
        j["alignas"] = x.get_obj1_alignas();
        j["alignof"] = x.get_obj1_alignof();
        j["and"] = x.get_obj1_and();
        j["and_eq"] = x.get_obj1_and_eq();
        j["any"] = x.get_obj1_any();
        j["asm"] = x.get_obj1_asm();
        j["atomic_cancel"] = x.get_obj1_atomic_cancel();
        j["atomic_commit"] = x.get_obj1_atomic_commit();
        j["atomic_noexcept"] = x.get_obj1_atomic_noexcept();
        j["auto"] = x.get_obj1_auto();
        j["bitand"] = x.get_obj1_bitand();
        j["bitor"] = x.get_obj1_bitor();
        j["BOOL"] = x.get_obj1_bool();
        j["break"] = x.get_obj1_break();
        j["case"] = x.get_obj1_case();
        j["catch"] = x.get_obj1_catch();
        j["char"] = x.get_obj1_char();
        j["char16_t"] = x.get_obj1_char16_t();
        j["char32_t"] = x.get_obj1_char32_t();
        j["Class"] = x.get_obj1_class();
        j["co_await"] = x.get_obj1_co_await();
        j["co_return"] = x.get_obj1_co_return();
        j["co_yield"] = x.get_obj1_co_yield();
        j["compl"] = x.get_obj1_compl();
        j["concept"] = x.get_obj1_concept();
        j["const"] = x.get_obj1_const();
        j["const_cast"] = x.get_obj1_const_cast();
        j["constexpr"] = x.get_obj1_constexpr();
        j["continue"] = x.get_obj1_continue();
        j["_Bool"] = x.get_purple_bool();
        j["class"] = x.get_purple_class();
    }

    inline void from_json(const json & j, CultureInfo& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("CultureInfo") != j.end() && !j.at("CultureInfo").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_culture_info(j.at("CultureInfo").get<int64_t>());
    }

    inline void to_json(json & j, const CultureInfo & x) {
        j = json::object();
        j["CultureInfo"] = x.get_culture_info();
    }

    inline void from_json(const json & j, Date& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("date") != j.end() && !j.at("date").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_date(j.at("date").get<int64_t>());
    }

    inline void to_json(json & j, const Date & x) {
        j = json::object();
        j["date"] = x.get_date();
    }

    inline void from_json(const json & j, DateFormatter& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("DateFormatter") != j.end() && !j.at("DateFormatter").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_date_formatter(j.at("DateFormatter").get<int64_t>());
    }

    inline void to_json(json & j, const DateFormatter & x) {
        j = json::object();
        j["DateFormatter"] = x.get_date_formatter();
    }

    inline void from_json(const json & j, DateOnly& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("DateOnly") != j.end() && !j.at("DateOnly").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_date_only(j.at("DateOnly").get<int64_t>());
    }

    inline void to_json(json & j, const DateOnly & x) {
        j = json::object();
        j["DateOnly"] = x.get_date_only();
    }

    inline void from_json(const json & j, DateOnlyConverter& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("DateOnlyConverter") != j.end() && !j.at("DateOnlyConverter").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_date_only_converter(j.at("DateOnlyConverter").get<int64_t>());
    }

    inline void to_json(json & j, const DateOnlyConverter & x) {
        j = json::object();
        j["DateOnlyConverter"] = x.get_date_only_converter();
    }

    inline void from_json(const json & j, DateParseHandling& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("date_parse_handling") != j.end() && !j.at("date_parse_handling").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_date_parse_handling(j.at("date_parse_handling").get<int64_t>());
    }

    inline void to_json(json & j, const DateParseHandling & x) {
        j = json::object();
        j["date_parse_handling"] = x.get_date_parse_handling();
    }

    inline void from_json(const json & j, DateTime& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("DateTime") != j.end() && !std::regex_match(j.at("DateTime").get<std::string>(), std::regex("^[0-9]{4}-[0-9]{2}-[0-9]{2}T.*$"))) throw std::runtime_error("Expected date-time");
        x.set_date_time(j.at("DateTime").get<std::string>());
    }

    inline void to_json(json & j, const DateTime & x) {
        j = json::object();
        j["DateTime"] = x.get_date_time();
    }

    inline void from_json(const json & j, DateTimeStyles& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("DateTimeStyles") != j.end() && !j.at("DateTimeStyles").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_date_time_styles(j.at("DateTimeStyles").get<int64_t>());
    }

    inline void to_json(json & j, const DateTimeStyles & x) {
        j = json::object();
        j["DateTimeStyles"] = x.get_date_time_styles();
    }

    inline void from_json(const json & j, Debugger& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("debugger") != j.end() && !j.at("debugger").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_debugger(j.at("debugger").get<int64_t>());
    }

    inline void to_json(json & j, const Debugger & x) {
        j = json::object();
        j["debugger"] = x.get_debugger();
    }

    inline void from_json(const json & j, Decimal& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("decimal") != j.end() && !j.at("decimal").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_decimal(j.at("decimal").get<int64_t>());
    }

    inline void to_json(json & j, const Decimal & x) {
        j = json::object();
        j["decimal"] = x.get_decimal();
    }

    inline void from_json(const json & j, Declare& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("declare") != j.end() && !j.at("declare").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_declare(j.at("declare").get<int64_t>());
    }

    inline void to_json(json & j, const Declare & x) {
        j = json::object();
        j["declare"] = x.get_declare();
    }

    inline void from_json(const json & j, DecodeString& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("decode_string") != j.end() && !j.at("decode_string").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_decode_string(j.at("decode_string").get<int64_t>());
    }

    inline void to_json(json & j, const DecodeString & x) {
        j = json::object();
        j["decode_string"] = x.get_decode_string();
    }

    inline void from_json(const json & j, Decoder& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("Decoder") != j.end() && !j.at("Decoder").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_decoder(j.at("Decoder").get<int64_t>());
    }

    inline void to_json(json & j, const Decoder & x) {
        j = json::object();
        j["Decoder"] = x.get_decoder();
    }

    inline void from_json(const json & j, DecodingError& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("DecodingError") != j.end() && !j.at("DecodingError").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_decoding_error(j.at("DecodingError").get<int64_t>());
    }

    inline void to_json(json & j, const DecodingError & x) {
        j = json::object();
        j["DecodingError"] = x.get_decoding_error();
    }

    inline void from_json(const json & j, Def& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("def") != j.end() && !j.at("def").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_def(j.at("def").get<int64_t>());
    }

    inline void to_json(json & j, const Def & x) {
        j = json::object();
        j["def"] = x.get_def();
    }

    inline void from_json(const json & j, Defer& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("defer") != j.end() && !j.at("defer").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_defer(j.at("defer").get<int64_t>());
    }

    inline void to_json(json & j, const Defer & x) {
        j = json::object();
        j["defer"] = x.get_defer();
    }

    inline void from_json(const json & j, Deinit& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("deinit") != j.end() && !j.at("deinit").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_deinit(j.at("deinit").get<int64_t>());
    }

    inline void to_json(json & j, const Deinit & x) {
        j = json::object();
        j["deinit"] = x.get_deinit();
    }

    inline void from_json(const json & j, Del& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("del") != j.end() && !j.at("del").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_del(j.at("del").get<int64_t>());
    }

    inline void to_json(json & j, const Del & x) {
        j = json::object();
        j["del"] = x.get_del();
    }

    inline void from_json(const json & j, Delegate& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("delegate") != j.end() && !j.at("delegate").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_delegate(j.at("delegate").get<int64_t>());
    }

    inline void to_json(json & j, const Delegate & x) {
        j = json::object();
        j["delegate"] = x.get_delegate();
    }

    inline void from_json(const json & j, DeserializationFeature& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("DeserializationFeature") != j.end() && !j.at("DeserializationFeature").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_deserialization_feature(j.at("DeserializationFeature").get<int64_t>());
    }

    inline void to_json(json & j, const DeserializationFeature & x) {
        j = json::object();
        j["DeserializationFeature"] = x.get_deserialization_feature();
    }

    inline void from_json(const json & j, Dict& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("dict") != j.end() && !j.at("dict").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_dict(j.at("dict").get<int64_t>());
    }

    inline void to_json(json & j, const Dict & x) {
        j = json::object();
        j["dict"] = x.get_dict();
    }

    inline void from_json(const json & j, Dictionary& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("dictionary") != j.end() && !j.at("dictionary").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_dictionary(j.at("dictionary").get<int64_t>());
    }

    inline void to_json(json & j, const Dictionary & x) {
        j = json::object();
        j["dictionary"] = x.get_dictionary();
    }

    inline void from_json(const json & j, DidSet& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("didSet") != j.end() && !j.at("didSet").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_did_set(j.at("didSet").get<int64_t>());
    }

    inline void to_json(json & j, const DidSet & x) {
        j = json::object();
        j["didSet"] = x.get_did_set();
    }

    inline void from_json(const json & j, DoubleNode& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("DoubleNode") != j.end() && !j.at("DoubleNode").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_double_node(j.at("DoubleNode").get<int64_t>());
    }

    inline void to_json(json & j, const DoubleNode & x) {
        j = json::object();
        j["DoubleNode"] = x.get_double_node();
    }

    inline void from_json(const json & j, Dynamic& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("dynamic") != j.end() && !j.at("dynamic").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_dynamic(j.at("dynamic").get<int64_t>());
    }

    inline void to_json(json & j, const Dynamic & x) {
        j = json::object();
        j["dynamic"] = x.get_dynamic();
    }

    inline void from_json(const json & j, Elif& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("elif") != j.end() && !j.at("elif").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_elif(j.at("elif").get<int64_t>());
    }

    inline void to_json(json & j, const Elif & x) {
        j = json::object();
        j["elif"] = x.get_elif();
    }

    inline void from_json(const json & j, EncodeQuickType& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("encode_quick_type") != j.end() && !j.at("encode_quick_type").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_encode_quick_type(j.at("encode_quick_type").get<int64_t>());
    }

    inline void to_json(json & j, const EncodeQuickType & x) {
        j = json::object();
        j["encode_quick_type"] = x.get_encode_quick_type();
    }

    inline void from_json(const json & j, Encoder& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("Encoder") != j.end() && !j.at("Encoder").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_encoder(j.at("Encoder").get<int64_t>());
    }

    inline void to_json(json & j, const Encoder & x) {
        j = json::object();
        j["Encoder"] = x.get_encoder();
    }

    inline void from_json(const json & j, EnumValues& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_enum_values(j.at("EnumValues").get<std::vector<EnumValue>>());
    }

    inline void to_json(json & j, const EnumValues & x) {
        j = json::object();
        j["EnumValues"] = x.get_enum_values();
    }

    inline void from_json(const json & j, EqualityContract& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("equalityContract") != j.end() && !j.at("equalityContract").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_equality_contract(j.at("equalityContract").get<int64_t>());
    }

    inline void to_json(json & j, const EqualityContract & x) {
        j = json::object();
        j["equalityContract"] = x.get_equality_contract();
    }

    inline void from_json(const json & j, Equatable& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("Equatable") != j.end() && !j.at("Equatable").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_equatable(j.at("Equatable").get<int64_t>());
    }

    inline void to_json(json & j, const Equatable & x) {
        j = json::object();
        j["Equatable"] = x.get_equatable();
    }

    inline void from_json(const json & j, Event& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("event") != j.end() && !j.at("event").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_event(j.at("event").get<int64_t>());
    }

    inline void to_json(json & j, const Event & x) {
        j = json::object();
        j["event"] = x.get_event();
    }

    inline void from_json(const json & j, Except& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("except") != j.end() && !j.at("except").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_except(j.at("except").get<int64_t>());
    }

    inline void to_json(json & j, const Except & x) {
        j = json::object();
        j["except"] = x.get_except();
    }

    inline void from_json(const json & j, Exception& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("exception") != j.end() && !j.at("exception").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_exception(j.at("exception").get<int64_t>());
    }

    inline void to_json(json & j, const Exception & x) {
        j = json::object();
        j["exception"] = x.get_exception();
    }

    inline void from_json(const json & j, Exposing& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("exposing") != j.end() && !j.at("exposing").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_exposing(j.at("exposing").get<int64_t>());
    }

    inline void to_json(json & j, const Exposing & x) {
        j = json::object();
        j["exposing"] = x.get_exposing();
    }

    inline void from_json(const json & j, Extends& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("extends") != j.end() && !j.at("extends").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_extends(j.at("extends").get<int64_t>());
    }

    inline void to_json(json & j, const Extends & x) {
        j = json::object();
        j["extends"] = x.get_extends();
    }

    inline void from_json(const json & j, Extension& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("extension") != j.end() && !j.at("extension").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_extension(j.at("extension").get<int64_t>());
    }

    inline void to_json(json & j, const Extension & x) {
        j = json::object();
        j["extension"] = x.get_extension();
    }

    inline void from_json(const json & j, Fallthrough& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("fallthrough") != j.end() && !j.at("fallthrough").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_fallthrough(j.at("fallthrough").get<int64_t>());
    }

    inline void to_json(json & j, const Fallthrough & x) {
        j = json::object();
        j["fallthrough"] = x.get_fallthrough();
    }

    inline void from_json(const json & j, Fileprivate& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("fileprivate") != j.end() && !j.at("fileprivate").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_fileprivate(j.at("fileprivate").get<int64_t>());
    }

    inline void to_json(json & j, const Fileprivate & x) {
        j = json::object();
        j["fileprivate"] = x.get_fileprivate();
    }

    inline void from_json(const json & j, Finally& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("finally") != j.end() && !j.at("finally").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_finally(j.at("finally").get<int64_t>());
    }

    inline void to_json(json & j, const Finally & x) {
        j = json::object();
        j["finally"] = x.get_finally();
    }

    inline void from_json(const json & j, Fixed& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("fixed") != j.end() && !j.at("fixed").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_fixed(j.at("fixed").get<int64_t>());
    }

    inline void to_json(json & j, const Fixed & x) {
        j = json::object();
        j["fixed"] = x.get_fixed();
    }

    inline void from_json(const json & j, Foreach& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("foreach") != j.end() && !j.at("foreach").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_foreach(j.at("foreach").get<int64_t>());
    }

    inline void to_json(json & j, const Foreach & x) {
        j = json::object();
        j["foreach"] = x.get_foreach();
    }

    inline void from_json(const json & j, FormatException& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("FormatException") != j.end() && !j.at("FormatException").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_format_exception(j.at("FormatException").get<int64_t>());
    }

    inline void to_json(json & j, const FormatException & x) {
        j = json::object();
        j["FormatException"] = x.get_format_exception();
    }

    inline void from_json(const json & j, From& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("from") != j.end() && !j.at("from").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_from(j.at("from").get<int64_t>());
    }

    inline void to_json(json & j, const From & x) {
        j = json::object();
        j["from"] = x.get_from();
    }

    inline void from_json(const json & j, FromDict& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("from_dict") != j.end() && !j.at("from_dict").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_from_dict(j.at("from_dict").get<int64_t>());
    }

    inline void to_json(json & j, const FromDict & x) {
        j = json::object();
        j["from_dict"] = x.get_from_dict();
    }

    inline void from_json(const json & j, FromJson& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("from_json") != j.end() && !j.at("from_json").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_from_json(j.at("from_json").get<int64_t>());
    }

    inline void to_json(json & j, const FromJson & x) {
        j = json::object();
        j["from_json"] = x.get_from_json();
    }

    inline void from_json(const json & j, Func& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("func") != j.end() && !j.at("func").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_func(j.at("func").get<int64_t>());
    }

    inline void to_json(json & j, const Func & x) {
        j = json::object();
        j["func"] = x.get_func();
    }

    inline void from_json(const json & j, Decltype& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("decltype") != j.end() && !j.at("decltype").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_decltype_decltype(j.at("decltype").get<int64_t>());
    }

    inline void to_json(json & j, const Decltype & x) {
        j = json::object();
        j["decltype"] = x.get_decltype_decltype();
    }

    inline void from_json(const json & j, Default& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("default") != j.end() && !j.at("default").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_default_default(j.at("default").get<int64_t>());
    }

    inline void to_json(json & j, const Default & x) {
        j = json::object();
        j["default"] = x.get_default_default();
    }

    inline void from_json(const json & j, Delete& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("delete") != j.end() && !j.at("delete").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_delete_delete(j.at("delete").get<int64_t>());
    }

    inline void to_json(json & j, const Delete & x) {
        j = json::object();
        j["delete"] = x.get_delete_delete();
    }

    inline void from_json(const json & j, Do& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("do") != j.end() && !j.at("do").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_do_do(j.at("do").get<int64_t>());
    }

    inline void to_json(json & j, const Do & x) {
        j = json::object();
        j["do"] = x.get_do_do();
    }

    inline void from_json(const json & j, Double& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("double") != j.end() && !j.at("double").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_double_double(j.at("double").get<int64_t>());
    }

    inline void to_json(json & j, const Double & x) {
        j = json::object();
        j["double"] = x.get_double_double();
    }

    inline void from_json(const json & j, DynamicCast& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("dynamic_cast") != j.end() && !j.at("dynamic_cast").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_dynamic_cast_dynamic_cast(j.at("dynamic_cast").get<int64_t>());
    }

    inline void to_json(json & j, const DynamicCast & x) {
        j = json::object();
        j["dynamic_cast"] = x.get_dynamic_cast_dynamic_cast();
    }

    inline void from_json(const json & j, Else& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("else") != j.end() && !j.at("else").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_else_else(j.at("else").get<int64_t>());
    }

    inline void to_json(json & j, const Else & x) {
        j = json::object();
        j["else"] = x.get_else_else();
    }

    inline void from_json(const json & j, Enum& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("enum") != j.end() && !j.at("enum").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_enum_enum(j.at("enum").get<int64_t>());
    }

    inline void to_json(json & j, const Enum & x) {
        j = json::object();
        j["enum"] = x.get_enum_enum();
    }

    inline void from_json(const json & j, Explicit& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("explicit") != j.end() && !j.at("explicit").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_explicit_explicit(j.at("explicit").get<int64_t>());
    }

    inline void to_json(json & j, const Explicit & x) {
        j = json::object();
        j["explicit"] = x.get_explicit_explicit();
    }

    inline void from_json(const json & j, Export& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("export") != j.end() && !j.at("export").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_export_export(j.at("export").get<int64_t>());
    }

    inline void to_json(json & j, const Export & x) {
        j = json::object();
        j["export"] = x.get_export_export();
    }

    inline void from_json(const json & j, Extern& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("extern") != j.end() && !j.at("extern").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_extern_extern(j.at("extern").get<int64_t>());
    }

    inline void to_json(json & j, const Extern & x) {
        j = json::object();
        j["extern"] = x.get_extern_extern();
    }

    inline void from_json(const json & j, False& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("False") != j.end() && !j.at("False").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_false_false(j.at("False").get<int64_t>());
    }

    inline void to_json(json & j, const False & x) {
        j = json::object();
        j["False"] = x.get_false_false();
    }

    inline void from_json(const json & j, Final& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("final") != j.end() && !j.at("final").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_final_final(j.at("final").get<int64_t>());
    }

    inline void to_json(json & j, const Final & x) {
        j = json::object();
        j["final"] = x.get_final_final();
    }

    inline void from_json(const json & j, Float& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("float") != j.end() && !j.at("float").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_float_float(j.at("float").get<int64_t>());
    }

    inline void to_json(json & j, const Float & x) {
        j = json::object();
        j["float"] = x.get_float_float();
    }

    inline void from_json(const json & j, For& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("for") != j.end() && !j.at("for").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_for_for(j.at("for").get<int64_t>());
    }

    inline void to_json(json & j, const For & x) {
        j = json::object();
        j["for"] = x.get_for_for();
    }

    inline void from_json(const json & j, Friend& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("friend") != j.end() && !j.at("friend").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_friend_friend(j.at("friend").get<int64_t>());
    }

    inline void to_json(json & j, const Friend & x) {
        j = json::object();
        j["friend"] = x.get_friend_friend();
    }

    inline void from_json(const json & j, FalseClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("false") != j.end() && !j.at("false").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_false_false(j.at("false").get<int64_t>());
    }

    inline void to_json(json & j, const FalseClass & x) {
        j = json::object();
        j["false"] = x.get_false_false();
    }

    inline void from_json(const json & j, Obj2& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_culture_info(j.at("CultureInfo").get<CultureInfo>());
        x.set_date(j.at("date").get<Date>());
        x.set_date_formatter(j.at("DateFormatter").get<DateFormatter>());
        x.set_date_only(j.at("DateOnly").get<DateOnly>());
        x.set_date_only_converter(j.at("DateOnlyConverter").get<DateOnlyConverter>());
        x.set_date_parse_handling(j.at("date_parse_handling").get<DateParseHandling>());
        x.set_date_time(j.at("DateTime").get<DateTime>());
        x.set_date_time_styles(j.at("DateTimeStyles").get<DateTimeStyles>());
        x.set_debugger(j.at("debugger").get<Debugger>());
        x.set_decimal(j.at("decimal").get<Decimal>());
        x.set_declare(j.at("declare").get<Declare>());
        x.set_decode_string(j.at("decode_string").get<DecodeString>());
        x.set_decoder(j.at("Decoder").get<Decoder>());
        x.set_decoding_error(j.at("DecodingError").get<DecodingError>());
        x.set_def(j.at("def").get<Def>());
        x.set_defer(j.at("defer").get<Defer>());
        x.set_deinit(j.at("deinit").get<Deinit>());
        x.set_del(j.at("del").get<Del>());
        x.set_delegate(j.at("delegate").get<Delegate>());
        x.set_deserialization_feature(j.at("DeserializationFeature").get<DeserializationFeature>());
        x.set_dict(j.at("dict").get<Dict>());
        x.set_dictionary(j.at("dictionary").get<Dictionary>());
        x.set_did_set(j.at("didSet").get<DidSet>());
        x.set_double_node(j.at("DoubleNode").get<DoubleNode>());
        if (j.find("dummy") != j.end() && !j.at("dummy").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_dummy(j.at("dummy").get<int64_t>());
        x.set_dynamic(j.at("dynamic").get<Dynamic>());
        x.set_elif(j.at("elif").get<Elif>());
        x.set_encode_quick_type(j.at("encode_quick_type").get<EncodeQuickType>());
        x.set_encoder(j.at("Encoder").get<Encoder>());
        x.set_enum_values(j.at("EnumValues").get<EnumValues>());
        x.set_equality_contract(j.at("equalityContract").get<EqualityContract>());
        x.set_equatable(j.at("Equatable").get<Equatable>());
        x.set_event(j.at("event").get<Event>());
        x.set_except(j.at("except").get<Except>());
        x.set_exception(j.at("exception").get<Exception>());
        x.set_exposing(j.at("exposing").get<Exposing>());
        x.set_extends(j.at("extends").get<Extends>());
        x.set_extension(j.at("extension").get<Extension>());
        x.set_fallthrough(j.at("fallthrough").get<Fallthrough>());
        x.set_fileprivate(j.at("fileprivate").get<Fileprivate>());
        x.set_finally(j.at("finally").get<Finally>());
        x.set_fixed(j.at("fixed").get<Fixed>());
        x.set_foreach(j.at("foreach").get<Foreach>());
        x.set_format_exception(j.at("FormatException").get<FormatException>());
        x.set_from(j.at("from").get<From>());
        x.set_from_dict(j.at("from_dict").get<FromDict>());
        x.set_from_json(j.at("from_json").get<FromJson>());
        x.set_func(j.at("func").get<Func>());
        x.set_obj2_decltype(j.at("decltype").get<Decltype>());
        x.set_obj2_default(j.at("default").get<Default>());
        x.set_obj2_delete(j.at("delete").get<Delete>());
        x.set_obj2_do(j.at("do").get<Do>());
        x.set_obj2_double(j.at("double").get<Double>());
        x.set_obj2_dynamic_cast(j.at("dynamic_cast").get<DynamicCast>());
        x.set_obj2_else(j.at("else").get<Else>());
        x.set_obj2_enum(j.at("enum").get<Enum>());
        x.set_obj2_explicit(j.at("explicit").get<Explicit>());
        x.set_obj2_export(j.at("export").get<Export>());
        x.set_obj2_extern(j.at("extern").get<Extern>());
        x.set_obj2_false(j.at("False").get<False>());
        x.set_obj2_final(j.at("final").get<Final>());
        x.set_obj2_float(j.at("float").get<Float>());
        x.set_obj2_for(j.at("for").get<For>());
        x.set_obj2_friend(j.at("friend").get<Friend>());
        x.set_purple_false(j.at("false").get<FalseClass>());
    }

    inline void to_json(json & j, const Obj2 & x) {
        j = json::object();
        j["CultureInfo"] = x.get_culture_info();
        j["date"] = x.get_date();
        j["DateFormatter"] = x.get_date_formatter();
        j["DateOnly"] = x.get_date_only();
        j["DateOnlyConverter"] = x.get_date_only_converter();
        j["date_parse_handling"] = x.get_date_parse_handling();
        j["DateTime"] = x.get_date_time();
        j["DateTimeStyles"] = x.get_date_time_styles();
        j["debugger"] = x.get_debugger();
        j["decimal"] = x.get_decimal();
        j["declare"] = x.get_declare();
        j["decode_string"] = x.get_decode_string();
        j["Decoder"] = x.get_decoder();
        j["DecodingError"] = x.get_decoding_error();
        j["def"] = x.get_def();
        j["defer"] = x.get_defer();
        j["deinit"] = x.get_deinit();
        j["del"] = x.get_del();
        j["delegate"] = x.get_delegate();
        j["DeserializationFeature"] = x.get_deserialization_feature();
        j["dict"] = x.get_dict();
        j["dictionary"] = x.get_dictionary();
        j["didSet"] = x.get_did_set();
        j["DoubleNode"] = x.get_double_node();
        j["dummy"] = x.get_dummy();
        j["dynamic"] = x.get_dynamic();
        j["elif"] = x.get_elif();
        j["encode_quick_type"] = x.get_encode_quick_type();
        j["Encoder"] = x.get_encoder();
        j["EnumValues"] = x.get_enum_values();
        j["equalityContract"] = x.get_equality_contract();
        j["Equatable"] = x.get_equatable();
        j["event"] = x.get_event();
        j["except"] = x.get_except();
        j["exception"] = x.get_exception();
        j["exposing"] = x.get_exposing();
        j["extends"] = x.get_extends();
        j["extension"] = x.get_extension();
        j["fallthrough"] = x.get_fallthrough();
        j["fileprivate"] = x.get_fileprivate();
        j["finally"] = x.get_finally();
        j["fixed"] = x.get_fixed();
        j["foreach"] = x.get_foreach();
        j["FormatException"] = x.get_format_exception();
        j["from"] = x.get_from();
        j["from_dict"] = x.get_from_dict();
        j["from_json"] = x.get_from_json();
        j["func"] = x.get_func();
        j["decltype"] = x.get_obj2_decltype();
        j["default"] = x.get_obj2_default();
        j["delete"] = x.get_obj2_delete();
        j["do"] = x.get_obj2_do();
        j["double"] = x.get_obj2_double();
        j["dynamic_cast"] = x.get_obj2_dynamic_cast();
        j["else"] = x.get_obj2_else();
        j["enum"] = x.get_obj2_enum();
        j["explicit"] = x.get_obj2_explicit();
        j["export"] = x.get_obj2_export();
        j["extern"] = x.get_obj2_extern();
        j["False"] = x.get_obj2_false();
        j["final"] = x.get_obj2_final();
        j["float"] = x.get_obj2_float();
        j["for"] = x.get_obj2_for();
        j["friend"] = x.get_obj2_friend();
        j["false"] = x.get_purple_false();
    }

    inline void from_json(const json & j, Function& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("function") != j.end() && !j.at("function").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_function(j.at("function").get<int64_t>());
    }

    inline void to_json(json & j, const Function & x) {
        j = json::object();
        j["function"] = x.get_function();
    }

    inline void from_json(const json & j, Get& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("get") != j.end() && !j.at("get").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_get(j.at("get").get<int64_t>());
    }

    inline void to_json(json & j, const Get & x) {
        j = json::object();
        j["get"] = x.get_get();
    }

    inline void from_json(const json & j, Global& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("global") != j.end() && !j.at("global").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_global(j.at("global").get<int64_t>());
    }

    inline void to_json(json & j, const Global & x) {
        j = json::object();
        j["global"] = x.get_global();
    }

    inline void from_json(const json & j, Go& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("go") != j.end() && !j.at("go").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_go(j.at("go").get<int64_t>());
    }

    inline void to_json(json & j, const Go & x) {
        j = json::object();
        j["go"] = x.get_go();
    }

    inline void from_json(const json & j, Guard& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("guard") != j.end() && !j.at("guard").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_guard(j.at("guard").get<int64_t>());
    }

    inline void to_json(json & j, const Guard & x) {
        j = json::object();
        j["guard"] = x.get_guard();
    }

    inline void from_json(const json & j, HasOwnProperty& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("hasOwnProperty") != j.end() && !j.at("hasOwnProperty").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_has_own_property(j.at("hasOwnProperty").get<int64_t>());
    }

    inline void to_json(json & j, const HasOwnProperty & x) {
        j = json::object();
        j["hasOwnProperty"] = x.get_has_own_property();
    }

    inline void from_json(const json & j, HashCode& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("hashCode") != j.end() && !j.at("hashCode").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_hash_code(j.at("hashCode").get<int64_t>());
    }

    inline void to_json(json & j, const HashCode & x) {
        j = json::object();
        j["hashCode"] = x.get_hash_code();
    }

    inline void from_json(const json & j, Hashable& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("Hashable") != j.end() && !j.at("Hashable").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_hashable(j.at("Hashable").get<int64_t>());
    }

    inline void to_json(json & j, const Hashable & x) {
        j = json::object();
        j["Hashable"] = x.get_hashable();
    }

    inline void from_json(const json & j, Hasher& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("Hasher") != j.end() && !j.at("Hasher").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_hasher(j.at("Hasher").get<int64_t>());
    }

    inline void to_json(json & j, const Hasher & x) {
        j = json::object();
        j["Hasher"] = x.get_hasher();
    }

    inline void from_json(const json & j, Id& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("id") != j.end() && !j.at("id").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_id(j.at("id").get<int64_t>());
    }

    inline void to_json(json & j, const Id & x) {
        j = json::object();
        j["id"] = x.get_id();
    }

    inline void from_json(const json & j, Imp& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("IMP") != j.end() && !j.at("IMP").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_imp(j.at("IMP").get<int64_t>());
    }

    inline void to_json(json & j, const Imp & x) {
        j = json::object();
        j["IMP"] = x.get_imp();
    }

    inline void from_json(const json & j, Implements& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("implements") != j.end() && !j.at("implements").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_implements(j.at("implements").get<int64_t>());
    }

    inline void to_json(json & j, const Implements & x) {
        j = json::object();
        j["implements"] = x.get_implements();
    }

    inline void from_json(const json & j, Implicit& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("implicit") != j.end() && !j.at("implicit").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_implicit(j.at("implicit").get<int64_t>());
    }

    inline void to_json(json & j, const Implicit & x) {
        j = json::object();
        j["implicit"] = x.get_implicit();
    }

    inline void from_json(const json & j, In& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("in") != j.end() && !j.at("in").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_in(j.at("in").get<int64_t>());
    }

    inline void to_json(json & j, const In & x) {
        j = json::object();
        j["in"] = x.get_in();
    }

    inline void from_json(const json & j, Indirect& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("indirect") != j.end() && !j.at("indirect").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_indirect(j.at("indirect").get<int64_t>());
    }

    inline void to_json(json & j, const Indirect & x) {
        j = json::object();
        j["indirect"] = x.get_indirect();
    }

    inline void from_json(const json & j, Infix& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("infix") != j.end() && !j.at("infix").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_infix(j.at("infix").get<int64_t>());
    }

    inline void to_json(json & j, const Infix & x) {
        j = json::object();
        j["infix"] = x.get_infix();
    }

    inline void from_json(const json & j, Init& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("init") != j.end() && !j.at("init").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_init(j.at("init").get<int64_t>());
    }

    inline void to_json(json & j, const Init & x) {
        j = json::object();
        j["init"] = x.get_init();
    }

    inline void from_json(const json & j, Inout& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("inout") != j.end() && !j.at("inout").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_inout(j.at("inout").get<int64_t>());
    }

    inline void to_json(json & j, const Inout & x) {
        j = json::object();
        j["inout"] = x.get_inout();
    }

    inline void from_json(const json & j, Instanceof& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("instanceof") != j.end() && !j.at("instanceof").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_instanceof(j.at("instanceof").get<int64_t>());
    }

    inline void to_json(json & j, const Instanceof & x) {
        j = json::object();
        j["instanceof"] = x.get_instanceof();
    }

    inline void from_json(const json & j, IntNode& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("IntNode") != j.end() && !j.at("IntNode").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_int_node(j.at("IntNode").get<int64_t>());
    }

    inline void to_json(json & j, const IntNode & x) {
        j = json::object();
        j["IntNode"] = x.get_int_node();
    }

    inline void from_json(const json & j, Interface& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("interface") != j.end() && !j.at("interface").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_interface(j.at("interface").get<int64_t>());
    }

    inline void to_json(json & j, const Interface & x) {
        j = json::object();
        j["interface"] = x.get_interface();
    }

    inline void from_json(const json & j, Internal& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("internal") != j.end() && !j.at("internal").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_internal(j.at("internal").get<int64_t>());
    }

    inline void to_json(json & j, const Internal & x) {
        j = json::object();
        j["internal"] = x.get_internal();
    }

    inline void from_json(const json & j, Is& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("is") != j.end() && !j.at("is").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_is(j.at("is").get<int64_t>());
    }

    inline void to_json(json & j, const Is & x) {
        j = json::object();
        j["is"] = x.get_is();
    }

    inline void from_json(const json & j, IsoDateTimeOffsetConverter& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("IsoDateTimeOffsetConverter") != j.end() && !j.at("IsoDateTimeOffsetConverter").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_iso_date_time_offset_converter(j.at("IsoDateTimeOffsetConverter").get<int64_t>());
    }

    inline void to_json(json & j, const IsoDateTimeOffsetConverter & x) {
        j = json::object();
        j["IsoDateTimeOffsetConverter"] = x.get_iso_date_time_offset_converter();
    }

    inline void from_json(const json & j, Iterable& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("iterable") != j.end() && !j.at("iterable").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_iterable(j.at("iterable").get<int64_t>());
    }

    inline void to_json(json & j, const Iterable & x) {
        j = json::object();
        j["iterable"] = x.get_iterable();
    }

    inline void from_json(const json & j, Jdec& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("jdec") != j.end() && !j.at("jdec").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_jdec(j.at("jdec").get<int64_t>());
    }

    inline void to_json(json & j, const Jdec & x) {
        j = json::object();
        j["jdec"] = x.get_jdec();
    }

    inline void from_json(const json & j, Jenc& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("jenc") != j.end() && !j.at("jenc").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_jenc(j.at("jenc").get<int64_t>());
    }

    inline void to_json(json & j, const Jenc & x) {
        j = json::object();
        j["jenc"] = x.get_jenc();
    }

    inline void from_json(const json & j, Jpipe& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("jpipe") != j.end() && !j.at("jpipe").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_jpipe(j.at("jpipe").get<int64_t>());
    }

    inline void to_json(json & j, const Jpipe & x) {
        j = json::object();
        j["jpipe"] = x.get_jpipe();
    }

    inline void from_json(const json & j, Json& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("json") != j.end() && !j.at("json").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_json(j.at("json").get<int64_t>());
    }

    inline void to_json(json & j, const Json & x) {
        j = json::object();
        j["json"] = x.get_json();
    }

    inline void from_json(const json & j, JsonAny& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_json_any(get_untyped(j, "JSONAny"));
    }

    inline void to_json(json & j, const JsonAny & x) {
        j = json::object();
        j["JSONAny"] = x.get_json_any();
    }

    inline void from_json(const json & j, JsonCodingKey& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("JSONCodingKey") != j.end() && !j.at("JSONCodingKey").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_json_coding_key(j.at("JSONCodingKey").get<int64_t>());
    }

    inline void to_json(json & j, const JsonCodingKey & x) {
        j = json::object();
        j["JSONCodingKey"] = x.get_json_coding_key();
    }

    inline void from_json(const json & j, JsonConverter& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("json_converter") != j.end() && !j.at("json_converter").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_json_converter(j.at("json_converter").get<int64_t>());
    }

    inline void to_json(json & j, const JsonConverter & x) {
        j = json::object();
        j["json_converter"] = x.get_json_converter();
    }

    inline void from_json(const json & j, JsonDecoder& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("JSONDecoder") != j.end() && !j.at("JSONDecoder").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_json_decoder(j.at("JSONDecoder").get<int64_t>());
    }

    inline void to_json(json & j, const JsonDecoder & x) {
        j = json::object();
        j["JSONDecoder"] = x.get_json_decoder();
    }

    inline void from_json(const json & j, JsonEncoder& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("JSONEncoder") != j.end() && !j.at("JSONEncoder").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_json_encoder(j.at("JSONEncoder").get<int64_t>());
    }

    inline void to_json(json & j, const JsonEncoder & x) {
        j = json::object();
        j["JSONEncoder"] = x.get_json_encoder();
    }

    inline void from_json(const json & j, JsonException& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("JsonException") != j.end() && !j.at("JsonException").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_json_exception(j.at("JsonException").get<int64_t>());
    }

    inline void to_json(json & j, const JsonException & x) {
        j = json::object();
        j["JsonException"] = x.get_json_exception();
    }

    inline void from_json(const json & j, JsonGenerator& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("JsonGenerator") != j.end() && !j.at("JsonGenerator").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_json_generator(j.at("JsonGenerator").get<int64_t>());
    }

    inline void to_json(json & j, const JsonGenerator & x) {
        j = json::object();
        j["JsonGenerator"] = x.get_json_generator();
    }

    inline void from_json(const json & j, JsonNode& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("JsonNode") != j.end() && !j.at("JsonNode").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_json_node(j.at("JsonNode").get<int64_t>());
    }

    inline void to_json(json & j, const JsonNode & x) {
        j = json::object();
        j["JsonNode"] = x.get_json_node();
    }

    inline void from_json(const json & j, JsonNull& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("JSONNull") != j.end() && !j.at("JSONNull").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_json_null(j.at("JSONNull").get<int64_t>());
    }

    inline void to_json(json & j, const JsonNull & x) {
        j = json::object();
        j["JSONNull"] = x.get_json_null();
    }

    inline void from_json(const json & j, JsonParser& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("JsonParser") != j.end() && !j.at("JsonParser").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_json_parser(j.at("JsonParser").get<int64_t>());
    }

    inline void to_json(json & j, const JsonParser & x) {
        j = json::object();
        j["JsonParser"] = x.get_json_parser();
    }

    inline void from_json(const json & j, JsonReader& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("JsonReader") != j.end() && !j.at("JsonReader").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_json_reader(j.at("JsonReader").get<int64_t>());
    }

    inline void to_json(json & j, const JsonReader & x) {
        j = json::object();
        j["JsonReader"] = x.get_json_reader();
    }

    inline void from_json(const json & j, JsonSerializer& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("json_serializer") != j.end() && !j.at("json_serializer").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_json_serializer(j.at("json_serializer").get<int64_t>());
    }

    inline void to_json(json & j, const JsonSerializer & x) {
        j = json::object();
        j["json_serializer"] = x.get_json_serializer();
    }

    inline void from_json(const json & j, JsonToken& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("json_token") != j.end() && !j.at("json_token").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_json_token(j.at("json_token").get<int64_t>());
    }

    inline void to_json(json & j, const JsonToken & x) {
        j = json::object();
        j["json_token"] = x.get_json_token();
    }

    inline void from_json(const json & j, JsonTokenType& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("JsonTokenType") != j.end() && !j.at("JsonTokenType").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_json_token_type(j.at("JsonTokenType").get<int64_t>());
    }

    inline void to_json(json & j, const JsonTokenType & x) {
        j = json::object();
        j["JsonTokenType"] = x.get_json_token_type();
    }

    inline void from_json(const json & j, JsonWriter& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("json_writer") != j.end() && !j.at("json_writer").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_json_writer(j.at("json_writer").get<int64_t>());
    }

    inline void to_json(json & j, const JsonWriter & x) {
        j = json::object();
        j["json_writer"] = x.get_json_writer();
    }

    inline void from_json(const json & j, Lambda& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("lambda") != j.end() && !j.at("lambda").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_lambda(j.at("lambda").get<int64_t>());
    }

    inline void to_json(json & j, const Lambda & x) {
        j = json::object();
        j["lambda"] = x.get_lambda();
    }

    inline void from_json(const json & j, Lazy& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("lazy") != j.end() && !j.at("lazy").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_lazy(j.at("lazy").get<int64_t>());
    }

    inline void to_json(json & j, const Lazy & x) {
        j = json::object();
        j["lazy"] = x.get_lazy();
    }

    inline void from_json(const json & j, Left& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("left") != j.end() && !j.at("left").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_left(j.at("left").get<int64_t>());
    }

    inline void to_json(json & j, const Left & x) {
        j = json::object();
        j["left"] = x.get_left();
    }

    inline void from_json(const json & j, Let& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("let") != j.end() && !j.at("let").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_let(j.at("let").get<int64_t>());
    }

    inline void to_json(json & j, const Let & x) {
        j = json::object();
        j["let"] = x.get_let();
    }

    inline void from_json(const json & j, List& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("list") != j.end() && !j.at("list").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_list(j.at("list").get<int64_t>());
    }

    inline void to_json(json & j, const List & x) {
        j = json::object();
        j["list"] = x.get_list();
    }

    inline void from_json(const json & j, LocalDate& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("LocalDate") != j.end() && !j.at("LocalDate").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_local_date(j.at("LocalDate").get<int64_t>());
    }

    inline void to_json(json & j, const LocalDate & x) {
        j = json::object();
        j["LocalDate"] = x.get_local_date();
    }

    inline void from_json(const json & j, Locale& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("Locale") != j.end() && !j.at("Locale").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_locale(j.at("Locale").get<int64_t>());
    }

    inline void to_json(json & j, const Locale & x) {
        j = json::object();
        j["Locale"] = x.get_locale();
    }

    inline void from_json(const json & j, Lock& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("lock") != j.end() && !j.at("lock").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_lock(j.at("lock").get<int64_t>());
    }

    inline void to_json(json & j, const Lock & x) {
        j = json::object();
        j["lock"] = x.get_lock();
    }

    inline void from_json(const json & j, LongNode& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("LongNode") != j.end() && !j.at("LongNode").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_long_node(j.at("LongNode").get<int64_t>());
    }

    inline void to_json(json & j, const LongNode & x) {
        j = json::object();
        j["LongNode"] = x.get_long_node();
    }

    inline void from_json(const json & j, Map& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("map") != j.end() && !j.at("map").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_map(j.at("map").get<int64_t>());
    }

    inline void to_json(json & j, const Map & x) {
        j = json::object();
        j["map"] = x.get_map();
    }

    inline void from_json(const json & j, MapEntry& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("MapEntry") != j.end() && !j.at("MapEntry").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_map_entry(j.at("MapEntry").get<int64_t>());
    }

    inline void to_json(json & j, const MapEntry & x) {
        j = json::object();
        j["MapEntry"] = x.get_map_entry();
    }

    inline void from_json(const json & j, MarshalJson& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("MarshalJSON") != j.end() && !j.at("MarshalJSON").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_marshal_json(j.at("MarshalJSON").get<int64_t>());
    }

    inline void to_json(json & j, const MarshalJson & x) {
        j = json::object();
        j["MarshalJSON"] = x.get_marshal_json();
    }

    inline void from_json(const json & j, MetadataPropertyHandling& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("metadata_property_handling") != j.end() && !j.at("metadata_property_handling").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_metadata_property_handling(j.at("metadata_property_handling").get<int64_t>());
    }

    inline void to_json(json & j, const MetadataPropertyHandling & x) {
        j = json::object();
        j["metadata_property_handling"] = x.get_metadata_property_handling();
    }

    inline void from_json(const json & j, Goto& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("goto") != j.end() && !j.at("goto").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_goto_goto(j.at("goto").get<int64_t>());
    }

    inline void to_json(json & j, const Goto & x) {
        j = json::object();
        j["goto"] = x.get_goto_goto();
    }

    inline void from_json(const json & j, If& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("if") != j.end() && !j.at("if").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_if_if(j.at("if").get<int64_t>());
    }

    inline void to_json(json & j, const If & x) {
        j = json::object();
        j["if"] = x.get_if_if();
    }

    inline void from_json(const json & j, Import& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("import") != j.end() && !j.at("import").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_import_import(j.at("import").get<int64_t>());
    }

    inline void to_json(json & j, const Import & x) {
        j = json::object();
        j["import"] = x.get_import_import();
    }

    inline void from_json(const json & j, Inline& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("inline") != j.end() && !j.at("inline").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_inline_inline(j.at("inline").get<int64_t>());
    }

    inline void to_json(json & j, const Inline & x) {
        j = json::object();
        j["inline"] = x.get_inline_inline();
    }

    inline void from_json(const json & j, Int& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("int") != j.end() && !j.at("int").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_int_int(j.at("int").get<int64_t>());
    }

    inline void to_json(json & j, const Int & x) {
        j = json::object();
        j["int"] = x.get_int_int();
    }

    inline void from_json(const json & j, Long& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("long") != j.end() && !j.at("long").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_long_long(j.at("long").get<int64_t>());
    }

    inline void to_json(json & j, const Long & x) {
        j = json::object();
        j["long"] = x.get_long_long();
    }

    inline void from_json(const json & j, Module& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("module") != j.end() && !j.at("module").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_module_module(j.at("module").get<int64_t>());
    }

    inline void to_json(json & j, const Module & x) {
        j = json::object();
        j["module"] = x.get_module_module();
    }

    inline void from_json(const json & j, Obj3& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("dummy") != j.end() && !j.at("dummy").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_dummy(j.at("dummy").get<int64_t>());
        x.set_function(j.at("function").get<Function>());
        x.set_get(j.at("get").get<Get>());
        x.set_global(j.at("global").get<Global>());
        x.set_go(j.at("go").get<Go>());
        x.set_guard(j.at("guard").get<Guard>());
        x.set_has_own_property(j.at("hasOwnProperty").get<HasOwnProperty>());
        x.set_hash_code(j.at("hashCode").get<HashCode>());
        x.set_hashable(j.at("Hashable").get<Hashable>());
        x.set_hasher(j.at("Hasher").get<Hasher>());
        x.set_id(j.at("id").get<Id>());
        x.set_imp(j.at("IMP").get<Imp>());
        x.set_implements(j.at("implements").get<Implements>());
        x.set_implicit(j.at("implicit").get<Implicit>());
        x.set_in(j.at("in").get<In>());
        x.set_indirect(j.at("indirect").get<Indirect>());
        x.set_infix(j.at("infix").get<Infix>());
        x.set_init(j.at("init").get<Init>());
        x.set_inout(j.at("inout").get<Inout>());
        x.set_instanceof(j.at("instanceof").get<Instanceof>());
        x.set_int_node(j.at("IntNode").get<IntNode>());
        x.set_interface(j.at("interface").get<Interface>());
        x.set_internal(j.at("internal").get<Internal>());
        x.set_is(j.at("is").get<Is>());
        x.set_iso_date_time_offset_converter(j.at("IsoDateTimeOffsetConverter").get<IsoDateTimeOffsetConverter>());
        x.set_iterable(j.at("iterable").get<Iterable>());
        x.set_jdec(j.at("jdec").get<Jdec>());
        x.set_jenc(j.at("jenc").get<Jenc>());
        x.set_jpipe(j.at("jpipe").get<Jpipe>());
        x.set_json(j.at("json").get<Json>());
        x.set_json_any(j.at("JSONAny").get<JsonAny>());
        x.set_json_coding_key(j.at("JSONCodingKey").get<JsonCodingKey>());
        x.set_json_converter(j.at("json_converter").get<JsonConverter>());
        x.set_json_decoder(j.at("JSONDecoder").get<JsonDecoder>());
        x.set_json_encoder(j.at("JSONEncoder").get<JsonEncoder>());
        x.set_json_exception(j.at("JsonException").get<JsonException>());
        x.set_json_generator(j.at("JsonGenerator").get<JsonGenerator>());
        x.set_json_node(j.at("JsonNode").get<JsonNode>());
        x.set_json_null(j.at("JSONNull").get<JsonNull>());
        x.set_json_parser(j.at("JsonParser").get<JsonParser>());
        x.set_json_reader(j.at("JsonReader").get<JsonReader>());
        x.set_json_serializer(j.at("json_serializer").get<JsonSerializer>());
        x.set_json_token(j.at("json_token").get<JsonToken>());
        x.set_json_token_type(j.at("JsonTokenType").get<JsonTokenType>());
        x.set_json_writer(j.at("json_writer").get<JsonWriter>());
        x.set_lambda(j.at("lambda").get<Lambda>());
        x.set_lazy(j.at("lazy").get<Lazy>());
        x.set_left(j.at("left").get<Left>());
        x.set_let(j.at("let").get<Let>());
        x.set_list(j.at("list").get<List>());
        x.set_local_date(j.at("LocalDate").get<LocalDate>());
        x.set_locale(j.at("Locale").get<Locale>());
        x.set_lock(j.at("lock").get<Lock>());
        x.set_long_node(j.at("LongNode").get<LongNode>());
        x.set_map(j.at("map").get<Map>());
        x.set_map_entry(j.at("MapEntry").get<MapEntry>());
        x.set_marshal_json(j.at("MarshalJSON").get<MarshalJson>());
        x.set_metadata_property_handling(j.at("metadata_property_handling").get<MetadataPropertyHandling>());
        x.set_obj3_goto(j.at("goto").get<Goto>());
        x.set_obj3_if(j.at("if").get<If>());
        x.set_obj3_import(j.at("import").get<Import>());
        x.set_obj3_inline(j.at("inline").get<Inline>());
        x.set_obj3_int(j.at("int").get<Int>());
        x.set_obj3_long(j.at("long").get<Long>());
        x.set_obj3_module(j.at("module").get<Module>());
    }

    inline void to_json(json & j, const Obj3 & x) {
        j = json::object();
        j["dummy"] = x.get_dummy();
        j["function"] = x.get_function();
        j["get"] = x.get_get();
        j["global"] = x.get_global();
        j["go"] = x.get_go();
        j["guard"] = x.get_guard();
        j["hasOwnProperty"] = x.get_has_own_property();
        j["hashCode"] = x.get_hash_code();
        j["Hashable"] = x.get_hashable();
        j["Hasher"] = x.get_hasher();
        j["id"] = x.get_id();
        j["IMP"] = x.get_imp();
        j["implements"] = x.get_implements();
        j["implicit"] = x.get_implicit();
        j["in"] = x.get_in();
        j["indirect"] = x.get_indirect();
        j["infix"] = x.get_infix();
        j["init"] = x.get_init();
        j["inout"] = x.get_inout();
        j["instanceof"] = x.get_instanceof();
        j["IntNode"] = x.get_int_node();
        j["interface"] = x.get_interface();
        j["internal"] = x.get_internal();
        j["is"] = x.get_is();
        j["IsoDateTimeOffsetConverter"] = x.get_iso_date_time_offset_converter();
        j["iterable"] = x.get_iterable();
        j["jdec"] = x.get_jdec();
        j["jenc"] = x.get_jenc();
        j["jpipe"] = x.get_jpipe();
        j["json"] = x.get_json();
        j["JSONAny"] = x.get_json_any();
        j["JSONCodingKey"] = x.get_json_coding_key();
        j["json_converter"] = x.get_json_converter();
        j["JSONDecoder"] = x.get_json_decoder();
        j["JSONEncoder"] = x.get_json_encoder();
        j["JsonException"] = x.get_json_exception();
        j["JsonGenerator"] = x.get_json_generator();
        j["JsonNode"] = x.get_json_node();
        j["JSONNull"] = x.get_json_null();
        j["JsonParser"] = x.get_json_parser();
        j["JsonReader"] = x.get_json_reader();
        j["json_serializer"] = x.get_json_serializer();
        j["json_token"] = x.get_json_token();
        j["JsonTokenType"] = x.get_json_token_type();
        j["json_writer"] = x.get_json_writer();
        j["lambda"] = x.get_lambda();
        j["lazy"] = x.get_lazy();
        j["left"] = x.get_left();
        j["let"] = x.get_let();
        j["list"] = x.get_list();
        j["LocalDate"] = x.get_local_date();
        j["Locale"] = x.get_locale();
        j["lock"] = x.get_lock();
        j["LongNode"] = x.get_long_node();
        j["map"] = x.get_map();
        j["MapEntry"] = x.get_map_entry();
        j["MarshalJSON"] = x.get_marshal_json();
        j["metadata_property_handling"] = x.get_metadata_property_handling();
        j["goto"] = x.get_obj3_goto();
        j["if"] = x.get_obj3_if();
        j["import"] = x.get_obj3_import();
        j["inline"] = x.get_obj3_inline();
        j["int"] = x.get_obj3_int();
        j["long"] = x.get_obj3_long();
        j["module"] = x.get_obj3_module();
    }

    inline void from_json(const json & j, Mutating& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("mutating") != j.end() && !j.at("mutating").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_mutating(j.at("mutating").get<int64_t>());
    }

    inline void to_json(json & j, const Mutating & x) {
        j = json::object();
        j["mutating"] = x.get_mutating();
    }

    inline void from_json(const json & j, Native& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("native") != j.end() && !j.at("native").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_native(j.at("native").get<int64_t>());
    }

    inline void to_json(json & j, const Native & x) {
        j = json::object();
        j["native"] = x.get_native();
    }

    inline void from_json(const json & j, Newtonsoft& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("newtonsoft") != j.end() && !j.at("newtonsoft").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_newtonsoft(j.at("newtonsoft").get<int64_t>());
    }

    inline void to_json(json & j, const Newtonsoft & x) {
        j = json::object();
        j["newtonsoft"] = x.get_newtonsoft();
    }

    inline void from_json(const json & j, Nil& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("nil") != j.end() && !j.at("nil").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_nil(j.at("nil").get<int64_t>());
    }

    inline void to_json(json & j, const Nil & x) {
        j = json::object();
        j["nil"] = x.get_nil();
    }

    inline void from_json(const json & j, No& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("NO") != j.end() && !j.at("NO").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_no(j.at("NO").get<int64_t>());
    }

    inline void to_json(json & j, const No & x) {
        j = json::object();
        j["NO"] = x.get_no();
    }

    inline void from_json(const json & j, NoSuchMethod& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("noSuchMethod") != j.end() && !j.at("noSuchMethod").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_no_such_method(j.at("noSuchMethod").get<int64_t>());
    }

    inline void to_json(json & j, const NoSuchMethod & x) {
        j = json::object();
        j["noSuchMethod"] = x.get_no_such_method();
    }

    inline void from_json(const json & j, Nonatomic& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("nonatomic") != j.end() && !j.at("nonatomic").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_nonatomic(j.at("nonatomic").get<int64_t>());
    }

    inline void to_json(json & j, const Nonatomic & x) {
        j = json::object();
        j["nonatomic"] = x.get_nonatomic();
    }

    inline void from_json(const json & j, None& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("None") != j.end() && !j.at("None").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_none(j.at("None").get<int64_t>());
    }

    inline void to_json(json & j, const None & x) {
        j = json::object();
        j["None"] = x.get_none();
    }

    inline void from_json(const json & j, Nonlocal& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("nonlocal") != j.end() && !j.at("nonlocal").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_nonlocal(j.at("nonlocal").get<int64_t>());
    }

    inline void to_json(json & j, const Nonlocal & x) {
        j = json::object();
        j["nonlocal"] = x.get_nonlocal();
    }

    inline void from_json(const json & j, Nonmutating& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("nonmutating") != j.end() && !j.at("nonmutating").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_nonmutating(j.at("nonmutating").get<int64_t>());
    }

    inline void to_json(json & j, const Nonmutating & x) {
        j = json::object();
        j["nonmutating"] = x.get_nonmutating();
    }

    inline void from_json(const json & j, NsError& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("NSError") != j.end() && !j.at("NSError").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_ns_error(j.at("NSError").get<int64_t>());
    }

    inline void to_json(json & j, const NsError & x) {
        j = json::object();
        j["NSError"] = x.get_ns_error();
    }

    inline void from_json(const json & j, NsObject& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("NSObject") != j.end() && !j.at("NSObject").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_ns_object(j.at("NSObject").get<int64_t>());
    }

    inline void to_json(json & j, const NsObject & x) {
        j = json::object();
        j["NSObject"] = x.get_ns_object();
    }

    inline void from_json(const json & j, NsString& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("NSString") != j.end() && !j.at("NSString").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_ns_string(j.at("NSString").get<int64_t>());
    }

    inline void to_json(json & j, const NsString & x) {
        j = json::object();
        j["NSString"] = x.get_ns_string();
    }

    inline void from_json(const json & j, Null& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("NULL") != j.end() && !j.at("NULL").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_null(j.at("NULL").get<int64_t>());
    }

    inline void to_json(json & j, const Null & x) {
        j = json::object();
        j["NULL"] = x.get_null();
    }

    inline void from_json(const json & j, NullNode& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("NullNode") != j.end() && !j.at("NullNode").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_null_node(j.at("NullNode").get<int64_t>());
    }

    inline void to_json(json & j, const NullNode & x) {
        j = json::object();
        j["NullNode"] = x.get_null_node();
    }

    inline void from_json(const json & j, Number& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("number") != j.end() && !j.at("number").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_number(j.at("number").get<int64_t>());
    }

    inline void to_json(json & j, const Number & x) {
        j = json::object();
        j["number"] = x.get_number();
    }

    inline void from_json(const json & j, Mutable& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("mutable") != j.end() && !j.at("mutable").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_mutable_mutable(j.at("mutable").get<int64_t>());
    }

    inline void to_json(json & j, const Mutable & x) {
        j = json::object();
        j["mutable"] = x.get_mutable_mutable();
    }

    inline void from_json(const json & j, Namespace& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("namespace") != j.end() && !j.at("namespace").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_namespace_namespace(j.at("namespace").get<int64_t>());
    }

    inline void to_json(json & j, const Namespace & x) {
        j = json::object();
        j["namespace"] = x.get_namespace_namespace();
    }

    inline void from_json(const json & j, New& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("new") != j.end() && !j.at("new").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_new_new(j.at("new").get<int64_t>());
    }

    inline void to_json(json & j, const New & x) {
        j = json::object();
        j["new"] = x.get_new_new();
    }

    inline void from_json(const json & j, Noexcept& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("noexcept") != j.end() && !j.at("noexcept").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_noexcept_noexcept(j.at("noexcept").get<int64_t>());
    }

    inline void to_json(json & j, const Noexcept & x) {
        j = json::object();
        j["noexcept"] = x.get_noexcept_noexcept();
    }

    inline void from_json(const json & j, NoneClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("none") != j.end() && !j.at("none").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_none(j.at("none").get<int64_t>());
    }

    inline void to_json(json & j, const NoneClass & x) {
        j = json::object();
        j["none"] = x.get_none();
    }

    inline void from_json(const json & j, Not& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("not") != j.end() && !j.at("not").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_not_not(j.at("not").get<int64_t>());
    }

    inline void to_json(json & j, const Not & x) {
        j = json::object();
        j["not"] = x.get_not_not();
    }

    inline void from_json(const json & j, NotEq& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("not_eq") != j.end() && !j.at("not_eq").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_not_eq_not_eq(j.at("not_eq").get<int64_t>());
    }

    inline void to_json(json & j, const NotEq & x) {
        j = json::object();
        j["not_eq"] = x.get_not_eq_not_eq();
    }

    inline void from_json(const json & j, NullClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("null") != j.end() && !j.at("null").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_null(j.at("null").get<int64_t>());
    }

    inline void to_json(json & j, const NullClass & x) {
        j = json::object();
        j["null"] = x.get_null();
    }

    inline void from_json(const json & j, Nullptr& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("nullptr") != j.end() && !j.at("nullptr").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_nullptr_nullptr(j.at("nullptr").get<int64_t>());
    }

    inline void to_json(json & j, const Nullptr & x) {
        j = json::object();
        j["nullptr"] = x.get_nullptr_nullptr();
    }

    inline void from_json(const json & j, Operator& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("operator") != j.end() && !j.at("operator").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_operator_operator(j.at("operator").get<int64_t>());
    }

    inline void to_json(json & j, const Operator & x) {
        j = json::object();
        j["operator"] = x.get_operator_operator();
    }

    inline void from_json(const json & j, Or& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("or") != j.end() && !j.at("or").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_or_or(j.at("or").get<int64_t>());
    }

    inline void to_json(json & j, const Or & x) {
        j = json::object();
        j["or"] = x.get_or_or();
    }

    inline void from_json(const json & j, OrEq& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("or_eq") != j.end() && !j.at("or_eq").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_or_eq_or_eq(j.at("or_eq").get<int64_t>());
    }

    inline void to_json(json & j, const OrEq & x) {
        j = json::object();
        j["or_eq"] = x.get_or_eq_or_eq();
    }

    inline void from_json(const json & j, Override& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("override") != j.end() && !j.at("override").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_override_override(j.at("override").get<int64_t>());
    }

    inline void to_json(json & j, const Override & x) {
        j = json::object();
        j["override"] = x.get_override_override();
    }

    inline void from_json(const json & j, Private& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("private") != j.end() && !j.at("private").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_private_private(j.at("private").get<int64_t>());
    }

    inline void to_json(json & j, const Private & x) {
        j = json::object();
        j["private"] = x.get_private_private();
    }

    inline void from_json(const json & j, Protected& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("protected") != j.end() && !j.at("protected").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_protected_protected(j.at("protected").get<int64_t>());
    }

    inline void to_json(json & j, const Protected & x) {
        j = json::object();
        j["protected"] = x.get_protected_protected();
    }

    inline void from_json(const json & j, ProtocolClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("protocol") != j.end() && !j.at("protocol").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_protocol(j.at("protocol").get<int64_t>());
    }

    inline void to_json(json & j, const ProtocolClass & x) {
        j = json::object();
        j["protocol"] = x.get_protocol();
    }

    inline void from_json(const json & j, Public& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("public") != j.end() && !j.at("public").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_public_public(j.at("public").get<int64_t>());
    }

    inline void to_json(json & j, const Public & x) {
        j = json::object();
        j["public"] = x.get_public_public();
    }

    inline void from_json(const json & j, Register& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("register") != j.end() && !j.at("register").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_register_register(j.at("register").get<int64_t>());
    }

    inline void to_json(json & j, const Register & x) {
        j = json::object();
        j["register"] = x.get_register_register();
    }

    inline void from_json(const json & j, ReinterpretCast& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("reinterpret_cast") != j.end() && !j.at("reinterpret_cast").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_reinterpret_cast_reinterpret_cast(j.at("reinterpret_cast").get<int64_t>());
    }

    inline void to_json(json & j, const ReinterpretCast & x) {
        j = json::object();
        j["reinterpret_cast"] = x.get_reinterpret_cast_reinterpret_cast();
    }

    inline void from_json(const json & j, Object& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("object") != j.end() && !j.at("object").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_object(j.at("object").get<int64_t>());
    }

    inline void to_json(json & j, const Object & x) {
        j = json::object();
        j["object"] = x.get_object();
    }

    inline void from_json(const json & j, ObjectMapper& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("ObjectMapper") != j.end() && !j.at("ObjectMapper").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_object_mapper(j.at("ObjectMapper").get<int64_t>());
    }

    inline void to_json(json & j, const ObjectMapper & x) {
        j = json::object();
        j["ObjectMapper"] = x.get_object_mapper();
    }

    inline void from_json(const json & j, ObjectNode& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("ObjectNode") != j.end() && !j.at("ObjectNode").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_object_node(j.at("ObjectNode").get<int64_t>());
    }

    inline void to_json(json & j, const ObjectNode & x) {
        j = json::object();
        j["ObjectNode"] = x.get_object_node();
    }

    inline void from_json(const json & j, ObjectReader& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("ObjectReader") != j.end() && !j.at("ObjectReader").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_object_reader(j.at("ObjectReader").get<int64_t>());
    }

    inline void to_json(json & j, const ObjectReader & x) {
        j = json::object();
        j["ObjectReader"] = x.get_object_reader();
    }

    inline void from_json(const json & j, ObjectWriter& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("ObjectWriter") != j.end() && !j.at("ObjectWriter").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_object_writer(j.at("ObjectWriter").get<int64_t>());
    }

    inline void to_json(json & j, const ObjectWriter & x) {
        j = json::object();
        j["ObjectWriter"] = x.get_object_writer();
    }

    inline void from_json(const json & j, Of& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("of") != j.end() && !j.at("of").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_of(j.at("of").get<int64_t>());
    }

    inline void to_json(json & j, const Of & x) {
        j = json::object();
        j["of"] = x.get_of();
    }

    inline void from_json(const json & j, OffsetDateTime& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("OffsetDateTime") != j.end() && !j.at("OffsetDateTime").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_offset_date_time(j.at("OffsetDateTime").get<int64_t>());
    }

    inline void to_json(json & j, const OffsetDateTime & x) {
        j = json::object();
        j["OffsetDateTime"] = x.get_offset_date_time();
    }

    inline void from_json(const json & j, OffsetTime& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("OffsetTime") != j.end() && !j.at("OffsetTime").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_offset_time(j.at("OffsetTime").get<int64_t>());
    }

    inline void to_json(json & j, const OffsetTime & x) {
        j = json::object();
        j["OffsetTime"] = x.get_offset_time();
    }

    inline void from_json(const json & j, Oneway& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("oneway") != j.end() && !j.at("oneway").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_oneway(j.at("oneway").get<int64_t>());
    }

    inline void to_json(json & j, const Oneway & x) {
        j = json::object();
        j["oneway"] = x.get_oneway();
    }

    inline void from_json(const json & j, Open& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("open") != j.end() && !j.at("open").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_open(j.at("open").get<int64_t>());
    }

    inline void to_json(json & j, const Open & x) {
        j = json::object();
        j["open"] = x.get_open();
    }

    inline void from_json(const json & j, Optional& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("optional") != j.end() && !j.at("optional").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_optional(j.at("optional").get<int64_t>());
    }

    inline void to_json(json & j, const Optional & x) {
        j = json::object();
        j["optional"] = x.get_optional();
    }

    inline void from_json(const json & j, Out& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("out") != j.end() && !j.at("out").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_out(j.at("out").get<int64_t>());
    }

    inline void to_json(json & j, const Out & x) {
        j = json::object();
        j["out"] = x.get_out();
    }

    inline void from_json(const json & j, Package& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("package") != j.end() && !j.at("package").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_package(j.at("package").get<int64_t>());
    }

    inline void to_json(json & j, const Package & x) {
        j = json::object();
        j["package"] = x.get_package();
    }

    inline void from_json(const json & j, Params& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("params") != j.end() && !j.at("params").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_params(j.at("params").get<int64_t>());
    }

    inline void to_json(json & j, const Params & x) {
        j = json::object();
        j["params"] = x.get_params();
    }

    inline void from_json(const json & j, Pass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("pass") != j.end() && !j.at("pass").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_pass(j.at("pass").get<int64_t>());
    }

    inline void to_json(json & j, const Pass & x) {
        j = json::object();
        j["pass"] = x.get_pass();
    }

    inline void from_json(const json & j, Port& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("port") != j.end() && !j.at("port").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_port(j.at("port").get<int64_t>());
    }

    inline void to_json(json & j, const Port & x) {
        j = json::object();
        j["port"] = x.get_port();
    }

    inline void from_json(const json & j, Postfix& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("postfix") != j.end() && !j.at("postfix").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_postfix(j.at("postfix").get<int64_t>());
    }

    inline void to_json(json & j, const Postfix & x) {
        j = json::object();
        j["postfix"] = x.get_postfix();
    }

    inline void from_json(const json & j, Precedence& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("precedence") != j.end() && !j.at("precedence").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_precedence(j.at("precedence").get<int64_t>());
    }

    inline void to_json(json & j, const Precedence & x) {
        j = json::object();
        j["precedence"] = x.get_precedence();
    }

    inline void from_json(const json & j, Prefix& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("prefix") != j.end() && !j.at("prefix").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_prefix(j.at("prefix").get<int64_t>());
    }

    inline void to_json(json & j, const Prefix & x) {
        j = json::object();
        j["prefix"] = x.get_prefix();
    }

    inline void from_json(const json & j, Print& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("print") != j.end() && !j.at("print").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_print(j.at("print").get<int64_t>());
    }

    inline void to_json(json & j, const Print & x) {
        j = json::object();
        j["print"] = x.get_print();
    }

    inline void from_json(const json & j, PrintMembers& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("printMembers") != j.end() && !j.at("printMembers").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_print_members(j.at("printMembers").get<int64_t>());
    }

    inline void to_json(json & j, const PrintMembers & x) {
        j = json::object();
        j["printMembers"] = x.get_print_members();
    }

    inline void from_json(const json & j, Printf& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("printf") != j.end() && !j.at("printf").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_printf(j.at("printf").get<int64_t>());
    }

    inline void to_json(json & j, const Printf & x) {
        j = json::object();
        j["printf"] = x.get_printf();
    }

    inline void from_json(const json & j, Protocol& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("Protocol") != j.end() && !j.at("Protocol").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_protocol(j.at("Protocol").get<int64_t>());
    }

    inline void to_json(json & j, const Protocol & x) {
        j = json::object();
        j["Protocol"] = x.get_protocol();
    }

    inline void from_json(const json & j, Quicktype& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("quicktype") != j.end() && !j.at("quicktype").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_quicktype(j.at("quicktype").get<int64_t>());
    }

    inline void to_json(json & j, const Quicktype & x) {
        j = json::object();
        j["quicktype"] = x.get_quicktype();
    }

    inline void from_json(const json & j, Raise& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("raise") != j.end() && !j.at("raise").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_raise(j.at("raise").get<int64_t>());
    }

    inline void to_json(json & j, const Raise & x) {
        j = json::object();
        j["raise"] = x.get_raise();
    }

    inline void from_json(const json & j, Range& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("range") != j.end() && !j.at("range").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_range(j.at("range").get<int64_t>());
    }

    inline void to_json(json & j, const Range & x) {
        j = json::object();
        j["range"] = x.get_range();
    }

    inline void from_json(const json & j, Readonly& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("readonly") != j.end() && !j.at("readonly").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_readonly(j.at("readonly").get<int64_t>());
    }

    inline void to_json(json & j, const Readonly & x) {
        j = json::object();
        j["readonly"] = x.get_readonly();
    }

    inline void from_json(const json & j, Ref& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("ref") != j.end() && !j.at("ref").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_ref(j.at("ref").get<int64_t>());
    }

    inline void to_json(json & j, const Ref & x) {
        j = json::object();
        j["ref"] = x.get_ref();
    }

    inline void from_json(const json & j, RegExp& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("RegExp") != j.end() && !std::regex_match(j.at("RegExp").get<std::string>(), std::regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$"))) throw std::runtime_error("Expected UUID");
        x.set_reg_exp(j.at("RegExp").get<std::string>());
    }

    inline void to_json(json & j, const RegExp & x) {
        j = json::object();
        j["RegExp"] = x.get_reg_exp();
    }

    inline void from_json(const json & j, Obj4& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("dummy") != j.end() && !j.at("dummy").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_dummy(j.at("dummy").get<int64_t>());
        x.set_mutating(j.at("mutating").get<Mutating>());
        x.set_native(j.at("native").get<Native>());
        x.set_newtonsoft(j.at("newtonsoft").get<Newtonsoft>());
        x.set_nil(j.at("nil").get<Nil>());
        x.set_no(j.at("NO").get<No>());
        x.set_no_such_method(j.at("noSuchMethod").get<NoSuchMethod>());
        x.set_nonatomic(j.at("nonatomic").get<Nonatomic>());
        x.set_none(j.at("None").get<None>());
        x.set_nonlocal(j.at("nonlocal").get<Nonlocal>());
        x.set_nonmutating(j.at("nonmutating").get<Nonmutating>());
        x.set_ns_error(j.at("NSError").get<NsError>());
        x.set_ns_object(j.at("NSObject").get<NsObject>());
        x.set_ns_string(j.at("NSString").get<NsString>());
        x.set_null(j.at("NULL").get<Null>());
        x.set_null_node(j.at("NullNode").get<NullNode>());
        x.set_number(j.at("number").get<Number>());
        x.set_obj4_mutable(j.at("mutable").get<Mutable>());
        x.set_obj4_namespace(j.at("namespace").get<Namespace>());
        x.set_obj4_new(j.at("new").get<New>());
        x.set_obj4_noexcept(j.at("noexcept").get<Noexcept>());
        x.set_obj4_none(j.at("none").get<NoneClass>());
        x.set_obj4_not(j.at("not").get<Not>());
        x.set_obj4_not_eq(j.at("not_eq").get<NotEq>());
        x.set_obj4_null(j.at("null").get<NullClass>());
        x.set_obj4_nullptr(j.at("nullptr").get<Nullptr>());
        x.set_obj4_operator(j.at("operator").get<Operator>());
        x.set_obj4_or(j.at("or").get<Or>());
        x.set_obj4_or_eq(j.at("or_eq").get<OrEq>());
        x.set_obj4_override(j.at("override").get<Override>());
        x.set_obj4_private(j.at("private").get<Private>());
        x.set_obj4_protected(j.at("protected").get<Protected>());
        x.set_obj4_protocol(j.at("protocol").get<ProtocolClass>());
        x.set_obj4_public(j.at("public").get<Public>());
        x.set_obj4_register(j.at("register").get<Register>());
        x.set_obj4_reinterpret_cast(j.at("reinterpret_cast").get<ReinterpretCast>());
        x.set_object(j.at("object").get<Object>());
        x.set_object_mapper(j.at("ObjectMapper").get<ObjectMapper>());
        x.set_object_node(j.at("ObjectNode").get<ObjectNode>());
        x.set_object_reader(j.at("ObjectReader").get<ObjectReader>());
        x.set_object_writer(j.at("ObjectWriter").get<ObjectWriter>());
        x.set_of(j.at("of").get<Of>());
        x.set_offset_date_time(j.at("OffsetDateTime").get<OffsetDateTime>());
        x.set_offset_time(j.at("OffsetTime").get<OffsetTime>());
        x.set_oneway(j.at("oneway").get<Oneway>());
        x.set_open(j.at("open").get<Open>());
        x.set_optional(j.at("optional").get<Optional>());
        x.set_out(j.at("out").get<Out>());
        x.set_package(j.at("package").get<Package>());
        x.set_params(j.at("params").get<Params>());
        x.set_pass(j.at("pass").get<Pass>());
        x.set_port(j.at("port").get<Port>());
        x.set_postfix(j.at("postfix").get<Postfix>());
        x.set_precedence(j.at("precedence").get<Precedence>());
        x.set_prefix(j.at("prefix").get<Prefix>());
        x.set_print(j.at("print").get<Print>());
        x.set_print_members(j.at("printMembers").get<PrintMembers>());
        x.set_printf(j.at("printf").get<Printf>());
        x.set_protocol(j.at("Protocol").get<Protocol>());
        x.set_quicktype(j.at("quicktype").get<Quicktype>());
        x.set_raise(j.at("raise").get<Raise>());
        x.set_range(j.at("range").get<Range>());
        x.set_readonly(j.at("readonly").get<Readonly>());
        x.set_ref(j.at("ref").get<Ref>());
        x.set_reg_exp(j.at("RegExp").get<RegExp>());
    }

    inline void to_json(json & j, const Obj4 & x) {
        j = json::object();
        j["dummy"] = x.get_dummy();
        j["mutating"] = x.get_mutating();
        j["native"] = x.get_native();
        j["newtonsoft"] = x.get_newtonsoft();
        j["nil"] = x.get_nil();
        j["NO"] = x.get_no();
        j["noSuchMethod"] = x.get_no_such_method();
        j["nonatomic"] = x.get_nonatomic();
        j["None"] = x.get_none();
        j["nonlocal"] = x.get_nonlocal();
        j["nonmutating"] = x.get_nonmutating();
        j["NSError"] = x.get_ns_error();
        j["NSObject"] = x.get_ns_object();
        j["NSString"] = x.get_ns_string();
        j["NULL"] = x.get_null();
        j["NullNode"] = x.get_null_node();
        j["number"] = x.get_number();
        j["mutable"] = x.get_obj4_mutable();
        j["namespace"] = x.get_obj4_namespace();
        j["new"] = x.get_obj4_new();
        j["noexcept"] = x.get_obj4_noexcept();
        j["none"] = x.get_obj4_none();
        j["not"] = x.get_obj4_not();
        j["not_eq"] = x.get_obj4_not_eq();
        j["null"] = x.get_obj4_null();
        j["nullptr"] = x.get_obj4_nullptr();
        j["operator"] = x.get_obj4_operator();
        j["or"] = x.get_obj4_or();
        j["or_eq"] = x.get_obj4_or_eq();
        j["override"] = x.get_obj4_override();
        j["private"] = x.get_obj4_private();
        j["protected"] = x.get_obj4_protected();
        j["protocol"] = x.get_obj4_protocol();
        j["public"] = x.get_obj4_public();
        j["register"] = x.get_obj4_register();
        j["reinterpret_cast"] = x.get_obj4_reinterpret_cast();
        j["object"] = x.get_object();
        j["ObjectMapper"] = x.get_object_mapper();
        j["ObjectNode"] = x.get_object_node();
        j["ObjectReader"] = x.get_object_reader();
        j["ObjectWriter"] = x.get_object_writer();
        j["of"] = x.get_of();
        j["OffsetDateTime"] = x.get_offset_date_time();
        j["OffsetTime"] = x.get_offset_time();
        j["oneway"] = x.get_oneway();
        j["open"] = x.get_open();
        j["optional"] = x.get_optional();
        j["out"] = x.get_out();
        j["package"] = x.get_package();
        j["params"] = x.get_params();
        j["pass"] = x.get_pass();
        j["port"] = x.get_port();
        j["postfix"] = x.get_postfix();
        j["precedence"] = x.get_precedence();
        j["prefix"] = x.get_prefix();
        j["print"] = x.get_print();
        j["printMembers"] = x.get_print_members();
        j["printf"] = x.get_printf();
        j["Protocol"] = x.get_protocol();
        j["quicktype"] = x.get_quicktype();
        j["raise"] = x.get_raise();
        j["range"] = x.get_range();
        j["readonly"] = x.get_readonly();
        j["ref"] = x.get_ref();
        j["RegExp"] = x.get_reg_exp();
    }

    inline void from_json(const json & j, KSerializer& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("KSerializer") != j.end() && !j.at("KSerializer").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_k_serializer(j.at("KSerializer").get<int64_t>());
    }

    inline void to_json(json & j, const KSerializer & x) {
        j = json::object();
        j["KSerializer"] = x.get_k_serializer();
    }

    inline void from_json(const json & j, Requires& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("requires") != j.end() && !j.at("requires").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_requires_requires(j.at("requires").get<int64_t>());
    }

    inline void to_json(json & j, const Requires & x) {
        j = json::object();
        j["requires"] = x.get_requires_requires();
    }

    inline void from_json(const json & j, Return& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("return") != j.end() && !j.at("return").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_return_return(j.at("return").get<int64_t>());
    }

    inline void to_json(json & j, const Return & x) {
        j = json::object();
        j["return"] = x.get_return_return();
    }

    inline void from_json(const json & j, SelfClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("self") != j.end() && !j.at("self").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_self(j.at("self").get<int64_t>());
    }

    inline void to_json(json & j, const SelfClass & x) {
        j = json::object();
        j["self"] = x.get_self();
    }

    inline void from_json(const json & j, Short& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("short") != j.end() && !j.at("short").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_short_short(j.at("short").get<int64_t>());
    }

    inline void to_json(json & j, const Short & x) {
        j = json::object();
        j["short"] = x.get_short_short();
    }

    inline void from_json(const json & j, Signed& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("signed") != j.end() && !j.at("signed").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_signed_signed(j.at("signed").get<int64_t>());
    }

    inline void to_json(json & j, const Signed & x) {
        j = json::object();
        j["signed"] = x.get_signed_signed();
    }

    inline void from_json(const json & j, Sizeof& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("sizeof") != j.end() && !j.at("sizeof").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_sizeof_sizeof(j.at("sizeof").get<int64_t>());
    }

    inline void to_json(json & j, const Sizeof & x) {
        j = json::object();
        j["sizeof"] = x.get_sizeof_sizeof();
    }

    inline void from_json(const json & j, Static& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("static") != j.end() && !j.at("static").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_static_static(j.at("static").get<int64_t>());
    }

    inline void to_json(json & j, const Static & x) {
        j = json::object();
        j["static"] = x.get_static_static();
    }

    inline void from_json(const json & j, StaticAssert& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("static_assert") != j.end() && !j.at("static_assert").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_static_assert_static_assert(j.at("static_assert").get<int64_t>());
    }

    inline void to_json(json & j, const StaticAssert & x) {
        j = json::object();
        j["static_assert"] = x.get_static_assert_static_assert();
    }

    inline void from_json(const json & j, StaticCast& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("static_cast") != j.end() && !j.at("static_cast").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_static_cast_static_cast(j.at("static_cast").get<int64_t>());
    }

    inline void to_json(json & j, const StaticCast & x) {
        j = json::object();
        j["static_cast"] = x.get_static_cast_static_cast();
    }

    inline void from_json(const json & j, Struct& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("struct") != j.end() && !j.at("struct").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_struct_struct(j.at("struct").get<int64_t>());
    }

    inline void to_json(json & j, const Struct & x) {
        j = json::object();
        j["struct"] = x.get_struct_struct();
    }

    inline void from_json(const json & j, Switch& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("switch") != j.end() && !j.at("switch").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_switch_switch(j.at("switch").get<int64_t>());
    }

    inline void to_json(json & j, const Switch & x) {
        j = json::object();
        j["switch"] = x.get_switch_switch();
    }

    inline void from_json(const json & j, Synchronized& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("synchronized") != j.end() && !j.at("synchronized").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_synchronized_synchronized(j.at("synchronized").get<int64_t>());
    }

    inline void to_json(json & j, const Synchronized & x) {
        j = json::object();
        j["synchronized"] = x.get_synchronized_synchronized();
    }

    inline void from_json(const json & j, Template& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("template") != j.end() && !j.at("template").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_template_template(j.at("template").get<int64_t>());
    }

    inline void to_json(json & j, const Template & x) {
        j = json::object();
        j["template"] = x.get_template_template();
    }

    inline void from_json(const json & j, This& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("this") != j.end() && !j.at("this").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_this_this(j.at("this").get<int64_t>());
    }

    inline void to_json(json & j, const This & x) {
        j = json::object();
        j["this"] = x.get_this_this();
    }

    inline void from_json(const json & j, ThreadLocal& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("thread_local") != j.end() && !j.at("thread_local").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_thread_local_thread_local(j.at("thread_local").get<int64_t>());
    }

    inline void to_json(json & j, const ThreadLocal & x) {
        j = json::object();
        j["thread_local"] = x.get_thread_local_thread_local();
    }

    inline void from_json(const json & j, Throw& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("throw") != j.end() && !j.at("throw").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_throw_throw(j.at("throw").get<int64_t>());
    }

    inline void to_json(json & j, const Throw & x) {
        j = json::object();
        j["throw"] = x.get_throw_throw();
    }

    inline void from_json(const json & j, True& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("True") != j.end() && !j.at("True").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_true_true(j.at("True").get<int64_t>());
    }

    inline void to_json(json & j, const True & x) {
        j = json::object();
        j["True"] = x.get_true_true();
    }

    inline void from_json(const json & j, PrimitiveKind& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("PrimitiveKind") != j.end() && !j.at("PrimitiveKind").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_primitive_kind(j.at("PrimitiveKind").get<int64_t>());
    }

    inline void to_json(json & j, const PrimitiveKind & x) {
        j = json::object();
        j["PrimitiveKind"] = x.get_primitive_kind();
    }

    inline void from_json(const json & j, TrueClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("true") != j.end() && !j.at("true").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_true_true(j.at("true").get<int64_t>());
    }

    inline void to_json(json & j, const TrueClass & x) {
        j = json::object();
        j["true"] = x.get_true_true();
    }

    inline void from_json(const json & j, Repeat& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("repeat") != j.end() && !j.at("repeat").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_repeat(j.at("repeat").get<int64_t>());
    }

    inline void to_json(json & j, const Repeat & x) {
        j = json::object();
        j["repeat"] = x.get_repeat();
    }

    inline void from_json(const json & j, Require& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("require") != j.end() && !j.at("require").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_require(j.at("require").get<int64_t>());
    }

    inline void to_json(json & j, const Require & x) {
        j = json::object();
        j["require"] = x.get_require();
    }

    inline void from_json(const json & j, Required& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("required") != j.end() && !j.at("required").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_required(j.at("required").get<int64_t>());
    }

    inline void to_json(json & j, const Required & x) {
        j = json::object();
        j["required"] = x.get_required();
    }

    inline void from_json(const json & j, Restrict& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("restrict") != j.end() && !j.at("restrict").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_restrict(j.at("restrict").get<int64_t>());
    }

    inline void to_json(json & j, const Restrict & x) {
        j = json::object();
        j["restrict"] = x.get_restrict();
    }

    inline void from_json(const json & j, Retain& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("retain") != j.end() && !j.at("retain").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_retain(j.at("retain").get<int64_t>());
    }

    inline void to_json(json & j, const Retain & x) {
        j = json::object();
        j["retain"] = x.get_retain();
    }

    inline void from_json(const json & j, Rethrows& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("rethrows") != j.end() && !j.at("rethrows").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_rethrows(j.at("rethrows").get<int64_t>());
    }

    inline void to_json(json & j, const Rethrows & x) {
        j = json::object();
        j["rethrows"] = x.get_rethrows();
    }

    inline void from_json(const json & j, Right& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("right") != j.end() && !j.at("right").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_right(j.at("right").get<int64_t>());
    }

    inline void to_json(json & j, const Right & x) {
        j = json::object();
        j["right"] = x.get_right();
    }

    inline void from_json(const json & j, RuntimeType& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("runtimeType") != j.end() && !j.at("runtimeType").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_runtime_type(j.at("runtimeType").get<int64_t>());
    }

    inline void to_json(json & j, const RuntimeType & x) {
        j = json::object();
        j["runtimeType"] = x.get_runtime_type();
    }

    inline void from_json(const json & j, S& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("s") != j.end() && !j.at("s").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_s(j.at("s").get<int64_t>());
    }

    inline void to_json(json & j, const S & x) {
        j = json::object();
        j["s"] = x.get_s();
    }

    inline void from_json(const json & j, Sbyte& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("sbyte") != j.end() && !j.at("sbyte").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_sbyte(j.at("sbyte").get<int64_t>());
    }

    inline void to_json(json & j, const Sbyte & x) {
        j = json::object();
        j["sbyte"] = x.get_sbyte();
    }

    inline void from_json(const json & j, Sealed& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("sealed") != j.end() && !j.at("sealed").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_sealed(j.at("sealed").get<int64_t>());
    }

    inline void to_json(json & j, const Sealed & x) {
        j = json::object();
        j["sealed"] = x.get_sealed();
    }

    inline void from_json(const json & j, Sel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("SEL") != j.end() && !j.at("SEL").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_sel(j.at("SEL").get<int64_t>());
    }

    inline void to_json(json & j, const Sel & x) {
        j = json::object();
        j["SEL"] = x.get_sel();
    }

    inline void from_json(const json & j, Select& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("select") != j.end() && !j.at("select").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_select(j.at("select").get<int64_t>());
    }

    inline void to_json(json & j, const Select & x) {
        j = json::object();
        j["select"] = x.get_select();
    }

    inline void from_json(const json & j, Self& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("Self") != j.end() && !j.at("Self").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_self(j.at("Self").get<int64_t>());
    }

    inline void to_json(json & j, const Self & x) {
        j = json::object();
        j["Self"] = x.get_self();
    }

    inline void from_json(const json & j, Sendable& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("Sendable") != j.end() && !j.at("Sendable").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_sendable(j.at("Sendable").get<int64_t>());
    }

    inline void to_json(json & j, const Sendable & x) {
        j = json::object();
        j["Sendable"] = x.get_sendable();
    }

    inline void from_json(const json & j, SerialDescriptor& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("SerialDescriptor") != j.end() && !j.at("SerialDescriptor").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_serial_descriptor(j.at("SerialDescriptor").get<int64_t>());
    }

    inline void to_json(json & j, const SerialDescriptor & x) {
        j = json::object();
        j["SerialDescriptor"] = x.get_serial_descriptor();
    }

    inline void from_json(const json & j, SerialName& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("SerialName") != j.end() && !j.at("SerialName").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_serial_name(j.at("SerialName").get<int64_t>());
    }

    inline void to_json(json & j, const SerialName & x) {
        j = json::object();
        j["SerialName"] = x.get_serial_name();
    }

    inline void from_json(const json & j, Serializable& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("Serializable") != j.end() && !j.at("Serializable").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_serializable(j.at("Serializable").get<int64_t>());
    }

    inline void to_json(json & j, const Serializable & x) {
        j = json::object();
        j["Serializable"] = x.get_serializable();
    }

    inline void from_json(const json & j, SerializationFeature& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("SerializationFeature") != j.end() && !j.at("SerializationFeature").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_serialization_feature(j.at("SerializationFeature").get<int64_t>());
    }

    inline void to_json(json & j, const SerializationFeature & x) {
        j = json::object();
        j["SerializationFeature"] = x.get_serialization_feature();
    }

    inline void from_json(const json & j, Serialize& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("serialize") != j.end() && !j.at("serialize").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_serialize(j.at("serialize").get<int64_t>());
    }

    inline void to_json(json & j, const Serialize & x) {
        j = json::object();
        j["serialize"] = x.get_serialize();
    }

    inline void from_json(const json & j, SerializerProvider& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("SerializerProvider") != j.end() && !j.at("SerializerProvider").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_serializer_provider(j.at("SerializerProvider").get<int64_t>());
    }

    inline void to_json(json & j, const SerializerProvider & x) {
        j = json::object();
        j["SerializerProvider"] = x.get_serializer_provider();
    }

    inline void from_json(const json & j, Set& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("set") != j.end() && !j.at("set").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_set(j.at("set").get<int64_t>());
    }

    inline void to_json(json & j, const Set & x) {
        j = json::object();
        j["set"] = x.get_set();
    }

    inline void from_json(const json & j, SimpleModule& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("SimpleModule") != j.end() && !j.at("SimpleModule").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_simple_module(j.at("SimpleModule").get<int64_t>());
    }

    inline void to_json(json & j, const SimpleModule & x) {
        j = json::object();
        j["SimpleModule"] = x.get_simple_module();
    }

    inline void from_json(const json & j, Stackalloc& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("stackalloc") != j.end() && !j.at("stackalloc").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_stackalloc(j.at("stackalloc").get<int64_t>());
    }

    inline void to_json(json & j, const Stackalloc & x) {
        j = json::object();
        j["stackalloc"] = x.get_stackalloc();
    }

    inline void from_json(const json & j, Standards& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("Standards") != j.end() && !j.at("Standards").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_standards(j.at("Standards").get<int64_t>());
    }

    inline void to_json(json & j, const Standards & x) {
        j = json::object();
        j["Standards"] = x.get_standards();
    }

    inline void from_json(const json & j, StdDeserializer& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("StdDeserializer") != j.end() && !j.at("StdDeserializer").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_std_deserializer(j.at("StdDeserializer").get<int64_t>());
    }

    inline void to_json(json & j, const StdDeserializer & x) {
        j = json::object();
        j["StdDeserializer"] = x.get_std_deserializer();
    }

    inline void from_json(const json & j, StdSerializer& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("StdSerializer") != j.end() && !j.at("StdSerializer").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_std_serializer(j.at("StdSerializer").get<int64_t>());
    }

    inline void to_json(json & j, const StdSerializer & x) {
        j = json::object();
        j["StdSerializer"] = x.get_std_serializer();
    }

    inline void from_json(const json & j, Strictfp& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("strictfp") != j.end() && !j.at("strictfp").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_strictfp(j.at("strictfp").get<int64_t>());
    }

    inline void to_json(json & j, const Strictfp & x) {
        j = json::object();
        j["strictfp"] = x.get_strictfp();
    }

    inline void from_json(const json & j, String& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("string") != j.end() && !j.at("string").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_string(j.at("string").get<int64_t>());
    }

    inline void to_json(json & j, const String & x) {
        j = json::object();
        j["string"] = x.get_string();
    }

    inline void from_json(const json & j, Subscript& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("subscript") != j.end() && !j.at("subscript").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_subscript(j.at("subscript").get<int64_t>());
    }

    inline void to_json(json & j, const Subscript & x) {
        j = json::object();
        j["subscript"] = x.get_subscript();
    }

    inline void from_json(const json & j, Super& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("super") != j.end() && !j.at("super").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_super(j.at("super").get<int64_t>());
    }

    inline void to_json(json & j, const Super & x) {
        j = json::object();
        j["super"] = x.get_super();
    }

    inline void from_json(const json & j, Symbol& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("symbol") != j.end() && !j.at("symbol").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_symbol(j.at("symbol").get<int64_t>());
    }

    inline void to_json(json & j, const Symbol & x) {
        j = json::object();
        j["symbol"] = x.get_symbol();
    }

    inline void from_json(const json & j, System& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("system") != j.end() && !j.at("system").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_system(j.at("system").get<int64_t>());
    }

    inline void to_json(json & j, const System & x) {
        j = json::object();
        j["system"] = x.get_system();
    }

    inline void from_json(const json & j, TextNode& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("TextNode") != j.end() && !j.at("TextNode").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_text_node(j.at("TextNode").get<int64_t>());
    }

    inline void to_json(json & j, const TextNode & x) {
        j = json::object();
        j["TextNode"] = x.get_text_node();
    }

    inline void from_json(const json & j, Then& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("then") != j.end() && !j.at("then").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_then(j.at("then").get<int64_t>());
    }

    inline void to_json(json & j, const Then & x) {
        j = json::object();
        j["then"] = x.get_then();
    }

    inline void from_json(const json & j, Throws& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("throws") != j.end() && !j.at("throws").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_throws(j.at("throws").get<int64_t>());
    }

    inline void to_json(json & j, const Throws & x) {
        j = json::object();
        j["throws"] = x.get_throws();
    }

    inline void from_json(const json & j, TimeOnly& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("TimeOnly") != j.end() && !j.at("TimeOnly").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_time_only(j.at("TimeOnly").get<int64_t>());
    }

    inline void to_json(json & j, const TimeOnly & x) {
        j = json::object();
        j["TimeOnly"] = x.get_time_only();
    }

    inline void from_json(const json & j, TimeOnlyConverter& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("TimeOnlyConverter") != j.end() && !j.at("TimeOnlyConverter").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_time_only_converter(j.at("TimeOnlyConverter").get<int64_t>());
    }

    inline void to_json(json & j, const TimeOnlyConverter & x) {
        j = json::object();
        j["TimeOnlyConverter"] = x.get_time_only_converter();
    }

    inline void from_json(const json & j, TimeZone& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("TimeZone") != j.end() && !j.at("TimeZone").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_time_zone(j.at("TimeZone").get<int64_t>());
    }

    inline void to_json(json & j, const TimeZone & x) {
        j = json::object();
        j["TimeZone"] = x.get_time_zone();
    }

    inline void from_json(const json & j, ToDict& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("to_dict") != j.end() && !j.at("to_dict").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_to_dict(j.at("to_dict").get<int64_t>());
    }

    inline void to_json(json & j, const ToDict & x) {
        j = json::object();
        j["to_dict"] = x.get_to_dict();
    }

    inline void from_json(const json & j, ToJson& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("to_json") != j.end() && !j.at("to_json").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_to_json(j.at("to_json").get<int64_t>());
    }

    inline void to_json(json & j, const ToJson & x) {
        j = json::object();
        j["to_json"] = x.get_to_json();
    }

    inline void from_json(const json & j, ToString& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("toString") != j.end() && !j.at("toString").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_to_string(j.at("toString").get<int64_t>());
    }

    inline void to_json(json & j, const ToString & x) {
        j = json::object();
        j["toString"] = x.get_to_string();
    }

    inline void from_json(const json & j, TopLevelClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("top_level") != j.end() && !j.at("top_level").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_top_level(j.at("top_level").get<int64_t>());
    }

    inline void to_json(json & j, const TopLevelClass & x) {
        j = json::object();
        j["top_level"] = x.get_top_level();
    }

    inline void from_json(const json & j, Transient& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("transient") != j.end() && !j.at("transient").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_transient(j.at("transient").get<int64_t>());
    }

    inline void to_json(json & j, const Transient & x) {
        j = json::object();
        j["transient"] = x.get_transient();
    }

    inline void from_json(const json & j, Obj5& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("dummy") != j.end() && !j.at("dummy").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_dummy(j.at("dummy").get<int64_t>());
        x.set_k_serializer(j.at("KSerializer").get<KSerializer>());
        x.set_obj5_requires(j.at("requires").get<Requires>());
        x.set_obj5_return(j.at("return").get<Return>());
        x.set_obj5_self(j.at("self").get<SelfClass>());
        x.set_obj5_short(j.at("short").get<Short>());
        x.set_obj5_signed(j.at("signed").get<Signed>());
        x.set_obj5_sizeof(j.at("sizeof").get<Sizeof>());
        x.set_obj5_static(j.at("static").get<Static>());
        x.set_obj5_static_assert(j.at("static_assert").get<StaticAssert>());
        x.set_obj5_static_cast(j.at("static_cast").get<StaticCast>());
        x.set_obj5_struct(j.at("struct").get<Struct>());
        x.set_obj5_switch(j.at("switch").get<Switch>());
        x.set_obj5_synchronized(j.at("synchronized").get<Synchronized>());
        x.set_obj5_template(j.at("template").get<Template>());
        x.set_obj5_this(j.at("this").get<This>());
        x.set_obj5_thread_local(j.at("thread_local").get<ThreadLocal>());
        x.set_obj5_throw(j.at("throw").get<Throw>());
        x.set_obj5_true(j.at("True").get<True>());
        x.set_primitive_kind(j.at("PrimitiveKind").get<PrimitiveKind>());
        x.set_purple_true(j.at("true").get<TrueClass>());
        x.set_repeat(j.at("repeat").get<Repeat>());
        x.set_require(j.at("require").get<Require>());
        x.set_required(j.at("required").get<Required>());
        x.set_restrict(j.at("restrict").get<Restrict>());
        x.set_retain(j.at("retain").get<Retain>());
        x.set_rethrows(j.at("rethrows").get<Rethrows>());
        x.set_right(j.at("right").get<Right>());
        x.set_runtime_type(j.at("runtimeType").get<RuntimeType>());
        x.set_s(j.at("s").get<S>());
        x.set_sbyte(j.at("sbyte").get<Sbyte>());
        x.set_sealed(j.at("sealed").get<Sealed>());
        x.set_sel(j.at("SEL").get<Sel>());
        x.set_select(j.at("select").get<Select>());
        x.set_self(j.at("Self").get<Self>());
        x.set_sendable(j.at("Sendable").get<Sendable>());
        x.set_serial_descriptor(j.at("SerialDescriptor").get<SerialDescriptor>());
        x.set_serial_name(j.at("SerialName").get<SerialName>());
        x.set_serializable(j.at("Serializable").get<Serializable>());
        x.set_serialization_feature(j.at("SerializationFeature").get<SerializationFeature>());
        x.set_serialize(j.at("serialize").get<Serialize>());
        x.set_serializer_provider(j.at("SerializerProvider").get<SerializerProvider>());
        x.set_set(j.at("set").get<Set>());
        x.set_simple_module(j.at("SimpleModule").get<SimpleModule>());
        x.set_stackalloc(j.at("stackalloc").get<Stackalloc>());
        x.set_standards(j.at("Standards").get<Standards>());
        x.set_std_deserializer(j.at("StdDeserializer").get<StdDeserializer>());
        x.set_std_serializer(j.at("StdSerializer").get<StdSerializer>());
        x.set_strictfp(j.at("strictfp").get<Strictfp>());
        x.set_string(j.at("string").get<String>());
        x.set_subscript(j.at("subscript").get<Subscript>());
        x.set_super(j.at("super").get<Super>());
        x.set_symbol(j.at("symbol").get<Symbol>());
        x.set_system(j.at("system").get<System>());
        x.set_text_node(j.at("TextNode").get<TextNode>());
        x.set_then(j.at("then").get<Then>());
        x.set_throws(j.at("throws").get<Throws>());
        x.set_time_only(j.at("TimeOnly").get<TimeOnly>());
        x.set_time_only_converter(j.at("TimeOnlyConverter").get<TimeOnlyConverter>());
        x.set_time_zone(j.at("TimeZone").get<TimeZone>());
        x.set_to_dict(j.at("to_dict").get<ToDict>());
        x.set_to_json(j.at("to_json").get<ToJson>());
        x.set_to_string(j.at("toString").get<ToString>());
        x.set_top_level(j.at("top_level").get<TopLevelClass>());
        x.set_transient(j.at("transient").get<Transient>());
    }

    inline void to_json(json & j, const Obj5 & x) {
        j = json::object();
        j["dummy"] = x.get_dummy();
        j["KSerializer"] = x.get_k_serializer();
        j["requires"] = x.get_obj5_requires();
        j["return"] = x.get_obj5_return();
        j["self"] = x.get_obj5_self();
        j["short"] = x.get_obj5_short();
        j["signed"] = x.get_obj5_signed();
        j["sizeof"] = x.get_obj5_sizeof();
        j["static"] = x.get_obj5_static();
        j["static_assert"] = x.get_obj5_static_assert();
        j["static_cast"] = x.get_obj5_static_cast();
        j["struct"] = x.get_obj5_struct();
        j["switch"] = x.get_obj5_switch();
        j["synchronized"] = x.get_obj5_synchronized();
        j["template"] = x.get_obj5_template();
        j["this"] = x.get_obj5_this();
        j["thread_local"] = x.get_obj5_thread_local();
        j["throw"] = x.get_obj5_throw();
        j["True"] = x.get_obj5_true();
        j["PrimitiveKind"] = x.get_primitive_kind();
        j["true"] = x.get_purple_true();
        j["repeat"] = x.get_repeat();
        j["require"] = x.get_require();
        j["required"] = x.get_required();
        j["restrict"] = x.get_restrict();
        j["retain"] = x.get_retain();
        j["rethrows"] = x.get_rethrows();
        j["right"] = x.get_right();
        j["runtimeType"] = x.get_runtime_type();
        j["s"] = x.get_s();
        j["sbyte"] = x.get_sbyte();
        j["sealed"] = x.get_sealed();
        j["SEL"] = x.get_sel();
        j["select"] = x.get_select();
        j["Self"] = x.get_self();
        j["Sendable"] = x.get_sendable();
        j["SerialDescriptor"] = x.get_serial_descriptor();
        j["SerialName"] = x.get_serial_name();
        j["Serializable"] = x.get_serializable();
        j["SerializationFeature"] = x.get_serialization_feature();
        j["serialize"] = x.get_serialize();
        j["SerializerProvider"] = x.get_serializer_provider();
        j["set"] = x.get_set();
        j["SimpleModule"] = x.get_simple_module();
        j["stackalloc"] = x.get_stackalloc();
        j["Standards"] = x.get_standards();
        j["StdDeserializer"] = x.get_std_deserializer();
        j["StdSerializer"] = x.get_std_serializer();
        j["strictfp"] = x.get_strictfp();
        j["string"] = x.get_string();
        j["subscript"] = x.get_subscript();
        j["super"] = x.get_super();
        j["symbol"] = x.get_symbol();
        j["system"] = x.get_system();
        j["TextNode"] = x.get_text_node();
        j["then"] = x.get_then();
        j["throws"] = x.get_throws();
        j["TimeOnly"] = x.get_time_only();
        j["TimeOnlyConverter"] = x.get_time_only_converter();
        j["TimeZone"] = x.get_time_zone();
        j["to_dict"] = x.get_to_dict();
        j["to_json"] = x.get_to_json();
        j["toString"] = x.get_to_string();
        j["top_level"] = x.get_top_level();
        j["transient"] = x.get_transient();
    }

    inline void from_json(const json & j, Try& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("try") != j.end() && !j.at("try").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_try_try(j.at("try").get<int64_t>());
    }

    inline void to_json(json & j, const Try & x) {
        j = json::object();
        j["try"] = x.get_try_try();
    }

    inline void from_json(const json & j, TypeClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("type") != j.end() && !j.at("type").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_type(j.at("type").get<int64_t>());
    }

    inline void to_json(json & j, const TypeClass & x) {
        j = json::object();
        j["type"] = x.get_type();
    }

    inline void from_json(const json & j, Typedef& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("typedef") != j.end() && !j.at("typedef").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_typedef_typedef(j.at("typedef").get<int64_t>());
    }

    inline void to_json(json & j, const Typedef & x) {
        j = json::object();
        j["typedef"] = x.get_typedef_typedef();
    }

    inline void from_json(const json & j, Typeid& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("typeid") != j.end() && !j.at("typeid").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_typeid_typeid(j.at("typeid").get<int64_t>());
    }

    inline void to_json(json & j, const Typeid & x) {
        j = json::object();
        j["typeid"] = x.get_typeid_typeid();
    }

    inline void from_json(const json & j, Typename& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("typename") != j.end() && !j.at("typename").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_typename_typename(j.at("typename").get<int64_t>());
    }

    inline void to_json(json & j, const Typename & x) {
        j = json::object();
        j["typename"] = x.get_typename_typename();
    }

    inline void from_json(const json & j, Union& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("union") != j.end() && !j.at("union").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_union_union(j.at("union").get<int64_t>());
    }

    inline void to_json(json & j, const Union & x) {
        j = json::object();
        j["union"] = x.get_union_union();
    }

    inline void from_json(const json & j, Unsigned& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("unsigned") != j.end() && !j.at("unsigned").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_unsigned_unsigned(j.at("unsigned").get<int64_t>());
    }

    inline void to_json(json & j, const Unsigned & x) {
        j = json::object();
        j["unsigned"] = x.get_unsigned_unsigned();
    }

    inline void from_json(const json & j, Using& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("using") != j.end() && !j.at("using").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_using_using(j.at("using").get<int64_t>());
    }

    inline void to_json(json & j, const Using & x) {
        j = json::object();
        j["using"] = x.get_using_using();
    }

    inline void from_json(const json & j, Virtual& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("virtual") != j.end() && !j.at("virtual").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_virtual_virtual(j.at("virtual").get<int64_t>());
    }

    inline void to_json(json & j, const Virtual & x) {
        j = json::object();
        j["virtual"] = x.get_virtual_virtual();
    }

    inline void from_json(const json & j, Void& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("void") != j.end() && !j.at("void").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_void_void(j.at("void").get<int64_t>());
    }

    inline void to_json(json & j, const Void & x) {
        j = json::object();
        j["void"] = x.get_void_void();
    }

    inline void from_json(const json & j, Volatile& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("volatile") != j.end() && !j.at("volatile").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_volatile_volatile(j.at("volatile").get<int64_t>());
    }

    inline void to_json(json & j, const Volatile & x) {
        j = json::object();
        j["volatile"] = x.get_volatile_volatile();
    }

    inline void from_json(const json & j, WcharT& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("wchar_t") != j.end() && !j.at("wchar_t").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_wchar_t_wchar_t(j.at("wchar_t").get<int64_t>());
    }

    inline void to_json(json & j, const WcharT & x) {
        j = json::object();
        j["wchar_t"] = x.get_wchar_t_wchar_t();
    }

    inline void from_json(const json & j, While& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("while") != j.end() && !j.at("while").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_while_while(j.at("while").get<int64_t>());
    }

    inline void to_json(json & j, const While & x) {
        j = json::object();
        j["while"] = x.get_while_while();
    }

    inline void from_json(const json & j, Xor& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("xor") != j.end() && !j.at("xor").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_xor_xor(j.at("xor").get<int64_t>());
    }

    inline void to_json(json & j, const Xor & x) {
        j = json::object();
        j["xor"] = x.get_xor_xor();
    }

    inline void from_json(const json & j, XorEq& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("xor_eq") != j.end() && !j.at("xor_eq").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_xor_eq_xor_eq(j.at("xor_eq").get<int64_t>());
    }

    inline void to_json(json & j, const XorEq & x) {
        j = json::object();
        j["xor_eq"] = x.get_xor_eq_xor_eq();
    }

    inline void from_json(const json & j, Type& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("Type") != j.end() && !j.at("Type").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_type(j.at("Type").get<int64_t>());
    }

    inline void to_json(json & j, const Type & x) {
        j = json::object();
        j["Type"] = x.get_type();
    }

    inline void from_json(const json & j, Typealias& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("typealias") != j.end() && !j.at("typealias").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_typealias(j.at("typealias").get<int64_t>());
    }

    inline void to_json(json & j, const Typealias & x) {
        j = json::object();
        j["typealias"] = x.get_typealias();
    }

    inline void from_json(const json & j, Typeof& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("typeof") != j.end() && !j.at("typeof").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_typeof(j.at("typeof").get<int64_t>());
    }

    inline void to_json(json & j, const Typeof & x) {
        j = json::object();
        j["typeof"] = x.get_typeof();
    }

    inline void from_json(const json & j, Uint& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("uint") != j.end() && !j.at("uint").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_uint(j.at("uint").get<int64_t>());
    }

    inline void to_json(json & j, const Uint & x) {
        j = json::object();
        j["uint"] = x.get_uint();
    }

    inline void from_json(const json & j, Ulong& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("ulong") != j.end() && !j.at("ulong").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_ulong(j.at("ulong").get<int64_t>());
    }

    inline void to_json(json & j, const Ulong & x) {
        j = json::object();
        j["ulong"] = x.get_ulong();
    }

    inline void from_json(const json & j, Unchecked& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("unchecked") != j.end() && !j.at("unchecked").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_unchecked(j.at("unchecked").get<int64_t>());
    }

    inline void to_json(json & j, const Unchecked & x) {
        j = json::object();
        j["unchecked"] = x.get_unchecked();
    }

    inline void from_json(const json & j, Undefined& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("undefined") != j.end() && !j.at("undefined").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_undefined(j.at("undefined").get<int64_t>());
    }

    inline void to_json(json & j, const Undefined & x) {
        j = json::object();
        j["undefined"] = x.get_undefined();
    }

    inline void from_json(const json & j, UnmarshalJson& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("UnmarshalJSON") != j.end() && !j.at("UnmarshalJSON").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_unmarshal_json(j.at("UnmarshalJSON").get<int64_t>());
    }

    inline void to_json(json & j, const UnmarshalJson & x) {
        j = json::object();
        j["UnmarshalJSON"] = x.get_unmarshal_json();
    }

    inline void from_json(const json & j, Unowned& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("unowned") != j.end() && !j.at("unowned").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_unowned(j.at("unowned").get<int64_t>());
    }

    inline void to_json(json & j, const Unowned & x) {
        j = json::object();
        j["unowned"] = x.get_unowned();
    }

    inline void from_json(const json & j, Unsafe& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("unsafe") != j.end() && !j.at("unsafe").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_unsafe(j.at("unsafe").get<int64_t>());
    }

    inline void to_json(json & j, const Unsafe & x) {
        j = json::object();
        j["unsafe"] = x.get_unsafe();
    }

    inline void from_json(const json & j, UseSerializers& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("UseSerializers") != j.end() && !j.at("UseSerializers").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_use_serializers(j.at("UseSerializers").get<int64_t>());
    }

    inline void to_json(json & j, const UseSerializers & x) {
        j = json::object();
        j["UseSerializers"] = x.get_use_serializers();
    }

    inline void from_json(const json & j, Ushort& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("ushort") != j.end() && !j.at("ushort").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_ushort(j.at("ushort").get<int64_t>());
    }

    inline void to_json(json & j, const Ushort & x) {
        j = json::object();
        j["ushort"] = x.get_ushort();
    }

    inline void from_json(const json & j, Utf8JsonReader& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("Utf8JsonReader") != j.end() && !j.at("Utf8JsonReader").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_utf8_json_reader(j.at("Utf8JsonReader").get<int64_t>());
    }

    inline void to_json(json & j, const Utf8JsonReader & x) {
        j = json::object();
        j["Utf8JsonReader"] = x.get_utf8_json_reader();
    }

    inline void from_json(const json & j, Utf8JsonWriter& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("Utf8JsonWriter") != j.end() && !j.at("Utf8JsonWriter").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_utf8_json_writer(j.at("Utf8JsonWriter").get<int64_t>());
    }

    inline void to_json(json & j, const Utf8JsonWriter & x) {
        j = json::object();
        j["Utf8JsonWriter"] = x.get_utf8_json_writer();
    }

    inline void from_json(const json & j, Uuid& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("UUID") != j.end() && !j.at("UUID").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_uuid(j.at("UUID").get<int64_t>());
    }

    inline void to_json(json & j, const Uuid & x) {
        j = json::object();
        j["UUID"] = x.get_uuid();
    }

    inline void from_json(const json & j, Var& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("var") != j.end() && !j.at("var").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_var(j.at("var").get<int64_t>());
    }

    inline void to_json(json & j, const Var & x) {
        j = json::object();
        j["var"] = x.get_var();
    }

    inline void from_json(const json & j, Weak& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("weak") != j.end() && !j.at("weak").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_weak(j.at("weak").get<int64_t>());
    }

    inline void to_json(json & j, const Weak & x) {
        j = json::object();
        j["weak"] = x.get_weak();
    }

    inline void from_json(const json & j, Where& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("where") != j.end() && !j.at("where").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_where(j.at("where").get<int64_t>());
    }

    inline void to_json(json & j, const Where & x) {
        j = json::object();
        j["where"] = x.get_where();
    }

    inline void from_json(const json & j, WillSet& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("willSet") != j.end() && !j.at("willSet").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_will_set(j.at("willSet").get<int64_t>());
    }

    inline void to_json(json & j, const WillSet & x) {
        j = json::object();
        j["willSet"] = x.get_will_set();
    }

    inline void from_json(const json & j, With& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("with") != j.end() && !j.at("with").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_with(j.at("with").get<int64_t>());
    }

    inline void to_json(json & j, const With & x) {
        j = json::object();
        j["with"] = x.get_with();
    }

    inline void from_json(const json & j, Yes& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("YES") != j.end() && !j.at("YES").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_yes(j.at("YES").get<int64_t>());
    }

    inline void to_json(json & j, const Yes & x) {
        j = json::object();
        j["YES"] = x.get_yes();
    }

    inline void from_json(const json & j, Yield& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("yield") != j.end() && !j.at("yield").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_yield(j.at("yield").get<int64_t>());
    }

    inline void to_json(json & j, const Yield & x) {
        j = json::object();
        j["yield"] = x.get_yield();
    }

    inline void from_json(const json & j, Obj6& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("dummy") != j.end() && !j.at("dummy").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_dummy(j.at("dummy").get<int64_t>());
        x.set_obj6_try(j.at("try").get<Try>());
        x.set_obj6_type(j.at("type").get<TypeClass>());
        x.set_obj6_typedef(j.at("typedef").get<Typedef>());
        x.set_obj6_typeid(j.at("typeid").get<Typeid>());
        x.set_obj6_typename(j.at("typename").get<Typename>());
        x.set_obj6_union(j.at("union").get<Union>());
        x.set_obj6_unsigned(j.at("unsigned").get<Unsigned>());
        x.set_obj6_using(j.at("using").get<Using>());
        x.set_obj6_virtual(j.at("virtual").get<Virtual>());
        x.set_obj6_void(j.at("void").get<Void>());
        x.set_obj6_volatile(j.at("volatile").get<Volatile>());
        x.set_obj6_wchar_t(j.at("wchar_t").get<WcharT>());
        x.set_obj6_while(j.at("while").get<While>());
        x.set_obj6_xor(j.at("xor").get<Xor>());
        x.set_obj6_xor_eq(j.at("xor_eq").get<XorEq>());
        x.set_type(j.at("Type").get<Type>());
        x.set_typealias(j.at("typealias").get<Typealias>());
        x.set_typeof(j.at("typeof").get<Typeof>());
        x.set_uint(j.at("uint").get<Uint>());
        x.set_ulong(j.at("ulong").get<Ulong>());
        x.set_unchecked(j.at("unchecked").get<Unchecked>());
        x.set_undefined(j.at("undefined").get<Undefined>());
        x.set_unmarshal_json(j.at("UnmarshalJSON").get<UnmarshalJson>());
        x.set_unowned(j.at("unowned").get<Unowned>());
        x.set_unsafe(j.at("unsafe").get<Unsafe>());
        x.set_use_serializers(j.at("UseSerializers").get<UseSerializers>());
        x.set_ushort(j.at("ushort").get<Ushort>());
        x.set_utf8_json_reader(j.at("Utf8JsonReader").get<Utf8JsonReader>());
        x.set_utf8_json_writer(j.at("Utf8JsonWriter").get<Utf8JsonWriter>());
        x.set_uuid(j.at("UUID").get<Uuid>());
        x.set_var(j.at("var").get<Var>());
        x.set_weak(j.at("weak").get<Weak>());
        x.set_where(j.at("where").get<Where>());
        x.set_will_set(j.at("willSet").get<WillSet>());
        x.set_with(j.at("with").get<With>());
        x.set_yes(j.at("YES").get<Yes>());
        x.set_yield(j.at("yield").get<Yield>());
    }

    inline void to_json(json & j, const Obj6 & x) {
        j = json::object();
        j["dummy"] = x.get_dummy();
        j["try"] = x.get_obj6_try();
        j["type"] = x.get_obj6_type();
        j["typedef"] = x.get_obj6_typedef();
        j["typeid"] = x.get_obj6_typeid();
        j["typename"] = x.get_obj6_typename();
        j["union"] = x.get_obj6_union();
        j["unsigned"] = x.get_obj6_unsigned();
        j["using"] = x.get_obj6_using();
        j["virtual"] = x.get_obj6_virtual();
        j["void"] = x.get_obj6_void();
        j["volatile"] = x.get_obj6_volatile();
        j["wchar_t"] = x.get_obj6_wchar_t();
        j["while"] = x.get_obj6_while();
        j["xor"] = x.get_obj6_xor();
        j["xor_eq"] = x.get_obj6_xor_eq();
        j["Type"] = x.get_type();
        j["typealias"] = x.get_typealias();
        j["typeof"] = x.get_typeof();
        j["uint"] = x.get_uint();
        j["ulong"] = x.get_ulong();
        j["unchecked"] = x.get_unchecked();
        j["undefined"] = x.get_undefined();
        j["UnmarshalJSON"] = x.get_unmarshal_json();
        j["unowned"] = x.get_unowned();
        j["unsafe"] = x.get_unsafe();
        j["UseSerializers"] = x.get_use_serializers();
        j["ushort"] = x.get_ushort();
        j["Utf8JsonReader"] = x.get_utf8_json_reader();
        j["Utf8JsonWriter"] = x.get_utf8_json_writer();
        j["UUID"] = x.get_uuid();
        j["var"] = x.get_var();
        j["weak"] = x.get_weak();
        j["where"] = x.get_where();
        j["willSet"] = x.get_will_set();
        j["with"] = x.get_with();
        j["YES"] = x.get_yes();
        j["yield"] = x.get_yield();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("dummy") != j.end() && !j.at("dummy").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_dummy(j.at("dummy").get<int64_t>());
        x.set_obj1(j.at("obj1").get<Obj1>());
        x.set_obj2(j.at("obj2").get<Obj2>());
        x.set_obj3(j.at("obj3").get<Obj3>());
        x.set_obj4(j.at("obj4").get<Obj4>());
        x.set_obj5(j.at("obj5").get<Obj5>());
        x.set_obj6(j.at("obj6").get<Obj6>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["dummy"] = x.get_dummy();
        j["obj1"] = x.get_obj1();
        j["obj2"] = x.get_obj2();
        j["obj3"] = x.get_obj3();
        j["obj4"] = x.get_obj4();
        j["obj5"] = x.get_obj5();
        j["obj6"] = x.get_obj6();
    }

    inline void from_json(const json & j, EnumValue & x) {
        if (j == "ready") x = EnumValue::READY;
        else if (j == "done") x = EnumValue::DONE;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"EnumValue\""); }
    }

    inline void to_json(json & j, const EnumValue & x) {
        switch (x) {
            case EnumValue::READY: j = "ready"; break;
            case EnumValue::DONE: j = "done"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"EnumValue\": " + std::to_string(static_cast<int>(x)));
        }
    }
}
