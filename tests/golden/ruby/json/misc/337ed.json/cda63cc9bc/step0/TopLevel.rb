# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.results.first.custom_incomes.first.amount.even?
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Integer          = Strict::Integer
  Nil              = Strict::Nil
  Bool             = Strict::Bool
  Hash             = Strict::Hash
  String           = Strict::String
  CustomIncomeType = Strict::String.enum("public", "other")
  Status           = Strict::String.enum("active", "inactive")
  ResultType       = Strict::String.enum("FinancialDataNGO", "FinancialDataLawyer", "FinancialDataTradeAssociation")
end

class Facets < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

module CustomIncomeType
  Public = "public"
  Other  = "other"
end

module Status
  Active   = "active"
  Inactive = "inactive"
end

class CustomIncome < Dry::Struct
  attribute :amount,             Types::Integer
  attribute :created_at,         Types::String.constrained(format: /\A\d{4}-\d\d-\d\dT\d\d:\d\d:\d\d(?:\.\d+)?(?:Z|[+-]\d\d:\d\d)\z/i)
  attribute :custom_income_name, Types::String
  attribute :custom_income_type, Types::CustomIncomeType
  attribute :id,                 Types::String
  attribute :status,             Types::Status
  attribute :updated_at,         Types::String.constrained(format: /\A\d{4}-\d\d-\d\dT\d\d:\d\d:\d\d(?:\.\d+)?(?:Z|[+-]\d\d:\d\d)\z/i)
  attribute :uri,                Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      amount:             d.fetch("amount"),
      created_at:         d.fetch("created_at"),
      custom_income_name: d.fetch("name"),
      custom_income_type: d.fetch("type"),
      id:                 d.fetch("id"),
      status:             d.fetch("status"),
      updated_at:         d.fetch("updated_at"),
      uri:                d.fetch("uri"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "amount"     => amount,
      "created_at" => created_at,
      "name"       => custom_income_name,
      "type"       => custom_income_type,
      "id"         => id,
      "status"     => status,
      "updated_at" => updated_at,
      "uri"        => uri,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

module ResultType
  FinancialDataNGO              = "FinancialDataNGO"
  FinancialDataLawyer           = "FinancialDataLawyer"
  FinancialDataTradeAssociation = "FinancialDataTradeAssociation"
end

class Result < Dry::Struct
  attribute :cost_absolute,                  Types::Integer.optional
  attribute :cost_max,                       Types::Integer.optional
  attribute :cost_min,                       Types::Integer.optional
  attribute :created_at,                     Types::String.constrained(format: /\A\d{4}-\d\d-\d\dT\d\d:\d\d:\d\d(?:\.\d+)?(?:Z|[+-]\d\d:\d\d)\z/i)
  attribute :custom_incomes,                 Types.Array(CustomIncome)
  attribute :direct_rep_costs_max,           Types::Nil
  attribute :direct_rep_costs_min,           Types::Nil
  attribute :end_date,                       Types::String.constrained(format: /\A\d{4}-\d\d-\d\dT\d\d:\d\d:\d\d(?:\.\d+)?(?:Z|[+-]\d\d:\d\d)\z/i)
  attribute :eur_sources_grants,             Types::Integer
  attribute :eur_sources_grants_src,         Types::String.optional
  attribute :eur_sources_procurement,        Types::Integer
  attribute :eur_sources_procurement_src,    Types::String.optional
  attribute :id,                             Types::String
  attribute :new_organisation,               Types::Nil
  attribute :no_clients,                     Types::String.optional
  attribute :other_financial_information,    Types::String.optional
  attribute :other_sources_contributions,    Types::Integer.optional
  attribute :other_sources_donation,         Types::Integer.optional
  attribute :other_sources_total,            Types::Integer.optional
  attribute :public_financing_infranational, Types::Integer.optional
  attribute :public_financing_national,      Types::Integer.optional
  attribute :public_financing_total,         Types::Integer.optional
  attribute :representative,                 Types::String
  attribute :result_type,                    Types::ResultType
  attribute :start_date,                     Types::String.constrained(format: /\A\d{4}-\d\d-\d\dT\d\d:\d\d:\d\d(?:\.\d+)?(?:Z|[+-]\d\d:\d\d)\z/i)
  attribute :status,                         Types::Status
  attribute :total_budget,                   Types::Integer.optional
  attribute :turnover_absolute,              Types::Integer.optional
  attribute :turnover_max,                   Types::Integer.optional
  attribute :turnover_min,                   Types::Integer.optional
  attribute :updated_at,                     Types::String.constrained(format: /\A\d{4}-\d\d-\d\dT\d\d:\d\d:\d\d(?:\.\d+)?(?:Z|[+-]\d\d:\d\d)\z/i)
  attribute :uri,                            Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      cost_absolute:                  d.fetch("cost_absolute"),
      cost_max:                       d.fetch("cost_max"),
      cost_min:                       d.fetch("cost_min"),
      created_at:                     d.fetch("created_at"),
      custom_incomes:                 d.fetch("customIncomes").map { |x| CustomIncome.from_dynamic!(x) },
      direct_rep_costs_max:           d.fetch("direct_rep_costs_max"),
      direct_rep_costs_min:           d.fetch("direct_rep_costs_min"),
      end_date:                       d.fetch("end_date"),
      eur_sources_grants:             d.fetch("eur_sources_grants"),
      eur_sources_grants_src:         d.fetch("eur_sources_grants_src"),
      eur_sources_procurement:        d.fetch("eur_sources_procurement"),
      eur_sources_procurement_src:    d.fetch("eur_sources_procurement_src"),
      id:                             d.fetch("id"),
      new_organisation:               d.fetch("new_organisation"),
      no_clients:                     d.fetch("no_clients"),
      other_financial_information:    d.fetch("other_financial_information"),
      other_sources_contributions:    d.fetch("other_sources_contributions"),
      other_sources_donation:         d.fetch("other_sources_donation"),
      other_sources_total:            d.fetch("other_sources_total"),
      public_financing_infranational: d.fetch("public_financing_infranational"),
      public_financing_national:      d.fetch("public_financing_national"),
      public_financing_total:         d.fetch("public_financing_total"),
      representative:                 d.fetch("representative"),
      result_type:                    d.fetch("type"),
      start_date:                     d.fetch("start_date"),
      status:                         d.fetch("status"),
      total_budget:                   d.fetch("total_budget"),
      turnover_absolute:              d.fetch("turnover_absolute"),
      turnover_max:                   d.fetch("turnover_max"),
      turnover_min:                   d.fetch("turnover_min"),
      updated_at:                     d.fetch("updated_at"),
      uri:                            d.fetch("uri"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "cost_absolute"                  => cost_absolute,
      "cost_max"                       => cost_max,
      "cost_min"                       => cost_min,
      "created_at"                     => created_at,
      "customIncomes"                  => custom_incomes.map { |x| x.to_dynamic },
      "direct_rep_costs_max"           => direct_rep_costs_max,
      "direct_rep_costs_min"           => direct_rep_costs_min,
      "end_date"                       => end_date,
      "eur_sources_grants"             => eur_sources_grants,
      "eur_sources_grants_src"         => eur_sources_grants_src,
      "eur_sources_procurement"        => eur_sources_procurement,
      "eur_sources_procurement_src"    => eur_sources_procurement_src,
      "id"                             => id,
      "new_organisation"               => new_organisation,
      "no_clients"                     => no_clients,
      "other_financial_information"    => other_financial_information,
      "other_sources_contributions"    => other_sources_contributions,
      "other_sources_donation"         => other_sources_donation,
      "other_sources_total"            => other_sources_total,
      "public_financing_infranational" => public_financing_infranational,
      "public_financing_national"      => public_financing_national,
      "public_financing_total"         => public_financing_total,
      "representative"                 => representative,
      "type"                           => result_type,
      "start_date"                     => start_date,
      "status"                         => status,
      "total_budget"                   => total_budget,
      "turnover_absolute"              => turnover_absolute,
      "turnover_max"                   => turnover_max,
      "turnover_min"                   => turnover_min,
      "updated_at"                     => updated_at,
      "uri"                            => uri,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :count,          Types::Integer
  attribute :facets,         Facets
  attribute :limit,          Types::Integer
  attribute :offset,         Types::Integer
  attribute :previous,       Types::Bool
  attribute :results,        Types.Array(Result)
  attribute :top_level_next, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      count:          d.fetch("count"),
      facets:         Facets.from_dynamic!(d.fetch("facets")),
      limit:          d.fetch("limit"),
      offset:         d.fetch("offset"),
      previous:       d.fetch("previous"),
      results:        d.fetch("results").map { |x| Result.from_dynamic!(x) },
      top_level_next: d.fetch("next"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "count"    => count,
      "facets"   => facets.to_dynamic,
      "limit"    => limit,
      "offset"   => offset,
      "previous" => previous,
      "results"  => results.map { |x| x.to_dynamic },
      "next"     => top_level_next,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
