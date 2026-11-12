# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.product.first.product.thumbnail.formats&.first
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

# (forward declaration)
class Format < Dry::Struct; end

# (forward declaration)
class FormatsClass < Dry::Struct; end

class LinkLink < Dry::Struct
  attribute :link_type, Types::String
  attribute :url,       Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      link_type: d.fetch("type"),
      url:       d.fetch("url"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "type" => link_type,
      "url"  => url,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class LinkElement < Dry::Struct
  attribute :link, LinkLink

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      link: LinkLink.from_dynamic!(d.fetch("link")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "link" => link.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class CategoryThumbnail < Dry::Struct
  attribute :url, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      url: d.fetch("url"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "url" => url,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Category < Dry::Struct
  attribute :category_name,           Types::String
  attribute :concatenatecategoryname, Types::Bool
  attribute :hasoffer,                Types::Bool
  attribute :id,                      Types::Integer
  attribute :isfinal,                 Types::Bool
  attribute :links,                   Types.Array(LinkElement)
  attribute :parentcategoryid,        Types::Integer
  attribute :thumbnail,               CategoryThumbnail

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      category_name:           d.fetch("name"),
      concatenatecategoryname: d.fetch("concatenatecategoryname"),
      hasoffer:                d.fetch("hasoffer"),
      id:                      d.fetch("id"),
      isfinal:                 d.fetch("isfinal"),
      links:                   d.fetch("links").map { |x| LinkElement.from_dynamic!(x) },
      parentcategoryid:        d.fetch("parentcategoryid"),
      thumbnail:               CategoryThumbnail.from_dynamic!(d.fetch("thumbnail")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "name"                    => category_name,
      "concatenatecategoryname" => concatenatecategoryname,
      "hasoffer"                => hasoffer,
      "id"                      => id,
      "isfinal"                 => isfinal,
      "links"                   => links.map { |x| x.to_dynamic },
      "parentcategoryid"        => parentcategoryid,
      "thumbnail"               => thumbnail.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Eonandyear < Dry::Struct
  attribute :lowestsetbit, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      lowestsetbit: d.fetch("lowestsetbit"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "lowestsetbit" => lowestsetbit,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Xmlschematype < Dry::Struct
  attribute :localpart,    Types::String
  attribute :namespaceuri, Types::String
  attribute :prefix,       Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      localpart:    d.fetch("localpart"),
      namespaceuri: d.fetch("namespaceuri"),
      prefix:       d.fetch("prefix"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "localpart"    => localpart,
      "namespaceuri" => namespaceuri,
      "prefix"       => prefix,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class DateClass < Dry::Struct
  attribute :day,           Types::Integer
  attribute :eonandyear,    Eonandyear
  attribute :hour,          Types::Integer
  attribute :millisecond,   Types::Integer
  attribute :minute,        Types::Integer
  attribute :month,         Types::Integer
  attribute :second,        Types::Integer
  attribute :timezone,      Types::Integer
  attribute :valid,         Types::Bool
  attribute :xmlschematype, Xmlschematype
  attribute :year,          Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      day:           d.fetch("day"),
      eonandyear:    Eonandyear.from_dynamic!(d.fetch("eonandyear")),
      hour:          d.fetch("hour"),
      millisecond:   d.fetch("millisecond"),
      minute:        d.fetch("minute"),
      month:         d.fetch("month"),
      second:        d.fetch("second"),
      timezone:      d.fetch("timezone"),
      valid:         d.fetch("valid"),
      xmlschematype: Xmlschematype.from_dynamic!(d.fetch("xmlschematype")),
      year:          d.fetch("year"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "day"           => day,
      "eonandyear"    => eonandyear.to_dynamic,
      "hour"          => hour,
      "millisecond"   => millisecond,
      "minute"        => minute,
      "month"         => month,
      "second"        => second,
      "timezone"      => timezone,
      "valid"         => valid,
      "xmlschematype" => xmlschematype.to_dynamic,
      "year"          => year,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Details < Dry::Struct
  attribute :applicationid,      Types::String
  attribute :applicationversion, Types::String
  attribute :code,               Types::Integer
  attribute :date,               DateClass
  attribute :elapsedtime,        Types::Integer
  attribute :message,            Types::String
  attribute :status,             Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      applicationid:      d.fetch("applicationid"),
      applicationversion: d.fetch("applicationversion"),
      code:               d.fetch("code"),
      date:               DateClass.from_dynamic!(d.fetch("date")),
      elapsedtime:        d.fetch("elapsedtime"),
      message:            d.fetch("message"),
      status:             d.fetch("status"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "applicationid"      => applicationid,
      "applicationversion" => applicationversion,
      "code"               => code,
      "date"               => date.to_dynamic,
      "elapsedtime"        => elapsedtime,
      "message"            => message,
      "status"             => status,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Currency < Dry::Struct
  attribute :abbreviation, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      abbreviation: d.fetch("abbreviation"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "abbreviation" => abbreviation,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Useraveragerating < Dry::Struct
  attribute :links,       Types.Array(LinkElement)
  attribute :numcomments, Types::Integer
  attribute :rating,      Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      links:       d.fetch("links").map { |x| LinkElement.from_dynamic!(x) },
      numcomments: d.fetch("numcomments"),
      rating:      d.fetch("rating"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "links"       => links.map { |x| x.to_dynamic },
      "numcomments" => numcomments,
      "rating"      => rating,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Rating < Dry::Struct
  attribute :useraveragerating, Useraveragerating

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      useraveragerating: Useraveragerating.from_dynamic!(d.fetch("useraveragerating")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "useraveragerating" => useraveragerating.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Specification < Dry::Struct
  attribute :links, Types.Array(LinkElement)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      links: d.fetch("links").map { |x| LinkElement.from_dynamic!(x) },
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "links" => links.map { |x| x.to_dynamic },
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Format < Dry::Struct
  attribute :formats, FormatsClass

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      formats: FormatsClass.from_dynamic!(d.fetch("formats")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "formats" => formats.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class FormatsClass < Dry::Struct
  attribute :formats, Types.Array(Format).optional
  attribute :height,  Types::Integer
  attribute :url,     Types::String
  attribute :width,   Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      formats: d.key?("formats") ? d["formats"].map { |x| Format.from_dynamic!(x) } : nil,
      height:  d.fetch("height"),
      url:     d.fetch("url"),
      width:   d.fetch("width"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "formats" => formats&.map { |x| x.to_dynamic },
      "height"  => height,
      "url"     => url,
      "width"   => width,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ProductProduct < Dry::Struct
  attribute :categoryid,      Types::Integer
  attribute :currency,        Currency
  attribute :eco,             Types::Bool
  attribute :fulldescription, Types::Bool
  attribute :hasmetasearch,   Types::Bool
  attribute :id,              Types::Integer
  attribute :links,           Types.Array(LinkElement)
  attribute :numoffers,       Types::Integer
  attribute :pricemax,        Types::String
  attribute :pricemin,        Types::String
  attribute :productname,     Types::String
  attribute :quantity,        Types::Integer
  attribute :rating,          Rating
  attribute :specification,   Specification
  attribute :thumbnail,       FormatsClass
  attribute :totalsellers,    Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      categoryid:      d.fetch("categoryid"),
      currency:        Currency.from_dynamic!(d.fetch("currency")),
      eco:             d.fetch("eco"),
      fulldescription: d.fetch("fulldescription"),
      hasmetasearch:   d.fetch("hasmetasearch"),
      id:              d.fetch("id"),
      links:           d.fetch("links").map { |x| LinkElement.from_dynamic!(x) },
      numoffers:       d.fetch("numoffers"),
      pricemax:        d.fetch("pricemax"),
      pricemin:        d.fetch("pricemin"),
      productname:     d.fetch("productname"),
      quantity:        d.fetch("quantity"),
      rating:          Rating.from_dynamic!(d.fetch("rating")),
      specification:   Specification.from_dynamic!(d.fetch("specification")),
      thumbnail:       FormatsClass.from_dynamic!(d.fetch("thumbnail")),
      totalsellers:    d.fetch("totalsellers"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "categoryid"      => categoryid,
      "currency"        => currency.to_dynamic,
      "eco"             => eco,
      "fulldescription" => fulldescription,
      "hasmetasearch"   => hasmetasearch,
      "id"              => id,
      "links"           => links.map { |x| x.to_dynamic },
      "numoffers"       => numoffers,
      "pricemax"        => pricemax,
      "pricemin"        => pricemin,
      "productname"     => productname,
      "quantity"        => quantity,
      "rating"          => rating.to_dynamic,
      "specification"   => specification.to_dynamic,
      "thumbnail"       => thumbnail.to_dynamic,
      "totalsellers"    => totalsellers,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ProductElement < Dry::Struct
  attribute :product, ProductProduct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      product: ProductProduct.from_dynamic!(d.fetch("product")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "product" => product.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :category,              Category
  attribute :details,               Details
  attribute :match,                 Types::String
  attribute :page,                  Types::Integer
  attribute :product,               Types.Array(ProductElement)
  attribute :schk,                  Types::Bool
  attribute :totallooseoffers,      Types::Integer
  attribute :totalpages,            Types::Integer
  attribute :totalresultsavailable, Types::Integer
  attribute :totalresultsreturned,  Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      category:              Category.from_dynamic!(d.fetch("category")),
      details:               Details.from_dynamic!(d.fetch("details")),
      match:                 d.fetch("match"),
      page:                  d.fetch("page"),
      product:               d.fetch("product").map { |x| ProductElement.from_dynamic!(x) },
      schk:                  d.fetch("schk"),
      totallooseoffers:      d.fetch("totallooseoffers"),
      totalpages:            d.fetch("totalpages"),
      totalresultsavailable: d.fetch("totalresultsavailable"),
      totalresultsreturned:  d.fetch("totalresultsreturned"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "category"              => category.to_dynamic,
      "details"               => details.to_dynamic,
      "match"                 => match,
      "page"                  => page,
      "product"               => product.map { |x| x.to_dynamic },
      "schk"                  => schk,
      "totallooseoffers"      => totallooseoffers,
      "totalpages"            => totalpages,
      "totalresultsavailable" => totalresultsavailable,
      "totalresultsreturned"  => totalresultsreturned,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
