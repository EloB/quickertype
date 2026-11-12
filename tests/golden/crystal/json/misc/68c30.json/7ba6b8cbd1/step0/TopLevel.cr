require "json"

class TopLevel
  include JSON::Serializable

  property txs : Array(Tx)
end

class Tx
  include JSON::Serializable

  property double_spend : Bool

  property hash : String

  property inputs : Array(Input)

  property lock_time : Int64

  property relayed_by : String

  property size : Int64

  property time : Int64

  property tx_index : Int64

  @[JSON::Field(key: "out")]
  property tx_out : Array(Out)

  property ver : Int64

  property vin_sz : Int64

  property vout_sz : Int64
end

class Input
  include JSON::Serializable

  property prev_out : Out

  property script : String

  property sequence : Int64
end

class Out
  include JSON::Serializable

  property addr : String

  property n : Int64

  @[JSON::Field(key: "type")]
  property out_type : Int64

  property script : String

  property spent : Bool

  property tx_index : Int64

  property value : Int64
end
