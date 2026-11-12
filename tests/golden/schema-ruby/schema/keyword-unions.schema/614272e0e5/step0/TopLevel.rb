# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.empty
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Hash   = Strict::Hash
  Double = Strict::Float | Strict::Integer
end

class Abstract < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionAbstract < Dry::Struct
  attribute :abstract, Abstract.optional
  attribute :double,   Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = Abstract.from_dynamic!(d)
      if schema.key(:abstract).type.right.valid? value
        return new(abstract: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, abstract: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if abstract != nil
      abstract.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Alignas < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionAlignas < Dry::Struct
  attribute :alignas, Alignas.optional
  attribute :double,  Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = Alignas.from_dynamic!(d)
      if schema.key(:alignas).type.right.valid? value
        return new(alignas: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, alignas: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if alignas != nil
      alignas.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Alignof < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionAlignof < Dry::Struct
  attribute :alignof, Alignof.optional
  attribute :double,  Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = Alignof.from_dynamic!(d)
      if schema.key(:alignof).type.right.valid? value
        return new(alignof: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, alignof: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if alignof != nil
      alignof.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class AndEq < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionAndEq < Dry::Struct
  attribute :and_eq, AndEq.optional
  attribute :double, Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = AndEq.from_dynamic!(d)
      if schema.key(:and_eq).type.right.valid? value
        return new(and_eq: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, and_eq: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if and_eq != nil
      and_eq.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Any < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionAny < Dry::Struct
  attribute :any,    Any.optional
  attribute :double, Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = Any.from_dynamic!(d)
      if schema.key(:any).type.right.valid? value
        return new(any: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, any: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if any != nil
      any.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ArrayClass < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionArray < Dry::Struct
  attribute :array_class, ArrayClass.optional
  attribute :double,      Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = ArrayClass.from_dynamic!(d)
      if schema.key(:array_class).type.right.valid? value
        return new(array_class: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, array_class: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if array_class != nil
      array_class.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ArrayNode < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionArrayNode < Dry::Struct
  attribute :array_node, ArrayNode.optional
  attribute :double,     Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = ArrayNode.from_dynamic!(d)
      if schema.key(:array_node).type.right.valid? value
        return new(array_node: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, array_node: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if array_node != nil
      array_node.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class As < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionAs < Dry::Struct
  attribute :as,     As.optional
  attribute :double, Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = As.from_dynamic!(d)
      if schema.key(:as).type.right.valid? value
        return new(as: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, as: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if as != nil
      as.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ASM < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionASM < Dry::Struct
  attribute :asm,    ASM.optional
  attribute :double, Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = ASM.from_dynamic!(d)
      if schema.key(:asm).type.right.valid? value
        return new(asm: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, asm: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if asm != nil
      asm.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Assert < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionAssert < Dry::Struct
  attribute :assert, Assert.optional
  attribute :double, Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = Assert.from_dynamic!(d)
      if schema.key(:assert).type.right.valid? value
        return new(assert: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, assert: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if assert != nil
      assert.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Associatedtype < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionAssociatedtype < Dry::Struct
  attribute :associatedtype, Associatedtype.optional
  attribute :double,         Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = Associatedtype.from_dynamic!(d)
      if schema.key(:associatedtype).type.right.valid? value
        return new(associatedtype: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, associatedtype: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if associatedtype != nil
      associatedtype.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Associativity < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionAssociativity < Dry::Struct
  attribute :associativity, Associativity.optional
  attribute :double,        Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = Associativity.from_dynamic!(d)
      if schema.key(:associativity).type.right.valid? value
        return new(associativity: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, associativity: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if associativity != nil
      associativity.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Async < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionAsync < Dry::Struct
  attribute :async,  Async.optional
  attribute :double, Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = Async.from_dynamic!(d)
      if schema.key(:async).type.right.valid? value
        return new(async: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, async: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if async != nil
      async.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Atomic < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionAtomic < Dry::Struct
  attribute :atomic, Atomic.optional
  attribute :double, Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = Atomic.from_dynamic!(d)
      if schema.key(:atomic).type.right.valid? value
        return new(atomic: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, atomic: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if atomic != nil
      atomic.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class AtomicCancel < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionAtomicCancel < Dry::Struct
  attribute :atomic_cancel, AtomicCancel.optional
  attribute :double,        Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = AtomicCancel.from_dynamic!(d)
      if schema.key(:atomic_cancel).type.right.valid? value
        return new(atomic_cancel: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, atomic_cancel: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if atomic_cancel != nil
      atomic_cancel.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class AtomicCommit < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionAtomicCommit < Dry::Struct
  attribute :atomic_commit, AtomicCommit.optional
  attribute :double,        Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = AtomicCommit.from_dynamic!(d)
      if schema.key(:atomic_commit).type.right.valid? value
        return new(atomic_commit: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, atomic_commit: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if atomic_commit != nil
      atomic_commit.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class AtomicNoexcept < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionAtomicNoexcept < Dry::Struct
  attribute :atomic_noexcept, AtomicNoexcept.optional
  attribute :double,          Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = AtomicNoexcept.from_dynamic!(d)
      if schema.key(:atomic_noexcept).type.right.valid? value
        return new(atomic_noexcept: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, atomic_noexcept: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if atomic_noexcept != nil
      atomic_noexcept.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Auto < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionAuto < Dry::Struct
  attribute :auto,   Auto.optional
  attribute :double, Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = Auto.from_dynamic!(d)
      if schema.key(:auto).type.right.valid? value
        return new(auto: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, auto: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if auto != nil
      auto.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Await < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionAwait < Dry::Struct
  attribute :await,  Await.optional
  attribute :double, Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = Await.from_dynamic!(d)
      if schema.key(:await).type.right.valid? value
        return new(await: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, await: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if await != nil
      await.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Base < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionBase < Dry::Struct
  attribute :base,   Base.optional
  attribute :double, Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = Base.from_dynamic!(d)
      if schema.key(:base).type.right.valid? value
        return new(base: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, base: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if base != nil
      base.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Bitand < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionBitand < Dry::Struct
  attribute :bitand, Bitand.optional
  attribute :double, Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = Bitand.from_dynamic!(d)
      if schema.key(:bitand).type.right.valid? value
        return new(bitand: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, bitand: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if bitand != nil
      bitand.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Bitor < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionBitor < Dry::Struct
  attribute :bitor,  Bitor.optional
  attribute :double, Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = Bitor.from_dynamic!(d)
      if schema.key(:bitor).type.right.valid? value
        return new(bitor: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, bitor: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if bitor != nil
      bitor.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Bool < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionBOOL < Dry::Struct
  attribute :bool,   Bool.optional
  attribute :double, Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = Bool.from_dynamic!(d)
      if schema.key(:bool).type.right.valid? value
        return new(bool: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, bool: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if bool != nil
      bool.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionBoolBool < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionBoolUnion < Dry::Struct
  attribute :double,          Types::Double.optional
  attribute :union_bool_bool, UnionBoolBool.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, union_bool_bool: nil)
    end
    begin
      value = UnionBoolBool.from_dynamic!(d)
      if schema.key(:union_bool_bool).type.right.valid? value
        return new(union_bool_bool: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif union_bool_bool != nil
      union_bool_bool.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Boolean < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionBoolean < Dry::Struct
  attribute :boolean, Boolean.optional
  attribute :double,  Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = Boolean.from_dynamic!(d)
      if schema.key(:boolean).type.right.valid? value
        return new(boolean: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, boolean: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if boolean != nil
      boolean.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class BooleanNode < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionBooleanNode < Dry::Struct
  attribute :boolean_node, BooleanNode.optional
  attribute :double,       Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = BooleanNode.from_dynamic!(d)
      if schema.key(:boolean_node).type.right.valid? value
        return new(boolean_node: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, boolean_node: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if boolean_node != nil
      boolean_node.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Bycopy < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionBycopy < Dry::Struct
  attribute :bycopy, Bycopy.optional
  attribute :double, Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = Bycopy.from_dynamic!(d)
      if schema.key(:bycopy).type.right.valid? value
        return new(bycopy: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, bycopy: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if bycopy != nil
      bycopy.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Byref < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionByref < Dry::Struct
  attribute :byref,  Byref.optional
  attribute :double, Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = Byref.from_dynamic!(d)
      if schema.key(:byref).type.right.valid? value
        return new(byref: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, byref: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if byref != nil
      byref.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Byte < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionByte < Dry::Struct
  attribute :byte,   Byte.optional
  attribute :double, Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = Byte.from_dynamic!(d)
      if schema.key(:byte).type.right.valid? value
        return new(byte: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, byte: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if byte != nil
      byte.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Calendar < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionCalendar < Dry::Struct
  attribute :calendar, Calendar.optional
  attribute :double,   Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = Calendar.from_dynamic!(d)
      if schema.key(:calendar).type.right.valid? value
        return new(calendar: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, calendar: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if calendar != nil
      calendar.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Chan < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionChan < Dry::Struct
  attribute :chan,   Chan.optional
  attribute :double, Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = Chan.from_dynamic!(d)
      if schema.key(:chan).type.right.valid? value
        return new(chan: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, chan: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if chan != nil
      chan.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Char < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionChar < Dry::Struct
  attribute :char,   Char.optional
  attribute :double, Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = Char.from_dynamic!(d)
      if schema.key(:char).type.right.valid? value
        return new(char: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, char: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if char != nil
      char.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Char16T < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionChar16T < Dry::Struct
  attribute :char16_t, Char16T.optional
  attribute :double,   Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = Char16T.from_dynamic!(d)
      if schema.key(:char16_t).type.right.valid? value
        return new(char16_t: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, char16_t: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if char16_t != nil
      char16_t.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Char32T < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionChar32T < Dry::Struct
  attribute :char32_t, Char32T.optional
  attribute :double,   Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = Char32T.from_dynamic!(d)
      if schema.key(:char32_t).type.right.valid? value
        return new(char32_t: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, char32_t: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if char32_t != nil
      char32_t.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Checked < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionChecked < Dry::Struct
  attribute :checked, Checked.optional
  attribute :double,  Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = Checked.from_dynamic!(d)
      if schema.key(:checked).type.right.valid? value
        return new(checked: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, checked: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if checked != nil
      checked.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionClassClass < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionClassUnion < Dry::Struct
  attribute :double,            Types::Double.optional
  attribute :union_class_class, UnionClassClass.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, union_class_class: nil)
    end
    begin
      value = UnionClassClass.from_dynamic!(d)
      if schema.key(:union_class_class).type.right.valid? value
        return new(union_class_class: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif union_class_class != nil
      union_class_class.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class CoAwait < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionCoAwait < Dry::Struct
  attribute :co_await, CoAwait.optional
  attribute :double,   Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = CoAwait.from_dynamic!(d)
      if schema.key(:co_await).type.right.valid? value
        return new(co_await: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, co_await: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if co_await != nil
      co_await.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class CoReturn < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionCoReturn < Dry::Struct
  attribute :co_return, CoReturn.optional
  attribute :double,    Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = CoReturn.from_dynamic!(d)
      if schema.key(:co_return).type.right.valid? value
        return new(co_return: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, co_return: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if co_return != nil
      co_return.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class CoYield < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionCoYield < Dry::Struct
  attribute :co_yield, CoYield.optional
  attribute :double,   Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = CoYield.from_dynamic!(d)
      if schema.key(:co_yield).type.right.valid? value
        return new(co_yield: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, co_yield: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if co_yield != nil
      co_yield.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Codable < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionCodable < Dry::Struct
  attribute :codable, Codable.optional
  attribute :double,  Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = Codable.from_dynamic!(d)
      if schema.key(:codable).type.right.valid? value
        return new(codable: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, codable: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if codable != nil
      codable.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class CodingKey < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionCodingKey < Dry::Struct
  attribute :coding_key, CodingKey.optional
  attribute :double,     Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = CodingKey.from_dynamic!(d)
      if schema.key(:coding_key).type.right.valid? value
        return new(coding_key: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, coding_key: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if coding_key != nil
      coding_key.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class CodingKeys < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionCodingKeys < Dry::Struct
  attribute :coding_keys, CodingKeys.optional
  attribute :double,      Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = CodingKeys.from_dynamic!(d)
      if schema.key(:coding_keys).type.right.valid? value
        return new(coding_keys: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, coding_keys: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if coding_keys != nil
      coding_keys.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Compl < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionCompl < Dry::Struct
  attribute :compl,  Compl.optional
  attribute :double, Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = Compl.from_dynamic!(d)
      if schema.key(:compl).type.right.valid? value
        return new(compl: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, compl: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if compl != nil
      compl.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ComplexClass < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionComplex < Dry::Struct
  attribute :complex_class, ComplexClass.optional
  attribute :double,        Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = ComplexClass.from_dynamic!(d)
      if schema.key(:complex_class).type.right.valid? value
        return new(complex_class: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, complex_class: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if complex_class != nil
      complex_class.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Concept < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionConcept < Dry::Struct
  attribute :concept, Concept.optional
  attribute :double,  Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = Concept.from_dynamic!(d)
      if schema.key(:concept).type.right.valid? value
        return new(concept: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, concept: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if concept != nil
      concept.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Console < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionConsole < Dry::Struct
  attribute :console, Console.optional
  attribute :double,  Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = Console.from_dynamic!(d)
      if schema.key(:console).type.right.valid? value
        return new(console: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, console: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if console != nil
      console.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Const < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionConst < Dry::Struct
  attribute :const,  Const.optional
  attribute :double, Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = Const.from_dynamic!(d)
      if schema.key(:const).type.right.valid? value
        return new(const: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, const: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if const != nil
      const.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ConstCast < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionConstCast < Dry::Struct
  attribute :const_cast, ConstCast.optional
  attribute :double,     Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = ConstCast.from_dynamic!(d)
      if schema.key(:const_cast).type.right.valid? value
        return new(const_cast: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, const_cast: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if const_cast != nil
      const_cast.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Constexpr < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionConstexpr < Dry::Struct
  attribute :constexpr, Constexpr.optional
  attribute :double,    Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = Constexpr.from_dynamic!(d)
      if schema.key(:constexpr).type.right.valid? value
        return new(constexpr: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, constexpr: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if constexpr != nil
      constexpr.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Continue < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionContinue < Dry::Struct
  attribute :continue, Continue.optional
  attribute :double,   Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = Continue.from_dynamic!(d)
      if schema.key(:continue).type.right.valid? value
        return new(continue: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, continue: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if continue != nil
      continue.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Convenience < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionConvenience < Dry::Struct
  attribute :convenience, Convenience.optional
  attribute :double,      Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = Convenience.from_dynamic!(d)
      if schema.key(:convenience).type.right.valid? value
        return new(convenience: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, convenience: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if convenience != nil
      convenience.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Convert < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionConvert < Dry::Struct
  attribute :convert, Convert.optional
  attribute :double,  Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = Convert.from_dynamic!(d)
      if schema.key(:convert).type.right.valid? value
        return new(convert: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, convert: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if convert != nil
      convert.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Converter < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionConverter < Dry::Struct
  attribute :converter, Converter.optional
  attribute :double,    Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = Converter.from_dynamic!(d)
      if schema.key(:converter).type.right.valid? value
        return new(converter: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, converter: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if converter != nil
      converter.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class CultureInfo < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionCultureInfo < Dry::Struct
  attribute :culture_info, CultureInfo.optional
  attribute :double,       Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = CultureInfo.from_dynamic!(d)
      if schema.key(:culture_info).type.right.valid? value
        return new(culture_info: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, culture_info: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if culture_info != nil
      culture_info.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class DateClass < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionDate < Dry::Struct
  attribute :date_class, DateClass.optional
  attribute :double,     Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = DateClass.from_dynamic!(d)
      if schema.key(:date_class).type.right.valid? value
        return new(date_class: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, date_class: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if date_class != nil
      date_class.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class DateFormatter < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionDateFormatter < Dry::Struct
  attribute :date_formatter, DateFormatter.optional
  attribute :double,         Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = DateFormatter.from_dynamic!(d)
      if schema.key(:date_formatter).type.right.valid? value
        return new(date_formatter: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, date_formatter: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if date_formatter != nil
      date_formatter.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class DateOnly < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionDateOnly < Dry::Struct
  attribute :date_only, DateOnly.optional
  attribute :double,    Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = DateOnly.from_dynamic!(d)
      if schema.key(:date_only).type.right.valid? value
        return new(date_only: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, date_only: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if date_only != nil
      date_only.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class DateOnlyConverter < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionDateOnlyConverter < Dry::Struct
  attribute :date_only_converter, DateOnlyConverter.optional
  attribute :double,              Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = DateOnlyConverter.from_dynamic!(d)
      if schema.key(:date_only_converter).type.right.valid? value
        return new(date_only_converter: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, date_only_converter: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if date_only_converter != nil
      date_only_converter.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class DateParseHandling < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionDateParseHandling < Dry::Struct
  attribute :date_parse_handling, DateParseHandling.optional
  attribute :double,              Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = DateParseHandling.from_dynamic!(d)
      if schema.key(:date_parse_handling).type.right.valid? value
        return new(date_parse_handling: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, date_parse_handling: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if date_parse_handling != nil
      date_parse_handling.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class DateTimeClass < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionDateTime < Dry::Struct
  attribute :date_time_class, DateTimeClass.optional
  attribute :double,          Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = DateTimeClass.from_dynamic!(d)
      if schema.key(:date_time_class).type.right.valid? value
        return new(date_time_class: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, date_time_class: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if date_time_class != nil
      date_time_class.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class DateTimeStyles < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionDateTimeStyles < Dry::Struct
  attribute :date_time_styles, DateTimeStyles.optional
  attribute :double,           Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = DateTimeStyles.from_dynamic!(d)
      if schema.key(:date_time_styles).type.right.valid? value
        return new(date_time_styles: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, date_time_styles: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if date_time_styles != nil
      date_time_styles.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Debugger < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionDebugger < Dry::Struct
  attribute :debugger, Debugger.optional
  attribute :double,   Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = Debugger.from_dynamic!(d)
      if schema.key(:debugger).type.right.valid? value
        return new(debugger: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, debugger: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if debugger != nil
      debugger.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Decimal < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionDecimal < Dry::Struct
  attribute :decimal, Decimal.optional
  attribute :double,  Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = Decimal.from_dynamic!(d)
      if schema.key(:decimal).type.right.valid? value
        return new(decimal: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, decimal: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if decimal != nil
      decimal.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Declare < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionDeclare < Dry::Struct
  attribute :declare, Declare.optional
  attribute :double,  Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = Declare.from_dynamic!(d)
      if schema.key(:declare).type.right.valid? value
        return new(declare: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, declare: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if declare != nil
      declare.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Decltype < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionDecltype < Dry::Struct
  attribute :decltype, Decltype.optional
  attribute :double,   Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = Decltype.from_dynamic!(d)
      if schema.key(:decltype).type.right.valid? value
        return new(decltype: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, decltype: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if decltype != nil
      decltype.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class DecodeString < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionDecodeString < Dry::Struct
  attribute :decode_string, DecodeString.optional
  attribute :double,        Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = DecodeString.from_dynamic!(d)
      if schema.key(:decode_string).type.right.valid? value
        return new(decode_string: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, decode_string: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if decode_string != nil
      decode_string.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Decoder < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionDecoder < Dry::Struct
  attribute :decoder, Decoder.optional
  attribute :double,  Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = Decoder.from_dynamic!(d)
      if schema.key(:decoder).type.right.valid? value
        return new(decoder: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, decoder: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if decoder != nil
      decoder.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class DecodingError < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionDecodingError < Dry::Struct
  attribute :decoding_error, DecodingError.optional
  attribute :double,         Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = DecodingError.from_dynamic!(d)
      if schema.key(:decoding_error).type.right.valid? value
        return new(decoding_error: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, decoding_error: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if decoding_error != nil
      decoding_error.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Defer < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionDefer < Dry::Struct
  attribute :defer,  Defer.optional
  attribute :double, Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = Defer.from_dynamic!(d)
      if schema.key(:defer).type.right.valid? value
        return new(defer: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, defer: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if defer != nil
      defer.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Deinit < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionDeinit < Dry::Struct
  attribute :deinit, Deinit.optional
  attribute :double, Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = Deinit.from_dynamic!(d)
      if schema.key(:deinit).type.right.valid? value
        return new(deinit: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, deinit: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if deinit != nil
      deinit.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Del < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionDel < Dry::Struct
  attribute :del,    Del.optional
  attribute :double, Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = Del.from_dynamic!(d)
      if schema.key(:del).type.right.valid? value
        return new(del: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, del: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if del != nil
      del.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Delegate < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionDelegate < Dry::Struct
  attribute :delegate, Delegate.optional
  attribute :double,   Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = Delegate.from_dynamic!(d)
      if schema.key(:delegate).type.right.valid? value
        return new(delegate: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, delegate: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if delegate != nil
      delegate.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Delete < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionDelete < Dry::Struct
  attribute :delete, Delete.optional
  attribute :double, Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = Delete.from_dynamic!(d)
      if schema.key(:delete).type.right.valid? value
        return new(delete: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, delete: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if delete != nil
      delete.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class DeserializationFeature < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionDeserializationFeature < Dry::Struct
  attribute :deserialization_feature, DeserializationFeature.optional
  attribute :double,                  Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = DeserializationFeature.from_dynamic!(d)
      if schema.key(:deserialization_feature).type.right.valid? value
        return new(deserialization_feature: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, deserialization_feature: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if deserialization_feature != nil
      deserialization_feature.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Dict < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionDict < Dry::Struct
  attribute :dict,   Dict.optional
  attribute :double, Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = Dict.from_dynamic!(d)
      if schema.key(:dict).type.right.valid? value
        return new(dict: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, dict: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if dict != nil
      dict.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Dictionary < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionDictionary < Dry::Struct
  attribute :dictionary, Dictionary.optional
  attribute :double,     Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = Dictionary.from_dynamic!(d)
      if schema.key(:dictionary).type.right.valid? value
        return new(dictionary: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, dictionary: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if dictionary != nil
      dictionary.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class DidSet < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionDidSet < Dry::Struct
  attribute :did_set, DidSet.optional
  attribute :double,  Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = DidSet.from_dynamic!(d)
      if schema.key(:did_set).type.right.valid? value
        return new(did_set: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, did_set: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if did_set != nil
      did_set.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Double < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionDouble < Dry::Struct
  attribute :double,   Types::Double.optional
  attribute :double_1, Double.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, double_1: nil)
    end
    begin
      value = Double.from_dynamic!(d)
      if schema.key(:double_1).type.right.valid? value
        return new(double_1: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif double_1 != nil
      double_1.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class DoubleNode < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionDoubleNode < Dry::Struct
  attribute :double,      Types::Double.optional
  attribute :double_node, DoubleNode.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, double_node: nil)
    end
    begin
      value = DoubleNode.from_dynamic!(d)
      if schema.key(:double_node).type.right.valid? value
        return new(double_node: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif double_node != nil
      double_node.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Dynamic < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionDynamic < Dry::Struct
  attribute :double,  Types::Double.optional
  attribute :dynamic, Dynamic.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, dynamic: nil)
    end
    begin
      value = Dynamic.from_dynamic!(d)
      if schema.key(:dynamic).type.right.valid? value
        return new(dynamic: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif dynamic != nil
      dynamic.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class DynamicCast < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionDynamicCast < Dry::Struct
  attribute :double,       Types::Double.optional
  attribute :dynamic_cast, DynamicCast.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, dynamic_cast: nil)
    end
    begin
      value = DynamicCast.from_dynamic!(d)
      if schema.key(:dynamic_cast).type.right.valid? value
        return new(dynamic_cast: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif dynamic_cast != nil
      dynamic_cast.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Elif < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionElif < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :elif,   Elif.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, elif: nil)
    end
    begin
      value = Elif.from_dynamic!(d)
      if schema.key(:elif).type.right.valid? value
        return new(elif: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif elif != nil
      elif.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Empty < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionUnion < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :empty,  Empty.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, empty: nil)
    end
    begin
      value = Empty.from_dynamic!(d)
      if schema.key(:empty).type.right.valid? value
        return new(empty: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif empty != nil
      empty.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class EncodeQuickType < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionEncodeQuickType < Dry::Struct
  attribute :double,            Types::Double.optional
  attribute :encode_quick_type, EncodeQuickType.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, encode_quick_type: nil)
    end
    begin
      value = EncodeQuickType.from_dynamic!(d)
      if schema.key(:encode_quick_type).type.right.valid? value
        return new(encode_quick_type: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif encode_quick_type != nil
      encode_quick_type.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Encoder < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionEncoder < Dry::Struct
  attribute :double,  Types::Double.optional
  attribute :encoder, Encoder.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, encoder: nil)
    end
    begin
      value = Encoder.from_dynamic!(d)
      if schema.key(:encoder).type.right.valid? value
        return new(encoder: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif encoder != nil
      encoder.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class EnumValues < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionEnumValues < Dry::Struct
  attribute :double,      Types::Double.optional
  attribute :enum_values, EnumValues.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, enum_values: nil)
    end
    begin
      value = EnumValues.from_dynamic!(d)
      if schema.key(:enum_values).type.right.valid? value
        return new(enum_values: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif enum_values != nil
      enum_values.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class EqualityContract < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionEqualityContract < Dry::Struct
  attribute :double,            Types::Double.optional
  attribute :equality_contract, EqualityContract.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, equality_contract: nil)
    end
    begin
      value = EqualityContract.from_dynamic!(d)
      if schema.key(:equality_contract).type.right.valid? value
        return new(equality_contract: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif equality_contract != nil
      equality_contract.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Equatable < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionEquatable < Dry::Struct
  attribute :double,    Types::Double.optional
  attribute :equatable, Equatable.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, equatable: nil)
    end
    begin
      value = Equatable.from_dynamic!(d)
      if schema.key(:equatable).type.right.valid? value
        return new(equatable: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif equatable != nil
      equatable.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Event < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionEvent < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :event,  Event.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, event: nil)
    end
    begin
      value = Event.from_dynamic!(d)
      if schema.key(:event).type.right.valid? value
        return new(event: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif event != nil
      event.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Except < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionExcept < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :except, Except.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, except: nil)
    end
    begin
      value = Except.from_dynamic!(d)
      if schema.key(:except).type.right.valid? value
        return new(except: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif except != nil
      except.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ExceptionClass < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionException < Dry::Struct
  attribute :double,          Types::Double.optional
  attribute :exception_class, ExceptionClass.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, exception_class: nil)
    end
    begin
      value = ExceptionClass.from_dynamic!(d)
      if schema.key(:exception_class).type.right.valid? value
        return new(exception_class: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif exception_class != nil
      exception_class.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Explicit < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionExplicit < Dry::Struct
  attribute :double,   Types::Double.optional
  attribute :explicit, Explicit.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, explicit: nil)
    end
    begin
      value = Explicit.from_dynamic!(d)
      if schema.key(:explicit).type.right.valid? value
        return new(explicit: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif explicit != nil
      explicit.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Export < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionExport < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :export, Export.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, export: nil)
    end
    begin
      value = Export.from_dynamic!(d)
      if schema.key(:export).type.right.valid? value
        return new(export: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif export != nil
      export.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Exposing < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionExposing < Dry::Struct
  attribute :double,   Types::Double.optional
  attribute :exposing, Exposing.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, exposing: nil)
    end
    begin
      value = Exposing.from_dynamic!(d)
      if schema.key(:exposing).type.right.valid? value
        return new(exposing: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif exposing != nil
      exposing.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Extends < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionExtends < Dry::Struct
  attribute :double,  Types::Double.optional
  attribute :extends, Extends.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, extends: nil)
    end
    begin
      value = Extends.from_dynamic!(d)
      if schema.key(:extends).type.right.valid? value
        return new(extends: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif extends != nil
      extends.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Extension < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionExtension < Dry::Struct
  attribute :double,    Types::Double.optional
  attribute :extension, Extension.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, extension: nil)
    end
    begin
      value = Extension.from_dynamic!(d)
      if schema.key(:extension).type.right.valid? value
        return new(extension: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif extension != nil
      extension.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Extern < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionExtern < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :extern, Extern.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, extern: nil)
    end
    begin
      value = Extern.from_dynamic!(d)
      if schema.key(:extern).type.right.valid? value
        return new(extern: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif extern != nil
      extern.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Fallthrough < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionFallthrough < Dry::Struct
  attribute :double,      Types::Double.optional
  attribute :fallthrough, Fallthrough.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, fallthrough: nil)
    end
    begin
      value = Fallthrough.from_dynamic!(d)
      if schema.key(:fallthrough).type.right.valid? value
        return new(fallthrough: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif fallthrough != nil
      fallthrough.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionFalseFalse < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionFalseUnion < Dry::Struct
  attribute :double,            Types::Double.optional
  attribute :union_false_false, UnionFalseFalse.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, union_false_false: nil)
    end
    begin
      value = UnionFalseFalse.from_dynamic!(d)
      if schema.key(:union_false_false).type.right.valid? value
        return new(union_false_false: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif union_false_false != nil
      union_false_false.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Fileprivate < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionFileprivate < Dry::Struct
  attribute :double,      Types::Double.optional
  attribute :fileprivate, Fileprivate.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, fileprivate: nil)
    end
    begin
      value = Fileprivate.from_dynamic!(d)
      if schema.key(:fileprivate).type.right.valid? value
        return new(fileprivate: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif fileprivate != nil
      fileprivate.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Final < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionFinal < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :final,  Final.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, final: nil)
    end
    begin
      value = Final.from_dynamic!(d)
      if schema.key(:final).type.right.valid? value
        return new(final: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif final != nil
      final.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Finally < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionFinally < Dry::Struct
  attribute :double,  Types::Double.optional
  attribute :finally, Finally.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, finally: nil)
    end
    begin
      value = Finally.from_dynamic!(d)
      if schema.key(:finally).type.right.valid? value
        return new(finally: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif finally != nil
      finally.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Fixed < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionFixed < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :fixed,  Fixed.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, fixed: nil)
    end
    begin
      value = Fixed.from_dynamic!(d)
      if schema.key(:fixed).type.right.valid? value
        return new(fixed: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif fixed != nil
      fixed.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class FloatClass < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionFloat < Dry::Struct
  attribute :double,      Types::Double.optional
  attribute :float_class, FloatClass.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, float_class: nil)
    end
    begin
      value = FloatClass.from_dynamic!(d)
      if schema.key(:float_class).type.right.valid? value
        return new(float_class: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif float_class != nil
      float_class.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Foreach < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionForeach < Dry::Struct
  attribute :double,  Types::Double.optional
  attribute :foreach, Foreach.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, foreach: nil)
    end
    begin
      value = Foreach.from_dynamic!(d)
      if schema.key(:foreach).type.right.valid? value
        return new(foreach: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif foreach != nil
      foreach.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class FormatException < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionFormatException < Dry::Struct
  attribute :double,           Types::Double.optional
  attribute :format_exception, FormatException.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, format_exception: nil)
    end
    begin
      value = FormatException.from_dynamic!(d)
      if schema.key(:format_exception).type.right.valid? value
        return new(format_exception: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif format_exception != nil
      format_exception.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Friend < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionFriend < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :friend, Friend.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, friend: nil)
    end
    begin
      value = Friend.from_dynamic!(d)
      if schema.key(:friend).type.right.valid? value
        return new(friend: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif friend != nil
      friend.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class From < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionFrom < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :from,   From.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, from: nil)
    end
    begin
      value = From.from_dynamic!(d)
      if schema.key(:from).type.right.valid? value
        return new(from: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif from != nil
      from.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class FromDict < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionFromDict < Dry::Struct
  attribute :double,    Types::Double.optional
  attribute :from_dict, FromDict.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, from_dict: nil)
    end
    begin
      value = FromDict.from_dynamic!(d)
      if schema.key(:from_dict).type.right.valid? value
        return new(from_dict: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif from_dict != nil
      from_dict.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class FromJSON < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionFromJSON < Dry::Struct
  attribute :double,    Types::Double.optional
  attribute :from_json, FromJSON.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, from_json: nil)
    end
    begin
      value = FromJSON.from_dynamic!(d)
      if schema.key(:from_json).type.right.valid? value
        return new(from_json: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif from_json != nil
      from_json.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Func < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionFunc < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :func,   Func.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, func: nil)
    end
    begin
      value = Func.from_dynamic!(d)
      if schema.key(:func).type.right.valid? value
        return new(func: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif func != nil
      func.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Function < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionFunction < Dry::Struct
  attribute :double,   Types::Double.optional
  attribute :function, Function.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, function: nil)
    end
    begin
      value = Function.from_dynamic!(d)
      if schema.key(:function).type.right.valid? value
        return new(function: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif function != nil
      function.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Get < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionGet < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :get,    Get.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, get: nil)
    end
    begin
      value = Get.from_dynamic!(d)
      if schema.key(:get).type.right.valid? value
        return new(get: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif get != nil
      get.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Global < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionGlobal < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :global, Global.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, global: nil)
    end
    begin
      value = Global.from_dynamic!(d)
      if schema.key(:global).type.right.valid? value
        return new(global: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif global != nil
      global.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Go < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionGo < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :go,     Go.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, go: nil)
    end
    begin
      value = Go.from_dynamic!(d)
      if schema.key(:go).type.right.valid? value
        return new(go: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif go != nil
      go.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Goto < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionGoto < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :goto,   Goto.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, goto: nil)
    end
    begin
      value = Goto.from_dynamic!(d)
      if schema.key(:goto).type.right.valid? value
        return new(goto: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif goto != nil
      goto.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Guard < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionGuard < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :guard,  Guard.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, guard: nil)
    end
    begin
      value = Guard.from_dynamic!(d)
      if schema.key(:guard).type.right.valid? value
        return new(guard: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif guard != nil
      guard.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class HasOwnProperty < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionHasOwnProperty < Dry::Struct
  attribute :double,           Types::Double.optional
  attribute :has_own_property, HasOwnProperty.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, has_own_property: nil)
    end
    begin
      value = HasOwnProperty.from_dynamic!(d)
      if schema.key(:has_own_property).type.right.valid? value
        return new(has_own_property: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif has_own_property != nil
      has_own_property.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class HashCode < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionHashCode < Dry::Struct
  attribute :double,    Types::Double.optional
  attribute :hash_code, HashCode.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, hash_code: nil)
    end
    begin
      value = HashCode.from_dynamic!(d)
      if schema.key(:hash_code).type.right.valid? value
        return new(hash_code: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif hash_code != nil
      hash_code.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Hashable < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionHashable < Dry::Struct
  attribute :double,   Types::Double.optional
  attribute :hashable, Hashable.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, hashable: nil)
    end
    begin
      value = Hashable.from_dynamic!(d)
      if schema.key(:hashable).type.right.valid? value
        return new(hashable: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif hashable != nil
      hashable.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Hasher < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionHasher < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :hasher, Hasher.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, hasher: nil)
    end
    begin
      value = Hasher.from_dynamic!(d)
      if schema.key(:hasher).type.right.valid? value
        return new(hasher: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif hasher != nil
      hasher.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ID < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionID < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :id,     ID.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, id: nil)
    end
    begin
      value = ID.from_dynamic!(d)
      if schema.key(:id).type.right.valid? value
        return new(id: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif id != nil
      id.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Imaginery < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionImaginery < Dry::Struct
  attribute :double,    Types::Double.optional
  attribute :imaginery, Imaginery.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, imaginery: nil)
    end
    begin
      value = Imaginery.from_dynamic!(d)
      if schema.key(:imaginery).type.right.valid? value
        return new(imaginery: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif imaginery != nil
      imaginery.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Imp < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionIMP < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :imp,    Imp.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, imp: nil)
    end
    begin
      value = Imp.from_dynamic!(d)
      if schema.key(:imp).type.right.valid? value
        return new(imp: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif imp != nil
      imp.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Implements < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionImplements < Dry::Struct
  attribute :double,     Types::Double.optional
  attribute :implements, Implements.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, implements: nil)
    end
    begin
      value = Implements.from_dynamic!(d)
      if schema.key(:implements).type.right.valid? value
        return new(implements: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif implements != nil
      implements.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Implicit < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionImplicit < Dry::Struct
  attribute :double,   Types::Double.optional
  attribute :implicit, Implicit.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, implicit: nil)
    end
    begin
      value = Implicit.from_dynamic!(d)
      if schema.key(:implicit).type.right.valid? value
        return new(implicit: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif implicit != nil
      implicit.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Import < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionImport < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :import, Import.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, import: nil)
    end
    begin
      value = Import.from_dynamic!(d)
      if schema.key(:import).type.right.valid? value
        return new(import: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif import != nil
      import.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Indirect < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionIndirect < Dry::Struct
  attribute :double,   Types::Double.optional
  attribute :indirect, Indirect.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, indirect: nil)
    end
    begin
      value = Indirect.from_dynamic!(d)
      if schema.key(:indirect).type.right.valid? value
        return new(indirect: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif indirect != nil
      indirect.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Infix < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionInfix < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :infix,  Infix.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, infix: nil)
    end
    begin
      value = Infix.from_dynamic!(d)
      if schema.key(:infix).type.right.valid? value
        return new(infix: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif infix != nil
      infix.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Init < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionInit < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :init,   Init.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, init: nil)
    end
    begin
      value = Init.from_dynamic!(d)
      if schema.key(:init).type.right.valid? value
        return new(init: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif init != nil
      init.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Inline < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionInline < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :inline, Inline.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, inline: nil)
    end
    begin
      value = Inline.from_dynamic!(d)
      if schema.key(:inline).type.right.valid? value
        return new(inline: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif inline != nil
      inline.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Inout < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionInout < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :inout,  Inout.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, inout: nil)
    end
    begin
      value = Inout.from_dynamic!(d)
      if schema.key(:inout).type.right.valid? value
        return new(inout: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif inout != nil
      inout.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Instanceof < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionInstanceof < Dry::Struct
  attribute :double,     Types::Double.optional
  attribute :instanceof, Instanceof.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, instanceof: nil)
    end
    begin
      value = Instanceof.from_dynamic!(d)
      if schema.key(:instanceof).type.right.valid? value
        return new(instanceof: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif instanceof != nil
      instanceof.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Int < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionInt < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :int,    Int.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, int: nil)
    end
    begin
      value = Int.from_dynamic!(d)
      if schema.key(:int).type.right.valid? value
        return new(int: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif int != nil
      int.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class IntNode < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionIntNode < Dry::Struct
  attribute :double,   Types::Double.optional
  attribute :int_node, IntNode.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, int_node: nil)
    end
    begin
      value = IntNode.from_dynamic!(d)
      if schema.key(:int_node).type.right.valid? value
        return new(int_node: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif int_node != nil
      int_node.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Interface < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionInterface < Dry::Struct
  attribute :double,    Types::Double.optional
  attribute :interface, Interface.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, interface: nil)
    end
    begin
      value = Interface.from_dynamic!(d)
      if schema.key(:interface).type.right.valid? value
        return new(interface: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif interface != nil
      interface.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Internal < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionInternal < Dry::Struct
  attribute :double,   Types::Double.optional
  attribute :internal, Internal.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, internal: nil)
    end
    begin
      value = Internal.from_dynamic!(d)
      if schema.key(:internal).type.right.valid? value
        return new(internal: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif internal != nil
      internal.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Is < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionIs < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :is,     Is.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, is: nil)
    end
    begin
      value = Is.from_dynamic!(d)
      if schema.key(:is).type.right.valid? value
        return new(is: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif is != nil
      is.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ISODateTimeOffsetConverter < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionISODateTimeOffsetConverter < Dry::Struct
  attribute :double,                         Types::Double.optional
  attribute :iso_date_time_offset_converter, ISODateTimeOffsetConverter.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, iso_date_time_offset_converter: nil)
    end
    begin
      value = ISODateTimeOffsetConverter.from_dynamic!(d)
      if schema.key(:iso_date_time_offset_converter).type.right.valid? value
        return new(iso_date_time_offset_converter: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif iso_date_time_offset_converter != nil
      iso_date_time_offset_converter.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Iterable < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionIterable < Dry::Struct
  attribute :double,   Types::Double.optional
  attribute :iterable, Iterable.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, iterable: nil)
    end
    begin
      value = Iterable.from_dynamic!(d)
      if schema.key(:iterable).type.right.valid? value
        return new(iterable: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif iterable != nil
      iterable.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Jdec < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionJdec < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :jdec,   Jdec.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, jdec: nil)
    end
    begin
      value = Jdec.from_dynamic!(d)
      if schema.key(:jdec).type.right.valid? value
        return new(jdec: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif jdec != nil
      jdec.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Jenc < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionJenc < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :jenc,   Jenc.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, jenc: nil)
    end
    begin
      value = Jenc.from_dynamic!(d)
      if schema.key(:jenc).type.right.valid? value
        return new(jenc: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif jenc != nil
      jenc.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Jpipe < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionJpipe < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :jpipe,  Jpipe.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, jpipe: nil)
    end
    begin
      value = Jpipe.from_dynamic!(d)
      if schema.key(:jpipe).type.right.valid? value
        return new(jpipe: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif jpipe != nil
      jpipe.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class JSONClass < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionJSON < Dry::Struct
  attribute :double,     Types::Double.optional
  attribute :json_class, JSONClass.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, json_class: nil)
    end
    begin
      value = JSONClass.from_dynamic!(d)
      if schema.key(:json_class).type.right.valid? value
        return new(json_class: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif json_class != nil
      json_class.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class JSONAny < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionJSONAny < Dry::Struct
  attribute :double,   Types::Double.optional
  attribute :json_any, JSONAny.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, json_any: nil)
    end
    begin
      value = JSONAny.from_dynamic!(d)
      if schema.key(:json_any).type.right.valid? value
        return new(json_any: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif json_any != nil
      json_any.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class JSONCodingKey < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionJSONCodingKey < Dry::Struct
  attribute :double,          Types::Double.optional
  attribute :json_coding_key, JSONCodingKey.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, json_coding_key: nil)
    end
    begin
      value = JSONCodingKey.from_dynamic!(d)
      if schema.key(:json_coding_key).type.right.valid? value
        return new(json_coding_key: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif json_coding_key != nil
      json_coding_key.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class JSONConverter < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionJSONConverter < Dry::Struct
  attribute :double,         Types::Double.optional
  attribute :json_converter, JSONConverter.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, json_converter: nil)
    end
    begin
      value = JSONConverter.from_dynamic!(d)
      if schema.key(:json_converter).type.right.valid? value
        return new(json_converter: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif json_converter != nil
      json_converter.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class JSONDecoder < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionJSONDecoder < Dry::Struct
  attribute :double,       Types::Double.optional
  attribute :json_decoder, JSONDecoder.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, json_decoder: nil)
    end
    begin
      value = JSONDecoder.from_dynamic!(d)
      if schema.key(:json_decoder).type.right.valid? value
        return new(json_decoder: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif json_decoder != nil
      json_decoder.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class JSONEncoder < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionJSONEncoder < Dry::Struct
  attribute :double,       Types::Double.optional
  attribute :json_encoder, JSONEncoder.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, json_encoder: nil)
    end
    begin
      value = JSONEncoder.from_dynamic!(d)
      if schema.key(:json_encoder).type.right.valid? value
        return new(json_encoder: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif json_encoder != nil
      json_encoder.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class JSONException < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionJSONException < Dry::Struct
  attribute :double,         Types::Double.optional
  attribute :json_exception, JSONException.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, json_exception: nil)
    end
    begin
      value = JSONException.from_dynamic!(d)
      if schema.key(:json_exception).type.right.valid? value
        return new(json_exception: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif json_exception != nil
      json_exception.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class JSONGenerator < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionJSONGenerator < Dry::Struct
  attribute :double,         Types::Double.optional
  attribute :json_generator, JSONGenerator.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, json_generator: nil)
    end
    begin
      value = JSONGenerator.from_dynamic!(d)
      if schema.key(:json_generator).type.right.valid? value
        return new(json_generator: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif json_generator != nil
      json_generator.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class JSONNode < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionJSONNode < Dry::Struct
  attribute :double,    Types::Double.optional
  attribute :json_node, JSONNode.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, json_node: nil)
    end
    begin
      value = JSONNode.from_dynamic!(d)
      if schema.key(:json_node).type.right.valid? value
        return new(json_node: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif json_node != nil
      json_node.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class JSONNull < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionJSONNull < Dry::Struct
  attribute :double,    Types::Double.optional
  attribute :json_null, JSONNull.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, json_null: nil)
    end
    begin
      value = JSONNull.from_dynamic!(d)
      if schema.key(:json_null).type.right.valid? value
        return new(json_null: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif json_null != nil
      json_null.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class JSONParser < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionJSONParser < Dry::Struct
  attribute :double,      Types::Double.optional
  attribute :json_parser, JSONParser.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, json_parser: nil)
    end
    begin
      value = JSONParser.from_dynamic!(d)
      if schema.key(:json_parser).type.right.valid? value
        return new(json_parser: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif json_parser != nil
      json_parser.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class JSONReader < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionJSONReader < Dry::Struct
  attribute :double,      Types::Double.optional
  attribute :json_reader, JSONReader.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, json_reader: nil)
    end
    begin
      value = JSONReader.from_dynamic!(d)
      if schema.key(:json_reader).type.right.valid? value
        return new(json_reader: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif json_reader != nil
      json_reader.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class JSONSerializer < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionJSONSerializer < Dry::Struct
  attribute :double,          Types::Double.optional
  attribute :json_serializer, JSONSerializer.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, json_serializer: nil)
    end
    begin
      value = JSONSerializer.from_dynamic!(d)
      if schema.key(:json_serializer).type.right.valid? value
        return new(json_serializer: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif json_serializer != nil
      json_serializer.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class JSONToken < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionJSONToken < Dry::Struct
  attribute :double,     Types::Double.optional
  attribute :json_token, JSONToken.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, json_token: nil)
    end
    begin
      value = JSONToken.from_dynamic!(d)
      if schema.key(:json_token).type.right.valid? value
        return new(json_token: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif json_token != nil
      json_token.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class JSONTokenType < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionJSONTokenType < Dry::Struct
  attribute :double,          Types::Double.optional
  attribute :json_token_type, JSONTokenType.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, json_token_type: nil)
    end
    begin
      value = JSONTokenType.from_dynamic!(d)
      if schema.key(:json_token_type).type.right.valid? value
        return new(json_token_type: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif json_token_type != nil
      json_token_type.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class JSONWriter < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionJSONWriter < Dry::Struct
  attribute :double,      Types::Double.optional
  attribute :json_writer, JSONWriter.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, json_writer: nil)
    end
    begin
      value = JSONWriter.from_dynamic!(d)
      if schema.key(:json_writer).type.right.valid? value
        return new(json_writer: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif json_writer != nil
      json_writer.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class KSerializer < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionKSerializer < Dry::Struct
  attribute :double,       Types::Double.optional
  attribute :k_serializer, KSerializer.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, k_serializer: nil)
    end
    begin
      value = KSerializer.from_dynamic!(d)
      if schema.key(:k_serializer).type.right.valid? value
        return new(k_serializer: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif k_serializer != nil
      k_serializer.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Lazy < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionLazy < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :lazy,   Lazy.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, lazy: nil)
    end
    begin
      value = Lazy.from_dynamic!(d)
      if schema.key(:lazy).type.right.valid? value
        return new(lazy: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif lazy != nil
      lazy.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Left < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionLeft < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :left,   Left.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, left: nil)
    end
    begin
      value = Left.from_dynamic!(d)
      if schema.key(:left).type.right.valid? value
        return new(left: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif left != nil
      left.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Let < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionLet < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :let,    Let.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, let: nil)
    end
    begin
      value = Let.from_dynamic!(d)
      if schema.key(:let).type.right.valid? value
        return new(let: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif let != nil
      let.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class List < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionList < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :list,   List.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, list: nil)
    end
    begin
      value = List.from_dynamic!(d)
      if schema.key(:list).type.right.valid? value
        return new(list: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif list != nil
      list.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class LocalDate < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionLocalDate < Dry::Struct
  attribute :double,     Types::Double.optional
  attribute :local_date, LocalDate.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, local_date: nil)
    end
    begin
      value = LocalDate.from_dynamic!(d)
      if schema.key(:local_date).type.right.valid? value
        return new(local_date: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif local_date != nil
      local_date.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Locale < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionLocale < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :locale, Locale.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, locale: nil)
    end
    begin
      value = Locale.from_dynamic!(d)
      if schema.key(:locale).type.right.valid? value
        return new(locale: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif locale != nil
      locale.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Lock < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionLock < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :lock,   Lock.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, lock: nil)
    end
    begin
      value = Lock.from_dynamic!(d)
      if schema.key(:lock).type.right.valid? value
        return new(lock: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif lock != nil
      lock.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Long < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionLong < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :long,   Long.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, long: nil)
    end
    begin
      value = Long.from_dynamic!(d)
      if schema.key(:long).type.right.valid? value
        return new(long: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif long != nil
      long.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class LongNode < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionLongNode < Dry::Struct
  attribute :double,    Types::Double.optional
  attribute :long_node, LongNode.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, long_node: nil)
    end
    begin
      value = LongNode.from_dynamic!(d)
      if schema.key(:long_node).type.right.valid? value
        return new(long_node: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif long_node != nil
      long_node.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Map < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionMap < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :map,    Map.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, map: nil)
    end
    begin
      value = Map.from_dynamic!(d)
      if schema.key(:map).type.right.valid? value
        return new(map: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif map != nil
      map.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class MapEntry < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionMapEntry < Dry::Struct
  attribute :double,    Types::Double.optional
  attribute :map_entry, MapEntry.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, map_entry: nil)
    end
    begin
      value = MapEntry.from_dynamic!(d)
      if schema.key(:map_entry).type.right.valid? value
        return new(map_entry: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif map_entry != nil
      map_entry.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class MarshalJSON < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionMarshalJSON < Dry::Struct
  attribute :double,       Types::Double.optional
  attribute :marshal_json, MarshalJSON.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, marshal_json: nil)
    end
    begin
      value = MarshalJSON.from_dynamic!(d)
      if schema.key(:marshal_json).type.right.valid? value
        return new(marshal_json: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif marshal_json != nil
      marshal_json.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class MetadataPropertyHandling < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionMetadataPropertyHandling < Dry::Struct
  attribute :double,                     Types::Double.optional
  attribute :metadata_property_handling, MetadataPropertyHandling.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, metadata_property_handling: nil)
    end
    begin
      value = MetadataPropertyHandling.from_dynamic!(d)
      if schema.key(:metadata_property_handling).type.right.valid? value
        return new(metadata_property_handling: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif metadata_property_handling != nil
      metadata_property_handling.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Mutable < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionMutable < Dry::Struct
  attribute :double,  Types::Double.optional
  attribute :mutable, Mutable.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, mutable: nil)
    end
    begin
      value = Mutable.from_dynamic!(d)
      if schema.key(:mutable).type.right.valid? value
        return new(mutable: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif mutable != nil
      mutable.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Mutating < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionMutating < Dry::Struct
  attribute :double,   Types::Double.optional
  attribute :mutating, Mutating.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, mutating: nil)
    end
    begin
      value = Mutating.from_dynamic!(d)
      if schema.key(:mutating).type.right.valid? value
        return new(mutating: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif mutating != nil
      mutating.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Namespace < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionNamespace < Dry::Struct
  attribute :double,    Types::Double.optional
  attribute :namespace, Namespace.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, namespace: nil)
    end
    begin
      value = Namespace.from_dynamic!(d)
      if schema.key(:namespace).type.right.valid? value
        return new(namespace: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif namespace != nil
      namespace.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Native < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionNative < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :native, Native.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, native: nil)
    end
    begin
      value = Native.from_dynamic!(d)
      if schema.key(:native).type.right.valid? value
        return new(native: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif native != nil
      native.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Newtonsoft < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionNewtonsoft < Dry::Struct
  attribute :double,     Types::Double.optional
  attribute :newtonsoft, Newtonsoft.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, newtonsoft: nil)
    end
    begin
      value = Newtonsoft.from_dynamic!(d)
      if schema.key(:newtonsoft).type.right.valid? value
        return new(newtonsoft: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif newtonsoft != nil
      newtonsoft.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class No < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionNO < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :no,     No.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, no: nil)
    end
    begin
      value = No.from_dynamic!(d)
      if schema.key(:no).type.right.valid? value
        return new(no: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif no != nil
      no.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class NoSuchMethod < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionNoSuchMethod < Dry::Struct
  attribute :double,         Types::Double.optional
  attribute :no_such_method, NoSuchMethod.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, no_such_method: nil)
    end
    begin
      value = NoSuchMethod.from_dynamic!(d)
      if schema.key(:no_such_method).type.right.valid? value
        return new(no_such_method: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif no_such_method != nil
      no_such_method.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Noexcept < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionNoexcept < Dry::Struct
  attribute :double,   Types::Double.optional
  attribute :noexcept, Noexcept.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, noexcept: nil)
    end
    begin
      value = Noexcept.from_dynamic!(d)
      if schema.key(:noexcept).type.right.valid? value
        return new(noexcept: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif noexcept != nil
      noexcept.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Nonatomic < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionNonatomic < Dry::Struct
  attribute :double,    Types::Double.optional
  attribute :nonatomic, Nonatomic.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, nonatomic: nil)
    end
    begin
      value = Nonatomic.from_dynamic!(d)
      if schema.key(:nonatomic).type.right.valid? value
        return new(nonatomic: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif nonatomic != nil
      nonatomic.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class None < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionNone < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :none,   None.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, none: nil)
    end
    begin
      value = None.from_dynamic!(d)
      if schema.key(:none).type.right.valid? value
        return new(none: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif none != nil
      none.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Nonlocal < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionNonlocal < Dry::Struct
  attribute :double,   Types::Double.optional
  attribute :nonlocal, Nonlocal.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, nonlocal: nil)
    end
    begin
      value = Nonlocal.from_dynamic!(d)
      if schema.key(:nonlocal).type.right.valid? value
        return new(nonlocal: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif nonlocal != nil
      nonlocal.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Nonmutating < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionNonmutating < Dry::Struct
  attribute :double,      Types::Double.optional
  attribute :nonmutating, Nonmutating.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, nonmutating: nil)
    end
    begin
      value = Nonmutating.from_dynamic!(d)
      if schema.key(:nonmutating).type.right.valid? value
        return new(nonmutating: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif nonmutating != nil
      nonmutating.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class NotEq < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionNotEq < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :not_eq, NotEq.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, not_eq: nil)
    end
    begin
      value = NotEq.from_dynamic!(d)
      if schema.key(:not_eq).type.right.valid? value
        return new(not_eq: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif not_eq != nil
      not_eq.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class NSError < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionNSError < Dry::Struct
  attribute :double,   Types::Double.optional
  attribute :ns_error, NSError.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, ns_error: nil)
    end
    begin
      value = NSError.from_dynamic!(d)
      if schema.key(:ns_error).type.right.valid? value
        return new(ns_error: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif ns_error != nil
      ns_error.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class NSObject < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionNSObject < Dry::Struct
  attribute :double,    Types::Double.optional
  attribute :ns_object, NSObject.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, ns_object: nil)
    end
    begin
      value = NSObject.from_dynamic!(d)
      if schema.key(:ns_object).type.right.valid? value
        return new(ns_object: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif ns_object != nil
      ns_object.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class NSString < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionNSString < Dry::Struct
  attribute :double,    Types::Double.optional
  attribute :ns_string, NSString.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, ns_string: nil)
    end
    begin
      value = NSString.from_dynamic!(d)
      if schema.key(:ns_string).type.right.valid? value
        return new(ns_string: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif ns_string != nil
      ns_string.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Null < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionNULL < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :null,   Null.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, null: nil)
    end
    begin
      value = Null.from_dynamic!(d)
      if schema.key(:null).type.right.valid? value
        return new(null: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif null != nil
      null.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class NullNode < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionNullNode < Dry::Struct
  attribute :double,    Types::Double.optional
  attribute :null_node, NullNode.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, null_node: nil)
    end
    begin
      value = NullNode.from_dynamic!(d)
      if schema.key(:null_node).type.right.valid? value
        return new(null_node: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif null_node != nil
      null_node.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Nullptr < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionNullptr < Dry::Struct
  attribute :double,  Types::Double.optional
  attribute :nullptr, Nullptr.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, nullptr: nil)
    end
    begin
      value = Nullptr.from_dynamic!(d)
      if schema.key(:nullptr).type.right.valid? value
        return new(nullptr: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif nullptr != nil
      nullptr.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Number < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionNumber < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :number, Number.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, number: nil)
    end
    begin
      value = Number.from_dynamic!(d)
      if schema.key(:number).type.right.valid? value
        return new(number: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif number != nil
      number.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ObjectClass < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionObject < Dry::Struct
  attribute :double,       Types::Double.optional
  attribute :object_class, ObjectClass.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, object_class: nil)
    end
    begin
      value = ObjectClass.from_dynamic!(d)
      if schema.key(:object_class).type.right.valid? value
        return new(object_class: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif object_class != nil
      object_class.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ObjectMapper < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionObjectMapper < Dry::Struct
  attribute :double,        Types::Double.optional
  attribute :object_mapper, ObjectMapper.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, object_mapper: nil)
    end
    begin
      value = ObjectMapper.from_dynamic!(d)
      if schema.key(:object_mapper).type.right.valid? value
        return new(object_mapper: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif object_mapper != nil
      object_mapper.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ObjectNode < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionObjectNode < Dry::Struct
  attribute :double,      Types::Double.optional
  attribute :object_node, ObjectNode.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, object_node: nil)
    end
    begin
      value = ObjectNode.from_dynamic!(d)
      if schema.key(:object_node).type.right.valid? value
        return new(object_node: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif object_node != nil
      object_node.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ObjectReader < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionObjectReader < Dry::Struct
  attribute :double,        Types::Double.optional
  attribute :object_reader, ObjectReader.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, object_reader: nil)
    end
    begin
      value = ObjectReader.from_dynamic!(d)
      if schema.key(:object_reader).type.right.valid? value
        return new(object_reader: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif object_reader != nil
      object_reader.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ObjectWriter < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionObjectWriter < Dry::Struct
  attribute :double,        Types::Double.optional
  attribute :object_writer, ObjectWriter.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, object_writer: nil)
    end
    begin
      value = ObjectWriter.from_dynamic!(d)
      if schema.key(:object_writer).type.right.valid? value
        return new(object_writer: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif object_writer != nil
      object_writer.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Of < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionOf < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :of,     Of.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, of: nil)
    end
    begin
      value = Of.from_dynamic!(d)
      if schema.key(:of).type.right.valid? value
        return new(of: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif of != nil
      of.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class OffsetDateTime < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionOffsetDateTime < Dry::Struct
  attribute :double,           Types::Double.optional
  attribute :offset_date_time, OffsetDateTime.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, offset_date_time: nil)
    end
    begin
      value = OffsetDateTime.from_dynamic!(d)
      if schema.key(:offset_date_time).type.right.valid? value
        return new(offset_date_time: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif offset_date_time != nil
      offset_date_time.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class OffsetTime < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionOffsetTime < Dry::Struct
  attribute :double,      Types::Double.optional
  attribute :offset_time, OffsetTime.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, offset_time: nil)
    end
    begin
      value = OffsetTime.from_dynamic!(d)
      if schema.key(:offset_time).type.right.valid? value
        return new(offset_time: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif offset_time != nil
      offset_time.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Oneway < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionOneway < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :oneway, Oneway.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, oneway: nil)
    end
    begin
      value = Oneway.from_dynamic!(d)
      if schema.key(:oneway).type.right.valid? value
        return new(oneway: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif oneway != nil
      oneway.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Operator < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionOperator < Dry::Struct
  attribute :double,   Types::Double.optional
  attribute :operator, Operator.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, operator: nil)
    end
    begin
      value = Operator.from_dynamic!(d)
      if schema.key(:operator).type.right.valid? value
        return new(operator: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif operator != nil
      operator.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class OrEq < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionOrEq < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :or_eq,  OrEq.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, or_eq: nil)
    end
    begin
      value = OrEq.from_dynamic!(d)
      if schema.key(:or_eq).type.right.valid? value
        return new(or_eq: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif or_eq != nil
      or_eq.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Out < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionOut < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :out,    Out.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, out: nil)
    end
    begin
      value = Out.from_dynamic!(d)
      if schema.key(:out).type.right.valid? value
        return new(out: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif out != nil
      out.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Override < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionOverride < Dry::Struct
  attribute :double,   Types::Double.optional
  attribute :override, Override.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, override: nil)
    end
    begin
      value = Override.from_dynamic!(d)
      if schema.key(:override).type.right.valid? value
        return new(override: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif override != nil
      override.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Package < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionPackage < Dry::Struct
  attribute :double,  Types::Double.optional
  attribute :package, Package.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, package: nil)
    end
    begin
      value = Package.from_dynamic!(d)
      if schema.key(:package).type.right.valid? value
        return new(package: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif package != nil
      package.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Params < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionParams < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :params, Params.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, params: nil)
    end
    begin
      value = Params.from_dynamic!(d)
      if schema.key(:params).type.right.valid? value
        return new(params: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif params != nil
      params.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Pass < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionPass < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :pass,   Pass.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, pass: nil)
    end
    begin
      value = Pass.from_dynamic!(d)
      if schema.key(:pass).type.right.valid? value
        return new(pass: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif pass != nil
      pass.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Port < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionPort < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :port,   Port.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, port: nil)
    end
    begin
      value = Port.from_dynamic!(d)
      if schema.key(:port).type.right.valid? value
        return new(port: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif port != nil
      port.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Postfix < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionPostfix < Dry::Struct
  attribute :double,  Types::Double.optional
  attribute :postfix, Postfix.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, postfix: nil)
    end
    begin
      value = Postfix.from_dynamic!(d)
      if schema.key(:postfix).type.right.valid? value
        return new(postfix: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif postfix != nil
      postfix.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Precedence < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionPrecedence < Dry::Struct
  attribute :double,     Types::Double.optional
  attribute :precedence, Precedence.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, precedence: nil)
    end
    begin
      value = Precedence.from_dynamic!(d)
      if schema.key(:precedence).type.right.valid? value
        return new(precedence: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif precedence != nil
      precedence.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Prefix < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionPrefix < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :prefix, Prefix.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, prefix: nil)
    end
    begin
      value = Prefix.from_dynamic!(d)
      if schema.key(:prefix).type.right.valid? value
        return new(prefix: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif prefix != nil
      prefix.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class PrimitiveKind < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionPrimitiveKind < Dry::Struct
  attribute :double,         Types::Double.optional
  attribute :primitive_kind, PrimitiveKind.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, primitive_kind: nil)
    end
    begin
      value = PrimitiveKind.from_dynamic!(d)
      if schema.key(:primitive_kind).type.right.valid? value
        return new(primitive_kind: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif primitive_kind != nil
      primitive_kind.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class PrintMembers < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionPrintMembers < Dry::Struct
  attribute :double,        Types::Double.optional
  attribute :print_members, PrintMembers.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, print_members: nil)
    end
    begin
      value = PrintMembers.from_dynamic!(d)
      if schema.key(:print_members).type.right.valid? value
        return new(print_members: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif print_members != nil
      print_members.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Private < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionPrivate < Dry::Struct
  attribute :double,  Types::Double.optional
  attribute :private, Private.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, private: nil)
    end
    begin
      value = Private.from_dynamic!(d)
      if schema.key(:private).type.right.valid? value
        return new(private: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif private != nil
      private.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Protected < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionProtected < Dry::Struct
  attribute :double,    Types::Double.optional
  attribute :protected, Protected.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, protected: nil)
    end
    begin
      value = Protected.from_dynamic!(d)
      if schema.key(:protected).type.right.valid? value
        return new(protected: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif protected != nil
      protected.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Protocol < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionProtocol < Dry::Struct
  attribute :double,   Types::Double.optional
  attribute :protocol, Protocol.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, protocol: nil)
    end
    begin
      value = Protocol.from_dynamic!(d)
      if schema.key(:protocol).type.right.valid? value
        return new(protocol: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif protocol != nil
      protocol.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Public < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionPublic < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :public, Public.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, public: nil)
    end
    begin
      value = Public.from_dynamic!(d)
      if schema.key(:public).type.right.valid? value
        return new(public: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif public != nil
      public.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Quicktype < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionQuicktype < Dry::Struct
  attribute :double,    Types::Double.optional
  attribute :quicktype, Quicktype.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, quicktype: nil)
    end
    begin
      value = Quicktype.from_dynamic!(d)
      if schema.key(:quicktype).type.right.valid? value
        return new(quicktype: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif quicktype != nil
      quicktype.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class RangeClass < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionRange < Dry::Struct
  attribute :double,      Types::Double.optional
  attribute :range_class, RangeClass.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, range_class: nil)
    end
    begin
      value = RangeClass.from_dynamic!(d)
      if schema.key(:range_class).type.right.valid? value
        return new(range_class: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif range_class != nil
      range_class.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Readonly < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionReadonly < Dry::Struct
  attribute :double,   Types::Double.optional
  attribute :readonly, Readonly.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, readonly: nil)
    end
    begin
      value = Readonly.from_dynamic!(d)
      if schema.key(:readonly).type.right.valid? value
        return new(readonly: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif readonly != nil
      readonly.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Ref < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionRef < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :ref,    Ref.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, ref: nil)
    end
    begin
      value = Ref.from_dynamic!(d)
      if schema.key(:ref).type.right.valid? value
        return new(ref: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif ref != nil
      ref.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class RegExp < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionRegExp < Dry::Struct
  attribute :double,  Types::Double.optional
  attribute :reg_exp, RegExp.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, reg_exp: nil)
    end
    begin
      value = RegExp.from_dynamic!(d)
      if schema.key(:reg_exp).type.right.valid? value
        return new(reg_exp: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif reg_exp != nil
      reg_exp.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Register < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionRegister < Dry::Struct
  attribute :double,   Types::Double.optional
  attribute :register, Register.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, register: nil)
    end
    begin
      value = Register.from_dynamic!(d)
      if schema.key(:register).type.right.valid? value
        return new(register: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif register != nil
      register.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ReinterpretCast < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionReinterpretCast < Dry::Struct
  attribute :double,           Types::Double.optional
  attribute :reinterpret_cast, ReinterpretCast.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, reinterpret_cast: nil)
    end
    begin
      value = ReinterpretCast.from_dynamic!(d)
      if schema.key(:reinterpret_cast).type.right.valid? value
        return new(reinterpret_cast: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif reinterpret_cast != nil
      reinterpret_cast.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Repeat < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionRepeat < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :repeat, Repeat.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, repeat: nil)
    end
    begin
      value = Repeat.from_dynamic!(d)
      if schema.key(:repeat).type.right.valid? value
        return new(repeat: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif repeat != nil
      repeat.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Required < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionRequired < Dry::Struct
  attribute :double,   Types::Double.optional
  attribute :required, Required.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, required: nil)
    end
    begin
      value = Required.from_dynamic!(d)
      if schema.key(:required).type.right.valid? value
        return new(required: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif required != nil
      required.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Requires < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionRequires < Dry::Struct
  attribute :double,   Types::Double.optional
  attribute :requires, Requires.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, requires: nil)
    end
    begin
      value = Requires.from_dynamic!(d)
      if schema.key(:requires).type.right.valid? value
        return new(requires: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif requires != nil
      requires.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Restrict < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionRestrict < Dry::Struct
  attribute :double,   Types::Double.optional
  attribute :restrict, Restrict.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, restrict: nil)
    end
    begin
      value = Restrict.from_dynamic!(d)
      if schema.key(:restrict).type.right.valid? value
        return new(restrict: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif restrict != nil
      restrict.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Retain < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionRetain < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :retain, Retain.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, retain: nil)
    end
    begin
      value = Retain.from_dynamic!(d)
      if schema.key(:retain).type.right.valid? value
        return new(retain: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif retain != nil
      retain.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Rethrows < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionRethrows < Dry::Struct
  attribute :double,   Types::Double.optional
  attribute :rethrows, Rethrows.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, rethrows: nil)
    end
    begin
      value = Rethrows.from_dynamic!(d)
      if schema.key(:rethrows).type.right.valid? value
        return new(rethrows: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif rethrows != nil
      rethrows.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Right < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionRight < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :right,  Right.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, right: nil)
    end
    begin
      value = Right.from_dynamic!(d)
      if schema.key(:right).type.right.valid? value
        return new(right: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif right != nil
      right.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class RuntimeType < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionRuntimeType < Dry::Struct
  attribute :double,       Types::Double.optional
  attribute :runtime_type, RuntimeType.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, runtime_type: nil)
    end
    begin
      value = RuntimeType.from_dynamic!(d)
      if schema.key(:runtime_type).type.right.valid? value
        return new(runtime_type: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif runtime_type != nil
      runtime_type.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class S < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionS < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :s,      S.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, s: nil)
    end
    begin
      value = S.from_dynamic!(d)
      if schema.key(:s).type.right.valid? value
        return new(s: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif s != nil
      s.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Sbyte < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionSbyte < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :sbyte,  Sbyte.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, sbyte: nil)
    end
    begin
      value = Sbyte.from_dynamic!(d)
      if schema.key(:sbyte).type.right.valid? value
        return new(sbyte: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif sbyte != nil
      sbyte.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Sealed < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionSealed < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :sealed, Sealed.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, sealed: nil)
    end
    begin
      value = Sealed.from_dynamic!(d)
      if schema.key(:sealed).type.right.valid? value
        return new(sealed: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif sealed != nil
      sealed.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Sel < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionSEL < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :sel,    Sel.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, sel: nil)
    end
    begin
      value = Sel.from_dynamic!(d)
      if schema.key(:sel).type.right.valid? value
        return new(sel: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif sel != nil
      sel.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionSelfSelf < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionSelfUnion < Dry::Struct
  attribute :double,          Types::Double.optional
  attribute :union_self_self, UnionSelfSelf.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, union_self_self: nil)
    end
    begin
      value = UnionSelfSelf.from_dynamic!(d)
      if schema.key(:union_self_self).type.right.valid? value
        return new(union_self_self: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif union_self_self != nil
      union_self_self.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Sendable < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionSendable < Dry::Struct
  attribute :double,   Types::Double.optional
  attribute :sendable, Sendable.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, sendable: nil)
    end
    begin
      value = Sendable.from_dynamic!(d)
      if schema.key(:sendable).type.right.valid? value
        return new(sendable: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif sendable != nil
      sendable.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class SerialDescriptor < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionSerialDescriptor < Dry::Struct
  attribute :double,            Types::Double.optional
  attribute :serial_descriptor, SerialDescriptor.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, serial_descriptor: nil)
    end
    begin
      value = SerialDescriptor.from_dynamic!(d)
      if schema.key(:serial_descriptor).type.right.valid? value
        return new(serial_descriptor: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif serial_descriptor != nil
      serial_descriptor.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class SerialName < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionSerialName < Dry::Struct
  attribute :double,      Types::Double.optional
  attribute :serial_name, SerialName.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, serial_name: nil)
    end
    begin
      value = SerialName.from_dynamic!(d)
      if schema.key(:serial_name).type.right.valid? value
        return new(serial_name: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif serial_name != nil
      serial_name.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Serializable < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionSerializable < Dry::Struct
  attribute :double,       Types::Double.optional
  attribute :serializable, Serializable.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, serializable: nil)
    end
    begin
      value = Serializable.from_dynamic!(d)
      if schema.key(:serializable).type.right.valid? value
        return new(serializable: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif serializable != nil
      serializable.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class SerializationFeature < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionSerializationFeature < Dry::Struct
  attribute :double,                Types::Double.optional
  attribute :serialization_feature, SerializationFeature.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, serialization_feature: nil)
    end
    begin
      value = SerializationFeature.from_dynamic!(d)
      if schema.key(:serialization_feature).type.right.valid? value
        return new(serialization_feature: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif serialization_feature != nil
      serialization_feature.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Serialize < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionSerialize < Dry::Struct
  attribute :double,    Types::Double.optional
  attribute :serialize, Serialize.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, serialize: nil)
    end
    begin
      value = Serialize.from_dynamic!(d)
      if schema.key(:serialize).type.right.valid? value
        return new(serialize: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif serialize != nil
      serialize.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class SerializerProvider < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionSerializerProvider < Dry::Struct
  attribute :double,              Types::Double.optional
  attribute :serializer_provider, SerializerProvider.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, serializer_provider: nil)
    end
    begin
      value = SerializerProvider.from_dynamic!(d)
      if schema.key(:serializer_provider).type.right.valid? value
        return new(serializer_provider: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif serializer_provider != nil
      serializer_provider.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class SetClass < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionSet < Dry::Struct
  attribute :double,    Types::Double.optional
  attribute :set_class, SetClass.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, set_class: nil)
    end
    begin
      value = SetClass.from_dynamic!(d)
      if schema.key(:set_class).type.right.valid? value
        return new(set_class: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif set_class != nil
      set_class.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Short < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionShort < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :short,  Short.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, short: nil)
    end
    begin
      value = Short.from_dynamic!(d)
      if schema.key(:short).type.right.valid? value
        return new(short: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif short != nil
      short.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Signed < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionSigned < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :signed, Signed.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, signed: nil)
    end
    begin
      value = Signed.from_dynamic!(d)
      if schema.key(:signed).type.right.valid? value
        return new(signed: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif signed != nil
      signed.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class SimpleModule < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionSimpleModule < Dry::Struct
  attribute :double,        Types::Double.optional
  attribute :simple_module, SimpleModule.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, simple_module: nil)
    end
    begin
      value = SimpleModule.from_dynamic!(d)
      if schema.key(:simple_module).type.right.valid? value
        return new(simple_module: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif simple_module != nil
      simple_module.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Sizeof < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionSizeof < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :sizeof, Sizeof.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, sizeof: nil)
    end
    begin
      value = Sizeof.from_dynamic!(d)
      if schema.key(:sizeof).type.right.valid? value
        return new(sizeof: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif sizeof != nil
      sizeof.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Stackalloc < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionStackalloc < Dry::Struct
  attribute :double,     Types::Double.optional
  attribute :stackalloc, Stackalloc.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, stackalloc: nil)
    end
    begin
      value = Stackalloc.from_dynamic!(d)
      if schema.key(:stackalloc).type.right.valid? value
        return new(stackalloc: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif stackalloc != nil
      stackalloc.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Standards < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionStandards < Dry::Struct
  attribute :double,    Types::Double.optional
  attribute :standards, Standards.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, standards: nil)
    end
    begin
      value = Standards.from_dynamic!(d)
      if schema.key(:standards).type.right.valid? value
        return new(standards: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif standards != nil
      standards.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Static < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionStatic < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :static, Static.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, static: nil)
    end
    begin
      value = Static.from_dynamic!(d)
      if schema.key(:static).type.right.valid? value
        return new(static: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif static != nil
      static.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class StaticAssert < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionStaticAssert < Dry::Struct
  attribute :double,        Types::Double.optional
  attribute :static_assert, StaticAssert.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, static_assert: nil)
    end
    begin
      value = StaticAssert.from_dynamic!(d)
      if schema.key(:static_assert).type.right.valid? value
        return new(static_assert: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif static_assert != nil
      static_assert.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class StaticCast < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionStaticCast < Dry::Struct
  attribute :double,      Types::Double.optional
  attribute :static_cast, StaticCast.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, static_cast: nil)
    end
    begin
      value = StaticCast.from_dynamic!(d)
      if schema.key(:static_cast).type.right.valid? value
        return new(static_cast: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif static_cast != nil
      static_cast.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class StdDeserializer < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionStdDeserializer < Dry::Struct
  attribute :double,           Types::Double.optional
  attribute :std_deserializer, StdDeserializer.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, std_deserializer: nil)
    end
    begin
      value = StdDeserializer.from_dynamic!(d)
      if schema.key(:std_deserializer).type.right.valid? value
        return new(std_deserializer: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif std_deserializer != nil
      std_deserializer.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class StdSerializer < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionStdSerializer < Dry::Struct
  attribute :double,         Types::Double.optional
  attribute :std_serializer, StdSerializer.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, std_serializer: nil)
    end
    begin
      value = StdSerializer.from_dynamic!(d)
      if schema.key(:std_serializer).type.right.valid? value
        return new(std_serializer: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif std_serializer != nil
      std_serializer.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Strictfp < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionStrictfp < Dry::Struct
  attribute :double,   Types::Double.optional
  attribute :strictfp, Strictfp.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, strictfp: nil)
    end
    begin
      value = Strictfp.from_dynamic!(d)
      if schema.key(:strictfp).type.right.valid? value
        return new(strictfp: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif strictfp != nil
      strictfp.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class StringClass < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionString < Dry::Struct
  attribute :double,       Types::Double.optional
  attribute :string_class, StringClass.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, string_class: nil)
    end
    begin
      value = StringClass.from_dynamic!(d)
      if schema.key(:string_class).type.right.valid? value
        return new(string_class: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif string_class != nil
      string_class.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class StructClass < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionStruct < Dry::Struct
  attribute :double,       Types::Double.optional
  attribute :struct_class, StructClass.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, struct_class: nil)
    end
    begin
      value = StructClass.from_dynamic!(d)
      if schema.key(:struct_class).type.right.valid? value
        return new(struct_class: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif struct_class != nil
      struct_class.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Subscript < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionSubscript < Dry::Struct
  attribute :double,    Types::Double.optional
  attribute :subscript, Subscript.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, subscript: nil)
    end
    begin
      value = Subscript.from_dynamic!(d)
      if schema.key(:subscript).type.right.valid? value
        return new(subscript: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif subscript != nil
      subscript.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Switch < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionSwitch < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :switch, Switch.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, switch: nil)
    end
    begin
      value = Switch.from_dynamic!(d)
      if schema.key(:switch).type.right.valid? value
        return new(switch: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif switch != nil
      switch.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class SymbolClass < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionSymbol < Dry::Struct
  attribute :double,       Types::Double.optional
  attribute :symbol_class, SymbolClass.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, symbol_class: nil)
    end
    begin
      value = SymbolClass.from_dynamic!(d)
      if schema.key(:symbol_class).type.right.valid? value
        return new(symbol_class: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif symbol_class != nil
      symbol_class.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Synchronized < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionSynchronized < Dry::Struct
  attribute :double,       Types::Double.optional
  attribute :synchronized, Synchronized.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, synchronized: nil)
    end
    begin
      value = Synchronized.from_dynamic!(d)
      if schema.key(:synchronized).type.right.valid? value
        return new(synchronized: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif synchronized != nil
      synchronized.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Template < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionTemplate < Dry::Struct
  attribute :double,   Types::Double.optional
  attribute :template, Template.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, template: nil)
    end
    begin
      value = Template.from_dynamic!(d)
      if schema.key(:template).type.right.valid? value
        return new(template: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif template != nil
      template.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TextNode < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionTextNode < Dry::Struct
  attribute :double,    Types::Double.optional
  attribute :text_node, TextNode.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, text_node: nil)
    end
    begin
      value = TextNode.from_dynamic!(d)
      if schema.key(:text_node).type.right.valid? value
        return new(text_node: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif text_node != nil
      text_node.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class This < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionThis < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :this,   This.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, this: nil)
    end
    begin
      value = This.from_dynamic!(d)
      if schema.key(:this).type.right.valid? value
        return new(this: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif this != nil
      this.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ThreadLocal < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionThreadLocal < Dry::Struct
  attribute :double,       Types::Double.optional
  attribute :thread_local, ThreadLocal.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, thread_local: nil)
    end
    begin
      value = ThreadLocal.from_dynamic!(d)
      if schema.key(:thread_local).type.right.valid? value
        return new(thread_local: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif thread_local != nil
      thread_local.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Throws < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionThrows < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :throws, Throws.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, throws: nil)
    end
    begin
      value = Throws.from_dynamic!(d)
      if schema.key(:throws).type.right.valid? value
        return new(throws: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif throws != nil
      throws.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TimeOnly < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionTimeOnly < Dry::Struct
  attribute :double,    Types::Double.optional
  attribute :time_only, TimeOnly.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, time_only: nil)
    end
    begin
      value = TimeOnly.from_dynamic!(d)
      if schema.key(:time_only).type.right.valid? value
        return new(time_only: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif time_only != nil
      time_only.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TimeOnlyConverter < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionTimeOnlyConverter < Dry::Struct
  attribute :double,              Types::Double.optional
  attribute :time_only_converter, TimeOnlyConverter.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, time_only_converter: nil)
    end
    begin
      value = TimeOnlyConverter.from_dynamic!(d)
      if schema.key(:time_only_converter).type.right.valid? value
        return new(time_only_converter: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif time_only_converter != nil
      time_only_converter.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TimeZone < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionTimeZone < Dry::Struct
  attribute :double,    Types::Double.optional
  attribute :time_zone, TimeZone.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, time_zone: nil)
    end
    begin
      value = TimeZone.from_dynamic!(d)
      if schema.key(:time_zone).type.right.valid? value
        return new(time_zone: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif time_zone != nil
      time_zone.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ToDict < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionToDict < Dry::Struct
  attribute :double,  Types::Double.optional
  attribute :to_dict, ToDict.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, to_dict: nil)
    end
    begin
      value = ToDict.from_dynamic!(d)
      if schema.key(:to_dict).type.right.valid? value
        return new(to_dict: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif to_dict != nil
      to_dict.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ToString < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionToString < Dry::Struct
  attribute :double,    Types::Double.optional
  attribute :to_string, ToString.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, to_string: nil)
    end
    begin
      value = ToString.from_dynamic!(d)
      if schema.key(:to_string).type.right.valid? value
        return new(to_string: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif to_string != nil
      to_string.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevelClass < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionTopLevel < Dry::Struct
  attribute :double,          Types::Double.optional
  attribute :top_level_class, TopLevelClass.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, top_level_class: nil)
    end
    begin
      value = TopLevelClass.from_dynamic!(d)
      if schema.key(:top_level_class).type.right.valid? value
        return new(top_level_class: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif top_level_class != nil
      top_level_class.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class And < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionAnd < Dry::Struct
  attribute :and_1,  And.optional
  attribute :double, Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = And.from_dynamic!(d)
      if schema.key(:and_1).type.right.valid? value
        return new(and_1: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, and_1: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if and_1 != nil
      and_1.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class AnyClass < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionAnyUnion < Dry::Struct
  attribute :any_class, AnyClass.optional
  attribute :double,    Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = AnyClass.from_dynamic!(d)
      if schema.key(:any_class).type.right.valid? value
        return new(any_class: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, any_class: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if any_class != nil
      any_class.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class BoolClass < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionBool < Dry::Struct
  attribute :bool_class, BoolClass.optional
  attribute :double,     Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = BoolClass.from_dynamic!(d)
      if schema.key(:bool_class).type.right.valid? value
        return new(bool_class: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, bool_class: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if bool_class != nil
      bool_class.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Break < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionBreak < Dry::Struct
  attribute :break_1, Break.optional
  attribute :double,  Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = Break.from_dynamic!(d)
      if schema.key(:break_1).type.right.valid? value
        return new(break_1: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, break_1: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if break_1 != nil
      break_1.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Case < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionCase < Dry::Struct
  attribute :case_1, Case.optional
  attribute :double, Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = Case.from_dynamic!(d)
      if schema.key(:case_1).type.right.valid? value
        return new(case_1: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, case_1: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if case_1 != nil
      case_1.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Catch < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionCatch < Dry::Struct
  attribute :catch_1, Catch.optional
  attribute :double,  Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = Catch.from_dynamic!(d)
      if schema.key(:catch_1).type.right.valid? value
        return new(catch_1: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, catch_1: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if catch_1 != nil
      catch_1.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ClassClass < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionClass < Dry::Struct
  attribute :class_class, ClassClass.optional
  attribute :double,      Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = ClassClass.from_dynamic!(d)
      if schema.key(:class_class).type.right.valid? value
        return new(class_class: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, class_class: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if class_class != nil
      class_class.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Clone < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionClone < Dry::Struct
  attribute :clone_1, Clone.optional
  attribute :double,  Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = Clone.from_dynamic!(d)
      if schema.key(:clone_1).type.right.valid? value
        return new(clone_1: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, clone_1: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if clone_1 != nil
      clone_1.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ConstructorClass < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionConstructor < Dry::Struct
  attribute :constructor_class, ConstructorClass.optional
  attribute :double,            Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = ConstructorClass.from_dynamic!(d)
      if schema.key(:constructor_class).type.right.valid? value
        return new(constructor_class: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, constructor_class: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if constructor_class != nil
      constructor_class.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Def < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionDef < Dry::Struct
  attribute :def_1,  Def.optional
  attribute :double, Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = Def.from_dynamic!(d)
      if schema.key(:def_1).type.right.valid? value
        return new(def_1: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, def_1: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if def_1 != nil
      def_1.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Default < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionDefault < Dry::Struct
  attribute :default_1, Default.optional
  attribute :double,    Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = Default.from_dynamic!(d)
      if schema.key(:default_1).type.right.valid? value
        return new(default_1: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, default_1: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if default_1 != nil
      default_1.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Do < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionDo < Dry::Struct
  attribute :do_1,   Do.optional
  attribute :double, Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = Do.from_dynamic!(d)
      if schema.key(:do_1).type.right.valid? value
        return new(do_1: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, do_1: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if do_1 != nil
      do_1.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Else < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionElse < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :else_1, Else.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, else_1: nil)
    end
    begin
      value = Else.from_dynamic!(d)
      if schema.key(:else_1).type.right.valid? value
        return new(else_1: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif else_1 != nil
      else_1.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Enum < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionEnum < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :enum_1, Enum.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, enum_1: nil)
    end
    begin
      value = Enum.from_dynamic!(d)
      if schema.key(:enum_1).type.right.valid? value
        return new(enum_1: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif enum_1 != nil
      enum_1.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class False < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionFalse < Dry::Struct
  attribute :double,  Types::Double.optional
  attribute :false_1, False.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, false_1: nil)
    end
    begin
      value = False.from_dynamic!(d)
      if schema.key(:false_1).type.right.valid? value
        return new(false_1: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif false_1 != nil
      false_1.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class For < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionFor < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :for_1,  For.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, for_1: nil)
    end
    begin
      value = For.from_dynamic!(d)
      if schema.key(:for_1).type.right.valid? value
        return new(for_1: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif for_1 != nil
      for_1.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class If < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionIf < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :if_1,   If.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, if_1: nil)
    end
    begin
      value = If.from_dynamic!(d)
      if schema.key(:if_1).type.right.valid? value
        return new(if_1: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif if_1 != nil
      if_1.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class In < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionIn < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :in_1,   In.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, in_1: nil)
    end
    begin
      value = In.from_dynamic!(d)
      if schema.key(:in_1).type.right.valid? value
        return new(in_1: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif in_1 != nil
      in_1.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Lambda < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionLambda < Dry::Struct
  attribute :double,   Types::Double.optional
  attribute :lambda_1, Lambda.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, lambda_1: nil)
    end
    begin
      value = Lambda.from_dynamic!(d)
      if schema.key(:lambda_1).type.right.valid? value
        return new(lambda_1: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif lambda_1 != nil
      lambda_1.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ModuleClass < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionModule < Dry::Struct
  attribute :double,       Types::Double.optional
  attribute :module_class, ModuleClass.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, module_class: nil)
    end
    begin
      value = ModuleClass.from_dynamic!(d)
      if schema.key(:module_class).type.right.valid? value
        return new(module_class: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif module_class != nil
      module_class.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class New < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionNew < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :new_1,  New.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, new_1: nil)
    end
    begin
      value = New.from_dynamic!(d)
      if schema.key(:new_1).type.right.valid? value
        return new(new_1: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif new_1 != nil
      new_1.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Nil < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionNil < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :nil_1,  Nil.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, nil_1: nil)
    end
    begin
      value = Nil.from_dynamic!(d)
      if schema.key(:nil_1).type.right.valid? value
        return new(nil_1: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif nil_1 != nil
      nil_1.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class NoneClass < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionNoneUnion < Dry::Struct
  attribute :double,     Types::Double.optional
  attribute :none_class, NoneClass.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, none_class: nil)
    end
    begin
      value = NoneClass.from_dynamic!(d)
      if schema.key(:none_class).type.right.valid? value
        return new(none_class: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif none_class != nil
      none_class.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Not < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionNot < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :not_1,  Not.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, not_1: nil)
    end
    begin
      value = Not.from_dynamic!(d)
      if schema.key(:not_1).type.right.valid? value
        return new(not_1: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif not_1 != nil
      not_1.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class NullClass < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionNull < Dry::Struct
  attribute :double,     Types::Double.optional
  attribute :null_class, NullClass.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, null_class: nil)
    end
    begin
      value = NullClass.from_dynamic!(d)
      if schema.key(:null_class).type.right.valid? value
        return new(null_class: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif null_class != nil
      null_class.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Open < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionOpen < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :open_1, Open.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, open_1: nil)
    end
    begin
      value = Open.from_dynamic!(d)
      if schema.key(:open_1).type.right.valid? value
        return new(open_1: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif open_1 != nil
      open_1.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Optional < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionOptional < Dry::Struct
  attribute :double,     Types::Double.optional
  attribute :optional_1, Optional.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, optional_1: nil)
    end
    begin
      value = Optional.from_dynamic!(d)
      if schema.key(:optional_1).type.right.valid? value
        return new(optional_1: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif optional_1 != nil
      optional_1.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Or < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionOr < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :or_1,   Or.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, or_1: nil)
    end
    begin
      value = Or.from_dynamic!(d)
      if schema.key(:or_1).type.right.valid? value
        return new(or_1: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif or_1 != nil
      or_1.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Print < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionPrint < Dry::Struct
  attribute :double,  Types::Double.optional
  attribute :print_1, Print.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, print_1: nil)
    end
    begin
      value = Print.from_dynamic!(d)
      if schema.key(:print_1).type.right.valid? value
        return new(print_1: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif print_1 != nil
      print_1.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Printf < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionPrintf < Dry::Struct
  attribute :double,   Types::Double.optional
  attribute :printf_1, Printf.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, printf_1: nil)
    end
    begin
      value = Printf.from_dynamic!(d)
      if schema.key(:printf_1).type.right.valid? value
        return new(printf_1: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif printf_1 != nil
      printf_1.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ProtocolClass < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionProtocolUnion < Dry::Struct
  attribute :double,         Types::Double.optional
  attribute :protocol_class, ProtocolClass.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, protocol_class: nil)
    end
    begin
      value = ProtocolClass.from_dynamic!(d)
      if schema.key(:protocol_class).type.right.valid? value
        return new(protocol_class: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif protocol_class != nil
      protocol_class.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Raise < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionRaise < Dry::Struct
  attribute :double,  Types::Double.optional
  attribute :raise_1, Raise.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, raise_1: nil)
    end
    begin
      value = Raise.from_dynamic!(d)
      if schema.key(:raise_1).type.right.valid? value
        return new(raise_1: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif raise_1 != nil
      raise_1.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Require < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionRequire < Dry::Struct
  attribute :double,    Types::Double.optional
  attribute :require_1, Require.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, require_1: nil)
    end
    begin
      value = Require.from_dynamic!(d)
      if schema.key(:require_1).type.right.valid? value
        return new(require_1: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif require_1 != nil
      require_1.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Return < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionReturn < Dry::Struct
  attribute :double,   Types::Double.optional
  attribute :return_1, Return.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, return_1: nil)
    end
    begin
      value = Return.from_dynamic!(d)
      if schema.key(:return_1).type.right.valid? value
        return new(return_1: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif return_1 != nil
      return_1.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Select < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionSelect < Dry::Struct
  attribute :double,   Types::Double.optional
  attribute :select_1, Select.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, select_1: nil)
    end
    begin
      value = Select.from_dynamic!(d)
      if schema.key(:select_1).type.right.valid? value
        return new(select_1: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif select_1 != nil
      select_1.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class SelfClass < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionSelf < Dry::Struct
  attribute :double,     Types::Double.optional
  attribute :self_class, SelfClass.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, self_class: nil)
    end
    begin
      value = SelfClass.from_dynamic!(d)
      if schema.key(:self_class).type.right.valid? value
        return new(self_class: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif self_class != nil
      self_class.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Super < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionSuper < Dry::Struct
  attribute :double,  Types::Double.optional
  attribute :super_1, Super.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, super_1: nil)
    end
    begin
      value = Super.from_dynamic!(d)
      if schema.key(:super_1).type.right.valid? value
        return new(super_1: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif super_1 != nil
      super_1.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class System < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionSystem < Dry::Struct
  attribute :double,   Types::Double.optional
  attribute :system_1, System.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, system_1: nil)
    end
    begin
      value = System.from_dynamic!(d)
      if schema.key(:system_1).type.right.valid? value
        return new(system_1: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif system_1 != nil
      system_1.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Then < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionThen < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :then_1, Then.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, then_1: nil)
    end
    begin
      value = Then.from_dynamic!(d)
      if schema.key(:then_1).type.right.valid? value
        return new(then_1: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif then_1 != nil
      then_1.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Throw < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionThrow < Dry::Struct
  attribute :double,  Types::Double.optional
  attribute :throw_1, Throw.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, throw_1: nil)
    end
    begin
      value = Throw.from_dynamic!(d)
      if schema.key(:throw_1).type.right.valid? value
        return new(throw_1: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif throw_1 != nil
      throw_1.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ToJSON < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionToJSON < Dry::Struct
  attribute :double,    Types::Double.optional
  attribute :to_json_1, ToJSON.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, to_json_1: nil)
    end
    begin
      value = ToJSON.from_dynamic!(d)
      if schema.key(:to_json_1).type.right.valid? value
        return new(to_json_1: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif to_json_1 != nil
      to_json_1.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class True < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionTrue < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :true_1, True.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, true_1: nil)
    end
    begin
      value = True.from_dynamic!(d)
      if schema.key(:true_1).type.right.valid? value
        return new(true_1: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif true_1 != nil
      true_1.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Try < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionTry < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :try_1,  Try.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, try_1: nil)
    end
    begin
      value = Try.from_dynamic!(d)
      if schema.key(:try_1).type.right.valid? value
        return new(try_1: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif try_1 != nil
      try_1.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Type < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionType < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :type_1, Type.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, type_1: nil)
    end
    begin
      value = Type.from_dynamic!(d)
      if schema.key(:type_1).type.right.valid? value
        return new(type_1: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif type_1 != nil
      type_1.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class While < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionWhile < Dry::Struct
  attribute :double,  Types::Double.optional
  attribute :while_1, While.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, while_1: nil)
    end
    begin
      value = While.from_dynamic!(d)
      if schema.key(:while_1).type.right.valid? value
        return new(while_1: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif while_1 != nil
      while_1.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class With < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionWith < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :with_1, With.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, with_1: nil)
    end
    begin
      value = With.from_dynamic!(d)
      if schema.key(:with_1).type.right.valid? value
        return new(with_1: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif with_1 != nil
      with_1.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Yield < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionYield < Dry::Struct
  attribute :double,  Types::Double.optional
  attribute :yield_1, Yield.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, yield_1: nil)
    end
    begin
      value = Yield.from_dynamic!(d)
      if schema.key(:yield_1).type.right.valid? value
        return new(yield_1: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif yield_1 != nil
      yield_1.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Transient < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionTransient < Dry::Struct
  attribute :double,    Types::Double.optional
  attribute :transient, Transient.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, transient: nil)
    end
    begin
      value = Transient.from_dynamic!(d)
      if schema.key(:transient).type.right.valid? value
        return new(transient: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif transient != nil
      transient.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionTrueTrue < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionTrueUnion < Dry::Struct
  attribute :double,          Types::Double.optional
  attribute :union_true_true, UnionTrueTrue.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, union_true_true: nil)
    end
    begin
      value = UnionTrueTrue.from_dynamic!(d)
      if schema.key(:union_true_true).type.right.valid? value
        return new(union_true_true: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif union_true_true != nil
      union_true_true.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TypeClass < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionTypeUnion < Dry::Struct
  attribute :double,     Types::Double.optional
  attribute :type_class, TypeClass.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, type_class: nil)
    end
    begin
      value = TypeClass.from_dynamic!(d)
      if schema.key(:type_class).type.right.valid? value
        return new(type_class: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif type_class != nil
      type_class.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Typealias < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionTypealias < Dry::Struct
  attribute :double,    Types::Double.optional
  attribute :typealias, Typealias.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, typealias: nil)
    end
    begin
      value = Typealias.from_dynamic!(d)
      if schema.key(:typealias).type.right.valid? value
        return new(typealias: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif typealias != nil
      typealias.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Typedef < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionTypedef < Dry::Struct
  attribute :double,  Types::Double.optional
  attribute :typedef, Typedef.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, typedef: nil)
    end
    begin
      value = Typedef.from_dynamic!(d)
      if schema.key(:typedef).type.right.valid? value
        return new(typedef: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif typedef != nil
      typedef.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Typeid < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionTypeid < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :typeid, Typeid.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, typeid: nil)
    end
    begin
      value = Typeid.from_dynamic!(d)
      if schema.key(:typeid).type.right.valid? value
        return new(typeid: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif typeid != nil
      typeid.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Typename < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionTypename < Dry::Struct
  attribute :double,   Types::Double.optional
  attribute :typename, Typename.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, typename: nil)
    end
    begin
      value = Typename.from_dynamic!(d)
      if schema.key(:typename).type.right.valid? value
        return new(typename: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif typename != nil
      typename.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Typeof < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionTypeof < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :typeof, Typeof.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, typeof: nil)
    end
    begin
      value = Typeof.from_dynamic!(d)
      if schema.key(:typeof).type.right.valid? value
        return new(typeof: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif typeof != nil
      typeof.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Uint < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionUint < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :uint,   Uint.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, uint: nil)
    end
    begin
      value = Uint.from_dynamic!(d)
      if schema.key(:uint).type.right.valid? value
        return new(uint: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif uint != nil
      uint.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Ulong < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionUlong < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :ulong,  Ulong.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, ulong: nil)
    end
    begin
      value = Ulong.from_dynamic!(d)
      if schema.key(:ulong).type.right.valid? value
        return new(ulong: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif ulong != nil
      ulong.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Unchecked < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionUnchecked < Dry::Struct
  attribute :double,    Types::Double.optional
  attribute :unchecked, Unchecked.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, unchecked: nil)
    end
    begin
      value = Unchecked.from_dynamic!(d)
      if schema.key(:unchecked).type.right.valid? value
        return new(unchecked: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif unchecked != nil
      unchecked.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UndefinedClass < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionUndefined < Dry::Struct
  attribute :double,          Types::Double.optional
  attribute :undefined_class, UndefinedClass.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, undefined_class: nil)
    end
    begin
      value = UndefinedClass.from_dynamic!(d)
      if schema.key(:undefined_class).type.right.valid? value
        return new(undefined_class: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif undefined_class != nil
      undefined_class.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Union < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionUnionUnion < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :union,  Union.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, union: nil)
    end
    begin
      value = Union.from_dynamic!(d)
      if schema.key(:union).type.right.valid? value
        return new(union: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif union != nil
      union.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnmarshalJSON < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionUnmarshalJSON < Dry::Struct
  attribute :double,         Types::Double.optional
  attribute :unmarshal_json, UnmarshalJSON.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, unmarshal_json: nil)
    end
    begin
      value = UnmarshalJSON.from_dynamic!(d)
      if schema.key(:unmarshal_json).type.right.valid? value
        return new(unmarshal_json: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif unmarshal_json != nil
      unmarshal_json.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Unowned < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionUnowned < Dry::Struct
  attribute :double,  Types::Double.optional
  attribute :unowned, Unowned.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, unowned: nil)
    end
    begin
      value = Unowned.from_dynamic!(d)
      if schema.key(:unowned).type.right.valid? value
        return new(unowned: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif unowned != nil
      unowned.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Unsafe < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionUnsafe < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :unsafe, Unsafe.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, unsafe: nil)
    end
    begin
      value = Unsafe.from_dynamic!(d)
      if schema.key(:unsafe).type.right.valid? value
        return new(unsafe: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif unsafe != nil
      unsafe.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Unsigned < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionUnsigned < Dry::Struct
  attribute :double,   Types::Double.optional
  attribute :unsigned, Unsigned.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, unsigned: nil)
    end
    begin
      value = Unsigned.from_dynamic!(d)
      if schema.key(:unsigned).type.right.valid? value
        return new(unsigned: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif unsigned != nil
      unsigned.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UseSerializers < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionUseSerializers < Dry::Struct
  attribute :double,          Types::Double.optional
  attribute :use_serializers, UseSerializers.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, use_serializers: nil)
    end
    begin
      value = UseSerializers.from_dynamic!(d)
      if schema.key(:use_serializers).type.right.valid? value
        return new(use_serializers: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif use_serializers != nil
      use_serializers.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Ushort < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionUshort < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :ushort, Ushort.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, ushort: nil)
    end
    begin
      value = Ushort.from_dynamic!(d)
      if schema.key(:ushort).type.right.valid? value
        return new(ushort: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif ushort != nil
      ushort.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Using < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionUsing < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :using,  Using.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, using: nil)
    end
    begin
      value = Using.from_dynamic!(d)
      if schema.key(:using).type.right.valid? value
        return new(using: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif using != nil
      using.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Utf8JSONReader < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionUtf8JSONReader < Dry::Struct
  attribute :double,           Types::Double.optional
  attribute :utf8_json_reader, Utf8JSONReader.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, utf8_json_reader: nil)
    end
    begin
      value = Utf8JSONReader.from_dynamic!(d)
      if schema.key(:utf8_json_reader).type.right.valid? value
        return new(utf8_json_reader: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif utf8_json_reader != nil
      utf8_json_reader.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Utf8JSONWriter < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionUtf8JSONWriter < Dry::Struct
  attribute :double,           Types::Double.optional
  attribute :utf8_json_writer, Utf8JSONWriter.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, utf8_json_writer: nil)
    end
    begin
      value = Utf8JSONWriter.from_dynamic!(d)
      if schema.key(:utf8_json_writer).type.right.valid? value
        return new(utf8_json_writer: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif utf8_json_writer != nil
      utf8_json_writer.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UUID < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionUUID < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :uuid,   UUID.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, uuid: nil)
    end
    begin
      value = UUID.from_dynamic!(d)
      if schema.key(:uuid).type.right.valid? value
        return new(uuid: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif uuid != nil
      uuid.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Var < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionVar < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :var,    Var.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, var: nil)
    end
    begin
      value = Var.from_dynamic!(d)
      if schema.key(:var).type.right.valid? value
        return new(var: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif var != nil
      var.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Virtual < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionVirtual < Dry::Struct
  attribute :double,  Types::Double.optional
  attribute :virtual, Virtual.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, virtual: nil)
    end
    begin
      value = Virtual.from_dynamic!(d)
      if schema.key(:virtual).type.right.valid? value
        return new(virtual: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif virtual != nil
      virtual.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Void < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionVoid < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :void,   Void.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, void: nil)
    end
    begin
      value = Void.from_dynamic!(d)
      if schema.key(:void).type.right.valid? value
        return new(void: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif void != nil
      void.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Volatile < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionVolatile < Dry::Struct
  attribute :double,   Types::Double.optional
  attribute :volatile, Volatile.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, volatile: nil)
    end
    begin
      value = Volatile.from_dynamic!(d)
      if schema.key(:volatile).type.right.valid? value
        return new(volatile: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif volatile != nil
      volatile.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class WcharT < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionWcharT < Dry::Struct
  attribute :double,  Types::Double.optional
  attribute :wchar_t, WcharT.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, wchar_t: nil)
    end
    begin
      value = WcharT.from_dynamic!(d)
      if schema.key(:wchar_t).type.right.valid? value
        return new(wchar_t: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif wchar_t != nil
      wchar_t.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Weak < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionWeak < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :weak,   Weak.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, weak: nil)
    end
    begin
      value = Weak.from_dynamic!(d)
      if schema.key(:weak).type.right.valid? value
        return new(weak: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif weak != nil
      weak.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Where < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionWhere < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :where,  Where.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, where: nil)
    end
    begin
      value = Where.from_dynamic!(d)
      if schema.key(:where).type.right.valid? value
        return new(where: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif where != nil
      where.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class WillSet < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionWillSet < Dry::Struct
  attribute :double,   Types::Double.optional
  attribute :will_set, WillSet.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, will_set: nil)
    end
    begin
      value = WillSet.from_dynamic!(d)
      if schema.key(:will_set).type.right.valid? value
        return new(will_set: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif will_set != nil
      will_set.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Xor < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionXor < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :xor,    Xor.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, xor: nil)
    end
    begin
      value = Xor.from_dynamic!(d)
      if schema.key(:xor).type.right.valid? value
        return new(xor: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif xor != nil
      xor.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class XorEq < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionXorEq < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :xor_eq, XorEq.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, xor_eq: nil)
    end
    begin
      value = XorEq.from_dynamic!(d)
      if schema.key(:xor_eq).type.right.valid? value
        return new(xor_eq: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif xor_eq != nil
      xor_eq.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Yes < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionYES < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :yes,    Yes.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, yes: nil)
    end
    begin
      value = Yes.from_dynamic!(d)
      if schema.key(:yes).type.right.valid? value
        return new(yes: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif yes != nil
      yes.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :empty,                          Types.Instance(UnionUnion).optional
  attribute :top_level_bool,                 Types.Instance(UnionBool).optional
  attribute :complex,                        Types.Instance(UnionComplex).optional
  attribute :imaginery,                      Types.Instance(UnionImaginery).optional
  attribute :abstract,                       Types.Instance(UnionAbstract).optional
  attribute :alignas,                        Types.Instance(UnionAlignas).optional
  attribute :alignof,                        Types.Instance(UnionAlignof).optional
  attribute :top_level_and,                  Types.Instance(UnionAnd).optional
  attribute :and_eq,                         Types.Instance(UnionAndEq).optional
  attribute :top_level_any,                  Types.Instance(UnionAnyUnion).optional
  attribute :any,                            Types.Instance(UnionAny).optional
  attribute :array,                          Types.Instance(UnionArray).optional
  attribute :array_node,                     Types.Instance(UnionArrayNode).optional
  attribute :as,                             Types.Instance(UnionAs).optional
  attribute :asm,                            Types.Instance(UnionASM).optional
  attribute :assert,                         Types.Instance(UnionAssert).optional
  attribute :associatedtype,                 Types.Instance(UnionAssociatedtype).optional
  attribute :associativity,                  Types.Instance(UnionAssociativity).optional
  attribute :async,                          Types.Instance(UnionAsync).optional
  attribute :atomic,                         Types.Instance(UnionAtomic).optional
  attribute :atomic_cancel,                  Types.Instance(UnionAtomicCancel).optional
  attribute :atomic_commit,                  Types.Instance(UnionAtomicCommit).optional
  attribute :atomic_noexcept,                Types.Instance(UnionAtomicNoexcept).optional
  attribute :auto,                           Types.Instance(UnionAuto).optional
  attribute :await,                          Types.Instance(UnionAwait).optional
  attribute :base,                           Types.Instance(UnionBase).optional
  attribute :bitand,                         Types.Instance(UnionBitand).optional
  attribute :bitor,                          Types.Instance(UnionBitor).optional
  attribute :bool,                           Types.Instance(UnionBOOL).optional
  attribute :bool_1,                         Types.Instance(UnionBoolUnion).optional
  attribute :boolean,                        Types.Instance(UnionBoolean).optional
  attribute :boolean_node,                   Types.Instance(UnionBooleanNode).optional
  attribute :top_level_break,                Types.Instance(UnionBreak).optional
  attribute :bycopy,                         Types.Instance(UnionBycopy).optional
  attribute :byref,                          Types.Instance(UnionByref).optional
  attribute :byte,                           Types.Instance(UnionByte).optional
  attribute :calendar,                       Types.Instance(UnionCalendar).optional
  attribute :top_level_case,                 Types.Instance(UnionCase).optional
  attribute :top_level_catch,                Types.Instance(UnionCatch).optional
  attribute :chan,                           Types.Instance(UnionChan).optional
  attribute :char,                           Types.Instance(UnionChar).optional
  attribute :char16_t,                       Types.Instance(UnionChar16T).optional
  attribute :char32_t,                       Types.Instance(UnionChar32T).optional
  attribute :checked,                        Types.Instance(UnionChecked).optional
  attribute :class_1,                        Types.Instance(UnionClassUnion).optional
  attribute :top_level_class,                Types.Instance(UnionClass).optional
  attribute :top_level_clone,                Types.Instance(UnionClone).optional
  attribute :co_await,                       Types.Instance(UnionCoAwait).optional
  attribute :co_return,                      Types.Instance(UnionCoReturn).optional
  attribute :co_yield,                       Types.Instance(UnionCoYield).optional
  attribute :codable,                        Types.Instance(UnionCodable).optional
  attribute :coding_key,                     Types.Instance(UnionCodingKey).optional
  attribute :coding_keys,                    Types.Instance(UnionCodingKeys).optional
  attribute :compl,                          Types.Instance(UnionCompl).optional
  attribute :concept,                        Types.Instance(UnionConcept).optional
  attribute :console,                        Types.Instance(UnionConsole).optional
  attribute :const,                          Types.Instance(UnionConst).optional
  attribute :const_cast,                     Types.Instance(UnionConstCast).optional
  attribute :constexpr,                      Types.Instance(UnionConstexpr).optional
  attribute :top_level_constructor,          Types.Instance(UnionConstructor).optional
  attribute :continue,                       Types.Instance(UnionContinue).optional
  attribute :convenience,                    Types.Instance(UnionConvenience).optional
  attribute :convert,                        Types.Instance(UnionConvert).optional
  attribute :converter,                      Types.Instance(UnionConverter).optional
  attribute :culture_info,                   Types.Instance(UnionCultureInfo).optional
  attribute :date,                           Types.Instance(UnionDate).optional
  attribute :date_parse_handling,            Types.Instance(UnionDateParseHandling).optional
  attribute :date_formatter,                 Types.Instance(UnionDateFormatter).optional
  attribute :date_only,                      Types.Instance(UnionDateOnly).optional
  attribute :date_only_converter,            Types.Instance(UnionDateOnlyConverter).optional
  attribute :date_time,                      Types.Instance(UnionDateTime).optional
  attribute :date_time_styles,               Types.Instance(UnionDateTimeStyles).optional
  attribute :debugger,                       Types.Instance(UnionDebugger).optional
  attribute :decimal,                        Types.Instance(UnionDecimal).optional
  attribute :declare,                        Types.Instance(UnionDeclare).optional
  attribute :decltype,                       Types.Instance(UnionDecltype).optional
  attribute :decode_string,                  Types.Instance(UnionDecodeString).optional
  attribute :decoder,                        Types.Instance(UnionDecoder).optional
  attribute :decoding_error,                 Types.Instance(UnionDecodingError).optional
  attribute :top_level_def,                  Types.Instance(UnionDef).optional
  attribute :top_level_default,              Types.Instance(UnionDefault).optional
  attribute :defer,                          Types.Instance(UnionDefer).optional
  attribute :deinit,                         Types.Instance(UnionDeinit).optional
  attribute :del,                            Types.Instance(UnionDel).optional
  attribute :delegate,                       Types.Instance(UnionDelegate).optional
  attribute :delete,                         Types.Instance(UnionDelete).optional
  attribute :deserialization_feature,        Types.Instance(UnionDeserializationFeature).optional
  attribute :dict,                           Types.Instance(UnionDict).optional
  attribute :dictionary,                     Types.Instance(UnionDictionary).optional
  attribute :did_set,                        Types.Instance(UnionDidSet).optional
  attribute :top_level_do,                   Types.Instance(UnionDo).optional
  attribute :double,                         Types.Instance(UnionDouble).optional
  attribute :double_node,                    Types.Instance(UnionDoubleNode).optional
  attribute :dummy,                          Types::Double.optional
  attribute :dynamic,                        Types.Instance(UnionDynamic).optional
  attribute :dynamic_cast,                   Types.Instance(UnionDynamicCast).optional
  attribute :elif,                           Types.Instance(UnionElif).optional
  attribute :top_level_else,                 Types.Instance(UnionElse).optional
  attribute :encode_quick_type,              Types.Instance(UnionEncodeQuickType).optional
  attribute :encoder,                        Types.Instance(UnionEncoder).optional
  attribute :top_level_enum,                 Types.Instance(UnionEnum).optional
  attribute :enum_values,                    Types.Instance(UnionEnumValues).optional
  attribute :equality_contract,              Types.Instance(UnionEqualityContract).optional
  attribute :equatable,                      Types.Instance(UnionEquatable).optional
  attribute :event,                          Types.Instance(UnionEvent).optional
  attribute :except,                         Types.Instance(UnionExcept).optional
  attribute :exception,                      Types.Instance(UnionException).optional
  attribute :explicit,                       Types.Instance(UnionExplicit).optional
  attribute :export,                         Types.Instance(UnionExport).optional
  attribute :exposing,                       Types.Instance(UnionExposing).optional
  attribute :extends,                        Types.Instance(UnionExtends).optional
  attribute :extension,                      Types.Instance(UnionExtension).optional
  attribute :extern,                         Types.Instance(UnionExtern).optional
  attribute :fallthrough,                    Types.Instance(UnionFallthrough).optional
  attribute :false_1,                        Types.Instance(UnionFalseUnion).optional
  attribute :top_level_false,                Types.Instance(UnionFalse).optional
  attribute :fileprivate,                    Types.Instance(UnionFileprivate).optional
  attribute :final,                          Types.Instance(UnionFinal).optional
  attribute :finally,                        Types.Instance(UnionFinally).optional
  attribute :fixed,                          Types.Instance(UnionFixed).optional
  attribute :float,                          Types.Instance(UnionFloat).optional
  attribute :top_level_for,                  Types.Instance(UnionFor).optional
  attribute :foreach,                        Types.Instance(UnionForeach).optional
  attribute :format_exception,               Types.Instance(UnionFormatException).optional
  attribute :friend,                         Types.Instance(UnionFriend).optional
  attribute :from,                           Types.Instance(UnionFrom).optional
  attribute :from_dict,                      Types.Instance(UnionFromDict).optional
  attribute :from_json,                      Types.Instance(UnionFromJSON).optional
  attribute :func,                           Types.Instance(UnionFunc).optional
  attribute :function,                       Types.Instance(UnionFunction).optional
  attribute :get,                            Types.Instance(UnionGet).optional
  attribute :global,                         Types.Instance(UnionGlobal).optional
  attribute :go,                             Types.Instance(UnionGo).optional
  attribute :goto,                           Types.Instance(UnionGoto).optional
  attribute :guard,                          Types.Instance(UnionGuard).optional
  attribute :hashable,                       Types.Instance(UnionHashable).optional
  attribute :hash_code,                      Types.Instance(UnionHashCode).optional
  attribute :hasher,                         Types.Instance(UnionHasher).optional
  attribute :has_own_property,               Types.Instance(UnionHasOwnProperty).optional
  attribute :id,                             Types.Instance(UnionID).optional
  attribute :top_level_if,                   Types.Instance(UnionIf).optional
  attribute :imp,                            Types.Instance(UnionIMP).optional
  attribute :implements,                     Types.Instance(UnionImplements).optional
  attribute :implicit,                       Types.Instance(UnionImplicit).optional
  attribute :import,                         Types.Instance(UnionImport).optional
  attribute :top_level_in,                   Types.Instance(UnionIn).optional
  attribute :indirect,                       Types.Instance(UnionIndirect).optional
  attribute :infix,                          Types.Instance(UnionInfix).optional
  attribute :init,                           Types.Instance(UnionInit).optional
  attribute :inline,                         Types.Instance(UnionInline).optional
  attribute :inout,                          Types.Instance(UnionInout).optional
  attribute :instanceof,                     Types.Instance(UnionInstanceof).optional
  attribute :int,                            Types.Instance(UnionInt).optional
  attribute :interface,                      Types.Instance(UnionInterface).optional
  attribute :internal,                       Types.Instance(UnionInternal).optional
  attribute :int_node,                       Types.Instance(UnionIntNode).optional
  attribute :is,                             Types.Instance(UnionIs).optional
  attribute :iso_date_time_offset_converter, Types.Instance(UnionISODateTimeOffsetConverter).optional
  attribute :iterable,                       Types.Instance(UnionIterable).optional
  attribute :jdec,                           Types.Instance(UnionJdec).optional
  attribute :jenc,                           Types.Instance(UnionJenc).optional
  attribute :jpipe,                          Types.Instance(UnionJpipe).optional
  attribute :json,                           Types.Instance(UnionJSON).optional
  attribute :json_converter,                 Types.Instance(UnionJSONConverter).optional
  attribute :json_serializer,                Types.Instance(UnionJSONSerializer).optional
  attribute :json_token,                     Types.Instance(UnionJSONToken).optional
  attribute :json_writer,                    Types.Instance(UnionJSONWriter).optional
  attribute :json_any,                       Types.Instance(UnionJSONAny).optional
  attribute :json_coding_key,                Types.Instance(UnionJSONCodingKey).optional
  attribute :json_decoder,                   Types.Instance(UnionJSONDecoder).optional
  attribute :json_encoder,                   Types.Instance(UnionJSONEncoder).optional
  attribute :json_exception,                 Types.Instance(UnionJSONException).optional
  attribute :json_generator,                 Types.Instance(UnionJSONGenerator).optional
  attribute :json_node,                      Types.Instance(UnionJSONNode).optional
  attribute :json_null,                      Types.Instance(UnionJSONNull).optional
  attribute :json_parser,                    Types.Instance(UnionJSONParser).optional
  attribute :json_reader,                    Types.Instance(UnionJSONReader).optional
  attribute :json_token_type,                Types.Instance(UnionJSONTokenType).optional
  attribute :k_serializer,                   Types.Instance(UnionKSerializer).optional
  attribute :top_level_lambda,               Types.Instance(UnionLambda).optional
  attribute :lazy,                           Types.Instance(UnionLazy).optional
  attribute :left,                           Types.Instance(UnionLeft).optional
  attribute :let,                            Types.Instance(UnionLet).optional
  attribute :list,                           Types.Instance(UnionList).optional
  attribute :local_date,                     Types.Instance(UnionLocalDate).optional
  attribute :locale,                         Types.Instance(UnionLocale).optional
  attribute :lock,                           Types.Instance(UnionLock).optional
  attribute :long,                           Types.Instance(UnionLong).optional
  attribute :long_node,                      Types.Instance(UnionLongNode).optional
  attribute :map,                            Types.Instance(UnionMap).optional
  attribute :map_entry,                      Types.Instance(UnionMapEntry).optional
  attribute :marshal_json,                   Types.Instance(UnionMarshalJSON).optional
  attribute :metadata_property_handling,     Types.Instance(UnionMetadataPropertyHandling).optional
  attribute :top_level_module,               Types.Instance(UnionModule).optional
  attribute :mutable,                        Types.Instance(UnionMutable).optional
  attribute :mutating,                       Types.Instance(UnionMutating).optional
  attribute :namespace,                      Types.Instance(UnionNamespace).optional
  attribute :native,                         Types.Instance(UnionNative).optional
  attribute :top_level_new,                  Types.Instance(UnionNew).optional
  attribute :newtonsoft,                     Types.Instance(UnionNewtonsoft).optional
  attribute :top_level_nil,                  Types.Instance(UnionNil).optional
  attribute :no,                             Types.Instance(UnionNO).optional
  attribute :noexcept,                       Types.Instance(UnionNoexcept).optional
  attribute :nonatomic,                      Types.Instance(UnionNonatomic).optional
  attribute :top_level_none,                 Types.Instance(UnionNoneUnion).optional
  attribute :none,                           Types.Instance(UnionNone).optional
  attribute :nonlocal,                       Types.Instance(UnionNonlocal).optional
  attribute :nonmutating,                    Types.Instance(UnionNonmutating).optional
  attribute :no_such_method,                 Types.Instance(UnionNoSuchMethod).optional
  attribute :top_level_not,                  Types.Instance(UnionNot).optional
  attribute :not_eq,                         Types.Instance(UnionNotEq).optional
  attribute :ns_error,                       Types.Instance(UnionNSError).optional
  attribute :ns_object,                      Types.Instance(UnionNSObject).optional
  attribute :ns_string,                      Types.Instance(UnionNSString).optional
  attribute :null,                           Types.Instance(UnionNULL).optional
  attribute :top_level_null,                 Types.Instance(UnionNull).optional
  attribute :null_node,                      Types.Instance(UnionNullNode).optional
  attribute :nullptr,                        Types.Instance(UnionNullptr).optional
  attribute :number,                         Types.Instance(UnionNumber).optional
  attribute :object,                         Types.Instance(UnionObject).optional
  attribute :object_mapper,                  Types.Instance(UnionObjectMapper).optional
  attribute :object_node,                    Types.Instance(UnionObjectNode).optional
  attribute :object_reader,                  Types.Instance(UnionObjectReader).optional
  attribute :object_writer,                  Types.Instance(UnionObjectWriter).optional
  attribute :of,                             Types.Instance(UnionOf).optional
  attribute :offset_date_time,               Types.Instance(UnionOffsetDateTime).optional
  attribute :offset_time,                    Types.Instance(UnionOffsetTime).optional
  attribute :oneway,                         Types.Instance(UnionOneway).optional
  attribute :top_level_open,                 Types.Instance(UnionOpen).optional
  attribute :operator,                       Types.Instance(UnionOperator).optional
  attribute :top_level_optional,             Types.Instance(UnionOptional).optional
  attribute :top_level_or,                   Types.Instance(UnionOr).optional
  attribute :or_eq,                          Types.Instance(UnionOrEq).optional
  attribute :out,                            Types.Instance(UnionOut).optional
  attribute :override,                       Types.Instance(UnionOverride).optional
  attribute :package,                        Types.Instance(UnionPackage).optional
  attribute :params,                         Types.Instance(UnionParams).optional
  attribute :pass,                           Types.Instance(UnionPass).optional
  attribute :port,                           Types.Instance(UnionPort).optional
  attribute :postfix,                        Types.Instance(UnionPostfix).optional
  attribute :precedence,                     Types.Instance(UnionPrecedence).optional
  attribute :prefix,                         Types.Instance(UnionPrefix).optional
  attribute :primitive_kind,                 Types.Instance(UnionPrimitiveKind).optional
  attribute :top_level_print,                Types.Instance(UnionPrint).optional
  attribute :top_level_printf,               Types.Instance(UnionPrintf).optional
  attribute :print_members,                  Types.Instance(UnionPrintMembers).optional
  attribute :private,                        Types.Instance(UnionPrivate).optional
  attribute :protected,                      Types.Instance(UnionProtected).optional
  attribute :protocol,                       Types.Instance(UnionProtocol).optional
  attribute :top_level_protocol,             Types.Instance(UnionProtocolUnion).optional
  attribute :public,                         Types.Instance(UnionPublic).optional
  attribute :quicktype,                      Types.Instance(UnionQuicktype).optional
  attribute :top_level_raise,                Types.Instance(UnionRaise).optional
  attribute :range,                          Types.Instance(UnionRange).optional
  attribute :readonly,                       Types.Instance(UnionReadonly).optional
  attribute :ref,                            Types.Instance(UnionRef).optional
  attribute :reg_exp,                        Types.Instance(UnionRegExp).optional
  attribute :register,                       Types.Instance(UnionRegister).optional
  attribute :reinterpret_cast,               Types.Instance(UnionReinterpretCast).optional
  attribute :repeat,                         Types.Instance(UnionRepeat).optional
  attribute :top_level_require,              Types.Instance(UnionRequire).optional
  attribute :required,                       Types.Instance(UnionRequired).optional
  attribute :requires,                       Types.Instance(UnionRequires).optional
  attribute :restrict,                       Types.Instance(UnionRestrict).optional
  attribute :retain,                         Types.Instance(UnionRetain).optional
  attribute :rethrows,                       Types.Instance(UnionRethrows).optional
  attribute :top_level_return,               Types.Instance(UnionReturn).optional
  attribute :right,                          Types.Instance(UnionRight).optional
  attribute :runtime_type,                   Types.Instance(UnionRuntimeType).optional
  attribute :s,                              Types.Instance(UnionS).optional
  attribute :sbyte,                          Types.Instance(UnionSbyte).optional
  attribute :sealed,                         Types.Instance(UnionSealed).optional
  attribute :sel,                            Types.Instance(UnionSEL).optional
  attribute :top_level_select,               Types.Instance(UnionSelect).optional
  attribute :top_level_self,                 Types.Instance(UnionSelf).optional
  attribute :self_1,                         Types.Instance(UnionSelfUnion).optional
  attribute :sendable,                       Types.Instance(UnionSendable).optional
  attribute :serial_descriptor,              Types.Instance(UnionSerialDescriptor).optional
  attribute :serializable,                   Types.Instance(UnionSerializable).optional
  attribute :serialization_feature,          Types.Instance(UnionSerializationFeature).optional
  attribute :serialize,                      Types.Instance(UnionSerialize).optional
  attribute :serializer_provider,            Types.Instance(UnionSerializerProvider).optional
  attribute :serial_name,                    Types.Instance(UnionSerialName).optional
  attribute :set,                            Types.Instance(UnionSet).optional
  attribute :short,                          Types.Instance(UnionShort).optional
  attribute :signed,                         Types.Instance(UnionSigned).optional
  attribute :simple_module,                  Types.Instance(UnionSimpleModule).optional
  attribute :sizeof,                         Types.Instance(UnionSizeof).optional
  attribute :stackalloc,                     Types.Instance(UnionStackalloc).optional
  attribute :standards,                      Types.Instance(UnionStandards).optional
  attribute :static,                         Types.Instance(UnionStatic).optional
  attribute :static_assert,                  Types.Instance(UnionStaticAssert).optional
  attribute :static_cast,                    Types.Instance(UnionStaticCast).optional
  attribute :std_deserializer,               Types.Instance(UnionStdDeserializer).optional
  attribute :std_serializer,                 Types.Instance(UnionStdSerializer).optional
  attribute :strictfp,                       Types.Instance(UnionStrictfp).optional
  attribute :string,                         Types.Instance(UnionString).optional
  attribute :struct,                         Types.Instance(UnionStruct).optional
  attribute :subscript,                      Types.Instance(UnionSubscript).optional
  attribute :top_level_super,                Types.Instance(UnionSuper).optional
  attribute :switch,                         Types.Instance(UnionSwitch).optional
  attribute :symbol,                         Types.Instance(UnionSymbol).optional
  attribute :synchronized,                   Types.Instance(UnionSynchronized).optional
  attribute :top_level_system,               Types.Instance(UnionSystem).optional
  attribute :template,                       Types.Instance(UnionTemplate).optional
  attribute :text_node,                      Types.Instance(UnionTextNode).optional
  attribute :top_level_then,                 Types.Instance(UnionThen).optional
  attribute :this,                           Types.Instance(UnionThis).optional
  attribute :thread_local,                   Types.Instance(UnionThreadLocal).optional
  attribute :top_level_throw,                Types.Instance(UnionThrow).optional
  attribute :throws,                         Types.Instance(UnionThrows).optional
  attribute :time_only,                      Types.Instance(UnionTimeOnly).optional
  attribute :time_only_converter,            Types.Instance(UnionTimeOnlyConverter).optional
  attribute :time_zone,                      Types.Instance(UnionTimeZone).optional
  attribute :to_dict,                        Types.Instance(UnionToDict).optional
  attribute :top_level_to_json,              Types.Instance(UnionToJSON).optional
  attribute :top_level,                      Types.Instance(UnionTopLevel).optional
  attribute :to_string,                      Types.Instance(UnionToString).optional
  attribute :transient,                      Types.Instance(UnionTransient).optional
  attribute :top_level_true,                 Types.Instance(UnionTrue).optional
  attribute :true_1,                         Types.Instance(UnionTrueUnion).optional
  attribute :top_level_try,                  Types.Instance(UnionTry).optional
  attribute :top_level_type,                 Types.Instance(UnionType).optional
  attribute :type_1,                         Types.Instance(UnionTypeUnion).optional
  attribute :typealias,                      Types.Instance(UnionTypealias).optional
  attribute :typedef,                        Types.Instance(UnionTypedef).optional
  attribute :typeid,                         Types.Instance(UnionTypeid).optional
  attribute :typename,                       Types.Instance(UnionTypename).optional
  attribute :typeof,                         Types.Instance(UnionTypeof).optional
  attribute :uint,                           Types.Instance(UnionUint).optional
  attribute :ulong,                          Types.Instance(UnionUlong).optional
  attribute :unchecked,                      Types.Instance(UnionUnchecked).optional
  attribute :undefined,                      Types.Instance(UnionUndefined).optional
  attribute :union,                          Types.Instance(UnionUnionUnion).optional
  attribute :unmarshal_json,                 Types.Instance(UnionUnmarshalJSON).optional
  attribute :unowned,                        Types.Instance(UnionUnowned).optional
  attribute :unsafe,                         Types.Instance(UnionUnsafe).optional
  attribute :unsigned,                       Types.Instance(UnionUnsigned).optional
  attribute :use_serializers,                Types.Instance(UnionUseSerializers).optional
  attribute :ushort,                         Types.Instance(UnionUshort).optional
  attribute :using,                          Types.Instance(UnionUsing).optional
  attribute :utf8_json_reader,               Types.Instance(UnionUtf8JSONReader).optional
  attribute :utf8_json_writer,               Types.Instance(UnionUtf8JSONWriter).optional
  attribute :uuid,                           Types.Instance(UnionUUID).optional
  attribute :var,                            Types.Instance(UnionVar).optional
  attribute :virtual,                        Types.Instance(UnionVirtual).optional
  attribute :void,                           Types.Instance(UnionVoid).optional
  attribute :volatile,                       Types.Instance(UnionVolatile).optional
  attribute :wchar_t,                        Types.Instance(UnionWcharT).optional
  attribute :weak,                           Types.Instance(UnionWeak).optional
  attribute :where,                          Types.Instance(UnionWhere).optional
  attribute :top_level_while,                Types.Instance(UnionWhile).optional
  attribute :will_set,                       Types.Instance(UnionWillSet).optional
  attribute :top_level_with,                 Types.Instance(UnionWith).optional
  attribute :xor,                            Types.Instance(UnionXor).optional
  attribute :xor_eq,                         Types.Instance(UnionXorEq).optional
  attribute :yes,                            Types.Instance(UnionYES).optional
  attribute :top_level_yield,                Types.Instance(UnionYield).optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      empty:                          d.key?("_") ? UnionUnion.from_dynamic!(d["_"]) : nil,
      top_level_bool:                 d.key?("_Bool") ? UnionBool.from_dynamic!(d["_Bool"]) : nil,
      complex:                        d.key?("_Complex") ? UnionComplex.from_dynamic!(d["_Complex"]) : nil,
      imaginery:                      d.key?("_Imaginery") ? UnionImaginery.from_dynamic!(d["_Imaginery"]) : nil,
      abstract:                       d.key?("abstract") ? UnionAbstract.from_dynamic!(d["abstract"]) : nil,
      alignas:                        d.key?("alignas") ? UnionAlignas.from_dynamic!(d["alignas"]) : nil,
      alignof:                        d.key?("alignof") ? UnionAlignof.from_dynamic!(d["alignof"]) : nil,
      top_level_and:                  d.key?("and") ? UnionAnd.from_dynamic!(d["and"]) : nil,
      and_eq:                         d.key?("and_eq") ? UnionAndEq.from_dynamic!(d["and_eq"]) : nil,
      top_level_any:                  d.key?("any") ? UnionAnyUnion.from_dynamic!(d["any"]) : nil,
      any:                            d.key?("Any") ? UnionAny.from_dynamic!(d["Any"]) : nil,
      array:                          d.key?("array") ? UnionArray.from_dynamic!(d["array"]) : nil,
      array_node:                     d.key?("ArrayNode") ? UnionArrayNode.from_dynamic!(d["ArrayNode"]) : nil,
      as:                             d.key?("as") ? UnionAs.from_dynamic!(d["as"]) : nil,
      asm:                            d.key?("asm") ? UnionASM.from_dynamic!(d["asm"]) : nil,
      assert:                         d.key?("assert") ? UnionAssert.from_dynamic!(d["assert"]) : nil,
      associatedtype:                 d.key?("associatedtype") ? UnionAssociatedtype.from_dynamic!(d["associatedtype"]) : nil,
      associativity:                  d.key?("associativity") ? UnionAssociativity.from_dynamic!(d["associativity"]) : nil,
      async:                          d.key?("async") ? UnionAsync.from_dynamic!(d["async"]) : nil,
      atomic:                         d.key?("atomic") ? UnionAtomic.from_dynamic!(d["atomic"]) : nil,
      atomic_cancel:                  d.key?("atomic_cancel") ? UnionAtomicCancel.from_dynamic!(d["atomic_cancel"]) : nil,
      atomic_commit:                  d.key?("atomic_commit") ? UnionAtomicCommit.from_dynamic!(d["atomic_commit"]) : nil,
      atomic_noexcept:                d.key?("atomic_noexcept") ? UnionAtomicNoexcept.from_dynamic!(d["atomic_noexcept"]) : nil,
      auto:                           d.key?("auto") ? UnionAuto.from_dynamic!(d["auto"]) : nil,
      await:                          d.key?("await") ? UnionAwait.from_dynamic!(d["await"]) : nil,
      base:                           d.key?("base") ? UnionBase.from_dynamic!(d["base"]) : nil,
      bitand:                         d.key?("bitand") ? UnionBitand.from_dynamic!(d["bitand"]) : nil,
      bitor:                          d.key?("bitor") ? UnionBitor.from_dynamic!(d["bitor"]) : nil,
      bool:                           d.key?("BOOL") ? UnionBOOL.from_dynamic!(d["BOOL"]) : nil,
      bool_1:                         d.key?("bool") ? UnionBoolUnion.from_dynamic!(d["bool"]) : nil,
      boolean:                        d.key?("boolean") ? UnionBoolean.from_dynamic!(d["boolean"]) : nil,
      boolean_node:                   d.key?("BooleanNode") ? UnionBooleanNode.from_dynamic!(d["BooleanNode"]) : nil,
      top_level_break:                d.key?("break") ? UnionBreak.from_dynamic!(d["break"]) : nil,
      bycopy:                         d.key?("bycopy") ? UnionBycopy.from_dynamic!(d["bycopy"]) : nil,
      byref:                          d.key?("byref") ? UnionByref.from_dynamic!(d["byref"]) : nil,
      byte:                           d.key?("byte") ? UnionByte.from_dynamic!(d["byte"]) : nil,
      calendar:                       d.key?("Calendar") ? UnionCalendar.from_dynamic!(d["Calendar"]) : nil,
      top_level_case:                 d.key?("case") ? UnionCase.from_dynamic!(d["case"]) : nil,
      top_level_catch:                d.key?("catch") ? UnionCatch.from_dynamic!(d["catch"]) : nil,
      chan:                           d.key?("chan") ? UnionChan.from_dynamic!(d["chan"]) : nil,
      char:                           d.key?("char") ? UnionChar.from_dynamic!(d["char"]) : nil,
      char16_t:                       d.key?("char16_t") ? UnionChar16T.from_dynamic!(d["char16_t"]) : nil,
      char32_t:                       d.key?("char32_t") ? UnionChar32T.from_dynamic!(d["char32_t"]) : nil,
      checked:                        d.key?("checked") ? UnionChecked.from_dynamic!(d["checked"]) : nil,
      class_1:                        d.key?("class") ? UnionClassUnion.from_dynamic!(d["class"]) : nil,
      top_level_class:                d.key?("Class") ? UnionClass.from_dynamic!(d["Class"]) : nil,
      top_level_clone:                d.key?("clone") ? UnionClone.from_dynamic!(d["clone"]) : nil,
      co_await:                       d.key?("co_await") ? UnionCoAwait.from_dynamic!(d["co_await"]) : nil,
      co_return:                      d.key?("co_return") ? UnionCoReturn.from_dynamic!(d["co_return"]) : nil,
      co_yield:                       d.key?("co_yield") ? UnionCoYield.from_dynamic!(d["co_yield"]) : nil,
      codable:                        d.key?("Codable") ? UnionCodable.from_dynamic!(d["Codable"]) : nil,
      coding_key:                     d.key?("CodingKey") ? UnionCodingKey.from_dynamic!(d["CodingKey"]) : nil,
      coding_keys:                    d.key?("CodingKeys") ? UnionCodingKeys.from_dynamic!(d["CodingKeys"]) : nil,
      compl:                          d.key?("compl") ? UnionCompl.from_dynamic!(d["compl"]) : nil,
      concept:                        d.key?("concept") ? UnionConcept.from_dynamic!(d["concept"]) : nil,
      console:                        d.key?("console") ? UnionConsole.from_dynamic!(d["console"]) : nil,
      const:                          d.key?("const") ? UnionConst.from_dynamic!(d["const"]) : nil,
      const_cast:                     d.key?("const_cast") ? UnionConstCast.from_dynamic!(d["const_cast"]) : nil,
      constexpr:                      d.key?("constexpr") ? UnionConstexpr.from_dynamic!(d["constexpr"]) : nil,
      top_level_constructor:          d.key?("constructor") ? UnionConstructor.from_dynamic!(d["constructor"]) : nil,
      continue:                       d.key?("continue") ? UnionContinue.from_dynamic!(d["continue"]) : nil,
      convenience:                    d.key?("convenience") ? UnionConvenience.from_dynamic!(d["convenience"]) : nil,
      convert:                        d.key?("convert") ? UnionConvert.from_dynamic!(d["convert"]) : nil,
      converter:                      d.key?("converter") ? UnionConverter.from_dynamic!(d["converter"]) : nil,
      culture_info:                   d.key?("CultureInfo") ? UnionCultureInfo.from_dynamic!(d["CultureInfo"]) : nil,
      date:                           d.key?("date") ? UnionDate.from_dynamic!(d["date"]) : nil,
      date_parse_handling:            d.key?("date_parse_handling") ? UnionDateParseHandling.from_dynamic!(d["date_parse_handling"]) : nil,
      date_formatter:                 d.key?("DateFormatter") ? UnionDateFormatter.from_dynamic!(d["DateFormatter"]) : nil,
      date_only:                      d.key?("DateOnly") ? UnionDateOnly.from_dynamic!(d["DateOnly"]) : nil,
      date_only_converter:            d.key?("DateOnlyConverter") ? UnionDateOnlyConverter.from_dynamic!(d["DateOnlyConverter"]) : nil,
      date_time:                      d.key?("DateTime") ? UnionDateTime.from_dynamic!(d["DateTime"]) : nil,
      date_time_styles:               d.key?("DateTimeStyles") ? UnionDateTimeStyles.from_dynamic!(d["DateTimeStyles"]) : nil,
      debugger:                       d.key?("debugger") ? UnionDebugger.from_dynamic!(d["debugger"]) : nil,
      decimal:                        d.key?("decimal") ? UnionDecimal.from_dynamic!(d["decimal"]) : nil,
      declare:                        d.key?("declare") ? UnionDeclare.from_dynamic!(d["declare"]) : nil,
      decltype:                       d.key?("decltype") ? UnionDecltype.from_dynamic!(d["decltype"]) : nil,
      decode_string:                  d.key?("decode_string") ? UnionDecodeString.from_dynamic!(d["decode_string"]) : nil,
      decoder:                        d.key?("Decoder") ? UnionDecoder.from_dynamic!(d["Decoder"]) : nil,
      decoding_error:                 d.key?("DecodingError") ? UnionDecodingError.from_dynamic!(d["DecodingError"]) : nil,
      top_level_def:                  d.key?("def") ? UnionDef.from_dynamic!(d["def"]) : nil,
      top_level_default:              d.key?("default") ? UnionDefault.from_dynamic!(d["default"]) : nil,
      defer:                          d.key?("defer") ? UnionDefer.from_dynamic!(d["defer"]) : nil,
      deinit:                         d.key?("deinit") ? UnionDeinit.from_dynamic!(d["deinit"]) : nil,
      del:                            d.key?("del") ? UnionDel.from_dynamic!(d["del"]) : nil,
      delegate:                       d.key?("delegate") ? UnionDelegate.from_dynamic!(d["delegate"]) : nil,
      delete:                         d.key?("delete") ? UnionDelete.from_dynamic!(d["delete"]) : nil,
      deserialization_feature:        d.key?("DeserializationFeature") ? UnionDeserializationFeature.from_dynamic!(d["DeserializationFeature"]) : nil,
      dict:                           d.key?("dict") ? UnionDict.from_dynamic!(d["dict"]) : nil,
      dictionary:                     d.key?("dictionary") ? UnionDictionary.from_dynamic!(d["dictionary"]) : nil,
      did_set:                        d.key?("didSet") ? UnionDidSet.from_dynamic!(d["didSet"]) : nil,
      top_level_do:                   d.key?("do") ? UnionDo.from_dynamic!(d["do"]) : nil,
      double:                         d.key?("double") ? UnionDouble.from_dynamic!(d["double"]) : nil,
      double_node:                    d.key?("DoubleNode") ? UnionDoubleNode.from_dynamic!(d["DoubleNode"]) : nil,
      dummy:                          d.key?("dummy") ? Types::Double[d["dummy"]] : nil,
      dynamic:                        d.key?("dynamic") ? UnionDynamic.from_dynamic!(d["dynamic"]) : nil,
      dynamic_cast:                   d.key?("dynamic_cast") ? UnionDynamicCast.from_dynamic!(d["dynamic_cast"]) : nil,
      elif:                           d.key?("elif") ? UnionElif.from_dynamic!(d["elif"]) : nil,
      top_level_else:                 d.key?("else") ? UnionElse.from_dynamic!(d["else"]) : nil,
      encode_quick_type:              d.key?("encode_quick_type") ? UnionEncodeQuickType.from_dynamic!(d["encode_quick_type"]) : nil,
      encoder:                        d.key?("Encoder") ? UnionEncoder.from_dynamic!(d["Encoder"]) : nil,
      top_level_enum:                 d.key?("enum") ? UnionEnum.from_dynamic!(d["enum"]) : nil,
      enum_values:                    d.key?("EnumValues") ? UnionEnumValues.from_dynamic!(d["EnumValues"]) : nil,
      equality_contract:              d.key?("equalityContract") ? UnionEqualityContract.from_dynamic!(d["equalityContract"]) : nil,
      equatable:                      d.key?("Equatable") ? UnionEquatable.from_dynamic!(d["Equatable"]) : nil,
      event:                          d.key?("event") ? UnionEvent.from_dynamic!(d["event"]) : nil,
      except:                         d.key?("except") ? UnionExcept.from_dynamic!(d["except"]) : nil,
      exception:                      d.key?("exception") ? UnionException.from_dynamic!(d["exception"]) : nil,
      explicit:                       d.key?("explicit") ? UnionExplicit.from_dynamic!(d["explicit"]) : nil,
      export:                         d.key?("export") ? UnionExport.from_dynamic!(d["export"]) : nil,
      exposing:                       d.key?("exposing") ? UnionExposing.from_dynamic!(d["exposing"]) : nil,
      extends:                        d.key?("extends") ? UnionExtends.from_dynamic!(d["extends"]) : nil,
      extension:                      d.key?("extension") ? UnionExtension.from_dynamic!(d["extension"]) : nil,
      extern:                         d.key?("extern") ? UnionExtern.from_dynamic!(d["extern"]) : nil,
      fallthrough:                    d.key?("fallthrough") ? UnionFallthrough.from_dynamic!(d["fallthrough"]) : nil,
      false_1:                        d.key?("false") ? UnionFalseUnion.from_dynamic!(d["false"]) : nil,
      top_level_false:                d.key?("False") ? UnionFalse.from_dynamic!(d["False"]) : nil,
      fileprivate:                    d.key?("fileprivate") ? UnionFileprivate.from_dynamic!(d["fileprivate"]) : nil,
      final:                          d.key?("final") ? UnionFinal.from_dynamic!(d["final"]) : nil,
      finally:                        d.key?("finally") ? UnionFinally.from_dynamic!(d["finally"]) : nil,
      fixed:                          d.key?("fixed") ? UnionFixed.from_dynamic!(d["fixed"]) : nil,
      float:                          d.key?("float") ? UnionFloat.from_dynamic!(d["float"]) : nil,
      top_level_for:                  d.key?("for") ? UnionFor.from_dynamic!(d["for"]) : nil,
      foreach:                        d.key?("foreach") ? UnionForeach.from_dynamic!(d["foreach"]) : nil,
      format_exception:               d.key?("FormatException") ? UnionFormatException.from_dynamic!(d["FormatException"]) : nil,
      friend:                         d.key?("friend") ? UnionFriend.from_dynamic!(d["friend"]) : nil,
      from:                           d.key?("from") ? UnionFrom.from_dynamic!(d["from"]) : nil,
      from_dict:                      d.key?("from_dict") ? UnionFromDict.from_dynamic!(d["from_dict"]) : nil,
      from_json:                      d.key?("from_json") ? UnionFromJSON.from_dynamic!(d["from_json"]) : nil,
      func:                           d.key?("func") ? UnionFunc.from_dynamic!(d["func"]) : nil,
      function:                       d.key?("function") ? UnionFunction.from_dynamic!(d["function"]) : nil,
      get:                            d.key?("get") ? UnionGet.from_dynamic!(d["get"]) : nil,
      global:                         d.key?("global") ? UnionGlobal.from_dynamic!(d["global"]) : nil,
      go:                             d.key?("go") ? UnionGo.from_dynamic!(d["go"]) : nil,
      goto:                           d.key?("goto") ? UnionGoto.from_dynamic!(d["goto"]) : nil,
      guard:                          d.key?("guard") ? UnionGuard.from_dynamic!(d["guard"]) : nil,
      hashable:                       d.key?("Hashable") ? UnionHashable.from_dynamic!(d["Hashable"]) : nil,
      hash_code:                      d.key?("hashCode") ? UnionHashCode.from_dynamic!(d["hashCode"]) : nil,
      hasher:                         d.key?("Hasher") ? UnionHasher.from_dynamic!(d["Hasher"]) : nil,
      has_own_property:               d.key?("hasOwnProperty") ? UnionHasOwnProperty.from_dynamic!(d["hasOwnProperty"]) : nil,
      id:                             d.key?("id") ? UnionID.from_dynamic!(d["id"]) : nil,
      top_level_if:                   d.key?("if") ? UnionIf.from_dynamic!(d["if"]) : nil,
      imp:                            d.key?("IMP") ? UnionIMP.from_dynamic!(d["IMP"]) : nil,
      implements:                     d.key?("implements") ? UnionImplements.from_dynamic!(d["implements"]) : nil,
      implicit:                       d.key?("implicit") ? UnionImplicit.from_dynamic!(d["implicit"]) : nil,
      import:                         d.key?("import") ? UnionImport.from_dynamic!(d["import"]) : nil,
      top_level_in:                   d.key?("in") ? UnionIn.from_dynamic!(d["in"]) : nil,
      indirect:                       d.key?("indirect") ? UnionIndirect.from_dynamic!(d["indirect"]) : nil,
      infix:                          d.key?("infix") ? UnionInfix.from_dynamic!(d["infix"]) : nil,
      init:                           d.key?("init") ? UnionInit.from_dynamic!(d["init"]) : nil,
      inline:                         d.key?("inline") ? UnionInline.from_dynamic!(d["inline"]) : nil,
      inout:                          d.key?("inout") ? UnionInout.from_dynamic!(d["inout"]) : nil,
      instanceof:                     d.key?("instanceof") ? UnionInstanceof.from_dynamic!(d["instanceof"]) : nil,
      int:                            d.key?("int") ? UnionInt.from_dynamic!(d["int"]) : nil,
      interface:                      d.key?("interface") ? UnionInterface.from_dynamic!(d["interface"]) : nil,
      internal:                       d.key?("internal") ? UnionInternal.from_dynamic!(d["internal"]) : nil,
      int_node:                       d.key?("IntNode") ? UnionIntNode.from_dynamic!(d["IntNode"]) : nil,
      is:                             d.key?("is") ? UnionIs.from_dynamic!(d["is"]) : nil,
      iso_date_time_offset_converter: d.key?("IsoDateTimeOffsetConverter") ? UnionISODateTimeOffsetConverter.from_dynamic!(d["IsoDateTimeOffsetConverter"]) : nil,
      iterable:                       d.key?("iterable") ? UnionIterable.from_dynamic!(d["iterable"]) : nil,
      jdec:                           d.key?("jdec") ? UnionJdec.from_dynamic!(d["jdec"]) : nil,
      jenc:                           d.key?("jenc") ? UnionJenc.from_dynamic!(d["jenc"]) : nil,
      jpipe:                          d.key?("jpipe") ? UnionJpipe.from_dynamic!(d["jpipe"]) : nil,
      json:                           d.key?("json") ? UnionJSON.from_dynamic!(d["json"]) : nil,
      json_converter:                 d.key?("json_converter") ? UnionJSONConverter.from_dynamic!(d["json_converter"]) : nil,
      json_serializer:                d.key?("json_serializer") ? UnionJSONSerializer.from_dynamic!(d["json_serializer"]) : nil,
      json_token:                     d.key?("json_token") ? UnionJSONToken.from_dynamic!(d["json_token"]) : nil,
      json_writer:                    d.key?("json_writer") ? UnionJSONWriter.from_dynamic!(d["json_writer"]) : nil,
      json_any:                       d.key?("JSONAny") ? UnionJSONAny.from_dynamic!(d["JSONAny"]) : nil,
      json_coding_key:                d.key?("JSONCodingKey") ? UnionJSONCodingKey.from_dynamic!(d["JSONCodingKey"]) : nil,
      json_decoder:                   d.key?("JSONDecoder") ? UnionJSONDecoder.from_dynamic!(d["JSONDecoder"]) : nil,
      json_encoder:                   d.key?("JSONEncoder") ? UnionJSONEncoder.from_dynamic!(d["JSONEncoder"]) : nil,
      json_exception:                 d.key?("JsonException") ? UnionJSONException.from_dynamic!(d["JsonException"]) : nil,
      json_generator:                 d.key?("JsonGenerator") ? UnionJSONGenerator.from_dynamic!(d["JsonGenerator"]) : nil,
      json_node:                      d.key?("JsonNode") ? UnionJSONNode.from_dynamic!(d["JsonNode"]) : nil,
      json_null:                      d.key?("JSONNull") ? UnionJSONNull.from_dynamic!(d["JSONNull"]) : nil,
      json_parser:                    d.key?("JsonParser") ? UnionJSONParser.from_dynamic!(d["JsonParser"]) : nil,
      json_reader:                    d.key?("JsonReader") ? UnionJSONReader.from_dynamic!(d["JsonReader"]) : nil,
      json_token_type:                d.key?("JsonTokenType") ? UnionJSONTokenType.from_dynamic!(d["JsonTokenType"]) : nil,
      k_serializer:                   d.key?("KSerializer") ? UnionKSerializer.from_dynamic!(d["KSerializer"]) : nil,
      top_level_lambda:               d.key?("lambda") ? UnionLambda.from_dynamic!(d["lambda"]) : nil,
      lazy:                           d.key?("lazy") ? UnionLazy.from_dynamic!(d["lazy"]) : nil,
      left:                           d.key?("left") ? UnionLeft.from_dynamic!(d["left"]) : nil,
      let:                            d.key?("let") ? UnionLet.from_dynamic!(d["let"]) : nil,
      list:                           d.key?("list") ? UnionList.from_dynamic!(d["list"]) : nil,
      local_date:                     d.key?("LocalDate") ? UnionLocalDate.from_dynamic!(d["LocalDate"]) : nil,
      locale:                         d.key?("Locale") ? UnionLocale.from_dynamic!(d["Locale"]) : nil,
      lock:                           d.key?("lock") ? UnionLock.from_dynamic!(d["lock"]) : nil,
      long:                           d.key?("long") ? UnionLong.from_dynamic!(d["long"]) : nil,
      long_node:                      d.key?("LongNode") ? UnionLongNode.from_dynamic!(d["LongNode"]) : nil,
      map:                            d.key?("map") ? UnionMap.from_dynamic!(d["map"]) : nil,
      map_entry:                      d.key?("MapEntry") ? UnionMapEntry.from_dynamic!(d["MapEntry"]) : nil,
      marshal_json:                   d.key?("MarshalJSON") ? UnionMarshalJSON.from_dynamic!(d["MarshalJSON"]) : nil,
      metadata_property_handling:     d.key?("metadata_property_handling") ? UnionMetadataPropertyHandling.from_dynamic!(d["metadata_property_handling"]) : nil,
      top_level_module:               d.key?("module") ? UnionModule.from_dynamic!(d["module"]) : nil,
      mutable:                        d.key?("mutable") ? UnionMutable.from_dynamic!(d["mutable"]) : nil,
      mutating:                       d.key?("mutating") ? UnionMutating.from_dynamic!(d["mutating"]) : nil,
      namespace:                      d.key?("namespace") ? UnionNamespace.from_dynamic!(d["namespace"]) : nil,
      native:                         d.key?("native") ? UnionNative.from_dynamic!(d["native"]) : nil,
      top_level_new:                  d.key?("new") ? UnionNew.from_dynamic!(d["new"]) : nil,
      newtonsoft:                     d.key?("newtonsoft") ? UnionNewtonsoft.from_dynamic!(d["newtonsoft"]) : nil,
      top_level_nil:                  d.key?("nil") ? UnionNil.from_dynamic!(d["nil"]) : nil,
      no:                             d.key?("NO") ? UnionNO.from_dynamic!(d["NO"]) : nil,
      noexcept:                       d.key?("noexcept") ? UnionNoexcept.from_dynamic!(d["noexcept"]) : nil,
      nonatomic:                      d.key?("nonatomic") ? UnionNonatomic.from_dynamic!(d["nonatomic"]) : nil,
      top_level_none:                 d.key?("none") ? UnionNoneUnion.from_dynamic!(d["none"]) : nil,
      none:                           d.key?("None") ? UnionNone.from_dynamic!(d["None"]) : nil,
      nonlocal:                       d.key?("nonlocal") ? UnionNonlocal.from_dynamic!(d["nonlocal"]) : nil,
      nonmutating:                    d.key?("nonmutating") ? UnionNonmutating.from_dynamic!(d["nonmutating"]) : nil,
      no_such_method:                 d.key?("noSuchMethod") ? UnionNoSuchMethod.from_dynamic!(d["noSuchMethod"]) : nil,
      top_level_not:                  d.key?("not") ? UnionNot.from_dynamic!(d["not"]) : nil,
      not_eq:                         d.key?("not_eq") ? UnionNotEq.from_dynamic!(d["not_eq"]) : nil,
      ns_error:                       d.key?("NSError") ? UnionNSError.from_dynamic!(d["NSError"]) : nil,
      ns_object:                      d.key?("NSObject") ? UnionNSObject.from_dynamic!(d["NSObject"]) : nil,
      ns_string:                      d.key?("NSString") ? UnionNSString.from_dynamic!(d["NSString"]) : nil,
      null:                           d.key?("NULL") ? UnionNULL.from_dynamic!(d["NULL"]) : nil,
      top_level_null:                 d.key?("null") ? UnionNull.from_dynamic!(d["null"]) : nil,
      null_node:                      d.key?("NullNode") ? UnionNullNode.from_dynamic!(d["NullNode"]) : nil,
      nullptr:                        d.key?("nullptr") ? UnionNullptr.from_dynamic!(d["nullptr"]) : nil,
      number:                         d.key?("number") ? UnionNumber.from_dynamic!(d["number"]) : nil,
      object:                         d.key?("object") ? UnionObject.from_dynamic!(d["object"]) : nil,
      object_mapper:                  d.key?("ObjectMapper") ? UnionObjectMapper.from_dynamic!(d["ObjectMapper"]) : nil,
      object_node:                    d.key?("ObjectNode") ? UnionObjectNode.from_dynamic!(d["ObjectNode"]) : nil,
      object_reader:                  d.key?("ObjectReader") ? UnionObjectReader.from_dynamic!(d["ObjectReader"]) : nil,
      object_writer:                  d.key?("ObjectWriter") ? UnionObjectWriter.from_dynamic!(d["ObjectWriter"]) : nil,
      of:                             d.key?("of") ? UnionOf.from_dynamic!(d["of"]) : nil,
      offset_date_time:               d.key?("OffsetDateTime") ? UnionOffsetDateTime.from_dynamic!(d["OffsetDateTime"]) : nil,
      offset_time:                    d.key?("OffsetTime") ? UnionOffsetTime.from_dynamic!(d["OffsetTime"]) : nil,
      oneway:                         d.key?("oneway") ? UnionOneway.from_dynamic!(d["oneway"]) : nil,
      top_level_open:                 d.key?("open") ? UnionOpen.from_dynamic!(d["open"]) : nil,
      operator:                       d.key?("operator") ? UnionOperator.from_dynamic!(d["operator"]) : nil,
      top_level_optional:             d.key?("optional") ? UnionOptional.from_dynamic!(d["optional"]) : nil,
      top_level_or:                   d.key?("or") ? UnionOr.from_dynamic!(d["or"]) : nil,
      or_eq:                          d.key?("or_eq") ? UnionOrEq.from_dynamic!(d["or_eq"]) : nil,
      out:                            d.key?("out") ? UnionOut.from_dynamic!(d["out"]) : nil,
      override:                       d.key?("override") ? UnionOverride.from_dynamic!(d["override"]) : nil,
      package:                        d.key?("package") ? UnionPackage.from_dynamic!(d["package"]) : nil,
      params:                         d.key?("params") ? UnionParams.from_dynamic!(d["params"]) : nil,
      pass:                           d.key?("pass") ? UnionPass.from_dynamic!(d["pass"]) : nil,
      port:                           d.key?("port") ? UnionPort.from_dynamic!(d["port"]) : nil,
      postfix:                        d.key?("postfix") ? UnionPostfix.from_dynamic!(d["postfix"]) : nil,
      precedence:                     d.key?("precedence") ? UnionPrecedence.from_dynamic!(d["precedence"]) : nil,
      prefix:                         d.key?("prefix") ? UnionPrefix.from_dynamic!(d["prefix"]) : nil,
      primitive_kind:                 d.key?("PrimitiveKind") ? UnionPrimitiveKind.from_dynamic!(d["PrimitiveKind"]) : nil,
      top_level_print:                d.key?("print") ? UnionPrint.from_dynamic!(d["print"]) : nil,
      top_level_printf:               d.key?("printf") ? UnionPrintf.from_dynamic!(d["printf"]) : nil,
      print_members:                  d.key?("printMembers") ? UnionPrintMembers.from_dynamic!(d["printMembers"]) : nil,
      private:                        d.key?("private") ? UnionPrivate.from_dynamic!(d["private"]) : nil,
      protected:                      d.key?("protected") ? UnionProtected.from_dynamic!(d["protected"]) : nil,
      protocol:                       d.key?("Protocol") ? UnionProtocol.from_dynamic!(d["Protocol"]) : nil,
      top_level_protocol:             d.key?("protocol") ? UnionProtocolUnion.from_dynamic!(d["protocol"]) : nil,
      public:                         d.key?("public") ? UnionPublic.from_dynamic!(d["public"]) : nil,
      quicktype:                      d.key?("quicktype") ? UnionQuicktype.from_dynamic!(d["quicktype"]) : nil,
      top_level_raise:                d.key?("raise") ? UnionRaise.from_dynamic!(d["raise"]) : nil,
      range:                          d.key?("range") ? UnionRange.from_dynamic!(d["range"]) : nil,
      readonly:                       d.key?("readonly") ? UnionReadonly.from_dynamic!(d["readonly"]) : nil,
      ref:                            d.key?("ref") ? UnionRef.from_dynamic!(d["ref"]) : nil,
      reg_exp:                        d.key?("RegExp") ? UnionRegExp.from_dynamic!(d["RegExp"]) : nil,
      register:                       d.key?("register") ? UnionRegister.from_dynamic!(d["register"]) : nil,
      reinterpret_cast:               d.key?("reinterpret_cast") ? UnionReinterpretCast.from_dynamic!(d["reinterpret_cast"]) : nil,
      repeat:                         d.key?("repeat") ? UnionRepeat.from_dynamic!(d["repeat"]) : nil,
      top_level_require:              d.key?("require") ? UnionRequire.from_dynamic!(d["require"]) : nil,
      required:                       d.key?("required") ? UnionRequired.from_dynamic!(d["required"]) : nil,
      requires:                       d.key?("requires") ? UnionRequires.from_dynamic!(d["requires"]) : nil,
      restrict:                       d.key?("restrict") ? UnionRestrict.from_dynamic!(d["restrict"]) : nil,
      retain:                         d.key?("retain") ? UnionRetain.from_dynamic!(d["retain"]) : nil,
      rethrows:                       d.key?("rethrows") ? UnionRethrows.from_dynamic!(d["rethrows"]) : nil,
      top_level_return:               d.key?("return") ? UnionReturn.from_dynamic!(d["return"]) : nil,
      right:                          d.key?("right") ? UnionRight.from_dynamic!(d["right"]) : nil,
      runtime_type:                   d.key?("runtimeType") ? UnionRuntimeType.from_dynamic!(d["runtimeType"]) : nil,
      s:                              d.key?("s") ? UnionS.from_dynamic!(d["s"]) : nil,
      sbyte:                          d.key?("sbyte") ? UnionSbyte.from_dynamic!(d["sbyte"]) : nil,
      sealed:                         d.key?("sealed") ? UnionSealed.from_dynamic!(d["sealed"]) : nil,
      sel:                            d.key?("SEL") ? UnionSEL.from_dynamic!(d["SEL"]) : nil,
      top_level_select:               d.key?("select") ? UnionSelect.from_dynamic!(d["select"]) : nil,
      top_level_self:                 d.key?("Self") ? UnionSelf.from_dynamic!(d["Self"]) : nil,
      self_1:                         d.key?("self") ? UnionSelfUnion.from_dynamic!(d["self"]) : nil,
      sendable:                       d.key?("Sendable") ? UnionSendable.from_dynamic!(d["Sendable"]) : nil,
      serial_descriptor:              d.key?("SerialDescriptor") ? UnionSerialDescriptor.from_dynamic!(d["SerialDescriptor"]) : nil,
      serializable:                   d.key?("Serializable") ? UnionSerializable.from_dynamic!(d["Serializable"]) : nil,
      serialization_feature:          d.key?("SerializationFeature") ? UnionSerializationFeature.from_dynamic!(d["SerializationFeature"]) : nil,
      serialize:                      d.key?("serialize") ? UnionSerialize.from_dynamic!(d["serialize"]) : nil,
      serializer_provider:            d.key?("SerializerProvider") ? UnionSerializerProvider.from_dynamic!(d["SerializerProvider"]) : nil,
      serial_name:                    d.key?("SerialName") ? UnionSerialName.from_dynamic!(d["SerialName"]) : nil,
      set:                            d.key?("set") ? UnionSet.from_dynamic!(d["set"]) : nil,
      short:                          d.key?("short") ? UnionShort.from_dynamic!(d["short"]) : nil,
      signed:                         d.key?("signed") ? UnionSigned.from_dynamic!(d["signed"]) : nil,
      simple_module:                  d.key?("SimpleModule") ? UnionSimpleModule.from_dynamic!(d["SimpleModule"]) : nil,
      sizeof:                         d.key?("sizeof") ? UnionSizeof.from_dynamic!(d["sizeof"]) : nil,
      stackalloc:                     d.key?("stackalloc") ? UnionStackalloc.from_dynamic!(d["stackalloc"]) : nil,
      standards:                      d.key?("Standards") ? UnionStandards.from_dynamic!(d["Standards"]) : nil,
      static:                         d.key?("static") ? UnionStatic.from_dynamic!(d["static"]) : nil,
      static_assert:                  d.key?("static_assert") ? UnionStaticAssert.from_dynamic!(d["static_assert"]) : nil,
      static_cast:                    d.key?("static_cast") ? UnionStaticCast.from_dynamic!(d["static_cast"]) : nil,
      std_deserializer:               d.key?("StdDeserializer") ? UnionStdDeserializer.from_dynamic!(d["StdDeserializer"]) : nil,
      std_serializer:                 d.key?("StdSerializer") ? UnionStdSerializer.from_dynamic!(d["StdSerializer"]) : nil,
      strictfp:                       d.key?("strictfp") ? UnionStrictfp.from_dynamic!(d["strictfp"]) : nil,
      string:                         d.key?("string") ? UnionString.from_dynamic!(d["string"]) : nil,
      struct:                         d.key?("struct") ? UnionStruct.from_dynamic!(d["struct"]) : nil,
      subscript:                      d.key?("subscript") ? UnionSubscript.from_dynamic!(d["subscript"]) : nil,
      top_level_super:                d.key?("super") ? UnionSuper.from_dynamic!(d["super"]) : nil,
      switch:                         d.key?("switch") ? UnionSwitch.from_dynamic!(d["switch"]) : nil,
      symbol:                         d.key?("symbol") ? UnionSymbol.from_dynamic!(d["symbol"]) : nil,
      synchronized:                   d.key?("synchronized") ? UnionSynchronized.from_dynamic!(d["synchronized"]) : nil,
      top_level_system:               d.key?("system") ? UnionSystem.from_dynamic!(d["system"]) : nil,
      template:                       d.key?("template") ? UnionTemplate.from_dynamic!(d["template"]) : nil,
      text_node:                      d.key?("TextNode") ? UnionTextNode.from_dynamic!(d["TextNode"]) : nil,
      top_level_then:                 d.key?("then") ? UnionThen.from_dynamic!(d["then"]) : nil,
      this:                           d.key?("this") ? UnionThis.from_dynamic!(d["this"]) : nil,
      thread_local:                   d.key?("thread_local") ? UnionThreadLocal.from_dynamic!(d["thread_local"]) : nil,
      top_level_throw:                d.key?("throw") ? UnionThrow.from_dynamic!(d["throw"]) : nil,
      throws:                         d.key?("throws") ? UnionThrows.from_dynamic!(d["throws"]) : nil,
      time_only:                      d.key?("TimeOnly") ? UnionTimeOnly.from_dynamic!(d["TimeOnly"]) : nil,
      time_only_converter:            d.key?("TimeOnlyConverter") ? UnionTimeOnlyConverter.from_dynamic!(d["TimeOnlyConverter"]) : nil,
      time_zone:                      d.key?("TimeZone") ? UnionTimeZone.from_dynamic!(d["TimeZone"]) : nil,
      to_dict:                        d.key?("to_dict") ? UnionToDict.from_dynamic!(d["to_dict"]) : nil,
      top_level_to_json:              d.key?("to_json") ? UnionToJSON.from_dynamic!(d["to_json"]) : nil,
      top_level:                      d.key?("top_level") ? UnionTopLevel.from_dynamic!(d["top_level"]) : nil,
      to_string:                      d.key?("toString") ? UnionToString.from_dynamic!(d["toString"]) : nil,
      transient:                      d.key?("transient") ? UnionTransient.from_dynamic!(d["transient"]) : nil,
      top_level_true:                 d.key?("True") ? UnionTrue.from_dynamic!(d["True"]) : nil,
      true_1:                         d.key?("true") ? UnionTrueUnion.from_dynamic!(d["true"]) : nil,
      top_level_try:                  d.key?("try") ? UnionTry.from_dynamic!(d["try"]) : nil,
      top_level_type:                 d.key?("Type") ? UnionType.from_dynamic!(d["Type"]) : nil,
      type_1:                         d.key?("type") ? UnionTypeUnion.from_dynamic!(d["type"]) : nil,
      typealias:                      d.key?("typealias") ? UnionTypealias.from_dynamic!(d["typealias"]) : nil,
      typedef:                        d.key?("typedef") ? UnionTypedef.from_dynamic!(d["typedef"]) : nil,
      typeid:                         d.key?("typeid") ? UnionTypeid.from_dynamic!(d["typeid"]) : nil,
      typename:                       d.key?("typename") ? UnionTypename.from_dynamic!(d["typename"]) : nil,
      typeof:                         d.key?("typeof") ? UnionTypeof.from_dynamic!(d["typeof"]) : nil,
      uint:                           d.key?("uint") ? UnionUint.from_dynamic!(d["uint"]) : nil,
      ulong:                          d.key?("ulong") ? UnionUlong.from_dynamic!(d["ulong"]) : nil,
      unchecked:                      d.key?("unchecked") ? UnionUnchecked.from_dynamic!(d["unchecked"]) : nil,
      undefined:                      d.key?("undefined") ? UnionUndefined.from_dynamic!(d["undefined"]) : nil,
      union:                          d.key?("union") ? UnionUnionUnion.from_dynamic!(d["union"]) : nil,
      unmarshal_json:                 d.key?("UnmarshalJSON") ? UnionUnmarshalJSON.from_dynamic!(d["UnmarshalJSON"]) : nil,
      unowned:                        d.key?("unowned") ? UnionUnowned.from_dynamic!(d["unowned"]) : nil,
      unsafe:                         d.key?("unsafe") ? UnionUnsafe.from_dynamic!(d["unsafe"]) : nil,
      unsigned:                       d.key?("unsigned") ? UnionUnsigned.from_dynamic!(d["unsigned"]) : nil,
      use_serializers:                d.key?("UseSerializers") ? UnionUseSerializers.from_dynamic!(d["UseSerializers"]) : nil,
      ushort:                         d.key?("ushort") ? UnionUshort.from_dynamic!(d["ushort"]) : nil,
      using:                          d.key?("using") ? UnionUsing.from_dynamic!(d["using"]) : nil,
      utf8_json_reader:               d.key?("Utf8JsonReader") ? UnionUtf8JSONReader.from_dynamic!(d["Utf8JsonReader"]) : nil,
      utf8_json_writer:               d.key?("Utf8JsonWriter") ? UnionUtf8JSONWriter.from_dynamic!(d["Utf8JsonWriter"]) : nil,
      uuid:                           d.key?("UUID") ? UnionUUID.from_dynamic!(d["UUID"]) : nil,
      var:                            d.key?("var") ? UnionVar.from_dynamic!(d["var"]) : nil,
      virtual:                        d.key?("virtual") ? UnionVirtual.from_dynamic!(d["virtual"]) : nil,
      void:                           d.key?("void") ? UnionVoid.from_dynamic!(d["void"]) : nil,
      volatile:                       d.key?("volatile") ? UnionVolatile.from_dynamic!(d["volatile"]) : nil,
      wchar_t:                        d.key?("wchar_t") ? UnionWcharT.from_dynamic!(d["wchar_t"]) : nil,
      weak:                           d.key?("weak") ? UnionWeak.from_dynamic!(d["weak"]) : nil,
      where:                          d.key?("where") ? UnionWhere.from_dynamic!(d["where"]) : nil,
      top_level_while:                d.key?("while") ? UnionWhile.from_dynamic!(d["while"]) : nil,
      will_set:                       d.key?("willSet") ? UnionWillSet.from_dynamic!(d["willSet"]) : nil,
      top_level_with:                 d.key?("with") ? UnionWith.from_dynamic!(d["with"]) : nil,
      xor:                            d.key?("xor") ? UnionXor.from_dynamic!(d["xor"]) : nil,
      xor_eq:                         d.key?("xor_eq") ? UnionXorEq.from_dynamic!(d["xor_eq"]) : nil,
      yes:                            d.key?("YES") ? UnionYES.from_dynamic!(d["YES"]) : nil,
      top_level_yield:                d.key?("yield") ? UnionYield.from_dynamic!(d["yield"]) : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "_"                          => empty&.to_dynamic,
      "_Bool"                      => top_level_bool&.to_dynamic,
      "_Complex"                   => complex&.to_dynamic,
      "_Imaginery"                 => imaginery&.to_dynamic,
      "abstract"                   => abstract&.to_dynamic,
      "alignas"                    => alignas&.to_dynamic,
      "alignof"                    => alignof&.to_dynamic,
      "and"                        => top_level_and&.to_dynamic,
      "and_eq"                     => and_eq&.to_dynamic,
      "any"                        => top_level_any&.to_dynamic,
      "Any"                        => any&.to_dynamic,
      "array"                      => array&.to_dynamic,
      "ArrayNode"                  => array_node&.to_dynamic,
      "as"                         => as&.to_dynamic,
      "asm"                        => asm&.to_dynamic,
      "assert"                     => assert&.to_dynamic,
      "associatedtype"             => associatedtype&.to_dynamic,
      "associativity"              => associativity&.to_dynamic,
      "async"                      => async&.to_dynamic,
      "atomic"                     => atomic&.to_dynamic,
      "atomic_cancel"              => atomic_cancel&.to_dynamic,
      "atomic_commit"              => atomic_commit&.to_dynamic,
      "atomic_noexcept"            => atomic_noexcept&.to_dynamic,
      "auto"                       => auto&.to_dynamic,
      "await"                      => await&.to_dynamic,
      "base"                       => base&.to_dynamic,
      "bitand"                     => bitand&.to_dynamic,
      "bitor"                      => bitor&.to_dynamic,
      "BOOL"                       => bool&.to_dynamic,
      "bool"                       => bool_1&.to_dynamic,
      "boolean"                    => boolean&.to_dynamic,
      "BooleanNode"                => boolean_node&.to_dynamic,
      "break"                      => top_level_break&.to_dynamic,
      "bycopy"                     => bycopy&.to_dynamic,
      "byref"                      => byref&.to_dynamic,
      "byte"                       => byte&.to_dynamic,
      "Calendar"                   => calendar&.to_dynamic,
      "case"                       => top_level_case&.to_dynamic,
      "catch"                      => top_level_catch&.to_dynamic,
      "chan"                       => chan&.to_dynamic,
      "char"                       => char&.to_dynamic,
      "char16_t"                   => char16_t&.to_dynamic,
      "char32_t"                   => char32_t&.to_dynamic,
      "checked"                    => checked&.to_dynamic,
      "class"                      => class_1&.to_dynamic,
      "Class"                      => top_level_class&.to_dynamic,
      "clone"                      => top_level_clone&.to_dynamic,
      "co_await"                   => co_await&.to_dynamic,
      "co_return"                  => co_return&.to_dynamic,
      "co_yield"                   => co_yield&.to_dynamic,
      "Codable"                    => codable&.to_dynamic,
      "CodingKey"                  => coding_key&.to_dynamic,
      "CodingKeys"                 => coding_keys&.to_dynamic,
      "compl"                      => compl&.to_dynamic,
      "concept"                    => concept&.to_dynamic,
      "console"                    => console&.to_dynamic,
      "const"                      => const&.to_dynamic,
      "const_cast"                 => const_cast&.to_dynamic,
      "constexpr"                  => constexpr&.to_dynamic,
      "constructor"                => top_level_constructor&.to_dynamic,
      "continue"                   => continue&.to_dynamic,
      "convenience"                => convenience&.to_dynamic,
      "convert"                    => convert&.to_dynamic,
      "converter"                  => converter&.to_dynamic,
      "CultureInfo"                => culture_info&.to_dynamic,
      "date"                       => date&.to_dynamic,
      "date_parse_handling"        => date_parse_handling&.to_dynamic,
      "DateFormatter"              => date_formatter&.to_dynamic,
      "DateOnly"                   => date_only&.to_dynamic,
      "DateOnlyConverter"          => date_only_converter&.to_dynamic,
      "DateTime"                   => date_time&.to_dynamic,
      "DateTimeStyles"             => date_time_styles&.to_dynamic,
      "debugger"                   => debugger&.to_dynamic,
      "decimal"                    => decimal&.to_dynamic,
      "declare"                    => declare&.to_dynamic,
      "decltype"                   => decltype&.to_dynamic,
      "decode_string"              => decode_string&.to_dynamic,
      "Decoder"                    => decoder&.to_dynamic,
      "DecodingError"              => decoding_error&.to_dynamic,
      "def"                        => top_level_def&.to_dynamic,
      "default"                    => top_level_default&.to_dynamic,
      "defer"                      => defer&.to_dynamic,
      "deinit"                     => deinit&.to_dynamic,
      "del"                        => del&.to_dynamic,
      "delegate"                   => delegate&.to_dynamic,
      "delete"                     => delete&.to_dynamic,
      "DeserializationFeature"     => deserialization_feature&.to_dynamic,
      "dict"                       => dict&.to_dynamic,
      "dictionary"                 => dictionary&.to_dynamic,
      "didSet"                     => did_set&.to_dynamic,
      "do"                         => top_level_do&.to_dynamic,
      "double"                     => double&.to_dynamic,
      "DoubleNode"                 => double_node&.to_dynamic,
      "dummy"                      => dummy,
      "dynamic"                    => dynamic&.to_dynamic,
      "dynamic_cast"               => dynamic_cast&.to_dynamic,
      "elif"                       => elif&.to_dynamic,
      "else"                       => top_level_else&.to_dynamic,
      "encode_quick_type"          => encode_quick_type&.to_dynamic,
      "Encoder"                    => encoder&.to_dynamic,
      "enum"                       => top_level_enum&.to_dynamic,
      "EnumValues"                 => enum_values&.to_dynamic,
      "equalityContract"           => equality_contract&.to_dynamic,
      "Equatable"                  => equatable&.to_dynamic,
      "event"                      => event&.to_dynamic,
      "except"                     => except&.to_dynamic,
      "exception"                  => exception&.to_dynamic,
      "explicit"                   => explicit&.to_dynamic,
      "export"                     => export&.to_dynamic,
      "exposing"                   => exposing&.to_dynamic,
      "extends"                    => extends&.to_dynamic,
      "extension"                  => extension&.to_dynamic,
      "extern"                     => extern&.to_dynamic,
      "fallthrough"                => fallthrough&.to_dynamic,
      "false"                      => false_1&.to_dynamic,
      "False"                      => top_level_false&.to_dynamic,
      "fileprivate"                => fileprivate&.to_dynamic,
      "final"                      => final&.to_dynamic,
      "finally"                    => finally&.to_dynamic,
      "fixed"                      => fixed&.to_dynamic,
      "float"                      => float&.to_dynamic,
      "for"                        => top_level_for&.to_dynamic,
      "foreach"                    => foreach&.to_dynamic,
      "FormatException"            => format_exception&.to_dynamic,
      "friend"                     => friend&.to_dynamic,
      "from"                       => from&.to_dynamic,
      "from_dict"                  => from_dict&.to_dynamic,
      "from_json"                  => from_json&.to_dynamic,
      "func"                       => func&.to_dynamic,
      "function"                   => function&.to_dynamic,
      "get"                        => get&.to_dynamic,
      "global"                     => global&.to_dynamic,
      "go"                         => go&.to_dynamic,
      "goto"                       => goto&.to_dynamic,
      "guard"                      => guard&.to_dynamic,
      "Hashable"                   => hashable&.to_dynamic,
      "hashCode"                   => hash_code&.to_dynamic,
      "Hasher"                     => hasher&.to_dynamic,
      "hasOwnProperty"             => has_own_property&.to_dynamic,
      "id"                         => id&.to_dynamic,
      "if"                         => top_level_if&.to_dynamic,
      "IMP"                        => imp&.to_dynamic,
      "implements"                 => implements&.to_dynamic,
      "implicit"                   => implicit&.to_dynamic,
      "import"                     => import&.to_dynamic,
      "in"                         => top_level_in&.to_dynamic,
      "indirect"                   => indirect&.to_dynamic,
      "infix"                      => infix&.to_dynamic,
      "init"                       => init&.to_dynamic,
      "inline"                     => inline&.to_dynamic,
      "inout"                      => inout&.to_dynamic,
      "instanceof"                 => instanceof&.to_dynamic,
      "int"                        => int&.to_dynamic,
      "interface"                  => interface&.to_dynamic,
      "internal"                   => internal&.to_dynamic,
      "IntNode"                    => int_node&.to_dynamic,
      "is"                         => is&.to_dynamic,
      "IsoDateTimeOffsetConverter" => iso_date_time_offset_converter&.to_dynamic,
      "iterable"                   => iterable&.to_dynamic,
      "jdec"                       => jdec&.to_dynamic,
      "jenc"                       => jenc&.to_dynamic,
      "jpipe"                      => jpipe&.to_dynamic,
      "json"                       => json&.to_dynamic,
      "json_converter"             => json_converter&.to_dynamic,
      "json_serializer"            => json_serializer&.to_dynamic,
      "json_token"                 => json_token&.to_dynamic,
      "json_writer"                => json_writer&.to_dynamic,
      "JSONAny"                    => json_any&.to_dynamic,
      "JSONCodingKey"              => json_coding_key&.to_dynamic,
      "JSONDecoder"                => json_decoder&.to_dynamic,
      "JSONEncoder"                => json_encoder&.to_dynamic,
      "JsonException"              => json_exception&.to_dynamic,
      "JsonGenerator"              => json_generator&.to_dynamic,
      "JsonNode"                   => json_node&.to_dynamic,
      "JSONNull"                   => json_null&.to_dynamic,
      "JsonParser"                 => json_parser&.to_dynamic,
      "JsonReader"                 => json_reader&.to_dynamic,
      "JsonTokenType"              => json_token_type&.to_dynamic,
      "KSerializer"                => k_serializer&.to_dynamic,
      "lambda"                     => top_level_lambda&.to_dynamic,
      "lazy"                       => lazy&.to_dynamic,
      "left"                       => left&.to_dynamic,
      "let"                        => let&.to_dynamic,
      "list"                       => list&.to_dynamic,
      "LocalDate"                  => local_date&.to_dynamic,
      "Locale"                     => locale&.to_dynamic,
      "lock"                       => lock&.to_dynamic,
      "long"                       => long&.to_dynamic,
      "LongNode"                   => long_node&.to_dynamic,
      "map"                        => map&.to_dynamic,
      "MapEntry"                   => map_entry&.to_dynamic,
      "MarshalJSON"                => marshal_json&.to_dynamic,
      "metadata_property_handling" => metadata_property_handling&.to_dynamic,
      "module"                     => top_level_module&.to_dynamic,
      "mutable"                    => mutable&.to_dynamic,
      "mutating"                   => mutating&.to_dynamic,
      "namespace"                  => namespace&.to_dynamic,
      "native"                     => native&.to_dynamic,
      "new"                        => top_level_new&.to_dynamic,
      "newtonsoft"                 => newtonsoft&.to_dynamic,
      "nil"                        => top_level_nil&.to_dynamic,
      "NO"                         => no&.to_dynamic,
      "noexcept"                   => noexcept&.to_dynamic,
      "nonatomic"                  => nonatomic&.to_dynamic,
      "none"                       => top_level_none&.to_dynamic,
      "None"                       => none&.to_dynamic,
      "nonlocal"                   => nonlocal&.to_dynamic,
      "nonmutating"                => nonmutating&.to_dynamic,
      "noSuchMethod"               => no_such_method&.to_dynamic,
      "not"                        => top_level_not&.to_dynamic,
      "not_eq"                     => not_eq&.to_dynamic,
      "NSError"                    => ns_error&.to_dynamic,
      "NSObject"                   => ns_object&.to_dynamic,
      "NSString"                   => ns_string&.to_dynamic,
      "NULL"                       => null&.to_dynamic,
      "null"                       => top_level_null&.to_dynamic,
      "NullNode"                   => null_node&.to_dynamic,
      "nullptr"                    => nullptr&.to_dynamic,
      "number"                     => number&.to_dynamic,
      "object"                     => object&.to_dynamic,
      "ObjectMapper"               => object_mapper&.to_dynamic,
      "ObjectNode"                 => object_node&.to_dynamic,
      "ObjectReader"               => object_reader&.to_dynamic,
      "ObjectWriter"               => object_writer&.to_dynamic,
      "of"                         => of&.to_dynamic,
      "OffsetDateTime"             => offset_date_time&.to_dynamic,
      "OffsetTime"                 => offset_time&.to_dynamic,
      "oneway"                     => oneway&.to_dynamic,
      "open"                       => top_level_open&.to_dynamic,
      "operator"                   => operator&.to_dynamic,
      "optional"                   => top_level_optional&.to_dynamic,
      "or"                         => top_level_or&.to_dynamic,
      "or_eq"                      => or_eq&.to_dynamic,
      "out"                        => out&.to_dynamic,
      "override"                   => override&.to_dynamic,
      "package"                    => package&.to_dynamic,
      "params"                     => params&.to_dynamic,
      "pass"                       => pass&.to_dynamic,
      "port"                       => port&.to_dynamic,
      "postfix"                    => postfix&.to_dynamic,
      "precedence"                 => precedence&.to_dynamic,
      "prefix"                     => prefix&.to_dynamic,
      "PrimitiveKind"              => primitive_kind&.to_dynamic,
      "print"                      => top_level_print&.to_dynamic,
      "printf"                     => top_level_printf&.to_dynamic,
      "printMembers"               => print_members&.to_dynamic,
      "private"                    => private&.to_dynamic,
      "protected"                  => protected&.to_dynamic,
      "Protocol"                   => protocol&.to_dynamic,
      "protocol"                   => top_level_protocol&.to_dynamic,
      "public"                     => public&.to_dynamic,
      "quicktype"                  => quicktype&.to_dynamic,
      "raise"                      => top_level_raise&.to_dynamic,
      "range"                      => range&.to_dynamic,
      "readonly"                   => readonly&.to_dynamic,
      "ref"                        => ref&.to_dynamic,
      "RegExp"                     => reg_exp&.to_dynamic,
      "register"                   => register&.to_dynamic,
      "reinterpret_cast"           => reinterpret_cast&.to_dynamic,
      "repeat"                     => repeat&.to_dynamic,
      "require"                    => top_level_require&.to_dynamic,
      "required"                   => required&.to_dynamic,
      "requires"                   => requires&.to_dynamic,
      "restrict"                   => restrict&.to_dynamic,
      "retain"                     => retain&.to_dynamic,
      "rethrows"                   => rethrows&.to_dynamic,
      "return"                     => top_level_return&.to_dynamic,
      "right"                      => right&.to_dynamic,
      "runtimeType"                => runtime_type&.to_dynamic,
      "s"                          => s&.to_dynamic,
      "sbyte"                      => sbyte&.to_dynamic,
      "sealed"                     => sealed&.to_dynamic,
      "SEL"                        => sel&.to_dynamic,
      "select"                     => top_level_select&.to_dynamic,
      "Self"                       => top_level_self&.to_dynamic,
      "self"                       => self_1&.to_dynamic,
      "Sendable"                   => sendable&.to_dynamic,
      "SerialDescriptor"           => serial_descriptor&.to_dynamic,
      "Serializable"               => serializable&.to_dynamic,
      "SerializationFeature"       => serialization_feature&.to_dynamic,
      "serialize"                  => serialize&.to_dynamic,
      "SerializerProvider"         => serializer_provider&.to_dynamic,
      "SerialName"                 => serial_name&.to_dynamic,
      "set"                        => set&.to_dynamic,
      "short"                      => short&.to_dynamic,
      "signed"                     => signed&.to_dynamic,
      "SimpleModule"               => simple_module&.to_dynamic,
      "sizeof"                     => sizeof&.to_dynamic,
      "stackalloc"                 => stackalloc&.to_dynamic,
      "Standards"                  => standards&.to_dynamic,
      "static"                     => static&.to_dynamic,
      "static_assert"              => static_assert&.to_dynamic,
      "static_cast"                => static_cast&.to_dynamic,
      "StdDeserializer"            => std_deserializer&.to_dynamic,
      "StdSerializer"              => std_serializer&.to_dynamic,
      "strictfp"                   => strictfp&.to_dynamic,
      "string"                     => string&.to_dynamic,
      "struct"                     => struct&.to_dynamic,
      "subscript"                  => subscript&.to_dynamic,
      "super"                      => top_level_super&.to_dynamic,
      "switch"                     => switch&.to_dynamic,
      "symbol"                     => symbol&.to_dynamic,
      "synchronized"               => synchronized&.to_dynamic,
      "system"                     => top_level_system&.to_dynamic,
      "template"                   => template&.to_dynamic,
      "TextNode"                   => text_node&.to_dynamic,
      "then"                       => top_level_then&.to_dynamic,
      "this"                       => this&.to_dynamic,
      "thread_local"               => thread_local&.to_dynamic,
      "throw"                      => top_level_throw&.to_dynamic,
      "throws"                     => throws&.to_dynamic,
      "TimeOnly"                   => time_only&.to_dynamic,
      "TimeOnlyConverter"          => time_only_converter&.to_dynamic,
      "TimeZone"                   => time_zone&.to_dynamic,
      "to_dict"                    => to_dict&.to_dynamic,
      "to_json"                    => top_level_to_json&.to_dynamic,
      "top_level"                  => top_level&.to_dynamic,
      "toString"                   => to_string&.to_dynamic,
      "transient"                  => transient&.to_dynamic,
      "True"                       => top_level_true&.to_dynamic,
      "true"                       => true_1&.to_dynamic,
      "try"                        => top_level_try&.to_dynamic,
      "Type"                       => top_level_type&.to_dynamic,
      "type"                       => type_1&.to_dynamic,
      "typealias"                  => typealias&.to_dynamic,
      "typedef"                    => typedef&.to_dynamic,
      "typeid"                     => typeid&.to_dynamic,
      "typename"                   => typename&.to_dynamic,
      "typeof"                     => typeof&.to_dynamic,
      "uint"                       => uint&.to_dynamic,
      "ulong"                      => ulong&.to_dynamic,
      "unchecked"                  => unchecked&.to_dynamic,
      "undefined"                  => undefined&.to_dynamic,
      "union"                      => union&.to_dynamic,
      "UnmarshalJSON"              => unmarshal_json&.to_dynamic,
      "unowned"                    => unowned&.to_dynamic,
      "unsafe"                     => unsafe&.to_dynamic,
      "unsigned"                   => unsigned&.to_dynamic,
      "UseSerializers"             => use_serializers&.to_dynamic,
      "ushort"                     => ushort&.to_dynamic,
      "using"                      => using&.to_dynamic,
      "Utf8JsonReader"             => utf8_json_reader&.to_dynamic,
      "Utf8JsonWriter"             => utf8_json_writer&.to_dynamic,
      "UUID"                       => uuid&.to_dynamic,
      "var"                        => var&.to_dynamic,
      "virtual"                    => virtual&.to_dynamic,
      "void"                       => void&.to_dynamic,
      "volatile"                   => volatile&.to_dynamic,
      "wchar_t"                    => wchar_t&.to_dynamic,
      "weak"                       => weak&.to_dynamic,
      "where"                      => where&.to_dynamic,
      "while"                      => top_level_while&.to_dynamic,
      "willSet"                    => will_set&.to_dynamic,
      "with"                       => top_level_with&.to_dynamic,
      "xor"                        => xor&.to_dynamic,
      "xor_eq"                     => xor_eq&.to_dynamic,
      "YES"                        => yes&.to_dynamic,
      "yield"                      => top_level_yield&.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
