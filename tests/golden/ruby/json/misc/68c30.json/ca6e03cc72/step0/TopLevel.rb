# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.txs.first.out.first.addr
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Integer = Strict::Integer
  Bool    = Strict::Bool
  Hash    = Strict::Hash
  String  = Strict::String
end

class Out < Dry::Struct
  attribute :addr,     Types::String
  attribute :n,        Types::Integer
  attribute :out_type, Types::Integer
  attribute :script,   Types::String
  attribute :spent,    Types::Bool
  attribute :tx_index, Types::Integer
  attribute :value,    Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      addr:     d.fetch("addr"),
      n:        d.fetch("n"),
      out_type: d.fetch("type"),
      script:   d.fetch("script"),
      spent:    d.fetch("spent"),
      tx_index: d.fetch("tx_index"),
      value:    d.fetch("value"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "addr"     => addr,
      "n"        => n,
      "type"     => out_type,
      "script"   => script,
      "spent"    => spent,
      "tx_index" => tx_index,
      "value"    => value,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Input < Dry::Struct
  attribute :prev_out, Out
  attribute :script,   Types::String
  attribute :sequence, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      prev_out: Out.from_dynamic!(d.fetch("prev_out")),
      script:   d.fetch("script"),
      sequence: d.fetch("sequence"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "prev_out" => prev_out.to_dynamic,
      "script"   => script,
      "sequence" => sequence,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Tx < Dry::Struct
  attribute :double_spend, Types::Bool
  attribute :inputs,       Types.Array(Input)
  attribute :lock_time,    Types::Integer
  attribute :out,          Types.Array(Out)
  attribute :relayed_by,   Types::String
  attribute :size,         Types::Integer
  attribute :time,         Types::Integer
  attribute :tx_hash,      Types::String
  attribute :tx_index,     Types::Integer
  attribute :ver,          Types::Integer
  attribute :vin_sz,       Types::Integer
  attribute :vout_sz,      Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      double_spend: d.fetch("double_spend"),
      inputs:       d.fetch("inputs").map { |x| Input.from_dynamic!(x) },
      lock_time:    d.fetch("lock_time"),
      out:          d.fetch("out").map { |x| Out.from_dynamic!(x) },
      relayed_by:   d.fetch("relayed_by"),
      size:         d.fetch("size"),
      time:         d.fetch("time"),
      tx_hash:      d.fetch("hash"),
      tx_index:     d.fetch("tx_index"),
      ver:          d.fetch("ver"),
      vin_sz:       d.fetch("vin_sz"),
      vout_sz:      d.fetch("vout_sz"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "double_spend" => double_spend,
      "inputs"       => inputs.map { |x| x.to_dynamic },
      "lock_time"    => lock_time,
      "out"          => out.map { |x| x.to_dynamic },
      "relayed_by"   => relayed_by,
      "size"         => size,
      "time"         => time,
      "hash"         => tx_hash,
      "tx_index"     => tx_index,
      "ver"          => ver,
      "vin_sz"       => vin_sz,
      "vout_sz"      => vout_sz,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :txs, Types.Array(Tx)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      txs: d.fetch("txs").map { |x| Tx.from_dynamic!(x) },
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "txs" => txs.map { |x| x.to_dynamic },
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
