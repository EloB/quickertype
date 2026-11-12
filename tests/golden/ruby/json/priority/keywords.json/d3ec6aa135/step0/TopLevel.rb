# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.obj6.yes.yes.even?
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Integer   = Strict::Integer
  Nil       = Strict::Nil
  Hash      = Strict::Hash
  String    = Strict::String
  EnumValue = Strict::String.enum("ready", "done")
end

class Abstract < Dry::Struct
  attribute :abstract, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      abstract: d.fetch("abstract"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "abstract" => abstract,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Alignas < Dry::Struct
  attribute :alignas, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      alignas: d.fetch("alignas"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "alignas" => alignas,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Alignof < Dry::Struct
  attribute :alignof, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      alignof: d.fetch("alignof"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "alignof" => alignof,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class AndEq < Dry::Struct
  attribute :and_eq, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      and_eq: d.fetch("and_eq"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "and_eq" => and_eq,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Any < Dry::Struct
  attribute :any, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      any: d.fetch("Any"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "Any" => any,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ArrayClass < Dry::Struct
  attribute :array, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      array: d.fetch("array"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "array" => array,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ArrayNode < Dry::Struct
  attribute :array_node, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      array_node: d.fetch("ArrayNode"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "ArrayNode" => array_node,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class As < Dry::Struct
  attribute :as, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      as: d.fetch("as"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "as" => as,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ASM < Dry::Struct
  attribute :asm, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      asm: d.fetch("asm"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "asm" => asm,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Assert < Dry::Struct
  attribute :assert, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      assert: d.fetch("assert"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "assert" => assert,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Associatedtype < Dry::Struct
  attribute :associatedtype, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      associatedtype: d.fetch("associatedtype"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "associatedtype" => associatedtype,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Associativity < Dry::Struct
  attribute :associativity, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      associativity: d.fetch("associativity"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "associativity" => associativity,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Async < Dry::Struct
  attribute :async, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      async: d.fetch("async"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "async" => async,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Atomic < Dry::Struct
  attribute :atomic, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      atomic: d.fetch("atomic"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "atomic" => atomic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class AtomicCancel < Dry::Struct
  attribute :atomic_cancel, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      atomic_cancel: d.fetch("atomic_cancel"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "atomic_cancel" => atomic_cancel,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class AtomicCommit < Dry::Struct
  attribute :atomic_commit, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      atomic_commit: d.fetch("atomic_commit"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "atomic_commit" => atomic_commit,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class AtomicNoexcept < Dry::Struct
  attribute :atomic_noexcept, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      atomic_noexcept: d.fetch("atomic_noexcept"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "atomic_noexcept" => atomic_noexcept,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Auto < Dry::Struct
  attribute :auto, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      auto: d.fetch("auto"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "auto" => auto,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Await < Dry::Struct
  attribute :await, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      await: d.fetch("await"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "await" => await,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Base < Dry::Struct
  attribute :base, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      base: d.fetch("base"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "base" => base,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Bitand < Dry::Struct
  attribute :bitand, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      bitand: d.fetch("bitand"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "bitand" => bitand,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Bitor < Dry::Struct
  attribute :bitor, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      bitor: d.fetch("bitor"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "bitor" => bitor,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Bool < Dry::Struct
  attribute :bool, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      bool: d.fetch("BOOL"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "BOOL" => bool,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Obj1Bool < Dry::Struct
  attribute :bool, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      bool: d.fetch("bool"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "bool" => bool,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Boolean < Dry::Struct
  attribute :boolean, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      boolean: d.fetch("boolean"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "boolean" => boolean,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class BooleanNode < Dry::Struct
  attribute :boolean_node, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      boolean_node: d.fetch("BooleanNode"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "BooleanNode" => boolean_node,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Bycopy < Dry::Struct
  attribute :bycopy, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      bycopy: d.fetch("bycopy"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "bycopy" => bycopy,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Byref < Dry::Struct
  attribute :byref, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      byref: d.fetch("byref"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "byref" => byref,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Byte < Dry::Struct
  attribute :byte, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      byte: d.fetch("byte"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "byte" => byte,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Calendar < Dry::Struct
  attribute :calendar, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      calendar: d.fetch("Calendar"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "Calendar" => calendar,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Chan < Dry::Struct
  attribute :chan, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      chan: d.fetch("chan"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "chan" => chan,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Char < Dry::Struct
  attribute :char, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      char: d.fetch("char"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "char" => char,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Char16T < Dry::Struct
  attribute :char16_t, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      char16_t: d.fetch("char16_t"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "char16_t" => char16_t,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Char32T < Dry::Struct
  attribute :char32_t, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      char32_t: d.fetch("char32_t"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "char32_t" => char32_t,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Checked < Dry::Struct
  attribute :checked, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      checked: d.fetch("checked"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "checked" => checked,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Obj1Class < Dry::Struct
  attribute :class_class, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      class_class: d.fetch("class"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "class" => class_class,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class CoAwait < Dry::Struct
  attribute :co_await, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      co_await: d.fetch("co_await"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "co_await" => co_await,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class CoReturn < Dry::Struct
  attribute :co_return, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      co_return: d.fetch("co_return"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "co_return" => co_return,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class CoYield < Dry::Struct
  attribute :co_yield, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      co_yield: d.fetch("co_yield"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "co_yield" => co_yield,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Codable < Dry::Struct
  attribute :codable, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      codable: d.fetch("Codable"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "Codable" => codable,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class CodingKey < Dry::Struct
  attribute :coding_key, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      coding_key: d.fetch("CodingKey"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "CodingKey" => coding_key,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class CodingKeys < Dry::Struct
  attribute :coding_keys, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      coding_keys: d.fetch("CodingKeys"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "CodingKeys" => coding_keys,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Compl < Dry::Struct
  attribute :compl, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      compl: d.fetch("compl"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "compl" => compl,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ComplexClass < Dry::Struct
  attribute :complex, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      complex: d.fetch("_Complex"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "_Complex" => complex,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Concept < Dry::Struct
  attribute :concept, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      concept: d.fetch("concept"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "concept" => concept,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Console < Dry::Struct
  attribute :console, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      console: d.fetch("console"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "console" => console,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Const < Dry::Struct
  attribute :const, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      const: d.fetch("const"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "const" => const,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ConstCast < Dry::Struct
  attribute :const_cast, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      const_cast: d.fetch("const_cast"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "const_cast" => const_cast,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Constexpr < Dry::Struct
  attribute :constexpr, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      constexpr: d.fetch("constexpr"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "constexpr" => constexpr,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Continue < Dry::Struct
  attribute :continue, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      continue: d.fetch("continue"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "continue" => continue,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Convenience < Dry::Struct
  attribute :convenience, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      convenience: d.fetch("convenience"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "convenience" => convenience,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Convert < Dry::Struct
  attribute :convert, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      convert: d.fetch("convert"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "convert" => convert,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Converter < Dry::Struct
  attribute :converter, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      converter: d.fetch("converter"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "converter" => converter,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Empty < Dry::Struct
  attribute :empty, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      empty: d.fetch("_"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "_" => empty,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Imaginery < Dry::Struct
  attribute :imaginery, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      imaginery: d.fetch("_Imaginery"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "_Imaginery" => imaginery,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class And < Dry::Struct
  attribute :and_and, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      and_and: d.fetch("and"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "and" => and_and,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class AnyClass < Dry::Struct
  attribute :any, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      any: d.fetch("any"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "any" => any,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class BoolClass < Dry::Struct
  attribute :bool, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      bool: d.fetch("_Bool"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "_Bool" => bool,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Break < Dry::Struct
  attribute :break_break, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      break_break: d.fetch("break"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "break" => break_break,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Case < Dry::Struct
  attribute :case_case, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      case_case: d.fetch("case"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "case" => case_case,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Catch < Dry::Struct
  attribute :catch_catch, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      catch_catch: d.fetch("catch"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "catch" => catch_catch,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ClassClass < Dry::Struct
  attribute :class_class, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      class_class: d.fetch("Class"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "Class" => class_class,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Clone < Dry::Struct
  attribute :clone_clone, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      clone_clone: d.fetch("clone"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "clone" => clone_clone,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ConstructorClass < Dry::Struct
  attribute :constructor_constructor, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      constructor_constructor: d.fetch("constructor"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "constructor" => constructor_constructor,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Obj1 < Dry::Struct
  attribute :abstract,         Abstract
  attribute :alignas,          Alignas
  attribute :alignof,          Alignof
  attribute :and_eq,           AndEq
  attribute :any,              Any
  attribute :array,            ArrayClass
  attribute :array_node,       ArrayNode
  attribute :as,               As
  attribute :asm,              ASM
  attribute :assert,           Assert
  attribute :associatedtype,   Associatedtype
  attribute :associativity,    Associativity
  attribute :async,            Async
  attribute :atomic,           Atomic
  attribute :atomic_cancel,    AtomicCancel
  attribute :atomic_commit,    AtomicCommit
  attribute :atomic_noexcept,  AtomicNoexcept
  attribute :auto,             Auto
  attribute :await,            Await
  attribute :base,             Base
  attribute :bitand,           Bitand
  attribute :bitor,            Bitor
  attribute :bool,             Bool
  attribute :bool_1,           Obj1Bool
  attribute :boolean,          Boolean
  attribute :boolean_node,     BooleanNode
  attribute :bycopy,           Bycopy
  attribute :byref,            Byref
  attribute :byte,             Byte
  attribute :calendar,         Calendar
  attribute :chan,             Chan
  attribute :char,             Char
  attribute :char16_t,         Char16T
  attribute :char32_t,         Char32T
  attribute :checked,          Checked
  attribute :class_1,          Obj1Class
  attribute :co_await,         CoAwait
  attribute :co_return,        CoReturn
  attribute :co_yield,         CoYield
  attribute :codable,          Codable
  attribute :coding_key,       CodingKey
  attribute :coding_keys,      CodingKeys
  attribute :compl,            Compl
  attribute :complex,          ComplexClass
  attribute :concept,          Concept
  attribute :console,          Console
  attribute :const,            Const
  attribute :const_cast,       ConstCast
  attribute :constexpr,        Constexpr
  attribute :continue,         Continue
  attribute :convenience,      Convenience
  attribute :convert,          Convert
  attribute :converter,        Converter
  attribute :dummy,            Types::Integer
  attribute :empty,            Empty
  attribute :imaginery,        Imaginery
  attribute :obj1_and,         And
  attribute :obj1_any,         AnyClass
  attribute :obj1_bool,        BoolClass
  attribute :obj1_break,       Break
  attribute :obj1_case,        Case
  attribute :obj1_catch,       Catch
  attribute :obj1_class,       ClassClass
  attribute :obj1_clone,       Clone
  attribute :obj1_constructor, ConstructorClass

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      abstract:         Abstract.from_dynamic!(d.fetch("abstract")),
      alignas:          Alignas.from_dynamic!(d.fetch("alignas")),
      alignof:          Alignof.from_dynamic!(d.fetch("alignof")),
      and_eq:           AndEq.from_dynamic!(d.fetch("and_eq")),
      any:              Any.from_dynamic!(d.fetch("Any")),
      array:            ArrayClass.from_dynamic!(d.fetch("array")),
      array_node:       ArrayNode.from_dynamic!(d.fetch("ArrayNode")),
      as:               As.from_dynamic!(d.fetch("as")),
      asm:              ASM.from_dynamic!(d.fetch("asm")),
      assert:           Assert.from_dynamic!(d.fetch("assert")),
      associatedtype:   Associatedtype.from_dynamic!(d.fetch("associatedtype")),
      associativity:    Associativity.from_dynamic!(d.fetch("associativity")),
      async:            Async.from_dynamic!(d.fetch("async")),
      atomic:           Atomic.from_dynamic!(d.fetch("atomic")),
      atomic_cancel:    AtomicCancel.from_dynamic!(d.fetch("atomic_cancel")),
      atomic_commit:    AtomicCommit.from_dynamic!(d.fetch("atomic_commit")),
      atomic_noexcept:  AtomicNoexcept.from_dynamic!(d.fetch("atomic_noexcept")),
      auto:             Auto.from_dynamic!(d.fetch("auto")),
      await:            Await.from_dynamic!(d.fetch("await")),
      base:             Base.from_dynamic!(d.fetch("base")),
      bitand:           Bitand.from_dynamic!(d.fetch("bitand")),
      bitor:            Bitor.from_dynamic!(d.fetch("bitor")),
      bool:             Bool.from_dynamic!(d.fetch("BOOL")),
      bool_1:           Obj1Bool.from_dynamic!(d.fetch("bool")),
      boolean:          Boolean.from_dynamic!(d.fetch("boolean")),
      boolean_node:     BooleanNode.from_dynamic!(d.fetch("BooleanNode")),
      bycopy:           Bycopy.from_dynamic!(d.fetch("bycopy")),
      byref:            Byref.from_dynamic!(d.fetch("byref")),
      byte:             Byte.from_dynamic!(d.fetch("byte")),
      calendar:         Calendar.from_dynamic!(d.fetch("Calendar")),
      chan:             Chan.from_dynamic!(d.fetch("chan")),
      char:             Char.from_dynamic!(d.fetch("char")),
      char16_t:         Char16T.from_dynamic!(d.fetch("char16_t")),
      char32_t:         Char32T.from_dynamic!(d.fetch("char32_t")),
      checked:          Checked.from_dynamic!(d.fetch("checked")),
      class_1:          Obj1Class.from_dynamic!(d.fetch("class")),
      co_await:         CoAwait.from_dynamic!(d.fetch("co_await")),
      co_return:        CoReturn.from_dynamic!(d.fetch("co_return")),
      co_yield:         CoYield.from_dynamic!(d.fetch("co_yield")),
      codable:          Codable.from_dynamic!(d.fetch("Codable")),
      coding_key:       CodingKey.from_dynamic!(d.fetch("CodingKey")),
      coding_keys:      CodingKeys.from_dynamic!(d.fetch("CodingKeys")),
      compl:            Compl.from_dynamic!(d.fetch("compl")),
      complex:          ComplexClass.from_dynamic!(d.fetch("_Complex")),
      concept:          Concept.from_dynamic!(d.fetch("concept")),
      console:          Console.from_dynamic!(d.fetch("console")),
      const:            Const.from_dynamic!(d.fetch("const")),
      const_cast:       ConstCast.from_dynamic!(d.fetch("const_cast")),
      constexpr:        Constexpr.from_dynamic!(d.fetch("constexpr")),
      continue:         Continue.from_dynamic!(d.fetch("continue")),
      convenience:      Convenience.from_dynamic!(d.fetch("convenience")),
      convert:          Convert.from_dynamic!(d.fetch("convert")),
      converter:        Converter.from_dynamic!(d.fetch("converter")),
      dummy:            d.fetch("dummy"),
      empty:            Empty.from_dynamic!(d.fetch("_")),
      imaginery:        Imaginery.from_dynamic!(d.fetch("_Imaginery")),
      obj1_and:         And.from_dynamic!(d.fetch("and")),
      obj1_any:         AnyClass.from_dynamic!(d.fetch("any")),
      obj1_bool:        BoolClass.from_dynamic!(d.fetch("_Bool")),
      obj1_break:       Break.from_dynamic!(d.fetch("break")),
      obj1_case:        Case.from_dynamic!(d.fetch("case")),
      obj1_catch:       Catch.from_dynamic!(d.fetch("catch")),
      obj1_class:       ClassClass.from_dynamic!(d.fetch("Class")),
      obj1_clone:       Clone.from_dynamic!(d.fetch("clone")),
      obj1_constructor: ConstructorClass.from_dynamic!(d.fetch("constructor")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "abstract"        => abstract.to_dynamic,
      "alignas"         => alignas.to_dynamic,
      "alignof"         => alignof.to_dynamic,
      "and_eq"          => and_eq.to_dynamic,
      "Any"             => any.to_dynamic,
      "array"           => array.to_dynamic,
      "ArrayNode"       => array_node.to_dynamic,
      "as"              => as.to_dynamic,
      "asm"             => asm.to_dynamic,
      "assert"          => assert.to_dynamic,
      "associatedtype"  => associatedtype.to_dynamic,
      "associativity"   => associativity.to_dynamic,
      "async"           => async.to_dynamic,
      "atomic"          => atomic.to_dynamic,
      "atomic_cancel"   => atomic_cancel.to_dynamic,
      "atomic_commit"   => atomic_commit.to_dynamic,
      "atomic_noexcept" => atomic_noexcept.to_dynamic,
      "auto"            => auto.to_dynamic,
      "await"           => await.to_dynamic,
      "base"            => base.to_dynamic,
      "bitand"          => bitand.to_dynamic,
      "bitor"           => bitor.to_dynamic,
      "BOOL"            => bool.to_dynamic,
      "bool"            => bool_1.to_dynamic,
      "boolean"         => boolean.to_dynamic,
      "BooleanNode"     => boolean_node.to_dynamic,
      "bycopy"          => bycopy.to_dynamic,
      "byref"           => byref.to_dynamic,
      "byte"            => byte.to_dynamic,
      "Calendar"        => calendar.to_dynamic,
      "chan"            => chan.to_dynamic,
      "char"            => char.to_dynamic,
      "char16_t"        => char16_t.to_dynamic,
      "char32_t"        => char32_t.to_dynamic,
      "checked"         => checked.to_dynamic,
      "class"           => class_1.to_dynamic,
      "co_await"        => co_await.to_dynamic,
      "co_return"       => co_return.to_dynamic,
      "co_yield"        => co_yield.to_dynamic,
      "Codable"         => codable.to_dynamic,
      "CodingKey"       => coding_key.to_dynamic,
      "CodingKeys"      => coding_keys.to_dynamic,
      "compl"           => compl.to_dynamic,
      "_Complex"        => complex.to_dynamic,
      "concept"         => concept.to_dynamic,
      "console"         => console.to_dynamic,
      "const"           => const.to_dynamic,
      "const_cast"      => const_cast.to_dynamic,
      "constexpr"       => constexpr.to_dynamic,
      "continue"        => continue.to_dynamic,
      "convenience"     => convenience.to_dynamic,
      "convert"         => convert.to_dynamic,
      "converter"       => converter.to_dynamic,
      "dummy"           => dummy,
      "_"               => empty.to_dynamic,
      "_Imaginery"      => imaginery.to_dynamic,
      "and"             => obj1_and.to_dynamic,
      "any"             => obj1_any.to_dynamic,
      "_Bool"           => obj1_bool.to_dynamic,
      "break"           => obj1_break.to_dynamic,
      "case"            => obj1_case.to_dynamic,
      "catch"           => obj1_catch.to_dynamic,
      "Class"           => obj1_class.to_dynamic,
      "clone"           => obj1_clone.to_dynamic,
      "constructor"     => obj1_constructor.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class CultureInfo < Dry::Struct
  attribute :culture_info, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      culture_info: d.fetch("CultureInfo"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "CultureInfo" => culture_info,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class DateClass < Dry::Struct
  attribute :date, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      date: d.fetch("date"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "date" => date,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class DateFormatter < Dry::Struct
  attribute :date_formatter, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      date_formatter: d.fetch("DateFormatter"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "DateFormatter" => date_formatter,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class DateOnly < Dry::Struct
  attribute :date_only, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      date_only: d.fetch("DateOnly"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "DateOnly" => date_only,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class DateOnlyConverter < Dry::Struct
  attribute :date_only_converter, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      date_only_converter: d.fetch("DateOnlyConverter"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "DateOnlyConverter" => date_only_converter,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class DateParseHandling < Dry::Struct
  attribute :date_parse_handling, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      date_parse_handling: d.fetch("date_parse_handling"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "date_parse_handling" => date_parse_handling,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class DateTimeClass < Dry::Struct
  attribute :date_time, Types::String.constrained(format: /\A\d{4}-\d\d-\d\dT\d\d:\d\d:\d\d(?:\.\d+)?(?:Z|[+-]\d\d:\d\d)\z/i)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      date_time: d.fetch("DateTime"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "DateTime" => date_time,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class DateTimeStyles < Dry::Struct
  attribute :date_time_styles, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      date_time_styles: d.fetch("DateTimeStyles"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "DateTimeStyles" => date_time_styles,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Debugger < Dry::Struct
  attribute :debugger, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      debugger: d.fetch("debugger"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "debugger" => debugger,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Decimal < Dry::Struct
  attribute :decimal, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      decimal: d.fetch("decimal"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "decimal" => decimal,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Declare < Dry::Struct
  attribute :declare, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      declare: d.fetch("declare"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "declare" => declare,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Decltype < Dry::Struct
  attribute :decltype, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      decltype: d.fetch("decltype"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "decltype" => decltype,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class DecodeString < Dry::Struct
  attribute :decode_string, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      decode_string: d.fetch("decode_string"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "decode_string" => decode_string,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Decoder < Dry::Struct
  attribute :decoder, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      decoder: d.fetch("Decoder"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "Decoder" => decoder,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class DecodingError < Dry::Struct
  attribute :decoding_error, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      decoding_error: d.fetch("DecodingError"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "DecodingError" => decoding_error,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Defer < Dry::Struct
  attribute :defer, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      defer: d.fetch("defer"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "defer" => defer,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Deinit < Dry::Struct
  attribute :deinit, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      deinit: d.fetch("deinit"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "deinit" => deinit,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Del < Dry::Struct
  attribute :del, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      del: d.fetch("del"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "del" => del,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Delegate < Dry::Struct
  attribute :delegate, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      delegate: d.fetch("delegate"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "delegate" => delegate,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Delete < Dry::Struct
  attribute :delete, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      delete: d.fetch("delete"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "delete" => delete,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class DeserializationFeature < Dry::Struct
  attribute :deserialization_feature, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      deserialization_feature: d.fetch("DeserializationFeature"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "DeserializationFeature" => deserialization_feature,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Dict < Dry::Struct
  attribute :dict, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      dict: d.fetch("dict"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "dict" => dict,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Dictionary < Dry::Struct
  attribute :dictionary, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      dictionary: d.fetch("dictionary"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "dictionary" => dictionary,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class DidSet < Dry::Struct
  attribute :did_set, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      did_set: d.fetch("didSet"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "didSet" => did_set,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Double < Dry::Struct
  attribute :double, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      double: d.fetch("double"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "double" => double,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class DoubleNode < Dry::Struct
  attribute :double_node, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      double_node: d.fetch("DoubleNode"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "DoubleNode" => double_node,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Dynamic < Dry::Struct
  attribute :dynamic, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      dynamic: d.fetch("dynamic"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "dynamic" => dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class DynamicCast < Dry::Struct
  attribute :dynamic_cast, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      dynamic_cast: d.fetch("dynamic_cast"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "dynamic_cast" => dynamic_cast,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Elif < Dry::Struct
  attribute :elif, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      elif: d.fetch("elif"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "elif" => elif,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class EncodeQuickType < Dry::Struct
  attribute :encode_quick_type, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      encode_quick_type: d.fetch("encode_quick_type"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "encode_quick_type" => encode_quick_type,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Encoder < Dry::Struct
  attribute :encoder, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      encoder: d.fetch("Encoder"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "Encoder" => encoder,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

module EnumValue
  Ready = "ready"
  Done  = "done"
end

class EnumValues < Dry::Struct
  attribute :enum_values, Types.Array(Types::EnumValue)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      enum_values: d.fetch("EnumValues"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "EnumValues" => enum_values,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class EqualityContract < Dry::Struct
  attribute :equality_contract, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      equality_contract: d.fetch("equalityContract"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "equalityContract" => equality_contract,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Equatable < Dry::Struct
  attribute :equatable, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      equatable: d.fetch("Equatable"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "Equatable" => equatable,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Event < Dry::Struct
  attribute :event, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      event: d.fetch("event"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "event" => event,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Except < Dry::Struct
  attribute :except, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      except: d.fetch("except"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "except" => except,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ExceptionClass < Dry::Struct
  attribute :exception, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      exception: d.fetch("exception"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "exception" => exception,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Explicit < Dry::Struct
  attribute :explicit, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      explicit: d.fetch("explicit"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "explicit" => explicit,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Export < Dry::Struct
  attribute :export, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      export: d.fetch("export"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "export" => export,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Exposing < Dry::Struct
  attribute :exposing, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      exposing: d.fetch("exposing"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "exposing" => exposing,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Extends < Dry::Struct
  attribute :extends, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      extends: d.fetch("extends"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "extends" => extends,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Extension < Dry::Struct
  attribute :extension, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      extension: d.fetch("extension"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "extension" => extension,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Extern < Dry::Struct
  attribute :extern, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      extern: d.fetch("extern"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "extern" => extern,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Fallthrough < Dry::Struct
  attribute :fallthrough, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      fallthrough: d.fetch("fallthrough"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "fallthrough" => fallthrough,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Obj2False < Dry::Struct
  attribute :false_false, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      false_false: d.fetch("false"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "false" => false_false,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Fileprivate < Dry::Struct
  attribute :fileprivate, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      fileprivate: d.fetch("fileprivate"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "fileprivate" => fileprivate,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Final < Dry::Struct
  attribute :final, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      final: d.fetch("final"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "final" => final,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Finally < Dry::Struct
  attribute :finally, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      finally: d.fetch("finally"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "finally" => finally,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Fixed < Dry::Struct
  attribute :fixed, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      fixed: d.fetch("fixed"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "fixed" => fixed,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class FloatClass < Dry::Struct
  attribute :float, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      float: d.fetch("float"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "float" => float,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Foreach < Dry::Struct
  attribute :foreach, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      foreach: d.fetch("foreach"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "foreach" => foreach,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class FormatException < Dry::Struct
  attribute :format_exception, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      format_exception: d.fetch("FormatException"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "FormatException" => format_exception,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Friend < Dry::Struct
  attribute :friend, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      friend: d.fetch("friend"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "friend" => friend,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class From < Dry::Struct
  attribute :from, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      from: d.fetch("from"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "from" => from,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class FromDict < Dry::Struct
  attribute :from_dict, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      from_dict: d.fetch("from_dict"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "from_dict" => from_dict,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class FromJSON < Dry::Struct
  attribute :from_json, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      from_json: d.fetch("from_json"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "from_json" => from_json,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Func < Dry::Struct
  attribute :func, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      func: d.fetch("func"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "func" => func,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Def < Dry::Struct
  attribute :def_def, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      def_def: d.fetch("def"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "def" => def_def,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Default < Dry::Struct
  attribute :default_default, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      default_default: d.fetch("default"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "default" => default_default,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Do < Dry::Struct
  attribute :do_do, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      do_do: d.fetch("do"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "do" => do_do,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Else < Dry::Struct
  attribute :else_else, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      else_else: d.fetch("else"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "else" => else_else,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Enum < Dry::Struct
  attribute :enum_enum, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      enum_enum: d.fetch("enum"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "enum" => enum_enum,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class False < Dry::Struct
  attribute :false_false, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      false_false: d.fetch("False"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "False" => false_false,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class For < Dry::Struct
  attribute :for_for, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      for_for: d.fetch("for"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "for" => for_for,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Obj2 < Dry::Struct
  attribute :culture_info,            CultureInfo
  attribute :date,                    DateClass
  attribute :date_formatter,          DateFormatter
  attribute :date_only,               DateOnly
  attribute :date_only_converter,     DateOnlyConverter
  attribute :date_parse_handling,     DateParseHandling
  attribute :date_time,               DateTimeClass
  attribute :date_time_styles,        DateTimeStyles
  attribute :debugger,                Debugger
  attribute :decimal,                 Decimal
  attribute :declare,                 Declare
  attribute :decltype,                Decltype
  attribute :decode_string,           DecodeString
  attribute :decoder,                 Decoder
  attribute :decoding_error,          DecodingError
  attribute :defer,                   Defer
  attribute :deinit,                  Deinit
  attribute :del,                     Del
  attribute :delegate,                Delegate
  attribute :delete,                  Delete
  attribute :deserialization_feature, DeserializationFeature
  attribute :dict,                    Dict
  attribute :dictionary,              Dictionary
  attribute :did_set,                 DidSet
  attribute :double,                  Double
  attribute :double_node,             DoubleNode
  attribute :dummy,                   Types::Integer
  attribute :dynamic,                 Dynamic
  attribute :dynamic_cast,            DynamicCast
  attribute :elif,                    Elif
  attribute :encode_quick_type,       EncodeQuickType
  attribute :encoder,                 Encoder
  attribute :enum_values,             EnumValues
  attribute :equality_contract,       EqualityContract
  attribute :equatable,               Equatable
  attribute :event,                   Event
  attribute :except,                  Except
  attribute :exception,               ExceptionClass
  attribute :explicit,                Explicit
  attribute :export,                  Export
  attribute :exposing,                Exposing
  attribute :extends,                 Extends
  attribute :extension,               Extension
  attribute :extern,                  Extern
  attribute :fallthrough,             Fallthrough
  attribute :false_1,                 Obj2False
  attribute :fileprivate,             Fileprivate
  attribute :final,                   Final
  attribute :finally,                 Finally
  attribute :fixed,                   Fixed
  attribute :float,                   FloatClass
  attribute :foreach,                 Foreach
  attribute :format_exception,        FormatException
  attribute :friend,                  Friend
  attribute :from,                    From
  attribute :from_dict,               FromDict
  attribute :from_json,               FromJSON
  attribute :func,                    Func
  attribute :obj2_def,                Def
  attribute :obj2_default,            Default
  attribute :obj2_do,                 Do
  attribute :obj2_else,               Else
  attribute :obj2_enum,               Enum
  attribute :obj2_false,              False
  attribute :obj2_for,                For

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      culture_info:            CultureInfo.from_dynamic!(d.fetch("CultureInfo")),
      date:                    DateClass.from_dynamic!(d.fetch("date")),
      date_formatter:          DateFormatter.from_dynamic!(d.fetch("DateFormatter")),
      date_only:               DateOnly.from_dynamic!(d.fetch("DateOnly")),
      date_only_converter:     DateOnlyConverter.from_dynamic!(d.fetch("DateOnlyConverter")),
      date_parse_handling:     DateParseHandling.from_dynamic!(d.fetch("date_parse_handling")),
      date_time:               DateTimeClass.from_dynamic!(d.fetch("DateTime")),
      date_time_styles:        DateTimeStyles.from_dynamic!(d.fetch("DateTimeStyles")),
      debugger:                Debugger.from_dynamic!(d.fetch("debugger")),
      decimal:                 Decimal.from_dynamic!(d.fetch("decimal")),
      declare:                 Declare.from_dynamic!(d.fetch("declare")),
      decltype:                Decltype.from_dynamic!(d.fetch("decltype")),
      decode_string:           DecodeString.from_dynamic!(d.fetch("decode_string")),
      decoder:                 Decoder.from_dynamic!(d.fetch("Decoder")),
      decoding_error:          DecodingError.from_dynamic!(d.fetch("DecodingError")),
      defer:                   Defer.from_dynamic!(d.fetch("defer")),
      deinit:                  Deinit.from_dynamic!(d.fetch("deinit")),
      del:                     Del.from_dynamic!(d.fetch("del")),
      delegate:                Delegate.from_dynamic!(d.fetch("delegate")),
      delete:                  Delete.from_dynamic!(d.fetch("delete")),
      deserialization_feature: DeserializationFeature.from_dynamic!(d.fetch("DeserializationFeature")),
      dict:                    Dict.from_dynamic!(d.fetch("dict")),
      dictionary:              Dictionary.from_dynamic!(d.fetch("dictionary")),
      did_set:                 DidSet.from_dynamic!(d.fetch("didSet")),
      double:                  Double.from_dynamic!(d.fetch("double")),
      double_node:             DoubleNode.from_dynamic!(d.fetch("DoubleNode")),
      dummy:                   d.fetch("dummy"),
      dynamic:                 Dynamic.from_dynamic!(d.fetch("dynamic")),
      dynamic_cast:            DynamicCast.from_dynamic!(d.fetch("dynamic_cast")),
      elif:                    Elif.from_dynamic!(d.fetch("elif")),
      encode_quick_type:       EncodeQuickType.from_dynamic!(d.fetch("encode_quick_type")),
      encoder:                 Encoder.from_dynamic!(d.fetch("Encoder")),
      enum_values:             EnumValues.from_dynamic!(d.fetch("EnumValues")),
      equality_contract:       EqualityContract.from_dynamic!(d.fetch("equalityContract")),
      equatable:               Equatable.from_dynamic!(d.fetch("Equatable")),
      event:                   Event.from_dynamic!(d.fetch("event")),
      except:                  Except.from_dynamic!(d.fetch("except")),
      exception:               ExceptionClass.from_dynamic!(d.fetch("exception")),
      explicit:                Explicit.from_dynamic!(d.fetch("explicit")),
      export:                  Export.from_dynamic!(d.fetch("export")),
      exposing:                Exposing.from_dynamic!(d.fetch("exposing")),
      extends:                 Extends.from_dynamic!(d.fetch("extends")),
      extension:               Extension.from_dynamic!(d.fetch("extension")),
      extern:                  Extern.from_dynamic!(d.fetch("extern")),
      fallthrough:             Fallthrough.from_dynamic!(d.fetch("fallthrough")),
      false_1:                 Obj2False.from_dynamic!(d.fetch("false")),
      fileprivate:             Fileprivate.from_dynamic!(d.fetch("fileprivate")),
      final:                   Final.from_dynamic!(d.fetch("final")),
      finally:                 Finally.from_dynamic!(d.fetch("finally")),
      fixed:                   Fixed.from_dynamic!(d.fetch("fixed")),
      float:                   FloatClass.from_dynamic!(d.fetch("float")),
      foreach:                 Foreach.from_dynamic!(d.fetch("foreach")),
      format_exception:        FormatException.from_dynamic!(d.fetch("FormatException")),
      friend:                  Friend.from_dynamic!(d.fetch("friend")),
      from:                    From.from_dynamic!(d.fetch("from")),
      from_dict:               FromDict.from_dynamic!(d.fetch("from_dict")),
      from_json:               FromJSON.from_dynamic!(d.fetch("from_json")),
      func:                    Func.from_dynamic!(d.fetch("func")),
      obj2_def:                Def.from_dynamic!(d.fetch("def")),
      obj2_default:            Default.from_dynamic!(d.fetch("default")),
      obj2_do:                 Do.from_dynamic!(d.fetch("do")),
      obj2_else:               Else.from_dynamic!(d.fetch("else")),
      obj2_enum:               Enum.from_dynamic!(d.fetch("enum")),
      obj2_false:              False.from_dynamic!(d.fetch("False")),
      obj2_for:                For.from_dynamic!(d.fetch("for")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "CultureInfo"            => culture_info.to_dynamic,
      "date"                   => date.to_dynamic,
      "DateFormatter"          => date_formatter.to_dynamic,
      "DateOnly"               => date_only.to_dynamic,
      "DateOnlyConverter"      => date_only_converter.to_dynamic,
      "date_parse_handling"    => date_parse_handling.to_dynamic,
      "DateTime"               => date_time.to_dynamic,
      "DateTimeStyles"         => date_time_styles.to_dynamic,
      "debugger"               => debugger.to_dynamic,
      "decimal"                => decimal.to_dynamic,
      "declare"                => declare.to_dynamic,
      "decltype"               => decltype.to_dynamic,
      "decode_string"          => decode_string.to_dynamic,
      "Decoder"                => decoder.to_dynamic,
      "DecodingError"          => decoding_error.to_dynamic,
      "defer"                  => defer.to_dynamic,
      "deinit"                 => deinit.to_dynamic,
      "del"                    => del.to_dynamic,
      "delegate"               => delegate.to_dynamic,
      "delete"                 => delete.to_dynamic,
      "DeserializationFeature" => deserialization_feature.to_dynamic,
      "dict"                   => dict.to_dynamic,
      "dictionary"             => dictionary.to_dynamic,
      "didSet"                 => did_set.to_dynamic,
      "double"                 => double.to_dynamic,
      "DoubleNode"             => double_node.to_dynamic,
      "dummy"                  => dummy,
      "dynamic"                => dynamic.to_dynamic,
      "dynamic_cast"           => dynamic_cast.to_dynamic,
      "elif"                   => elif.to_dynamic,
      "encode_quick_type"      => encode_quick_type.to_dynamic,
      "Encoder"                => encoder.to_dynamic,
      "EnumValues"             => enum_values.to_dynamic,
      "equalityContract"       => equality_contract.to_dynamic,
      "Equatable"              => equatable.to_dynamic,
      "event"                  => event.to_dynamic,
      "except"                 => except.to_dynamic,
      "exception"              => exception.to_dynamic,
      "explicit"               => explicit.to_dynamic,
      "export"                 => export.to_dynamic,
      "exposing"               => exposing.to_dynamic,
      "extends"                => extends.to_dynamic,
      "extension"              => extension.to_dynamic,
      "extern"                 => extern.to_dynamic,
      "fallthrough"            => fallthrough.to_dynamic,
      "false"                  => false_1.to_dynamic,
      "fileprivate"            => fileprivate.to_dynamic,
      "final"                  => final.to_dynamic,
      "finally"                => finally.to_dynamic,
      "fixed"                  => fixed.to_dynamic,
      "float"                  => float.to_dynamic,
      "foreach"                => foreach.to_dynamic,
      "FormatException"        => format_exception.to_dynamic,
      "friend"                 => friend.to_dynamic,
      "from"                   => from.to_dynamic,
      "from_dict"              => from_dict.to_dynamic,
      "from_json"              => from_json.to_dynamic,
      "func"                   => func.to_dynamic,
      "def"                    => obj2_def.to_dynamic,
      "default"                => obj2_default.to_dynamic,
      "do"                     => obj2_do.to_dynamic,
      "else"                   => obj2_else.to_dynamic,
      "enum"                   => obj2_enum.to_dynamic,
      "False"                  => obj2_false.to_dynamic,
      "for"                    => obj2_for.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Function < Dry::Struct
  attribute :function, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      function: d.fetch("function"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "function" => function,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Get < Dry::Struct
  attribute :get, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      get: d.fetch("get"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "get" => get,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Global < Dry::Struct
  attribute :global, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      global: d.fetch("global"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "global" => global,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Go < Dry::Struct
  attribute :go, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      go: d.fetch("go"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "go" => go,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Goto < Dry::Struct
  attribute :goto, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      goto: d.fetch("goto"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "goto" => goto,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Guard < Dry::Struct
  attribute :guard, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      guard: d.fetch("guard"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "guard" => guard,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class HasOwnProperty < Dry::Struct
  attribute :has_own_property, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      has_own_property: d.fetch("hasOwnProperty"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "hasOwnProperty" => has_own_property,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class HashCode < Dry::Struct
  attribute :hash_code, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      hash_code: d.fetch("hashCode"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "hashCode" => hash_code,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Hashable < Dry::Struct
  attribute :hashable, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      hashable: d.fetch("Hashable"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "Hashable" => hashable,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Hasher < Dry::Struct
  attribute :hasher, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      hasher: d.fetch("Hasher"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "Hasher" => hasher,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ID < Dry::Struct
  attribute :id, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      id: d.fetch("id"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "id" => id,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Imp < Dry::Struct
  attribute :imp, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      imp: d.fetch("IMP"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "IMP" => imp,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Implements < Dry::Struct
  attribute :implements, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      implements: d.fetch("implements"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "implements" => implements,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Implicit < Dry::Struct
  attribute :implicit, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      implicit: d.fetch("implicit"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "implicit" => implicit,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Import < Dry::Struct
  attribute :import, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      import: d.fetch("import"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "import" => import,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Indirect < Dry::Struct
  attribute :indirect, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      indirect: d.fetch("indirect"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "indirect" => indirect,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Infix < Dry::Struct
  attribute :infix, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      infix: d.fetch("infix"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "infix" => infix,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Init < Dry::Struct
  attribute :init, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      init: d.fetch("init"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "init" => init,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Inline < Dry::Struct
  attribute :inline, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      inline: d.fetch("inline"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "inline" => inline,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Inout < Dry::Struct
  attribute :inout, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      inout: d.fetch("inout"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "inout" => inout,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Instanceof < Dry::Struct
  attribute :instanceof, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      instanceof: d.fetch("instanceof"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "instanceof" => instanceof,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Int < Dry::Struct
  attribute :int, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      int: d.fetch("int"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "int" => int,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class IntNode < Dry::Struct
  attribute :int_node, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      int_node: d.fetch("IntNode"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "IntNode" => int_node,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Interface < Dry::Struct
  attribute :interface, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      interface: d.fetch("interface"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "interface" => interface,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Internal < Dry::Struct
  attribute :internal, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      internal: d.fetch("internal"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "internal" => internal,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Is < Dry::Struct
  attribute :is, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      is: d.fetch("is"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "is" => is,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ISODateTimeOffsetConverter < Dry::Struct
  attribute :iso_date_time_offset_converter, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      iso_date_time_offset_converter: d.fetch("IsoDateTimeOffsetConverter"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "IsoDateTimeOffsetConverter" => iso_date_time_offset_converter,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Iterable < Dry::Struct
  attribute :iterable, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      iterable: d.fetch("iterable"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "iterable" => iterable,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Jdec < Dry::Struct
  attribute :jdec, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      jdec: d.fetch("jdec"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "jdec" => jdec,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Jenc < Dry::Struct
  attribute :jenc, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      jenc: d.fetch("jenc"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "jenc" => jenc,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Jpipe < Dry::Struct
  attribute :jpipe, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      jpipe: d.fetch("jpipe"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "jpipe" => jpipe,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class JSONClass < Dry::Struct
  attribute :json, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      json: d.fetch("json"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "json" => json,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class JSONAny < Dry::Struct
  attribute :json_any, Types::Nil

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      json_any: d.fetch("JSONAny"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "JSONAny" => json_any,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class JSONCodingKey < Dry::Struct
  attribute :json_coding_key, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      json_coding_key: d.fetch("JSONCodingKey"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "JSONCodingKey" => json_coding_key,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class JSONConverter < Dry::Struct
  attribute :json_converter, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      json_converter: d.fetch("json_converter"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "json_converter" => json_converter,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class JSONDecoder < Dry::Struct
  attribute :json_decoder, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      json_decoder: d.fetch("JSONDecoder"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "JSONDecoder" => json_decoder,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class JSONEncoder < Dry::Struct
  attribute :json_encoder, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      json_encoder: d.fetch("JSONEncoder"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "JSONEncoder" => json_encoder,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class JSONException < Dry::Struct
  attribute :json_exception, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      json_exception: d.fetch("JsonException"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "JsonException" => json_exception,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class JSONGenerator < Dry::Struct
  attribute :json_generator, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      json_generator: d.fetch("JsonGenerator"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "JsonGenerator" => json_generator,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class JSONNode < Dry::Struct
  attribute :json_node, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      json_node: d.fetch("JsonNode"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "JsonNode" => json_node,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class JSONNull < Dry::Struct
  attribute :json_null, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      json_null: d.fetch("JSONNull"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "JSONNull" => json_null,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class JSONParser < Dry::Struct
  attribute :json_parser, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      json_parser: d.fetch("JsonParser"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "JsonParser" => json_parser,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class JSONReader < Dry::Struct
  attribute :json_reader, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      json_reader: d.fetch("JsonReader"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "JsonReader" => json_reader,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class JSONSerializer < Dry::Struct
  attribute :json_serializer, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      json_serializer: d.fetch("json_serializer"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "json_serializer" => json_serializer,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class JSONToken < Dry::Struct
  attribute :json_token, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      json_token: d.fetch("json_token"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "json_token" => json_token,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class JSONTokenType < Dry::Struct
  attribute :json_token_type, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      json_token_type: d.fetch("JsonTokenType"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "JsonTokenType" => json_token_type,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class JSONWriter < Dry::Struct
  attribute :json_writer, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      json_writer: d.fetch("json_writer"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "json_writer" => json_writer,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Lazy < Dry::Struct
  attribute :lazy, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      lazy: d.fetch("lazy"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "lazy" => lazy,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Left < Dry::Struct
  attribute :left, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      left: d.fetch("left"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "left" => left,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Let < Dry::Struct
  attribute :let, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      let: d.fetch("let"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "let" => let,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class List < Dry::Struct
  attribute :list, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      list: d.fetch("list"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "list" => list,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class LocalDate < Dry::Struct
  attribute :local_date, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      local_date: d.fetch("LocalDate"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "LocalDate" => local_date,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Locale < Dry::Struct
  attribute :locale, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      locale: d.fetch("Locale"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "Locale" => locale,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Lock < Dry::Struct
  attribute :lock, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      lock: d.fetch("lock"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "lock" => lock,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Long < Dry::Struct
  attribute :long, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      long: d.fetch("long"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "long" => long,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class LongNode < Dry::Struct
  attribute :long_node, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      long_node: d.fetch("LongNode"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "LongNode" => long_node,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Map < Dry::Struct
  attribute :map, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      map: d.fetch("map"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "map" => map,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class MapEntry < Dry::Struct
  attribute :map_entry, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      map_entry: d.fetch("MapEntry"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "MapEntry" => map_entry,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class MarshalJSON < Dry::Struct
  attribute :marshal_json, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      marshal_json: d.fetch("MarshalJSON"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "MarshalJSON" => marshal_json,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class MetadataPropertyHandling < Dry::Struct
  attribute :metadata_property_handling, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      metadata_property_handling: d.fetch("metadata_property_handling"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "metadata_property_handling" => metadata_property_handling,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class If < Dry::Struct
  attribute :if_if, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      if_if: d.fetch("if"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "if" => if_if,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class In < Dry::Struct
  attribute :in_in, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      in_in: d.fetch("in"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "in" => in_in,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Lambda < Dry::Struct
  attribute :lambda_lambda, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      lambda_lambda: d.fetch("lambda"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "lambda" => lambda_lambda,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ModuleClass < Dry::Struct
  attribute :module_module, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      module_module: d.fetch("module"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "module" => module_module,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Obj3 < Dry::Struct
  attribute :dummy,                          Types::Integer
  attribute :function,                       Function
  attribute :get,                            Get
  attribute :global,                         Global
  attribute :go,                             Go
  attribute :goto,                           Goto
  attribute :guard,                          Guard
  attribute :has_own_property,               HasOwnProperty
  attribute :hash_code,                      HashCode
  attribute :hashable,                       Hashable
  attribute :hasher,                         Hasher
  attribute :id,                             ID
  attribute :imp,                            Imp
  attribute :implements,                     Implements
  attribute :implicit,                       Implicit
  attribute :import,                         Import
  attribute :indirect,                       Indirect
  attribute :infix,                          Infix
  attribute :init,                           Init
  attribute :inline,                         Inline
  attribute :inout,                          Inout
  attribute :instanceof,                     Instanceof
  attribute :int,                            Int
  attribute :int_node,                       IntNode
  attribute :interface,                      Interface
  attribute :internal,                       Internal
  attribute :is,                             Is
  attribute :iso_date_time_offset_converter, ISODateTimeOffsetConverter
  attribute :iterable,                       Iterable
  attribute :jdec,                           Jdec
  attribute :jenc,                           Jenc
  attribute :jpipe,                          Jpipe
  attribute :json,                           JSONClass
  attribute :json_any,                       JSONAny
  attribute :json_coding_key,                JSONCodingKey
  attribute :json_converter,                 JSONConverter
  attribute :json_decoder,                   JSONDecoder
  attribute :json_encoder,                   JSONEncoder
  attribute :json_exception,                 JSONException
  attribute :json_generator,                 JSONGenerator
  attribute :json_node,                      JSONNode
  attribute :json_null,                      JSONNull
  attribute :json_parser,                    JSONParser
  attribute :json_reader,                    JSONReader
  attribute :json_serializer,                JSONSerializer
  attribute :json_token,                     JSONToken
  attribute :json_token_type,                JSONTokenType
  attribute :json_writer,                    JSONWriter
  attribute :lazy,                           Lazy
  attribute :left,                           Left
  attribute :let,                            Let
  attribute :list,                           List
  attribute :local_date,                     LocalDate
  attribute :locale,                         Locale
  attribute :lock,                           Lock
  attribute :long,                           Long
  attribute :long_node,                      LongNode
  attribute :map,                            Map
  attribute :map_entry,                      MapEntry
  attribute :marshal_json,                   MarshalJSON
  attribute :metadata_property_handling,     MetadataPropertyHandling
  attribute :obj3_if,                        If
  attribute :obj3_in,                        In
  attribute :obj3_lambda,                    Lambda
  attribute :obj3_module,                    ModuleClass

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      dummy:                          d.fetch("dummy"),
      function:                       Function.from_dynamic!(d.fetch("function")),
      get:                            Get.from_dynamic!(d.fetch("get")),
      global:                         Global.from_dynamic!(d.fetch("global")),
      go:                             Go.from_dynamic!(d.fetch("go")),
      goto:                           Goto.from_dynamic!(d.fetch("goto")),
      guard:                          Guard.from_dynamic!(d.fetch("guard")),
      has_own_property:               HasOwnProperty.from_dynamic!(d.fetch("hasOwnProperty")),
      hash_code:                      HashCode.from_dynamic!(d.fetch("hashCode")),
      hashable:                       Hashable.from_dynamic!(d.fetch("Hashable")),
      hasher:                         Hasher.from_dynamic!(d.fetch("Hasher")),
      id:                             ID.from_dynamic!(d.fetch("id")),
      imp:                            Imp.from_dynamic!(d.fetch("IMP")),
      implements:                     Implements.from_dynamic!(d.fetch("implements")),
      implicit:                       Implicit.from_dynamic!(d.fetch("implicit")),
      import:                         Import.from_dynamic!(d.fetch("import")),
      indirect:                       Indirect.from_dynamic!(d.fetch("indirect")),
      infix:                          Infix.from_dynamic!(d.fetch("infix")),
      init:                           Init.from_dynamic!(d.fetch("init")),
      inline:                         Inline.from_dynamic!(d.fetch("inline")),
      inout:                          Inout.from_dynamic!(d.fetch("inout")),
      instanceof:                     Instanceof.from_dynamic!(d.fetch("instanceof")),
      int:                            Int.from_dynamic!(d.fetch("int")),
      int_node:                       IntNode.from_dynamic!(d.fetch("IntNode")),
      interface:                      Interface.from_dynamic!(d.fetch("interface")),
      internal:                       Internal.from_dynamic!(d.fetch("internal")),
      is:                             Is.from_dynamic!(d.fetch("is")),
      iso_date_time_offset_converter: ISODateTimeOffsetConverter.from_dynamic!(d.fetch("IsoDateTimeOffsetConverter")),
      iterable:                       Iterable.from_dynamic!(d.fetch("iterable")),
      jdec:                           Jdec.from_dynamic!(d.fetch("jdec")),
      jenc:                           Jenc.from_dynamic!(d.fetch("jenc")),
      jpipe:                          Jpipe.from_dynamic!(d.fetch("jpipe")),
      json:                           JSONClass.from_dynamic!(d.fetch("json")),
      json_any:                       JSONAny.from_dynamic!(d.fetch("JSONAny")),
      json_coding_key:                JSONCodingKey.from_dynamic!(d.fetch("JSONCodingKey")),
      json_converter:                 JSONConverter.from_dynamic!(d.fetch("json_converter")),
      json_decoder:                   JSONDecoder.from_dynamic!(d.fetch("JSONDecoder")),
      json_encoder:                   JSONEncoder.from_dynamic!(d.fetch("JSONEncoder")),
      json_exception:                 JSONException.from_dynamic!(d.fetch("JsonException")),
      json_generator:                 JSONGenerator.from_dynamic!(d.fetch("JsonGenerator")),
      json_node:                      JSONNode.from_dynamic!(d.fetch("JsonNode")),
      json_null:                      JSONNull.from_dynamic!(d.fetch("JSONNull")),
      json_parser:                    JSONParser.from_dynamic!(d.fetch("JsonParser")),
      json_reader:                    JSONReader.from_dynamic!(d.fetch("JsonReader")),
      json_serializer:                JSONSerializer.from_dynamic!(d.fetch("json_serializer")),
      json_token:                     JSONToken.from_dynamic!(d.fetch("json_token")),
      json_token_type:                JSONTokenType.from_dynamic!(d.fetch("JsonTokenType")),
      json_writer:                    JSONWriter.from_dynamic!(d.fetch("json_writer")),
      lazy:                           Lazy.from_dynamic!(d.fetch("lazy")),
      left:                           Left.from_dynamic!(d.fetch("left")),
      let:                            Let.from_dynamic!(d.fetch("let")),
      list:                           List.from_dynamic!(d.fetch("list")),
      local_date:                     LocalDate.from_dynamic!(d.fetch("LocalDate")),
      locale:                         Locale.from_dynamic!(d.fetch("Locale")),
      lock:                           Lock.from_dynamic!(d.fetch("lock")),
      long:                           Long.from_dynamic!(d.fetch("long")),
      long_node:                      LongNode.from_dynamic!(d.fetch("LongNode")),
      map:                            Map.from_dynamic!(d.fetch("map")),
      map_entry:                      MapEntry.from_dynamic!(d.fetch("MapEntry")),
      marshal_json:                   MarshalJSON.from_dynamic!(d.fetch("MarshalJSON")),
      metadata_property_handling:     MetadataPropertyHandling.from_dynamic!(d.fetch("metadata_property_handling")),
      obj3_if:                        If.from_dynamic!(d.fetch("if")),
      obj3_in:                        In.from_dynamic!(d.fetch("in")),
      obj3_lambda:                    Lambda.from_dynamic!(d.fetch("lambda")),
      obj3_module:                    ModuleClass.from_dynamic!(d.fetch("module")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "dummy"                      => dummy,
      "function"                   => function.to_dynamic,
      "get"                        => get.to_dynamic,
      "global"                     => global.to_dynamic,
      "go"                         => go.to_dynamic,
      "goto"                       => goto.to_dynamic,
      "guard"                      => guard.to_dynamic,
      "hasOwnProperty"             => has_own_property.to_dynamic,
      "hashCode"                   => hash_code.to_dynamic,
      "Hashable"                   => hashable.to_dynamic,
      "Hasher"                     => hasher.to_dynamic,
      "id"                         => id.to_dynamic,
      "IMP"                        => imp.to_dynamic,
      "implements"                 => implements.to_dynamic,
      "implicit"                   => implicit.to_dynamic,
      "import"                     => import.to_dynamic,
      "indirect"                   => indirect.to_dynamic,
      "infix"                      => infix.to_dynamic,
      "init"                       => init.to_dynamic,
      "inline"                     => inline.to_dynamic,
      "inout"                      => inout.to_dynamic,
      "instanceof"                 => instanceof.to_dynamic,
      "int"                        => int.to_dynamic,
      "IntNode"                    => int_node.to_dynamic,
      "interface"                  => interface.to_dynamic,
      "internal"                   => internal.to_dynamic,
      "is"                         => is.to_dynamic,
      "IsoDateTimeOffsetConverter" => iso_date_time_offset_converter.to_dynamic,
      "iterable"                   => iterable.to_dynamic,
      "jdec"                       => jdec.to_dynamic,
      "jenc"                       => jenc.to_dynamic,
      "jpipe"                      => jpipe.to_dynamic,
      "json"                       => json.to_dynamic,
      "JSONAny"                    => json_any.to_dynamic,
      "JSONCodingKey"              => json_coding_key.to_dynamic,
      "json_converter"             => json_converter.to_dynamic,
      "JSONDecoder"                => json_decoder.to_dynamic,
      "JSONEncoder"                => json_encoder.to_dynamic,
      "JsonException"              => json_exception.to_dynamic,
      "JsonGenerator"              => json_generator.to_dynamic,
      "JsonNode"                   => json_node.to_dynamic,
      "JSONNull"                   => json_null.to_dynamic,
      "JsonParser"                 => json_parser.to_dynamic,
      "JsonReader"                 => json_reader.to_dynamic,
      "json_serializer"            => json_serializer.to_dynamic,
      "json_token"                 => json_token.to_dynamic,
      "JsonTokenType"              => json_token_type.to_dynamic,
      "json_writer"                => json_writer.to_dynamic,
      "lazy"                       => lazy.to_dynamic,
      "left"                       => left.to_dynamic,
      "let"                        => let.to_dynamic,
      "list"                       => list.to_dynamic,
      "LocalDate"                  => local_date.to_dynamic,
      "Locale"                     => locale.to_dynamic,
      "lock"                       => lock.to_dynamic,
      "long"                       => long.to_dynamic,
      "LongNode"                   => long_node.to_dynamic,
      "map"                        => map.to_dynamic,
      "MapEntry"                   => map_entry.to_dynamic,
      "MarshalJSON"                => marshal_json.to_dynamic,
      "metadata_property_handling" => metadata_property_handling.to_dynamic,
      "if"                         => obj3_if.to_dynamic,
      "in"                         => obj3_in.to_dynamic,
      "lambda"                     => obj3_lambda.to_dynamic,
      "module"                     => obj3_module.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Mutable < Dry::Struct
  attribute :mutable, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      mutable: d.fetch("mutable"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "mutable" => mutable,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Mutating < Dry::Struct
  attribute :mutating, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      mutating: d.fetch("mutating"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "mutating" => mutating,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Namespace < Dry::Struct
  attribute :namespace, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      namespace: d.fetch("namespace"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "namespace" => namespace,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Native < Dry::Struct
  attribute :native, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      native: d.fetch("native"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "native" => native,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Newtonsoft < Dry::Struct
  attribute :newtonsoft, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      newtonsoft: d.fetch("newtonsoft"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "newtonsoft" => newtonsoft,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class No < Dry::Struct
  attribute :no, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      no: d.fetch("NO"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "NO" => no,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class NoSuchMethod < Dry::Struct
  attribute :no_such_method, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      no_such_method: d.fetch("noSuchMethod"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "noSuchMethod" => no_such_method,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Noexcept < Dry::Struct
  attribute :noexcept, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      noexcept: d.fetch("noexcept"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "noexcept" => noexcept,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Nonatomic < Dry::Struct
  attribute :nonatomic, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      nonatomic: d.fetch("nonatomic"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "nonatomic" => nonatomic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class None < Dry::Struct
  attribute :none, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      none: d.fetch("None"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "None" => none,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Nonlocal < Dry::Struct
  attribute :nonlocal, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      nonlocal: d.fetch("nonlocal"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "nonlocal" => nonlocal,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Nonmutating < Dry::Struct
  attribute :nonmutating, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      nonmutating: d.fetch("nonmutating"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "nonmutating" => nonmutating,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class NotEq < Dry::Struct
  attribute :not_eq, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      not_eq: d.fetch("not_eq"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "not_eq" => not_eq,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class NSError < Dry::Struct
  attribute :ns_error, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      ns_error: d.fetch("NSError"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "NSError" => ns_error,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class NSObject < Dry::Struct
  attribute :ns_object, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      ns_object: d.fetch("NSObject"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "NSObject" => ns_object,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class NSString < Dry::Struct
  attribute :ns_string, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      ns_string: d.fetch("NSString"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "NSString" => ns_string,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Null < Dry::Struct
  attribute :null, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      null: d.fetch("NULL"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "NULL" => null,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class NullNode < Dry::Struct
  attribute :null_node, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      null_node: d.fetch("NullNode"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "NullNode" => null_node,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Nullptr < Dry::Struct
  attribute :nullptr, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      nullptr: d.fetch("nullptr"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "nullptr" => nullptr,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Number < Dry::Struct
  attribute :number, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      number: d.fetch("number"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "number" => number,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class New < Dry::Struct
  attribute :new_new, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      new_new: d.fetch("new"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "new" => new_new,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Nil < Dry::Struct
  attribute :nil_nil, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      nil_nil: d.fetch("nil"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "nil" => nil_nil,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class NoneClass < Dry::Struct
  attribute :none, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      none: d.fetch("none"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "none" => none,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Not < Dry::Struct
  attribute :not_not, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      not_not: d.fetch("not"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "not" => not_not,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class NullClass < Dry::Struct
  attribute :null, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      null: d.fetch("null"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "null" => null,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Open < Dry::Struct
  attribute :open_open, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      open_open: d.fetch("open"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "open" => open_open,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Optional < Dry::Struct
  attribute :optional_optional, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      optional_optional: d.fetch("optional"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "optional" => optional_optional,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Or < Dry::Struct
  attribute :or_or, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      or_or: d.fetch("or"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "or" => or_or,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Print < Dry::Struct
  attribute :print_print, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      print_print: d.fetch("print"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "print" => print_print,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Printf < Dry::Struct
  attribute :printf_printf, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      printf_printf: d.fetch("printf"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "printf" => printf_printf,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ProtocolClass < Dry::Struct
  attribute :protocol, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      protocol: d.fetch("protocol"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "protocol" => protocol,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Raise < Dry::Struct
  attribute :raise_raise, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      raise_raise: d.fetch("raise"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "raise" => raise_raise,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ObjectClass < Dry::Struct
  attribute :object, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      object: d.fetch("object"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "object" => object,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ObjectMapper < Dry::Struct
  attribute :object_mapper, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      object_mapper: d.fetch("ObjectMapper"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "ObjectMapper" => object_mapper,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ObjectNode < Dry::Struct
  attribute :object_node, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      object_node: d.fetch("ObjectNode"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "ObjectNode" => object_node,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ObjectReader < Dry::Struct
  attribute :object_reader, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      object_reader: d.fetch("ObjectReader"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "ObjectReader" => object_reader,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ObjectWriter < Dry::Struct
  attribute :object_writer, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      object_writer: d.fetch("ObjectWriter"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "ObjectWriter" => object_writer,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Of < Dry::Struct
  attribute :of, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      of: d.fetch("of"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "of" => of,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class OffsetDateTime < Dry::Struct
  attribute :offset_date_time, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      offset_date_time: d.fetch("OffsetDateTime"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "OffsetDateTime" => offset_date_time,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class OffsetTime < Dry::Struct
  attribute :offset_time, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      offset_time: d.fetch("OffsetTime"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "OffsetTime" => offset_time,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Oneway < Dry::Struct
  attribute :oneway, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      oneway: d.fetch("oneway"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "oneway" => oneway,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Operator < Dry::Struct
  attribute :operator, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      operator: d.fetch("operator"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "operator" => operator,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class OrEq < Dry::Struct
  attribute :or_eq, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      or_eq: d.fetch("or_eq"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "or_eq" => or_eq,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Out < Dry::Struct
  attribute :out, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      out: d.fetch("out"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "out" => out,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Override < Dry::Struct
  attribute :override, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      override: d.fetch("override"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "override" => override,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Package < Dry::Struct
  attribute :package, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      package: d.fetch("package"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "package" => package,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Params < Dry::Struct
  attribute :params, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      params: d.fetch("params"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "params" => params,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Pass < Dry::Struct
  attribute :pass, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      pass: d.fetch("pass"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "pass" => pass,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Port < Dry::Struct
  attribute :port, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      port: d.fetch("port"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "port" => port,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Postfix < Dry::Struct
  attribute :postfix, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      postfix: d.fetch("postfix"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "postfix" => postfix,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Precedence < Dry::Struct
  attribute :precedence, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      precedence: d.fetch("precedence"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "precedence" => precedence,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Prefix < Dry::Struct
  attribute :prefix, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      prefix: d.fetch("prefix"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "prefix" => prefix,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class PrintMembers < Dry::Struct
  attribute :print_members, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      print_members: d.fetch("printMembers"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "printMembers" => print_members,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Private < Dry::Struct
  attribute :private, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      private: d.fetch("private"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "private" => private,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Protected < Dry::Struct
  attribute :protected, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      protected: d.fetch("protected"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "protected" => protected,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Protocol < Dry::Struct
  attribute :protocol, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      protocol: d.fetch("Protocol"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "Protocol" => protocol,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Public < Dry::Struct
  attribute :public, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      public: d.fetch("public"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "public" => public,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Quicktype < Dry::Struct
  attribute :quicktype, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      quicktype: d.fetch("quicktype"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "quicktype" => quicktype,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class RangeClass < Dry::Struct
  attribute :range, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      range: d.fetch("range"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "range" => range,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Readonly < Dry::Struct
  attribute :readonly, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      readonly: d.fetch("readonly"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "readonly" => readonly,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Ref < Dry::Struct
  attribute :ref, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      ref: d.fetch("ref"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "ref" => ref,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class RegExp < Dry::Struct
  attribute :reg_exp, Types::String.constrained(format: /\A[0-9a-f]{8}-(?:[0-9a-f]{4}-){3}[0-9a-f]{12}\z/i)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      reg_exp: d.fetch("RegExp"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "RegExp" => reg_exp,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Register < Dry::Struct
  attribute :register, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      register: d.fetch("register"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "register" => register,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ReinterpretCast < Dry::Struct
  attribute :reinterpret_cast, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      reinterpret_cast: d.fetch("reinterpret_cast"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "reinterpret_cast" => reinterpret_cast,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Obj4 < Dry::Struct
  attribute :dummy,            Types::Integer
  attribute :mutable,          Mutable
  attribute :mutating,         Mutating
  attribute :namespace,        Namespace
  attribute :native,           Native
  attribute :newtonsoft,       Newtonsoft
  attribute :no,               No
  attribute :no_such_method,   NoSuchMethod
  attribute :noexcept,         Noexcept
  attribute :nonatomic,        Nonatomic
  attribute :none,             None
  attribute :nonlocal,         Nonlocal
  attribute :nonmutating,      Nonmutating
  attribute :not_eq,           NotEq
  attribute :ns_error,         NSError
  attribute :ns_object,        NSObject
  attribute :ns_string,        NSString
  attribute :null,             Null
  attribute :null_node,        NullNode
  attribute :nullptr,          Nullptr
  attribute :number,           Number
  attribute :obj4_new,         New
  attribute :obj4_nil,         Nil
  attribute :obj4_none,        NoneClass
  attribute :obj4_not,         Not
  attribute :obj4_null,        NullClass
  attribute :obj4_open,        Open
  attribute :obj4_optional,    Optional
  attribute :obj4_or,          Or
  attribute :obj4_print,       Print
  attribute :obj4_printf,      Printf
  attribute :obj4_protocol,    ProtocolClass
  attribute :obj4_raise,       Raise
  attribute :object,           ObjectClass
  attribute :object_mapper,    ObjectMapper
  attribute :object_node,      ObjectNode
  attribute :object_reader,    ObjectReader
  attribute :object_writer,    ObjectWriter
  attribute :of,               Of
  attribute :offset_date_time, OffsetDateTime
  attribute :offset_time,      OffsetTime
  attribute :oneway,           Oneway
  attribute :operator,         Operator
  attribute :or_eq,            OrEq
  attribute :out,              Out
  attribute :override,         Override
  attribute :package,          Package
  attribute :params,           Params
  attribute :pass,             Pass
  attribute :port,             Port
  attribute :postfix,          Postfix
  attribute :precedence,       Precedence
  attribute :prefix,           Prefix
  attribute :print_members,    PrintMembers
  attribute :private,          Private
  attribute :protected,        Protected
  attribute :protocol,         Protocol
  attribute :public,           Public
  attribute :quicktype,        Quicktype
  attribute :range,            RangeClass
  attribute :readonly,         Readonly
  attribute :ref,              Ref
  attribute :reg_exp,          RegExp
  attribute :register,         Register
  attribute :reinterpret_cast, ReinterpretCast

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      dummy:            d.fetch("dummy"),
      mutable:          Mutable.from_dynamic!(d.fetch("mutable")),
      mutating:         Mutating.from_dynamic!(d.fetch("mutating")),
      namespace:        Namespace.from_dynamic!(d.fetch("namespace")),
      native:           Native.from_dynamic!(d.fetch("native")),
      newtonsoft:       Newtonsoft.from_dynamic!(d.fetch("newtonsoft")),
      no:               No.from_dynamic!(d.fetch("NO")),
      no_such_method:   NoSuchMethod.from_dynamic!(d.fetch("noSuchMethod")),
      noexcept:         Noexcept.from_dynamic!(d.fetch("noexcept")),
      nonatomic:        Nonatomic.from_dynamic!(d.fetch("nonatomic")),
      none:             None.from_dynamic!(d.fetch("None")),
      nonlocal:         Nonlocal.from_dynamic!(d.fetch("nonlocal")),
      nonmutating:      Nonmutating.from_dynamic!(d.fetch("nonmutating")),
      not_eq:           NotEq.from_dynamic!(d.fetch("not_eq")),
      ns_error:         NSError.from_dynamic!(d.fetch("NSError")),
      ns_object:        NSObject.from_dynamic!(d.fetch("NSObject")),
      ns_string:        NSString.from_dynamic!(d.fetch("NSString")),
      null:             Null.from_dynamic!(d.fetch("NULL")),
      null_node:        NullNode.from_dynamic!(d.fetch("NullNode")),
      nullptr:          Nullptr.from_dynamic!(d.fetch("nullptr")),
      number:           Number.from_dynamic!(d.fetch("number")),
      obj4_new:         New.from_dynamic!(d.fetch("new")),
      obj4_nil:         Nil.from_dynamic!(d.fetch("nil")),
      obj4_none:        NoneClass.from_dynamic!(d.fetch("none")),
      obj4_not:         Not.from_dynamic!(d.fetch("not")),
      obj4_null:        NullClass.from_dynamic!(d.fetch("null")),
      obj4_open:        Open.from_dynamic!(d.fetch("open")),
      obj4_optional:    Optional.from_dynamic!(d.fetch("optional")),
      obj4_or:          Or.from_dynamic!(d.fetch("or")),
      obj4_print:       Print.from_dynamic!(d.fetch("print")),
      obj4_printf:      Printf.from_dynamic!(d.fetch("printf")),
      obj4_protocol:    ProtocolClass.from_dynamic!(d.fetch("protocol")),
      obj4_raise:       Raise.from_dynamic!(d.fetch("raise")),
      object:           ObjectClass.from_dynamic!(d.fetch("object")),
      object_mapper:    ObjectMapper.from_dynamic!(d.fetch("ObjectMapper")),
      object_node:      ObjectNode.from_dynamic!(d.fetch("ObjectNode")),
      object_reader:    ObjectReader.from_dynamic!(d.fetch("ObjectReader")),
      object_writer:    ObjectWriter.from_dynamic!(d.fetch("ObjectWriter")),
      of:               Of.from_dynamic!(d.fetch("of")),
      offset_date_time: OffsetDateTime.from_dynamic!(d.fetch("OffsetDateTime")),
      offset_time:      OffsetTime.from_dynamic!(d.fetch("OffsetTime")),
      oneway:           Oneway.from_dynamic!(d.fetch("oneway")),
      operator:         Operator.from_dynamic!(d.fetch("operator")),
      or_eq:            OrEq.from_dynamic!(d.fetch("or_eq")),
      out:              Out.from_dynamic!(d.fetch("out")),
      override:         Override.from_dynamic!(d.fetch("override")),
      package:          Package.from_dynamic!(d.fetch("package")),
      params:           Params.from_dynamic!(d.fetch("params")),
      pass:             Pass.from_dynamic!(d.fetch("pass")),
      port:             Port.from_dynamic!(d.fetch("port")),
      postfix:          Postfix.from_dynamic!(d.fetch("postfix")),
      precedence:       Precedence.from_dynamic!(d.fetch("precedence")),
      prefix:           Prefix.from_dynamic!(d.fetch("prefix")),
      print_members:    PrintMembers.from_dynamic!(d.fetch("printMembers")),
      private:          Private.from_dynamic!(d.fetch("private")),
      protected:        Protected.from_dynamic!(d.fetch("protected")),
      protocol:         Protocol.from_dynamic!(d.fetch("Protocol")),
      public:           Public.from_dynamic!(d.fetch("public")),
      quicktype:        Quicktype.from_dynamic!(d.fetch("quicktype")),
      range:            RangeClass.from_dynamic!(d.fetch("range")),
      readonly:         Readonly.from_dynamic!(d.fetch("readonly")),
      ref:              Ref.from_dynamic!(d.fetch("ref")),
      reg_exp:          RegExp.from_dynamic!(d.fetch("RegExp")),
      register:         Register.from_dynamic!(d.fetch("register")),
      reinterpret_cast: ReinterpretCast.from_dynamic!(d.fetch("reinterpret_cast")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "dummy"            => dummy,
      "mutable"          => mutable.to_dynamic,
      "mutating"         => mutating.to_dynamic,
      "namespace"        => namespace.to_dynamic,
      "native"           => native.to_dynamic,
      "newtonsoft"       => newtonsoft.to_dynamic,
      "NO"               => no.to_dynamic,
      "noSuchMethod"     => no_such_method.to_dynamic,
      "noexcept"         => noexcept.to_dynamic,
      "nonatomic"        => nonatomic.to_dynamic,
      "None"             => none.to_dynamic,
      "nonlocal"         => nonlocal.to_dynamic,
      "nonmutating"      => nonmutating.to_dynamic,
      "not_eq"           => not_eq.to_dynamic,
      "NSError"          => ns_error.to_dynamic,
      "NSObject"         => ns_object.to_dynamic,
      "NSString"         => ns_string.to_dynamic,
      "NULL"             => null.to_dynamic,
      "NullNode"         => null_node.to_dynamic,
      "nullptr"          => nullptr.to_dynamic,
      "number"           => number.to_dynamic,
      "new"              => obj4_new.to_dynamic,
      "nil"              => obj4_nil.to_dynamic,
      "none"             => obj4_none.to_dynamic,
      "not"              => obj4_not.to_dynamic,
      "null"             => obj4_null.to_dynamic,
      "open"             => obj4_open.to_dynamic,
      "optional"         => obj4_optional.to_dynamic,
      "or"               => obj4_or.to_dynamic,
      "print"            => obj4_print.to_dynamic,
      "printf"           => obj4_printf.to_dynamic,
      "protocol"         => obj4_protocol.to_dynamic,
      "raise"            => obj4_raise.to_dynamic,
      "object"           => object.to_dynamic,
      "ObjectMapper"     => object_mapper.to_dynamic,
      "ObjectNode"       => object_node.to_dynamic,
      "ObjectReader"     => object_reader.to_dynamic,
      "ObjectWriter"     => object_writer.to_dynamic,
      "of"               => of.to_dynamic,
      "OffsetDateTime"   => offset_date_time.to_dynamic,
      "OffsetTime"       => offset_time.to_dynamic,
      "oneway"           => oneway.to_dynamic,
      "operator"         => operator.to_dynamic,
      "or_eq"            => or_eq.to_dynamic,
      "out"              => out.to_dynamic,
      "override"         => override.to_dynamic,
      "package"          => package.to_dynamic,
      "params"           => params.to_dynamic,
      "pass"             => pass.to_dynamic,
      "port"             => port.to_dynamic,
      "postfix"          => postfix.to_dynamic,
      "precedence"       => precedence.to_dynamic,
      "prefix"           => prefix.to_dynamic,
      "printMembers"     => print_members.to_dynamic,
      "private"          => private.to_dynamic,
      "protected"        => protected.to_dynamic,
      "Protocol"         => protocol.to_dynamic,
      "public"           => public.to_dynamic,
      "quicktype"        => quicktype.to_dynamic,
      "range"            => range.to_dynamic,
      "readonly"         => readonly.to_dynamic,
      "ref"              => ref.to_dynamic,
      "RegExp"           => reg_exp.to_dynamic,
      "register"         => register.to_dynamic,
      "reinterpret_cast" => reinterpret_cast.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class KSerializer < Dry::Struct
  attribute :k_serializer, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      k_serializer: d.fetch("KSerializer"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "KSerializer" => k_serializer,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Require < Dry::Struct
  attribute :require_require, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      require_require: d.fetch("require"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "require" => require_require,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Return < Dry::Struct
  attribute :return_return, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      return_return: d.fetch("return"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "return" => return_return,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Select < Dry::Struct
  attribute :select_select, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      select_select: d.fetch("select"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "select" => select_select,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class SelfClass < Dry::Struct
  attribute :self_self, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      self_self: d.fetch("Self"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "Self" => self_self,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Super < Dry::Struct
  attribute :super_super, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      super_super: d.fetch("super"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "super" => super_super,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class System < Dry::Struct
  attribute :system_system, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      system_system: d.fetch("system"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "system" => system_system,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Then < Dry::Struct
  attribute :then_then, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      then_then: d.fetch("then"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "then" => then_then,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Throw < Dry::Struct
  attribute :throw_throw, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      throw_throw: d.fetch("throw"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "throw" => throw_throw,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ToJSON < Dry::Struct
  attribute :to_json_to_json, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      to_json_to_json: d.fetch("to_json"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "to_json" => to_json_to_json,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class True < Dry::Struct
  attribute :true_true, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      true_true: d.fetch("True"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "True" => true_true,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class PrimitiveKind < Dry::Struct
  attribute :primitive_kind, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      primitive_kind: d.fetch("PrimitiveKind"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "PrimitiveKind" => primitive_kind,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Repeat < Dry::Struct
  attribute :repeat, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      repeat: d.fetch("repeat"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "repeat" => repeat,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Required < Dry::Struct
  attribute :required, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      required: d.fetch("required"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "required" => required,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Requires < Dry::Struct
  attribute :requires, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      requires: d.fetch("requires"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "requires" => requires,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Restrict < Dry::Struct
  attribute :restrict, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      restrict: d.fetch("restrict"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "restrict" => restrict,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Retain < Dry::Struct
  attribute :retain, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      retain: d.fetch("retain"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "retain" => retain,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Rethrows < Dry::Struct
  attribute :rethrows, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      rethrows: d.fetch("rethrows"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "rethrows" => rethrows,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Right < Dry::Struct
  attribute :right, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      right: d.fetch("right"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "right" => right,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class RuntimeType < Dry::Struct
  attribute :runtime_type, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      runtime_type: d.fetch("runtimeType"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "runtimeType" => runtime_type,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class S < Dry::Struct
  attribute :s, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      s: d.fetch("s"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "s" => s,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Sbyte < Dry::Struct
  attribute :sbyte, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      sbyte: d.fetch("sbyte"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "sbyte" => sbyte,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Sealed < Dry::Struct
  attribute :sealed, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      sealed: d.fetch("sealed"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "sealed" => sealed,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Sel < Dry::Struct
  attribute :sel, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      sel: d.fetch("SEL"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "SEL" => sel,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Obj5Self < Dry::Struct
  attribute :self_self, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      self_self: d.fetch("self"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "self" => self_self,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Sendable < Dry::Struct
  attribute :sendable, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      sendable: d.fetch("Sendable"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "Sendable" => sendable,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class SerialDescriptor < Dry::Struct
  attribute :serial_descriptor, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      serial_descriptor: d.fetch("SerialDescriptor"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "SerialDescriptor" => serial_descriptor,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class SerialName < Dry::Struct
  attribute :serial_name, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      serial_name: d.fetch("SerialName"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "SerialName" => serial_name,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Serializable < Dry::Struct
  attribute :serializable, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      serializable: d.fetch("Serializable"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "Serializable" => serializable,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class SerializationFeature < Dry::Struct
  attribute :serialization_feature, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      serialization_feature: d.fetch("SerializationFeature"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "SerializationFeature" => serialization_feature,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Serialize < Dry::Struct
  attribute :serialize, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      serialize: d.fetch("serialize"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "serialize" => serialize,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class SerializerProvider < Dry::Struct
  attribute :serializer_provider, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      serializer_provider: d.fetch("SerializerProvider"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "SerializerProvider" => serializer_provider,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class SetClass < Dry::Struct
  attribute :set, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      set: d.fetch("set"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "set" => set,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Short < Dry::Struct
  attribute :short, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      short: d.fetch("short"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "short" => short,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Signed < Dry::Struct
  attribute :signed, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      signed: d.fetch("signed"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "signed" => signed,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class SimpleModule < Dry::Struct
  attribute :simple_module, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      simple_module: d.fetch("SimpleModule"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "SimpleModule" => simple_module,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Sizeof < Dry::Struct
  attribute :sizeof, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      sizeof: d.fetch("sizeof"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "sizeof" => sizeof,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Stackalloc < Dry::Struct
  attribute :stackalloc, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      stackalloc: d.fetch("stackalloc"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "stackalloc" => stackalloc,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Standards < Dry::Struct
  attribute :standards, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      standards: d.fetch("Standards"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "Standards" => standards,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Static < Dry::Struct
  attribute :static, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      static: d.fetch("static"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "static" => static,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class StaticAssert < Dry::Struct
  attribute :static_assert, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      static_assert: d.fetch("static_assert"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "static_assert" => static_assert,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class StaticCast < Dry::Struct
  attribute :static_cast, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      static_cast: d.fetch("static_cast"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "static_cast" => static_cast,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class StdDeserializer < Dry::Struct
  attribute :std_deserializer, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      std_deserializer: d.fetch("StdDeserializer"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "StdDeserializer" => std_deserializer,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class StdSerializer < Dry::Struct
  attribute :std_serializer, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      std_serializer: d.fetch("StdSerializer"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "StdSerializer" => std_serializer,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Strictfp < Dry::Struct
  attribute :strictfp, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      strictfp: d.fetch("strictfp"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "strictfp" => strictfp,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class StringClass < Dry::Struct
  attribute :string, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      string: d.fetch("string"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "string" => string,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class StructClass < Dry::Struct
  attribute :struct, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      struct: d.fetch("struct"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "struct" => struct,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Subscript < Dry::Struct
  attribute :subscript, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      subscript: d.fetch("subscript"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "subscript" => subscript,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Switch < Dry::Struct
  attribute :switch, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      switch: d.fetch("switch"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "switch" => switch,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class SymbolClass < Dry::Struct
  attribute :symbol, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      symbol: d.fetch("symbol"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "symbol" => symbol,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Synchronized < Dry::Struct
  attribute :synchronized, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      synchronized: d.fetch("synchronized"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "synchronized" => synchronized,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Template < Dry::Struct
  attribute :template, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      template: d.fetch("template"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "template" => template,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TextNode < Dry::Struct
  attribute :text_node, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      text_node: d.fetch("TextNode"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "TextNode" => text_node,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class This < Dry::Struct
  attribute :this, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      this: d.fetch("this"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "this" => this,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ThreadLocal < Dry::Struct
  attribute :thread_local, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      thread_local: d.fetch("thread_local"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "thread_local" => thread_local,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Throws < Dry::Struct
  attribute :throws, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      throws: d.fetch("throws"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "throws" => throws,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TimeOnly < Dry::Struct
  attribute :time_only, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      time_only: d.fetch("TimeOnly"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "TimeOnly" => time_only,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TimeOnlyConverter < Dry::Struct
  attribute :time_only_converter, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      time_only_converter: d.fetch("TimeOnlyConverter"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "TimeOnlyConverter" => time_only_converter,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TimeZone < Dry::Struct
  attribute :time_zone, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      time_zone: d.fetch("TimeZone"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "TimeZone" => time_zone,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ToDict < Dry::Struct
  attribute :to_dict, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      to_dict: d.fetch("to_dict"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "to_dict" => to_dict,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ToString < Dry::Struct
  attribute :to_string, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      to_string: d.fetch("toString"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "toString" => to_string,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevelClass < Dry::Struct
  attribute :top_level, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      top_level: d.fetch("top_level"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "top_level" => top_level,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Transient < Dry::Struct
  attribute :transient, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      transient: d.fetch("transient"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "transient" => transient,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Obj5True < Dry::Struct
  attribute :true_true, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      true_true: d.fetch("true"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "true" => true_true,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Obj5 < Dry::Struct
  attribute :dummy,                 Types::Integer
  attribute :k_serializer,          KSerializer
  attribute :obj5_require,          Require
  attribute :obj5_return,           Return
  attribute :obj5_select,           Select
  attribute :obj5_self,             SelfClass
  attribute :obj5_super,            Super
  attribute :obj5_system,           System
  attribute :obj5_then,             Then
  attribute :obj5_throw,            Throw
  attribute :obj5_to_json,          ToJSON
  attribute :obj5_true,             True
  attribute :primitive_kind,        PrimitiveKind
  attribute :repeat,                Repeat
  attribute :required,              Required
  attribute :requires,              Requires
  attribute :restrict,              Restrict
  attribute :retain,                Retain
  attribute :rethrows,              Rethrows
  attribute :right,                 Right
  attribute :runtime_type,          RuntimeType
  attribute :s,                     S
  attribute :sbyte,                 Sbyte
  attribute :sealed,                Sealed
  attribute :sel,                   Sel
  attribute :self_1,                Obj5Self
  attribute :sendable,              Sendable
  attribute :serial_descriptor,     SerialDescriptor
  attribute :serial_name,           SerialName
  attribute :serializable,          Serializable
  attribute :serialization_feature, SerializationFeature
  attribute :serialize,             Serialize
  attribute :serializer_provider,   SerializerProvider
  attribute :set,                   SetClass
  attribute :short,                 Short
  attribute :signed,                Signed
  attribute :simple_module,         SimpleModule
  attribute :sizeof,                Sizeof
  attribute :stackalloc,            Stackalloc
  attribute :standards,             Standards
  attribute :static,                Static
  attribute :static_assert,         StaticAssert
  attribute :static_cast,           StaticCast
  attribute :std_deserializer,      StdDeserializer
  attribute :std_serializer,        StdSerializer
  attribute :strictfp,              Strictfp
  attribute :string,                StringClass
  attribute :struct,                StructClass
  attribute :subscript,             Subscript
  attribute :switch,                Switch
  attribute :symbol,                SymbolClass
  attribute :synchronized,          Synchronized
  attribute :template,              Template
  attribute :text_node,             TextNode
  attribute :this,                  This
  attribute :thread_local,          ThreadLocal
  attribute :throws,                Throws
  attribute :time_only,             TimeOnly
  attribute :time_only_converter,   TimeOnlyConverter
  attribute :time_zone,             TimeZone
  attribute :to_dict,               ToDict
  attribute :to_string,             ToString
  attribute :top_level,             TopLevelClass
  attribute :transient,             Transient
  attribute :true_1,                Obj5True

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      dummy:                 d.fetch("dummy"),
      k_serializer:          KSerializer.from_dynamic!(d.fetch("KSerializer")),
      obj5_require:          Require.from_dynamic!(d.fetch("require")),
      obj5_return:           Return.from_dynamic!(d.fetch("return")),
      obj5_select:           Select.from_dynamic!(d.fetch("select")),
      obj5_self:             SelfClass.from_dynamic!(d.fetch("Self")),
      obj5_super:            Super.from_dynamic!(d.fetch("super")),
      obj5_system:           System.from_dynamic!(d.fetch("system")),
      obj5_then:             Then.from_dynamic!(d.fetch("then")),
      obj5_throw:            Throw.from_dynamic!(d.fetch("throw")),
      obj5_to_json:          ToJSON.from_dynamic!(d.fetch("to_json")),
      obj5_true:             True.from_dynamic!(d.fetch("True")),
      primitive_kind:        PrimitiveKind.from_dynamic!(d.fetch("PrimitiveKind")),
      repeat:                Repeat.from_dynamic!(d.fetch("repeat")),
      required:              Required.from_dynamic!(d.fetch("required")),
      requires:              Requires.from_dynamic!(d.fetch("requires")),
      restrict:              Restrict.from_dynamic!(d.fetch("restrict")),
      retain:                Retain.from_dynamic!(d.fetch("retain")),
      rethrows:              Rethrows.from_dynamic!(d.fetch("rethrows")),
      right:                 Right.from_dynamic!(d.fetch("right")),
      runtime_type:          RuntimeType.from_dynamic!(d.fetch("runtimeType")),
      s:                     S.from_dynamic!(d.fetch("s")),
      sbyte:                 Sbyte.from_dynamic!(d.fetch("sbyte")),
      sealed:                Sealed.from_dynamic!(d.fetch("sealed")),
      sel:                   Sel.from_dynamic!(d.fetch("SEL")),
      self_1:                Obj5Self.from_dynamic!(d.fetch("self")),
      sendable:              Sendable.from_dynamic!(d.fetch("Sendable")),
      serial_descriptor:     SerialDescriptor.from_dynamic!(d.fetch("SerialDescriptor")),
      serial_name:           SerialName.from_dynamic!(d.fetch("SerialName")),
      serializable:          Serializable.from_dynamic!(d.fetch("Serializable")),
      serialization_feature: SerializationFeature.from_dynamic!(d.fetch("SerializationFeature")),
      serialize:             Serialize.from_dynamic!(d.fetch("serialize")),
      serializer_provider:   SerializerProvider.from_dynamic!(d.fetch("SerializerProvider")),
      set:                   SetClass.from_dynamic!(d.fetch("set")),
      short:                 Short.from_dynamic!(d.fetch("short")),
      signed:                Signed.from_dynamic!(d.fetch("signed")),
      simple_module:         SimpleModule.from_dynamic!(d.fetch("SimpleModule")),
      sizeof:                Sizeof.from_dynamic!(d.fetch("sizeof")),
      stackalloc:            Stackalloc.from_dynamic!(d.fetch("stackalloc")),
      standards:             Standards.from_dynamic!(d.fetch("Standards")),
      static:                Static.from_dynamic!(d.fetch("static")),
      static_assert:         StaticAssert.from_dynamic!(d.fetch("static_assert")),
      static_cast:           StaticCast.from_dynamic!(d.fetch("static_cast")),
      std_deserializer:      StdDeserializer.from_dynamic!(d.fetch("StdDeserializer")),
      std_serializer:        StdSerializer.from_dynamic!(d.fetch("StdSerializer")),
      strictfp:              Strictfp.from_dynamic!(d.fetch("strictfp")),
      string:                StringClass.from_dynamic!(d.fetch("string")),
      struct:                StructClass.from_dynamic!(d.fetch("struct")),
      subscript:             Subscript.from_dynamic!(d.fetch("subscript")),
      switch:                Switch.from_dynamic!(d.fetch("switch")),
      symbol:                SymbolClass.from_dynamic!(d.fetch("symbol")),
      synchronized:          Synchronized.from_dynamic!(d.fetch("synchronized")),
      template:              Template.from_dynamic!(d.fetch("template")),
      text_node:             TextNode.from_dynamic!(d.fetch("TextNode")),
      this:                  This.from_dynamic!(d.fetch("this")),
      thread_local:          ThreadLocal.from_dynamic!(d.fetch("thread_local")),
      throws:                Throws.from_dynamic!(d.fetch("throws")),
      time_only:             TimeOnly.from_dynamic!(d.fetch("TimeOnly")),
      time_only_converter:   TimeOnlyConverter.from_dynamic!(d.fetch("TimeOnlyConverter")),
      time_zone:             TimeZone.from_dynamic!(d.fetch("TimeZone")),
      to_dict:               ToDict.from_dynamic!(d.fetch("to_dict")),
      to_string:             ToString.from_dynamic!(d.fetch("toString")),
      top_level:             TopLevelClass.from_dynamic!(d.fetch("top_level")),
      transient:             Transient.from_dynamic!(d.fetch("transient")),
      true_1:                Obj5True.from_dynamic!(d.fetch("true")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "dummy"                => dummy,
      "KSerializer"          => k_serializer.to_dynamic,
      "require"              => obj5_require.to_dynamic,
      "return"               => obj5_return.to_dynamic,
      "select"               => obj5_select.to_dynamic,
      "Self"                 => obj5_self.to_dynamic,
      "super"                => obj5_super.to_dynamic,
      "system"               => obj5_system.to_dynamic,
      "then"                 => obj5_then.to_dynamic,
      "throw"                => obj5_throw.to_dynamic,
      "to_json"              => obj5_to_json.to_dynamic,
      "True"                 => obj5_true.to_dynamic,
      "PrimitiveKind"        => primitive_kind.to_dynamic,
      "repeat"               => repeat.to_dynamic,
      "required"             => required.to_dynamic,
      "requires"             => requires.to_dynamic,
      "restrict"             => restrict.to_dynamic,
      "retain"               => retain.to_dynamic,
      "rethrows"             => rethrows.to_dynamic,
      "right"                => right.to_dynamic,
      "runtimeType"          => runtime_type.to_dynamic,
      "s"                    => s.to_dynamic,
      "sbyte"                => sbyte.to_dynamic,
      "sealed"               => sealed.to_dynamic,
      "SEL"                  => sel.to_dynamic,
      "self"                 => self_1.to_dynamic,
      "Sendable"             => sendable.to_dynamic,
      "SerialDescriptor"     => serial_descriptor.to_dynamic,
      "SerialName"           => serial_name.to_dynamic,
      "Serializable"         => serializable.to_dynamic,
      "SerializationFeature" => serialization_feature.to_dynamic,
      "serialize"            => serialize.to_dynamic,
      "SerializerProvider"   => serializer_provider.to_dynamic,
      "set"                  => set.to_dynamic,
      "short"                => short.to_dynamic,
      "signed"               => signed.to_dynamic,
      "SimpleModule"         => simple_module.to_dynamic,
      "sizeof"               => sizeof.to_dynamic,
      "stackalloc"           => stackalloc.to_dynamic,
      "Standards"            => standards.to_dynamic,
      "static"               => static.to_dynamic,
      "static_assert"        => static_assert.to_dynamic,
      "static_cast"          => static_cast.to_dynamic,
      "StdDeserializer"      => std_deserializer.to_dynamic,
      "StdSerializer"        => std_serializer.to_dynamic,
      "strictfp"             => strictfp.to_dynamic,
      "string"               => string.to_dynamic,
      "struct"               => struct.to_dynamic,
      "subscript"            => subscript.to_dynamic,
      "switch"               => switch.to_dynamic,
      "symbol"               => symbol.to_dynamic,
      "synchronized"         => synchronized.to_dynamic,
      "template"             => template.to_dynamic,
      "TextNode"             => text_node.to_dynamic,
      "this"                 => this.to_dynamic,
      "thread_local"         => thread_local.to_dynamic,
      "throws"               => throws.to_dynamic,
      "TimeOnly"             => time_only.to_dynamic,
      "TimeOnlyConverter"    => time_only_converter.to_dynamic,
      "TimeZone"             => time_zone.to_dynamic,
      "to_dict"              => to_dict.to_dynamic,
      "toString"             => to_string.to_dynamic,
      "top_level"            => top_level.to_dynamic,
      "transient"            => transient.to_dynamic,
      "true"                 => true_1.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Try < Dry::Struct
  attribute :try_try, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      try_try: d.fetch("try"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "try" => try_try,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Type < Dry::Struct
  attribute :type_type, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      type_type: d.fetch("Type"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "Type" => type_type,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class While < Dry::Struct
  attribute :while_while, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      while_while: d.fetch("while"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "while" => while_while,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class With < Dry::Struct
  attribute :with_with, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      with_with: d.fetch("with"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "with" => with_with,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Yield < Dry::Struct
  attribute :yield_yield, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      yield_yield: d.fetch("yield"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "yield" => yield_yield,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TypeClass < Dry::Struct
  attribute :type_type, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      type_type: d.fetch("type"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "type" => type_type,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Typealias < Dry::Struct
  attribute :typealias, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      typealias: d.fetch("typealias"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "typealias" => typealias,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Typedef < Dry::Struct
  attribute :typedef, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      typedef: d.fetch("typedef"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "typedef" => typedef,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Typeid < Dry::Struct
  attribute :typeid, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      typeid: d.fetch("typeid"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "typeid" => typeid,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Typename < Dry::Struct
  attribute :typename, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      typename: d.fetch("typename"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "typename" => typename,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Typeof < Dry::Struct
  attribute :typeof, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      typeof: d.fetch("typeof"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "typeof" => typeof,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Uint < Dry::Struct
  attribute :uint, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      uint: d.fetch("uint"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "uint" => uint,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Ulong < Dry::Struct
  attribute :ulong, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      ulong: d.fetch("ulong"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "ulong" => ulong,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Unchecked < Dry::Struct
  attribute :unchecked, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      unchecked: d.fetch("unchecked"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "unchecked" => unchecked,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UndefinedClass < Dry::Struct
  attribute :undefined, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      undefined: d.fetch("undefined"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "undefined" => undefined,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Union < Dry::Struct
  attribute :union, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      union: d.fetch("union"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "union" => union,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnmarshalJSON < Dry::Struct
  attribute :unmarshal_json, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      unmarshal_json: d.fetch("UnmarshalJSON"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "UnmarshalJSON" => unmarshal_json,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Unowned < Dry::Struct
  attribute :unowned, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      unowned: d.fetch("unowned"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "unowned" => unowned,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Unsafe < Dry::Struct
  attribute :unsafe, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      unsafe: d.fetch("unsafe"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "unsafe" => unsafe,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Unsigned < Dry::Struct
  attribute :unsigned, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      unsigned: d.fetch("unsigned"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "unsigned" => unsigned,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UseSerializers < Dry::Struct
  attribute :use_serializers, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      use_serializers: d.fetch("UseSerializers"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "UseSerializers" => use_serializers,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Ushort < Dry::Struct
  attribute :ushort, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      ushort: d.fetch("ushort"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "ushort" => ushort,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Using < Dry::Struct
  attribute :using, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      using: d.fetch("using"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "using" => using,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Utf8JSONReader < Dry::Struct
  attribute :utf8_json_reader, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      utf8_json_reader: d.fetch("Utf8JsonReader"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "Utf8JsonReader" => utf8_json_reader,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Utf8JSONWriter < Dry::Struct
  attribute :utf8_json_writer, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      utf8_json_writer: d.fetch("Utf8JsonWriter"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "Utf8JsonWriter" => utf8_json_writer,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UUID < Dry::Struct
  attribute :uuid, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      uuid: d.fetch("UUID"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "UUID" => uuid,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Var < Dry::Struct
  attribute :var, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      var: d.fetch("var"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "var" => var,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Virtual < Dry::Struct
  attribute :virtual, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      virtual: d.fetch("virtual"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "virtual" => virtual,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Void < Dry::Struct
  attribute :void, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      void: d.fetch("void"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "void" => void,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Volatile < Dry::Struct
  attribute :volatile, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      volatile: d.fetch("volatile"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "volatile" => volatile,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class WcharT < Dry::Struct
  attribute :wchar_t, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      wchar_t: d.fetch("wchar_t"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "wchar_t" => wchar_t,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Weak < Dry::Struct
  attribute :weak, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      weak: d.fetch("weak"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "weak" => weak,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Where < Dry::Struct
  attribute :where, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      where: d.fetch("where"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "where" => where,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class WillSet < Dry::Struct
  attribute :will_set, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      will_set: d.fetch("willSet"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "willSet" => will_set,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Xor < Dry::Struct
  attribute :xor, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      xor: d.fetch("xor"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "xor" => xor,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class XorEq < Dry::Struct
  attribute :xor_eq, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      xor_eq: d.fetch("xor_eq"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "xor_eq" => xor_eq,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Yes < Dry::Struct
  attribute :yes, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      yes: d.fetch("YES"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "YES" => yes,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Obj6 < Dry::Struct
  attribute :dummy,            Types::Integer
  attribute :obj6_try,         Try
  attribute :obj6_type,        Type
  attribute :obj6_while,       While
  attribute :obj6_with,        With
  attribute :obj6_yield,       Yield
  attribute :type_1,           TypeClass
  attribute :typealias,        Typealias
  attribute :typedef,          Typedef
  attribute :typeid,           Typeid
  attribute :typename,         Typename
  attribute :typeof,           Typeof
  attribute :uint,             Uint
  attribute :ulong,            Ulong
  attribute :unchecked,        Unchecked
  attribute :undefined,        UndefinedClass
  attribute :union,            Union
  attribute :unmarshal_json,   UnmarshalJSON
  attribute :unowned,          Unowned
  attribute :unsafe,           Unsafe
  attribute :unsigned,         Unsigned
  attribute :use_serializers,  UseSerializers
  attribute :ushort,           Ushort
  attribute :using,            Using
  attribute :utf8_json_reader, Utf8JSONReader
  attribute :utf8_json_writer, Utf8JSONWriter
  attribute :uuid,             UUID
  attribute :var,              Var
  attribute :virtual,          Virtual
  attribute :void,             Void
  attribute :volatile,         Volatile
  attribute :wchar_t,          WcharT
  attribute :weak,             Weak
  attribute :where,            Where
  attribute :will_set,         WillSet
  attribute :xor,              Xor
  attribute :xor_eq,           XorEq
  attribute :yes,              Yes

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      dummy:            d.fetch("dummy"),
      obj6_try:         Try.from_dynamic!(d.fetch("try")),
      obj6_type:        Type.from_dynamic!(d.fetch("Type")),
      obj6_while:       While.from_dynamic!(d.fetch("while")),
      obj6_with:        With.from_dynamic!(d.fetch("with")),
      obj6_yield:       Yield.from_dynamic!(d.fetch("yield")),
      type_1:           TypeClass.from_dynamic!(d.fetch("type")),
      typealias:        Typealias.from_dynamic!(d.fetch("typealias")),
      typedef:          Typedef.from_dynamic!(d.fetch("typedef")),
      typeid:           Typeid.from_dynamic!(d.fetch("typeid")),
      typename:         Typename.from_dynamic!(d.fetch("typename")),
      typeof:           Typeof.from_dynamic!(d.fetch("typeof")),
      uint:             Uint.from_dynamic!(d.fetch("uint")),
      ulong:            Ulong.from_dynamic!(d.fetch("ulong")),
      unchecked:        Unchecked.from_dynamic!(d.fetch("unchecked")),
      undefined:        UndefinedClass.from_dynamic!(d.fetch("undefined")),
      union:            Union.from_dynamic!(d.fetch("union")),
      unmarshal_json:   UnmarshalJSON.from_dynamic!(d.fetch("UnmarshalJSON")),
      unowned:          Unowned.from_dynamic!(d.fetch("unowned")),
      unsafe:           Unsafe.from_dynamic!(d.fetch("unsafe")),
      unsigned:         Unsigned.from_dynamic!(d.fetch("unsigned")),
      use_serializers:  UseSerializers.from_dynamic!(d.fetch("UseSerializers")),
      ushort:           Ushort.from_dynamic!(d.fetch("ushort")),
      using:            Using.from_dynamic!(d.fetch("using")),
      utf8_json_reader: Utf8JSONReader.from_dynamic!(d.fetch("Utf8JsonReader")),
      utf8_json_writer: Utf8JSONWriter.from_dynamic!(d.fetch("Utf8JsonWriter")),
      uuid:             UUID.from_dynamic!(d.fetch("UUID")),
      var:              Var.from_dynamic!(d.fetch("var")),
      virtual:          Virtual.from_dynamic!(d.fetch("virtual")),
      void:             Void.from_dynamic!(d.fetch("void")),
      volatile:         Volatile.from_dynamic!(d.fetch("volatile")),
      wchar_t:          WcharT.from_dynamic!(d.fetch("wchar_t")),
      weak:             Weak.from_dynamic!(d.fetch("weak")),
      where:            Where.from_dynamic!(d.fetch("where")),
      will_set:         WillSet.from_dynamic!(d.fetch("willSet")),
      xor:              Xor.from_dynamic!(d.fetch("xor")),
      xor_eq:           XorEq.from_dynamic!(d.fetch("xor_eq")),
      yes:              Yes.from_dynamic!(d.fetch("YES")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "dummy"          => dummy,
      "try"            => obj6_try.to_dynamic,
      "Type"           => obj6_type.to_dynamic,
      "while"          => obj6_while.to_dynamic,
      "with"           => obj6_with.to_dynamic,
      "yield"          => obj6_yield.to_dynamic,
      "type"           => type_1.to_dynamic,
      "typealias"      => typealias.to_dynamic,
      "typedef"        => typedef.to_dynamic,
      "typeid"         => typeid.to_dynamic,
      "typename"       => typename.to_dynamic,
      "typeof"         => typeof.to_dynamic,
      "uint"           => uint.to_dynamic,
      "ulong"          => ulong.to_dynamic,
      "unchecked"      => unchecked.to_dynamic,
      "undefined"      => undefined.to_dynamic,
      "union"          => union.to_dynamic,
      "UnmarshalJSON"  => unmarshal_json.to_dynamic,
      "unowned"        => unowned.to_dynamic,
      "unsafe"         => unsafe.to_dynamic,
      "unsigned"       => unsigned.to_dynamic,
      "UseSerializers" => use_serializers.to_dynamic,
      "ushort"         => ushort.to_dynamic,
      "using"          => using.to_dynamic,
      "Utf8JsonReader" => utf8_json_reader.to_dynamic,
      "Utf8JsonWriter" => utf8_json_writer.to_dynamic,
      "UUID"           => uuid.to_dynamic,
      "var"            => var.to_dynamic,
      "virtual"        => virtual.to_dynamic,
      "void"           => void.to_dynamic,
      "volatile"       => volatile.to_dynamic,
      "wchar_t"        => wchar_t.to_dynamic,
      "weak"           => weak.to_dynamic,
      "where"          => where.to_dynamic,
      "willSet"        => will_set.to_dynamic,
      "xor"            => xor.to_dynamic,
      "xor_eq"         => xor_eq.to_dynamic,
      "YES"            => yes.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :dummy, Types::Integer
  attribute :obj1,  Obj1
  attribute :obj2,  Obj2
  attribute :obj3,  Obj3
  attribute :obj4,  Obj4
  attribute :obj5,  Obj5
  attribute :obj6,  Obj6

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      dummy: d.fetch("dummy"),
      obj1:  Obj1.from_dynamic!(d.fetch("obj1")),
      obj2:  Obj2.from_dynamic!(d.fetch("obj2")),
      obj3:  Obj3.from_dynamic!(d.fetch("obj3")),
      obj4:  Obj4.from_dynamic!(d.fetch("obj4")),
      obj5:  Obj5.from_dynamic!(d.fetch("obj5")),
      obj6:  Obj6.from_dynamic!(d.fetch("obj6")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "dummy" => dummy,
      "obj1"  => obj1.to_dynamic,
      "obj2"  => obj2.to_dynamic,
      "obj3"  => obj3.to_dynamic,
      "obj4"  => obj4.to_dynamic,
      "obj5"  => obj5.to_dynamic,
      "obj6"  => obj6.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
