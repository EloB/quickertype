# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.groups.first.children.first.even?
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Integer             = Strict::Integer
  Bool                = Strict::Bool
  Hash                = Strict::Hash
  String              = Strict::String
  Name                = Strict::String.enum("string", "number", "void", "T", "boolean", "BaseClass", "any", "Array", "MyNumber")
  TypeEnum            = Strict::String.enum("intrinsic", "reflection", "array", "reference", "typeParameter", "tuple", "union", "stringLiteral")
  KindString1         = Strict::String.enum("Variable", "Function", "Property", "Method", "Constructor", "Accessor", "Enumeration member", "Module", "Object literal")
  FileName            = Strict::String.enum("modules.ts", "classes.ts", "flattened.ts", "access.ts", "default-export.ts", "enumerations.ts", "functions.ts", "generics.ts", "single-export.ts", "typescript-1.3.ts", "typescript-1.4.ts", "typescript-1.5.ts", "variables.ts")
  ParameterKindString = Strict::String.enum("Parameter")
  SignatureKindString = Strict::String.enum("Call signature", "Constructor signature")
  KindString2         = Strict::String.enum("Module", "Class", "Variable", "Function", "Interface", "Enumeration", "Object literal", "Type alias")
  KindString3         = Strict::String.enum("External module")
end

# (forward declaration)
class IndexSignatureElement < Dry::Struct; end

# (forward declaration)
class GetSignatureType < Dry::Struct; end

# (forward declaration)
class Type1 < Dry::Struct; end

# (forward declaration)
class GetSignatureChild < Dry::Struct; end

# (forward declaration)
class GetSignature < Dry::Struct; end

class GetSignatureFlags < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

module Name
  String    = "string"
  Number    = "number"
  Void      = "void"
  T         = "T"
  Boolean   = "boolean"
  BaseClass = "BaseClass"
  Any       = "any"
  Array     = "Array"
  MyNumber  = "MyNumber"
end

module TypeEnum
  Intrinsic     = "intrinsic"
  Reflection    = "reflection"
  Array         = "array"
  Reference     = "reference"
  TypeParameter = "typeParameter"
  Tuple         = "tuple"
  Union         = "union"
  StringLiteral = "stringLiteral"
end

class ElementType < Dry::Struct
  attribute :element_type_name, Types::Name
  attribute :element_type_type, Types::TypeEnum

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      element_type_name: d.fetch("name"),
      element_type_type: d.fetch("type"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "name" => element_type_name,
      "type" => element_type_type,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Comment2 < Dry::Struct
  attribute :text, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      text: d.fetch("text"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "text" => text,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Flags2 < Dry::Struct
  attribute :is_optional, Types::Bool.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      is_optional: d.key?("isOptional") ? Types::Bool[d["isOptional"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "isOptional" => is_optional,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

module KindString1
  Variable          = "Variable"
  Function          = "Function"
  Property          = "Property"
  Method            = "Method"
  Constructor       = "Constructor"
  Accessor          = "Accessor"
  EnumerationMember = "Enumeration member"
  Module            = "Module"
  ObjectLiteral     = "Object literal"
end

module FileName
  ModulesTs       = "modules.ts"
  ClassesTs       = "classes.ts"
  FlattenedTs     = "flattened.ts"
  AccessTs        = "access.ts"
  DefaultExportTs = "default-export.ts"
  EnumerationsTs  = "enumerations.ts"
  FunctionsTs     = "functions.ts"
  GenericsTs      = "generics.ts"
  SingleExportTs  = "single-export.ts"
  Typescript13Ts  = "typescript-1.3.ts"
  Typescript14Ts  = "typescript-1.4.ts"
  Typescript15Ts  = "typescript-1.5.ts"
  VariablesTs     = "variables.ts"
end

class Source < Dry::Struct
  attribute :character, Types::Integer
  attribute :file_name, Types::FileName
  attribute :line,      Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      character: d.fetch("character"),
      file_name: d.fetch("fileName"),
      line:      d.fetch("line"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "character" => character,
      "fileName"  => file_name,
      "line"      => line,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class GetSignatureComment < Dry::Struct
  attribute :returns,    Types::String.optional
  attribute :short_text, Types::String.optional
  attribute :text,       Types::String.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      returns:    d.key?("returns") ? Types::String[d["returns"]] : nil,
      short_text: d.key?("shortText") ? Types::String[d["shortText"]] : nil,
      text:       d.key?("text") ? Types::String[d["text"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "returns"   => returns,
      "shortText" => short_text,
      "text"      => text,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Group < Dry::Struct
  attribute :children, Types.Array(Types::Integer)
  attribute :kind,     Types::Integer
  attribute :title,    Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      children: d.fetch("children"),
      kind:     d.fetch("kind"),
      title:    d.fetch("title"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "children" => children,
      "kind"     => kind,
      "title"    => title,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Comment3 < Dry::Struct
  attribute :short_text, Types::String.optional
  attribute :text,       Types::String.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      short_text: d.key?("shortText") ? Types::String[d["shortText"]] : nil,
      text:       d.key?("text") ? Types::String[d["text"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "shortText" => short_text,
      "text"      => text,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Flags3 < Dry::Struct
  attribute :is_optional, Types::Bool.optional
  attribute :is_rest,     Types::Bool.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      is_optional: d.key?("isOptional") ? Types::Bool[d["isOptional"]] : nil,
      is_rest:     d.key?("isRest") ? Types::Bool[d["isRest"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "isOptional" => is_optional,
      "isRest"     => is_rest,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

module ParameterKindString
  Parameter = "Parameter"
end

class Type2 < Dry::Struct
  attribute :element_type,   ElementType.optional
  attribute :type_arguments, Types.Array(ElementType).optional
  attribute :type_name,      Types::Name.optional
  attribute :type_type,      Types::TypeEnum

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      element_type:   d.key?("elementType") ? ElementType.from_dynamic!(d["elementType"]) : nil,
      type_arguments: d.key?("typeArguments") ? d["typeArguments"].map { |x| ElementType.from_dynamic!(x) } : nil,
      type_name:      d.key?("name") ? Types::Name[d["name"]] : nil,
      type_type:      d.fetch("type"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "elementType"   => element_type&.to_dynamic,
      "typeArguments" => type_arguments&.map { |x| x.to_dynamic },
      "name"          => type_name,
      "type"          => type_type,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class GetSignatureParameter < Dry::Struct
  attribute :comment,        Comment3.optional
  attribute :flags,          Flags3
  attribute :id,             Types::Integer
  attribute :kind,           Types::Integer
  attribute :kind_string,    Types::ParameterKindString
  attribute :parameter_name, Types::String
  attribute :parameter_type, Type2

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      comment:        d.key?("comment") ? Comment3.from_dynamic!(d["comment"]) : nil,
      flags:          Flags3.from_dynamic!(d.fetch("flags")),
      id:             d.fetch("id"),
      kind:           d.fetch("kind"),
      kind_string:    d.fetch("kindString"),
      parameter_name: d.fetch("name"),
      parameter_type: Type2.from_dynamic!(d.fetch("type")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "comment"    => comment&.to_dynamic,
      "flags"      => flags.to_dynamic,
      "id"         => id,
      "kind"       => kind,
      "kindString" => kind_string,
      "name"       => parameter_name,
      "type"       => parameter_type.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class IndexSignatureElement < Dry::Struct
  attribute :flags,          GetSignatureFlags
  attribute :id,             Types::Integer
  attribute :kind,           Types::Integer
  attribute :kind_string,    Types::String
  attribute :parameters,     Types.Array(GetSignature).optional
  attribute :signature_name, Types::String
  attribute :signature_type, Type1

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      flags:          GetSignatureFlags.from_dynamic!(d.fetch("flags")),
      id:             d.fetch("id"),
      kind:           d.fetch("kind"),
      kind_string:    d.fetch("kindString"),
      parameters:     d.key?("parameters") ? d["parameters"].map { |x| GetSignature.from_dynamic!(x) } : nil,
      signature_name: d.fetch("name"),
      signature_type: Type1.from_dynamic!(d.fetch("type")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "flags"      => flags.to_dynamic,
      "id"         => id,
      "kind"       => kind,
      "kindString" => kind_string,
      "parameters" => parameters&.map { |x| x.to_dynamic },
      "name"       => signature_name,
      "type"       => signature_type.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class GetSignatureType < Dry::Struct
  attribute :declaration,  GetSignature.optional
  attribute :element_type, ElementType.optional
  attribute :type_name,    Types::Name.optional
  attribute :type_type,    Types::TypeEnum

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      declaration:  d.key?("declaration") ? GetSignature.from_dynamic!(d["declaration"]) : nil,
      element_type: d.key?("elementType") ? ElementType.from_dynamic!(d["elementType"]) : nil,
      type_name:    d.key?("name") ? Types::Name[d["name"]] : nil,
      type_type:    d.fetch("type"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "declaration" => declaration&.to_dynamic,
      "elementType" => element_type&.to_dynamic,
      "name"        => type_name,
      "type"        => type_type,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Type1 < Dry::Struct
  attribute :declaration, GetSignature.optional
  attribute :type_name,   Types::Name.optional
  attribute :type_type,   Types::TypeEnum

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      declaration: d.key?("declaration") ? GetSignature.from_dynamic!(d["declaration"]) : nil,
      type_name:   d.key?("name") ? Types::Name[d["name"]] : nil,
      type_type:   d.fetch("type"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "declaration" => declaration&.to_dynamic,
      "name"        => type_name,
      "type"        => type_type,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class GetSignatureChild < Dry::Struct
  attribute :child_name,  Types::String
  attribute :child_type,  Type1
  attribute :comment,     Comment2.optional
  attribute :flags,       Flags2
  attribute :id,          Types::Integer
  attribute :kind,        Types::Integer
  attribute :kind_string, Types::KindString1
  attribute :sources,     Types.Array(Source)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      child_name:  d.fetch("name"),
      child_type:  Type1.from_dynamic!(d.fetch("type")),
      comment:     d.key?("comment") ? Comment2.from_dynamic!(d["comment"]) : nil,
      flags:       Flags2.from_dynamic!(d.fetch("flags")),
      id:          d.fetch("id"),
      kind:        d.fetch("kind"),
      kind_string: d.fetch("kindString"),
      sources:     d.fetch("sources").map { |x| Source.from_dynamic!(x) },
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "name"       => child_name,
      "type"       => child_type.to_dynamic,
      "comment"    => comment&.to_dynamic,
      "flags"      => flags.to_dynamic,
      "id"         => id,
      "kind"       => kind,
      "kindString" => kind_string,
      "sources"    => sources.map { |x| x.to_dynamic },
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class GetSignature < Dry::Struct
  attribute :children,           Types.Array(GetSignatureChild).optional
  attribute :comment,            GetSignatureComment.optional
  attribute :default_value,      Types::String.optional
  attribute :flags,              GetSignatureFlags
  attribute :get_signature_name, Types::String
  attribute :get_signature_type, GetSignatureType.optional
  attribute :groups,             Types.Array(Group).optional
  attribute :id,                 Types::Integer
  attribute :kind,               Types::Integer
  attribute :kind_string,        Types::String
  attribute :parameters,         Types.Array(GetSignatureParameter).optional
  attribute :signatures,         Types.Array(IndexSignatureElement).optional
  attribute :sources,            Types.Array(Source).optional
  attribute :type_parameter,     Types.Array(GetSignature).optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      children:           d.key?("children") ? d["children"].map { |x| GetSignatureChild.from_dynamic!(x) } : nil,
      comment:            d.key?("comment") ? GetSignatureComment.from_dynamic!(d["comment"]) : nil,
      default_value:      d.key?("defaultValue") ? Types::String[d["defaultValue"]] : nil,
      flags:              GetSignatureFlags.from_dynamic!(d.fetch("flags")),
      get_signature_name: d.fetch("name"),
      get_signature_type: d.key?("type") ? GetSignatureType.from_dynamic!(d["type"]) : nil,
      groups:             d.key?("groups") ? d["groups"].map { |x| Group.from_dynamic!(x) } : nil,
      id:                 d.fetch("id"),
      kind:               d.fetch("kind"),
      kind_string:        d.fetch("kindString"),
      parameters:         d.key?("parameters") ? d["parameters"].map { |x| GetSignatureParameter.from_dynamic!(x) } : nil,
      signatures:         d.key?("signatures") ? d["signatures"].map { |x| IndexSignatureElement.from_dynamic!(x) } : nil,
      sources:            d.key?("sources") ? d["sources"].map { |x| Source.from_dynamic!(x) } : nil,
      type_parameter:     d.key?("typeParameter") ? d["typeParameter"].map { |x| GetSignature.from_dynamic!(x) } : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "children"      => children&.map { |x| x.to_dynamic },
      "comment"       => comment&.to_dynamic,
      "defaultValue"  => default_value,
      "flags"         => flags.to_dynamic,
      "name"          => get_signature_name,
      "type"          => get_signature_type&.to_dynamic,
      "groups"        => groups&.map { |x| x.to_dynamic },
      "id"            => id,
      "kind"          => kind,
      "kindString"    => kind_string,
      "parameters"    => parameters&.map { |x| x.to_dynamic },
      "signatures"    => signatures&.map { |x| x.to_dynamic },
      "sources"       => sources&.map { |x| x.to_dynamic },
      "typeParameter" => type_parameter&.map { |x| x.to_dynamic },
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Declaration5 < Dry::Struct
  attribute :children,         Types.Array(GetSignature).optional
  attribute :declaration_name, Types::String
  attribute :flags,            GetSignatureFlags
  attribute :groups,           Types.Array(Group).optional
  attribute :id,               Types::Integer
  attribute :kind,             Types::Integer
  attribute :kind_string,      Types::String
  attribute :signatures,       Types.Array(GetSignature).optional
  attribute :sources,          Types.Array(Source)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      children:         d.key?("children") ? d["children"].map { |x| GetSignature.from_dynamic!(x) } : nil,
      declaration_name: d.fetch("name"),
      flags:            GetSignatureFlags.from_dynamic!(d.fetch("flags")),
      groups:           d.key?("groups") ? d["groups"].map { |x| Group.from_dynamic!(x) } : nil,
      id:               d.fetch("id"),
      kind:             d.fetch("kind"),
      kind_string:      d.fetch("kindString"),
      signatures:       d.key?("signatures") ? d["signatures"].map { |x| GetSignature.from_dynamic!(x) } : nil,
      sources:          d.fetch("sources").map { |x| Source.from_dynamic!(x) },
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "children"   => children&.map { |x| x.to_dynamic },
      "name"       => declaration_name,
      "flags"      => flags.to_dynamic,
      "groups"     => groups&.map { |x| x.to_dynamic },
      "id"         => id,
      "kind"       => kind,
      "kindString" => kind_string,
      "signatures" => signatures&.map { |x| x.to_dynamic },
      "sources"    => sources.map { |x| x.to_dynamic },
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Type11 < Dry::Struct
  attribute :declaration, Declaration5.optional
  attribute :type_name,   Types::Name.optional
  attribute :type_type,   Types::TypeEnum

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      declaration: d.key?("declaration") ? Declaration5.from_dynamic!(d["declaration"]) : nil,
      type_name:   d.key?("name") ? Types::Name[d["name"]] : nil,
      type_type:   d.fetch("type"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "declaration" => declaration&.to_dynamic,
      "name"        => type_name,
      "type"        => type_type,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Child6 < Dry::Struct
  attribute :child_name,  Types::String
  attribute :child_type,  Type11
  attribute :flags,       Flags2
  attribute :id,          Types::Integer
  attribute :kind,        Types::Integer
  attribute :kind_string, Types::KindString1
  attribute :sources,     Types.Array(Source)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      child_name:  d.fetch("name"),
      child_type:  Type11.from_dynamic!(d.fetch("type")),
      flags:       Flags2.from_dynamic!(d.fetch("flags")),
      id:          d.fetch("id"),
      kind:        d.fetch("kind"),
      kind_string: d.fetch("kindString"),
      sources:     d.fetch("sources").map { |x| Source.from_dynamic!(x) },
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "name"       => child_name,
      "type"       => child_type.to_dynamic,
      "flags"      => flags.to_dynamic,
      "id"         => id,
      "kind"       => kind,
      "kindString" => kind_string,
      "sources"    => sources.map { |x| x.to_dynamic },
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Declaration4 < Dry::Struct
  attribute :children,         Types.Array(Child6).optional
  attribute :declaration_name, Types::String
  attribute :flags,            GetSignatureFlags
  attribute :groups,           Types.Array(Group).optional
  attribute :id,               Types::Integer
  attribute :kind,             Types::Integer
  attribute :kind_string,      Types::String
  attribute :signatures,       Types.Array(GetSignature)
  attribute :sources,          Types.Array(Source)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      children:         d.key?("children") ? d["children"].map { |x| Child6.from_dynamic!(x) } : nil,
      declaration_name: d.fetch("name"),
      flags:            GetSignatureFlags.from_dynamic!(d.fetch("flags")),
      groups:           d.key?("groups") ? d["groups"].map { |x| Group.from_dynamic!(x) } : nil,
      id:               d.fetch("id"),
      kind:             d.fetch("kind"),
      kind_string:      d.fetch("kindString"),
      signatures:       d.fetch("signatures").map { |x| GetSignature.from_dynamic!(x) },
      sources:          d.fetch("sources").map { |x| Source.from_dynamic!(x) },
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "children"   => children&.map { |x| x.to_dynamic },
      "name"       => declaration_name,
      "flags"      => flags.to_dynamic,
      "groups"     => groups&.map { |x| x.to_dynamic },
      "id"         => id,
      "kind"       => kind,
      "kindString" => kind_string,
      "signatures" => signatures.map { |x| x.to_dynamic },
      "sources"    => sources.map { |x| x.to_dynamic },
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ExtendedBy < Dry::Struct
  attribute :constraint,       ExtendedBy.optional
  attribute :extended_by_name, Types::String
  attribute :extended_by_type, Types::TypeEnum
  attribute :id,               Types::Integer.optional
  attribute :type_arguments,   Types.Array(ExtendedBy).optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      constraint:       d.key?("constraint") ? ExtendedBy.from_dynamic!(d["constraint"]) : nil,
      extended_by_name: d.fetch("name"),
      extended_by_type: d.fetch("type"),
      id:               d.key?("id") ? Types::Integer[d["id"]] : nil,
      type_arguments:   d.key?("typeArguments") ? d["typeArguments"].map { |x| ExtendedBy.from_dynamic!(x) } : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "constraint"    => constraint&.to_dynamic,
      "name"          => extended_by_name,
      "type"          => extended_by_type,
      "id"            => id,
      "typeArguments" => type_arguments&.map { |x| x.to_dynamic },
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TypeArgument2 < Dry::Struct
  attribute :type_argument_type, Types::TypeEnum
  attribute :types,              Types.Array(ElementType)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      type_argument_type: d.fetch("type"),
      types:              d.fetch("types").map { |x| ElementType.from_dynamic!(x) },
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "type"  => type_argument_type,
      "types" => types.map { |x| x.to_dynamic },
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Type10 < Dry::Struct
  attribute :declaration,    Declaration4.optional
  attribute :element_type,   ElementType.optional
  attribute :elements,       Types.Array(ExtendedBy).optional
  attribute :id,             Types::Integer.optional
  attribute :type_arguments, Types.Array(TypeArgument2).optional
  attribute :type_name,      Types::String.optional
  attribute :type_type,      Types::TypeEnum
  attribute :types,          Types.Array(ExtendedBy).optional
  attribute :value,          Types::String.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      declaration:    d.key?("declaration") ? Declaration4.from_dynamic!(d["declaration"]) : nil,
      element_type:   d.key?("elementType") ? ElementType.from_dynamic!(d["elementType"]) : nil,
      elements:       d.key?("elements") ? d["elements"].map { |x| ExtendedBy.from_dynamic!(x) } : nil,
      id:             d.key?("id") ? Types::Integer[d["id"]] : nil,
      type_arguments: d.key?("typeArguments") ? d["typeArguments"].map { |x| TypeArgument2.from_dynamic!(x) } : nil,
      type_name:      d.key?("name") ? Types::String[d["name"]] : nil,
      type_type:      d.fetch("type"),
      types:          d.key?("types") ? d["types"].map { |x| ExtendedBy.from_dynamic!(x) } : nil,
      value:          d.key?("value") ? Types::String[d["value"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "declaration"   => declaration&.to_dynamic,
      "elementType"   => element_type&.to_dynamic,
      "elements"      => elements&.map { |x| x.to_dynamic },
      "id"            => id,
      "typeArguments" => type_arguments&.map { |x| x.to_dynamic },
      "name"          => type_name,
      "type"          => type_type,
      "types"         => types&.map { |x| x.to_dynamic },
      "value"         => value,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Type6 < Dry::Struct
  attribute :declaration, GetSignature.optional
  attribute :elements,    Types.Array(ElementType).optional
  attribute :type_name,   Types::Name.optional
  attribute :type_type,   Types::TypeEnum

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      declaration: d.key?("declaration") ? GetSignature.from_dynamic!(d["declaration"]) : nil,
      elements:    d.key?("elements") ? d["elements"].map { |x| ElementType.from_dynamic!(x) } : nil,
      type_name:   d.key?("name") ? Types::Name[d["name"]] : nil,
      type_type:   d.fetch("type"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "declaration" => declaration&.to_dynamic,
      "elements"    => elements&.map { |x| x.to_dynamic },
      "name"        => type_name,
      "type"        => type_type,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Child4 < Dry::Struct
  attribute :child_name,  Types::String
  attribute :child_type,  Type6
  attribute :comment,     Comment2.optional
  attribute :flags,       Flags2
  attribute :id,          Types::Integer
  attribute :kind,        Types::Integer
  attribute :kind_string, Types::KindString1
  attribute :sources,     Types.Array(Source)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      child_name:  d.fetch("name"),
      child_type:  Type6.from_dynamic!(d.fetch("type")),
      comment:     d.key?("comment") ? Comment2.from_dynamic!(d["comment"]) : nil,
      flags:       Flags2.from_dynamic!(d.fetch("flags")),
      id:          d.fetch("id"),
      kind:        d.fetch("kind"),
      kind_string: d.fetch("kindString"),
      sources:     d.fetch("sources").map { |x| Source.from_dynamic!(x) },
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "name"       => child_name,
      "type"       => child_type.to_dynamic,
      "comment"    => comment&.to_dynamic,
      "flags"      => flags.to_dynamic,
      "id"         => id,
      "kind"       => kind,
      "kindString" => kind_string,
      "sources"    => sources.map { |x| x.to_dynamic },
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Type7 < Dry::Struct
  attribute :declaration, GetSignature
  attribute :type_type,   Types::TypeEnum

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      declaration: GetSignature.from_dynamic!(d.fetch("declaration")),
      type_type:   d.fetch("type"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "declaration" => declaration.to_dynamic,
      "type"        => type_type,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class IndexSignature < Dry::Struct
  attribute :flags,                GetSignatureFlags
  attribute :id,                   Types::Integer
  attribute :index_signature_name, Types::String
  attribute :index_signature_type, Type7
  attribute :kind,                 Types::Integer
  attribute :kind_string,          Types::String
  attribute :parameters,           Types.Array(GetSignature)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      flags:                GetSignatureFlags.from_dynamic!(d.fetch("flags")),
      id:                   d.fetch("id"),
      index_signature_name: d.fetch("name"),
      index_signature_type: Type7.from_dynamic!(d.fetch("type")),
      kind:                 d.fetch("kind"),
      kind_string:          d.fetch("kindString"),
      parameters:           d.fetch("parameters").map { |x| GetSignature.from_dynamic!(x) },
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "flags"      => flags.to_dynamic,
      "id"         => id,
      "name"       => index_signature_name,
      "type"       => index_signature_type.to_dynamic,
      "kind"       => kind,
      "kindString" => kind_string,
      "parameters" => parameters.map { |x| x.to_dynamic },
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Comment5 < Dry::Struct
  attribute :returns,    Types::String
  attribute :short_text, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      returns:    d.fetch("returns"),
      short_text: d.fetch("shortText"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "returns"   => returns,
      "shortText" => short_text,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

module SignatureKindString
  CallSignature        = "Call signature"
  ConstructorSignature = "Constructor signature"
end

class Parameter2 < Dry::Struct
  attribute :comment,        Comment2.optional
  attribute :flags,          Flags2
  attribute :id,             Types::Integer
  attribute :kind,           Types::Integer
  attribute :kind_string,    Types::String
  attribute :parameter_name, Types::String
  attribute :parameter_type, ElementType
  attribute :sources,        Types.Array(Source).optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      comment:        d.key?("comment") ? Comment2.from_dynamic!(d["comment"]) : nil,
      flags:          Flags2.from_dynamic!(d.fetch("flags")),
      id:             d.fetch("id"),
      kind:           d.fetch("kind"),
      kind_string:    d.fetch("kindString"),
      parameter_name: d.fetch("name"),
      parameter_type: ElementType.from_dynamic!(d.fetch("type")),
      sources:        d.key?("sources") ? d["sources"].map { |x| Source.from_dynamic!(x) } : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "comment"    => comment&.to_dynamic,
      "flags"      => flags.to_dynamic,
      "id"         => id,
      "kind"       => kind,
      "kindString" => kind_string,
      "name"       => parameter_name,
      "type"       => parameter_type.to_dynamic,
      "sources"    => sources&.map { |x| x.to_dynamic },
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Signature3 < Dry::Struct
  attribute :comment,        Comment5.optional
  attribute :flags,          GetSignatureFlags
  attribute :id,             Types::Integer
  attribute :kind,           Types::Integer
  attribute :kind_string,    Types::SignatureKindString
  attribute :parameters,     Types.Array(Parameter2).optional
  attribute :signature_name, Types::String
  attribute :signature_type, ExtendedBy

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      comment:        d.key?("comment") ? Comment5.from_dynamic!(d["comment"]) : nil,
      flags:          GetSignatureFlags.from_dynamic!(d.fetch("flags")),
      id:             d.fetch("id"),
      kind:           d.fetch("kind"),
      kind_string:    d.fetch("kindString"),
      parameters:     d.key?("parameters") ? d["parameters"].map { |x| Parameter2.from_dynamic!(x) } : nil,
      signature_name: d.fetch("name"),
      signature_type: ExtendedBy.from_dynamic!(d.fetch("type")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "comment"    => comment&.to_dynamic,
      "flags"      => flags.to_dynamic,
      "id"         => id,
      "kind"       => kind,
      "kindString" => kind_string,
      "parameters" => parameters&.map { |x| x.to_dynamic },
      "name"       => signature_name,
      "type"       => signature_type.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Declaration2 < Dry::Struct
  attribute :children,         Types.Array(Child4).optional
  attribute :declaration_name, Types::String
  attribute :flags,            GetSignatureFlags
  attribute :groups,           Types.Array(Group).optional
  attribute :id,               Types::Integer
  attribute :index_signature,  IndexSignature.optional
  attribute :kind,             Types::Integer
  attribute :kind_string,      Types::String
  attribute :signatures,       Types.Array(Signature3).optional
  attribute :sources,          Types.Array(Source)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      children:         d.key?("children") ? d["children"].map { |x| Child4.from_dynamic!(x) } : nil,
      declaration_name: d.fetch("name"),
      flags:            GetSignatureFlags.from_dynamic!(d.fetch("flags")),
      groups:           d.key?("groups") ? d["groups"].map { |x| Group.from_dynamic!(x) } : nil,
      id:               d.fetch("id"),
      index_signature:  d.key?("indexSignature") ? IndexSignature.from_dynamic!(d["indexSignature"]) : nil,
      kind:             d.fetch("kind"),
      kind_string:      d.fetch("kindString"),
      signatures:       d.key?("signatures") ? d["signatures"].map { |x| Signature3.from_dynamic!(x) } : nil,
      sources:          d.fetch("sources").map { |x| Source.from_dynamic!(x) },
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "children"       => children&.map { |x| x.to_dynamic },
      "name"           => declaration_name,
      "flags"          => flags.to_dynamic,
      "groups"         => groups&.map { |x| x.to_dynamic },
      "id"             => id,
      "indexSignature" => index_signature&.to_dynamic,
      "kind"           => kind,
      "kindString"     => kind_string,
      "signatures"     => signatures&.map { |x| x.to_dynamic },
      "sources"        => sources.map { |x| x.to_dynamic },
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TypeArgument1 < Dry::Struct
  attribute :operator,           Types::String
  attribute :target,             ElementType
  attribute :type_argument_type, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      operator:           d.fetch("operator"),
      target:             ElementType.from_dynamic!(d.fetch("target")),
      type_argument_type: d.fetch("type"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "operator" => operator,
      "target"   => target.to_dynamic,
      "type"     => type_argument_type,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TypeElement < Dry::Struct
  attribute :declaration,    GetSignature.optional
  attribute :element_type,   ElementType.optional
  attribute :type_arguments, Types.Array(ElementType).optional
  attribute :type_name,      Types::Name.optional
  attribute :type_type,      Types::TypeEnum

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      declaration:    d.key?("declaration") ? GetSignature.from_dynamic!(d["declaration"]) : nil,
      element_type:   d.key?("elementType") ? ElementType.from_dynamic!(d["elementType"]) : nil,
      type_arguments: d.key?("typeArguments") ? d["typeArguments"].map { |x| ElementType.from_dynamic!(x) } : nil,
      type_name:      d.key?("name") ? Types::Name[d["name"]] : nil,
      type_type:      d.fetch("type"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "declaration"   => declaration&.to_dynamic,
      "elementType"   => element_type&.to_dynamic,
      "typeArguments" => type_arguments&.map { |x| x.to_dynamic },
      "name"          => type_name,
      "type"          => type_type,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Type5 < Dry::Struct
  attribute :constraint,     ExtendedBy.optional
  attribute :declaration,    Declaration2.optional
  attribute :element_type,   ExtendedBy.optional
  attribute :elements,       Types.Array(ElementType).optional
  attribute :id,             Types::Integer.optional
  attribute :type_arguments, Types.Array(TypeArgument1).optional
  attribute :type_name,      Types::String.optional
  attribute :type_type,      Types::TypeEnum
  attribute :types,          Types.Array(TypeElement).optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      constraint:     d.key?("constraint") ? ExtendedBy.from_dynamic!(d["constraint"]) : nil,
      declaration:    d.key?("declaration") ? Declaration2.from_dynamic!(d["declaration"]) : nil,
      element_type:   d.key?("elementType") ? ExtendedBy.from_dynamic!(d["elementType"]) : nil,
      elements:       d.key?("elements") ? d["elements"].map { |x| ElementType.from_dynamic!(x) } : nil,
      id:             d.key?("id") ? Types::Integer[d["id"]] : nil,
      type_arguments: d.key?("typeArguments") ? d["typeArguments"].map { |x| TypeArgument1.from_dynamic!(x) } : nil,
      type_name:      d.key?("name") ? Types::String[d["name"]] : nil,
      type_type:      d.fetch("type"),
      types:          d.key?("types") ? d["types"].map { |x| TypeElement.from_dynamic!(x) } : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "constraint"    => constraint&.to_dynamic,
      "declaration"   => declaration&.to_dynamic,
      "elementType"   => element_type&.to_dynamic,
      "elements"      => elements&.map { |x| x.to_dynamic },
      "id"            => id,
      "typeArguments" => type_arguments&.map { |x| x.to_dynamic },
      "name"          => type_name,
      "type"          => type_type,
      "types"         => types&.map { |x| x.to_dynamic },
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Comment1 < Dry::Struct
  attribute :short_text, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      short_text: d.fetch("shortText"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "shortText" => short_text,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Flags1 < Dry::Struct
  attribute :is_exported, Types::Bool.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      is_exported: d.key?("isExported") ? Types::Bool[d["isExported"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "isExported" => is_exported,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Declaration1 < Dry::Struct
  attribute :children,         Types.Array(GetSignature)
  attribute :declaration_name, Types::String
  attribute :flags,            GetSignatureFlags
  attribute :groups,           Types.Array(Group)
  attribute :id,               Types::Integer
  attribute :kind,             Types::Integer
  attribute :kind_string,      Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      children:         d.fetch("children").map { |x| GetSignature.from_dynamic!(x) },
      declaration_name: d.fetch("name"),
      flags:            GetSignatureFlags.from_dynamic!(d.fetch("flags")),
      groups:           d.fetch("groups").map { |x| Group.from_dynamic!(x) },
      id:               d.fetch("id"),
      kind:             d.fetch("kind"),
      kind_string:      d.fetch("kindString"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "children"   => children.map { |x| x.to_dynamic },
      "name"       => declaration_name,
      "flags"      => flags.to_dynamic,
      "groups"     => groups.map { |x| x.to_dynamic },
      "id"         => id,
      "kind"       => kind,
      "kindString" => kind_string,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Type3 < Dry::Struct
  attribute :declaration, Declaration1.optional
  attribute :type_name,   Types::Name.optional
  attribute :type_type,   Types::TypeEnum

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      declaration: d.key?("declaration") ? Declaration1.from_dynamic!(d["declaration"]) : nil,
      type_name:   d.key?("name") ? Types::Name[d["name"]] : nil,
      type_type:   d.fetch("type"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "declaration" => declaration&.to_dynamic,
      "name"        => type_name,
      "type"        => type_type,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Signature1 < Dry::Struct
  attribute :comment,        Comment1.optional
  attribute :flags,          GetSignatureFlags
  attribute :id,             Types::Integer
  attribute :kind,           Types::Integer
  attribute :kind_string,    Types::SignatureKindString
  attribute :parameters,     Types.Array(GetSignature)
  attribute :signature_name, Types::String
  attribute :signature_type, Type3

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      comment:        d.key?("comment") ? Comment1.from_dynamic!(d["comment"]) : nil,
      flags:          GetSignatureFlags.from_dynamic!(d.fetch("flags")),
      id:             d.fetch("id"),
      kind:           d.fetch("kind"),
      kind_string:    d.fetch("kindString"),
      parameters:     d.fetch("parameters").map { |x| GetSignature.from_dynamic!(x) },
      signature_name: d.fetch("name"),
      signature_type: Type3.from_dynamic!(d.fetch("type")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "comment"    => comment&.to_dynamic,
      "flags"      => flags.to_dynamic,
      "id"         => id,
      "kind"       => kind,
      "kindString" => kind_string,
      "parameters" => parameters.map { |x| x.to_dynamic },
      "name"       => signature_name,
      "type"       => signature_type.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Child3 < Dry::Struct
  attribute :child_name,    Types::String
  attribute :child_type,    TypeElement.optional
  attribute :comment,       Comment1.optional
  attribute :default_value, Types::String.optional
  attribute :flags,         Flags1
  attribute :id,            Types::Integer
  attribute :kind,          Types::Integer
  attribute :kind_string,   Types::KindString1
  attribute :signatures,    Types.Array(Signature1).optional
  attribute :sources,       Types.Array(Source)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      child_name:    d.fetch("name"),
      child_type:    d.key?("type") ? TypeElement.from_dynamic!(d["type"]) : nil,
      comment:       d.key?("comment") ? Comment1.from_dynamic!(d["comment"]) : nil,
      default_value: d.key?("defaultValue") ? Types::String[d["defaultValue"]] : nil,
      flags:         Flags1.from_dynamic!(d.fetch("flags")),
      id:            d.fetch("id"),
      kind:          d.fetch("kind"),
      kind_string:   d.fetch("kindString"),
      signatures:    d.key?("signatures") ? d["signatures"].map { |x| Signature1.from_dynamic!(x) } : nil,
      sources:       d.fetch("sources").map { |x| Source.from_dynamic!(x) },
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "name"         => child_name,
      "type"         => child_type&.to_dynamic,
      "comment"      => comment&.to_dynamic,
      "defaultValue" => default_value,
      "flags"        => flags.to_dynamic,
      "id"           => id,
      "kind"         => kind,
      "kindString"   => kind_string,
      "signatures"   => signatures&.map { |x| x.to_dynamic },
      "sources"      => sources.map { |x| x.to_dynamic },
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Tag < Dry::Struct
  attribute :tag,  Types::String
  attribute :text, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      tag:  d.fetch("tag"),
      text: d.fetch("text"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "tag"  => tag,
      "text" => text,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Comment4 < Dry::Struct
  attribute :returns,    Types::String.optional
  attribute :short_text, Types::String.optional
  attribute :tags,       Types.Array(Tag).optional
  attribute :text,       Types::String.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      returns:    d.key?("returns") ? Types::String[d["returns"]] : nil,
      short_text: d.key?("shortText") ? Types::String[d["shortText"]] : nil,
      tags:       d.key?("tags") ? d["tags"].map { |x| Tag.from_dynamic!(x) } : nil,
      text:       d.key?("text") ? Types::String[d["text"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "returns"   => returns,
      "shortText" => short_text,
      "tags"      => tags&.map { |x| x.to_dynamic },
      "text"      => text,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Flags4 < Dry::Struct
  attribute :is_abstract,             Types::Bool.optional
  attribute :is_constructor_property, Types::Bool.optional
  attribute :is_exported,             Types::Bool.optional
  attribute :is_private,              Types::Bool.optional
  attribute :is_protected,            Types::Bool.optional
  attribute :is_public,               Types::Bool.optional
  attribute :is_static,               Types::Bool.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      is_abstract:             d.key?("isAbstract") ? Types::Bool[d["isAbstract"]] : nil,
      is_constructor_property: d.key?("isConstructorProperty") ? Types::Bool[d["isConstructorProperty"]] : nil,
      is_exported:             d.key?("isExported") ? Types::Bool[d["isExported"]] : nil,
      is_private:              d.key?("isPrivate") ? Types::Bool[d["isPrivate"]] : nil,
      is_protected:            d.key?("isProtected") ? Types::Bool[d["isProtected"]] : nil,
      is_public:               d.key?("isPublic") ? Types::Bool[d["isPublic"]] : nil,
      is_static:               d.key?("isStatic") ? Types::Bool[d["isStatic"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "isAbstract"            => is_abstract,
      "isConstructorProperty" => is_constructor_property,
      "isExported"            => is_exported,
      "isPrivate"             => is_private,
      "isProtected"           => is_protected,
      "isPublic"              => is_public,
      "isStatic"              => is_static,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Flags5 < Dry::Struct
  attribute :is_private,   Types::Bool.optional
  attribute :is_protected, Types::Bool.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      is_private:   d.key?("isPrivate") ? Types::Bool[d["isPrivate"]] : nil,
      is_protected: d.key?("isProtected") ? Types::Bool[d["isProtected"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "isPrivate"   => is_private,
      "isProtected" => is_protected,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Type4 < Dry::Struct
  attribute :constraint,     ExtendedBy.optional
  attribute :declaration,    GetSignature.optional
  attribute :element_type,   ElementType.optional
  attribute :elements,       Types.Array(ExtendedBy).optional
  attribute :id,             Types::Integer.optional
  attribute :type_arguments, Types.Array(ElementType).optional
  attribute :type_name,      Types::String.optional
  attribute :type_type,      Types::TypeEnum

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      constraint:     d.key?("constraint") ? ExtendedBy.from_dynamic!(d["constraint"]) : nil,
      declaration:    d.key?("declaration") ? GetSignature.from_dynamic!(d["declaration"]) : nil,
      element_type:   d.key?("elementType") ? ElementType.from_dynamic!(d["elementType"]) : nil,
      elements:       d.key?("elements") ? d["elements"].map { |x| ExtendedBy.from_dynamic!(x) } : nil,
      id:             d.key?("id") ? Types::Integer[d["id"]] : nil,
      type_arguments: d.key?("typeArguments") ? d["typeArguments"].map { |x| ElementType.from_dynamic!(x) } : nil,
      type_name:      d.key?("name") ? Types::String[d["name"]] : nil,
      type_type:      d.fetch("type"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "constraint"    => constraint&.to_dynamic,
      "declaration"   => declaration&.to_dynamic,
      "elementType"   => element_type&.to_dynamic,
      "elements"      => elements&.map { |x| x.to_dynamic },
      "id"            => id,
      "typeArguments" => type_arguments&.map { |x| x.to_dynamic },
      "name"          => type_name,
      "type"          => type_type,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Parameter1 < Dry::Struct
  attribute :comment,        Comment3.optional
  attribute :flags,          GetSignatureFlags
  attribute :id,             Types::Integer
  attribute :kind,           Types::Integer
  attribute :kind_string,    Types::ParameterKindString
  attribute :parameter_name, Types::String
  attribute :parameter_type, Type4

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      comment:        d.key?("comment") ? Comment3.from_dynamic!(d["comment"]) : nil,
      flags:          GetSignatureFlags.from_dynamic!(d.fetch("flags")),
      id:             d.fetch("id"),
      kind:           d.fetch("kind"),
      kind_string:    d.fetch("kindString"),
      parameter_name: d.fetch("name"),
      parameter_type: Type4.from_dynamic!(d.fetch("type")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "comment"    => comment&.to_dynamic,
      "flags"      => flags.to_dynamic,
      "id"         => id,
      "kind"       => kind,
      "kindString" => kind_string,
      "name"       => parameter_name,
      "type"       => parameter_type.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Signature2 < Dry::Struct
  attribute :comment,           Comment4.optional
  attribute :flags,             Flags5
  attribute :id,                Types::Integer
  attribute :implementation_of, ExtendedBy.optional
  attribute :inherited_from,    ExtendedBy.optional
  attribute :kind,              Types::Integer
  attribute :kind_string,       Types::SignatureKindString
  attribute :overwrites,        ExtendedBy.optional
  attribute :parameters,        Types.Array(Parameter1).optional
  attribute :signature_name,    Types::String
  attribute :signature_type,    ExtendedBy
  attribute :type_parameter,    Types.Array(GetSignature).optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      comment:           d.key?("comment") ? Comment4.from_dynamic!(d["comment"]) : nil,
      flags:             Flags5.from_dynamic!(d.fetch("flags")),
      id:                d.fetch("id"),
      implementation_of: d.key?("implementationOf") ? ExtendedBy.from_dynamic!(d["implementationOf"]) : nil,
      inherited_from:    d.key?("inheritedFrom") ? ExtendedBy.from_dynamic!(d["inheritedFrom"]) : nil,
      kind:              d.fetch("kind"),
      kind_string:       d.fetch("kindString"),
      overwrites:        d.key?("overwrites") ? ExtendedBy.from_dynamic!(d["overwrites"]) : nil,
      parameters:        d.key?("parameters") ? d["parameters"].map { |x| Parameter1.from_dynamic!(x) } : nil,
      signature_name:    d.fetch("name"),
      signature_type:    ExtendedBy.from_dynamic!(d.fetch("type")),
      type_parameter:    d.key?("typeParameter") ? d["typeParameter"].map { |x| GetSignature.from_dynamic!(x) } : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "comment"          => comment&.to_dynamic,
      "flags"            => flags.to_dynamic,
      "id"               => id,
      "implementationOf" => implementation_of&.to_dynamic,
      "inheritedFrom"    => inherited_from&.to_dynamic,
      "kind"             => kind,
      "kindString"       => kind_string,
      "overwrites"       => overwrites&.to_dynamic,
      "parameters"       => parameters&.map { |x| x.to_dynamic },
      "name"             => signature_name,
      "type"             => signature_type.to_dynamic,
      "typeParameter"    => type_parameter&.map { |x| x.to_dynamic },
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Child2 < Dry::Struct
  attribute :child_name,        Types::String
  attribute :child_type,        Type5.optional
  attribute :children,          Types.Array(Child3).optional
  attribute :comment,           Comment4.optional
  attribute :default_value,     Types::String.optional
  attribute :flags,             Flags4
  attribute :get_signature,     GetSignature.optional
  attribute :groups,            Types.Array(Group).optional
  attribute :id,                Types::Integer
  attribute :implementation_of, ExtendedBy.optional
  attribute :inherited_from,    ExtendedBy.optional
  attribute :kind,              Types::Integer
  attribute :kind_string,       Types::KindString1
  attribute :overwrites,        ExtendedBy.optional
  attribute :set_signature,     GetSignature.optional
  attribute :signatures,        Types.Array(Signature2).optional
  attribute :sources,           Types.Array(Source)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      child_name:        d.fetch("name"),
      child_type:        d.key?("type") ? Type5.from_dynamic!(d["type"]) : nil,
      children:          d.key?("children") ? d["children"].map { |x| Child3.from_dynamic!(x) } : nil,
      comment:           d.key?("comment") ? Comment4.from_dynamic!(d["comment"]) : nil,
      default_value:     d.key?("defaultValue") ? Types::String[d["defaultValue"]] : nil,
      flags:             Flags4.from_dynamic!(d.fetch("flags")),
      get_signature:     d.key?("getSignature") ? GetSignature.from_dynamic!(d["getSignature"]) : nil,
      groups:            d.key?("groups") ? d["groups"].map { |x| Group.from_dynamic!(x) } : nil,
      id:                d.fetch("id"),
      implementation_of: d.key?("implementationOf") ? ExtendedBy.from_dynamic!(d["implementationOf"]) : nil,
      inherited_from:    d.key?("inheritedFrom") ? ExtendedBy.from_dynamic!(d["inheritedFrom"]) : nil,
      kind:              d.fetch("kind"),
      kind_string:       d.fetch("kindString"),
      overwrites:        d.key?("overwrites") ? ExtendedBy.from_dynamic!(d["overwrites"]) : nil,
      set_signature:     d.key?("setSignature") ? GetSignature.from_dynamic!(d["setSignature"]) : nil,
      signatures:        d.key?("signatures") ? d["signatures"].map { |x| Signature2.from_dynamic!(x) } : nil,
      sources:           d.fetch("sources").map { |x| Source.from_dynamic!(x) },
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "name"             => child_name,
      "type"             => child_type&.to_dynamic,
      "children"         => children&.map { |x| x.to_dynamic },
      "comment"          => comment&.to_dynamic,
      "defaultValue"     => default_value,
      "flags"            => flags.to_dynamic,
      "getSignature"     => get_signature&.to_dynamic,
      "groups"           => groups&.map { |x| x.to_dynamic },
      "id"               => id,
      "implementationOf" => implementation_of&.to_dynamic,
      "inheritedFrom"    => inherited_from&.to_dynamic,
      "kind"             => kind,
      "kindString"       => kind_string,
      "overwrites"       => overwrites&.to_dynamic,
      "setSignature"     => set_signature&.to_dynamic,
      "signatures"       => signatures&.map { |x| x.to_dynamic },
      "sources"          => sources.map { |x| x.to_dynamic },
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Flags6 < Dry::Struct
  attribute :has_export_assignment, Types::Bool.optional
  attribute :is_abstract,           Types::Bool.optional
  attribute :is_const,              Types::Bool.optional
  attribute :is_exported,           Types::Bool.optional
  attribute :is_let,                Types::Bool.optional
  attribute :is_private,            Types::Bool.optional
  attribute :is_protected,          Types::Bool.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      has_export_assignment: d.key?("hasExportAssignment") ? Types::Bool[d["hasExportAssignment"]] : nil,
      is_abstract:           d.key?("isAbstract") ? Types::Bool[d["isAbstract"]] : nil,
      is_const:              d.key?("isConst") ? Types::Bool[d["isConst"]] : nil,
      is_exported:           d.key?("isExported") ? Types::Bool[d["isExported"]] : nil,
      is_let:                d.key?("isLet") ? Types::Bool[d["isLet"]] : nil,
      is_private:            d.key?("isPrivate") ? Types::Bool[d["isPrivate"]] : nil,
      is_protected:          d.key?("isProtected") ? Types::Bool[d["isProtected"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "hasExportAssignment" => has_export_assignment,
      "isAbstract"          => is_abstract,
      "isConst"             => is_const,
      "isExported"          => is_exported,
      "isLet"               => is_let,
      "isPrivate"           => is_private,
      "isProtected"         => is_protected,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

module KindString2
  Module        = "Module"
  Class         = "Class"
  Variable      = "Variable"
  Function      = "Function"
  Interface     = "Interface"
  Enumeration   = "Enumeration"
  ObjectLiteral = "Object literal"
  TypeAlias     = "Type alias"
end

class Child5 < Dry::Struct
  attribute :child_name,    Types::String
  attribute :child_type,    Type6
  attribute :comment,       Comment2
  attribute :default_value, Types::String.optional
  attribute :flags,         Flags2
  attribute :id,            Types::Integer
  attribute :kind,          Types::Integer
  attribute :kind_string,   Types::KindString1
  attribute :sources,       Types.Array(Source)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      child_name:    d.fetch("name"),
      child_type:    Type6.from_dynamic!(d.fetch("type")),
      comment:       Comment2.from_dynamic!(d.fetch("comment")),
      default_value: d.key?("defaultValue") ? Types::String[d["defaultValue"]] : nil,
      flags:         Flags2.from_dynamic!(d.fetch("flags")),
      id:            d.fetch("id"),
      kind:          d.fetch("kind"),
      kind_string:   d.fetch("kindString"),
      sources:       d.fetch("sources").map { |x| Source.from_dynamic!(x) },
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "name"         => child_name,
      "type"         => child_type.to_dynamic,
      "comment"      => comment.to_dynamic,
      "defaultValue" => default_value,
      "flags"        => flags.to_dynamic,
      "id"           => id,
      "kind"         => kind,
      "kindString"   => kind_string,
      "sources"      => sources.map { |x| x.to_dynamic },
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Declaration3 < Dry::Struct
  attribute :children,         Types.Array(Child5).optional
  attribute :declaration_name, Types::String
  attribute :flags,            GetSignatureFlags
  attribute :groups,           Types.Array(Group).optional
  attribute :id,               Types::Integer
  attribute :index_signature,  IndexSignatureElement.optional
  attribute :kind,             Types::Integer
  attribute :kind_string,      Types::String
  attribute :signatures,       Types.Array(GetSignature).optional
  attribute :sources,          Types.Array(Source)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      children:         d.key?("children") ? d["children"].map { |x| Child5.from_dynamic!(x) } : nil,
      declaration_name: d.fetch("name"),
      flags:            GetSignatureFlags.from_dynamic!(d.fetch("flags")),
      groups:           d.key?("groups") ? d["groups"].map { |x| Group.from_dynamic!(x) } : nil,
      id:               d.fetch("id"),
      index_signature:  d.key?("indexSignature") ? IndexSignatureElement.from_dynamic!(d["indexSignature"]) : nil,
      kind:             d.fetch("kind"),
      kind_string:      d.fetch("kindString"),
      signatures:       d.key?("signatures") ? d["signatures"].map { |x| GetSignature.from_dynamic!(x) } : nil,
      sources:          d.fetch("sources").map { |x| Source.from_dynamic!(x) },
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "children"       => children&.map { |x| x.to_dynamic },
      "name"           => declaration_name,
      "flags"          => flags.to_dynamic,
      "groups"         => groups&.map { |x| x.to_dynamic },
      "id"             => id,
      "indexSignature" => index_signature&.to_dynamic,
      "kind"           => kind,
      "kindString"     => kind_string,
      "signatures"     => signatures&.map { |x| x.to_dynamic },
      "sources"        => sources.map { |x| x.to_dynamic },
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Type8 < Dry::Struct
  attribute :declaration,    Declaration3.optional
  attribute :element_type,   ElementType.optional
  attribute :id,             Types::Integer.optional
  attribute :type_arguments, Types.Array(ElementType).optional
  attribute :type_name,      Types::String.optional
  attribute :type_type,      Types::TypeEnum

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      declaration:    d.key?("declaration") ? Declaration3.from_dynamic!(d["declaration"]) : nil,
      element_type:   d.key?("elementType") ? ElementType.from_dynamic!(d["elementType"]) : nil,
      id:             d.key?("id") ? Types::Integer[d["id"]] : nil,
      type_arguments: d.key?("typeArguments") ? d["typeArguments"].map { |x| ElementType.from_dynamic!(x) } : nil,
      type_name:      d.key?("name") ? Types::String[d["name"]] : nil,
      type_type:      d.fetch("type"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "declaration"   => declaration&.to_dynamic,
      "elementType"   => element_type&.to_dynamic,
      "id"            => id,
      "typeArguments" => type_arguments&.map { |x| x.to_dynamic },
      "name"          => type_name,
      "type"          => type_type,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Parameter3 < Dry::Struct
  attribute :comment,        Comment3.optional
  attribute :default_value,  Types::String.optional
  attribute :flags,          Flags3
  attribute :id,             Types::Integer
  attribute :kind,           Types::Integer
  attribute :kind_string,    Types::ParameterKindString
  attribute :original_name,  Types::String.optional
  attribute :parameter_name, Types::String
  attribute :parameter_type, Type8

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      comment:        d.key?("comment") ? Comment3.from_dynamic!(d["comment"]) : nil,
      default_value:  d.key?("defaultValue") ? Types::String[d["defaultValue"]] : nil,
      flags:          Flags3.from_dynamic!(d.fetch("flags")),
      id:             d.fetch("id"),
      kind:           d.fetch("kind"),
      kind_string:    d.fetch("kindString"),
      original_name:  d.key?("originalName") ? Types::String[d["originalName"]] : nil,
      parameter_name: d.fetch("name"),
      parameter_type: Type8.from_dynamic!(d.fetch("type")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "comment"      => comment&.to_dynamic,
      "defaultValue" => default_value,
      "flags"        => flags.to_dynamic,
      "id"           => id,
      "kind"         => kind,
      "kindString"   => kind_string,
      "originalName" => original_name,
      "name"         => parameter_name,
      "type"         => parameter_type.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Type9 < Dry::Struct
  attribute :declaration,    Declaration1.optional
  attribute :id,             Types::Integer.optional
  attribute :type_arguments, Types.Array(ElementType).optional
  attribute :type_name,      Types::Name.optional
  attribute :type_type,      Types::TypeEnum

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      declaration:    d.key?("declaration") ? Declaration1.from_dynamic!(d["declaration"]) : nil,
      id:             d.key?("id") ? Types::Integer[d["id"]] : nil,
      type_arguments: d.key?("typeArguments") ? d["typeArguments"].map { |x| ElementType.from_dynamic!(x) } : nil,
      type_name:      d.key?("name") ? Types::Name[d["name"]] : nil,
      type_type:      d.fetch("type"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "declaration"   => declaration&.to_dynamic,
      "id"            => id,
      "typeArguments" => type_arguments&.map { |x| x.to_dynamic },
      "name"          => type_name,
      "type"          => type_type,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Signature4 < Dry::Struct
  attribute :comment,        Comment4
  attribute :flags,          Flags5
  attribute :id,             Types::Integer
  attribute :kind,           Types::Integer
  attribute :kind_string,    Types::SignatureKindString
  attribute :parameters,     Types.Array(Parameter3).optional
  attribute :signature_name, Types::String
  attribute :signature_type, Type9
  attribute :type_parameter, Types.Array(GetSignature).optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      comment:        Comment4.from_dynamic!(d.fetch("comment")),
      flags:          Flags5.from_dynamic!(d.fetch("flags")),
      id:             d.fetch("id"),
      kind:           d.fetch("kind"),
      kind_string:    d.fetch("kindString"),
      parameters:     d.key?("parameters") ? d["parameters"].map { |x| Parameter3.from_dynamic!(x) } : nil,
      signature_name: d.fetch("name"),
      signature_type: Type9.from_dynamic!(d.fetch("type")),
      type_parameter: d.key?("typeParameter") ? d["typeParameter"].map { |x| GetSignature.from_dynamic!(x) } : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "comment"       => comment.to_dynamic,
      "flags"         => flags.to_dynamic,
      "id"            => id,
      "kind"          => kind,
      "kindString"    => kind_string,
      "parameters"    => parameters&.map { |x| x.to_dynamic },
      "name"          => signature_name,
      "type"          => signature_type.to_dynamic,
      "typeParameter" => type_parameter&.map { |x| x.to_dynamic },
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Type12 < Dry::Struct
  attribute :id,        Types::Integer.optional
  attribute :operator,  Types::String.optional
  attribute :target,    ElementType.optional
  attribute :type_name, Types::Name.optional
  attribute :type_type, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      id:        d.key?("id") ? Types::Integer[d["id"]] : nil,
      operator:  d.key?("operator") ? Types::String[d["operator"]] : nil,
      target:    d.key?("target") ? ElementType.from_dynamic!(d["target"]) : nil,
      type_name: d.key?("name") ? Types::Name[d["name"]] : nil,
      type_type: d.fetch("type"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "id"       => id,
      "operator" => operator,
      "target"   => target&.to_dynamic,
      "name"     => type_name,
      "type"     => type_type,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TypeParameter < Dry::Struct
  attribute :comment,             Comment1.optional
  attribute :flags,               GetSignatureFlags
  attribute :id,                  Types::Integer
  attribute :kind,                Types::Integer
  attribute :kind_string,         Types::String
  attribute :type_parameter_name, Types::String
  attribute :type_parameter_type, Type12.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      comment:             d.key?("comment") ? Comment1.from_dynamic!(d["comment"]) : nil,
      flags:               GetSignatureFlags.from_dynamic!(d.fetch("flags")),
      id:                  d.fetch("id"),
      kind:                d.fetch("kind"),
      kind_string:         d.fetch("kindString"),
      type_parameter_name: d.fetch("name"),
      type_parameter_type: d.key?("type") ? Type12.from_dynamic!(d["type"]) : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "comment"    => comment&.to_dynamic,
      "flags"      => flags.to_dynamic,
      "id"         => id,
      "kind"       => kind,
      "kindString" => kind_string,
      "name"       => type_parameter_name,
      "type"       => type_parameter_type&.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Child1 < Dry::Struct
  attribute :child_name,        Types::String
  attribute :child_type,        Type10.optional
  attribute :children,          Types.Array(Child2).optional
  attribute :comment,           Comment4.optional
  attribute :default_value,     Types::String.optional
  attribute :extended_by,       Types.Array(ExtendedBy).optional
  attribute :extended_types,    Types.Array(ExtendedBy).optional
  attribute :flags,             Flags6
  attribute :groups,            Types.Array(Group).optional
  attribute :id,                Types::Integer
  attribute :implemented_by,    Types.Array(ExtendedBy).optional
  attribute :implemented_types, Types.Array(ExtendedBy).optional
  attribute :kind,              Types::Integer
  attribute :kind_string,       Types::KindString2
  attribute :signatures,        Types.Array(Signature4).optional
  attribute :sources,           Types.Array(Source)
  attribute :type_parameter,    Types.Array(TypeParameter).optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      child_name:        d.fetch("name"),
      child_type:        d.key?("type") ? Type10.from_dynamic!(d["type"]) : nil,
      children:          d.key?("children") ? d["children"].map { |x| Child2.from_dynamic!(x) } : nil,
      comment:           d.key?("comment") ? Comment4.from_dynamic!(d["comment"]) : nil,
      default_value:     d.key?("defaultValue") ? Types::String[d["defaultValue"]] : nil,
      extended_by:       d.key?("extendedBy") ? d["extendedBy"].map { |x| ExtendedBy.from_dynamic!(x) } : nil,
      extended_types:    d.key?("extendedTypes") ? d["extendedTypes"].map { |x| ExtendedBy.from_dynamic!(x) } : nil,
      flags:             Flags6.from_dynamic!(d.fetch("flags")),
      groups:            d.key?("groups") ? d["groups"].map { |x| Group.from_dynamic!(x) } : nil,
      id:                d.fetch("id"),
      implemented_by:    d.key?("implementedBy") ? d["implementedBy"].map { |x| ExtendedBy.from_dynamic!(x) } : nil,
      implemented_types: d.key?("implementedTypes") ? d["implementedTypes"].map { |x| ExtendedBy.from_dynamic!(x) } : nil,
      kind:              d.fetch("kind"),
      kind_string:       d.fetch("kindString"),
      signatures:        d.key?("signatures") ? d["signatures"].map { |x| Signature4.from_dynamic!(x) } : nil,
      sources:           d.fetch("sources").map { |x| Source.from_dynamic!(x) },
      type_parameter:    d.key?("typeParameter") ? d["typeParameter"].map { |x| TypeParameter.from_dynamic!(x) } : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "name"             => child_name,
      "type"             => child_type&.to_dynamic,
      "children"         => children&.map { |x| x.to_dynamic },
      "comment"          => comment&.to_dynamic,
      "defaultValue"     => default_value,
      "extendedBy"       => extended_by&.map { |x| x.to_dynamic },
      "extendedTypes"    => extended_types&.map { |x| x.to_dynamic },
      "flags"            => flags.to_dynamic,
      "groups"           => groups&.map { |x| x.to_dynamic },
      "id"               => id,
      "implementedBy"    => implemented_by&.map { |x| x.to_dynamic },
      "implementedTypes" => implemented_types&.map { |x| x.to_dynamic },
      "kind"             => kind,
      "kindString"       => kind_string,
      "signatures"       => signatures&.map { |x| x.to_dynamic },
      "sources"          => sources.map { |x| x.to_dynamic },
      "typeParameter"    => type_parameter&.map { |x| x.to_dynamic },
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Comment6 < Dry::Struct
  attribute :short_text, Types::String
  attribute :tags,       Types.Array(Tag).optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      short_text: d.fetch("shortText"),
      tags:       d.key?("tags") ? d["tags"].map { |x| Tag.from_dynamic!(x) } : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "shortText" => short_text,
      "tags"      => tags&.map { |x| x.to_dynamic },
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

module KindString3
  ExternalModule = "External module"
end

class TopLevelChild < Dry::Struct
  attribute :child_name,    Types::String
  attribute :children,      Types.Array(Child1)
  attribute :comment,       Comment6.optional
  attribute :flags,         Flags1
  attribute :groups,        Types.Array(Group)
  attribute :id,            Types::Integer
  attribute :kind,          Types::Integer
  attribute :kind_string,   Types::KindString3
  attribute :original_name, Types::String
  attribute :sources,       Types.Array(Source)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      child_name:    d.fetch("name"),
      children:      d.fetch("children").map { |x| Child1.from_dynamic!(x) },
      comment:       d.key?("comment") ? Comment6.from_dynamic!(d["comment"]) : nil,
      flags:         Flags1.from_dynamic!(d.fetch("flags")),
      groups:        d.fetch("groups").map { |x| Group.from_dynamic!(x) },
      id:            d.fetch("id"),
      kind:          d.fetch("kind"),
      kind_string:   d.fetch("kindString"),
      original_name: d.fetch("originalName"),
      sources:       d.fetch("sources").map { |x| Source.from_dynamic!(x) },
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "name"         => child_name,
      "children"     => children.map { |x| x.to_dynamic },
      "comment"      => comment&.to_dynamic,
      "flags"        => flags.to_dynamic,
      "groups"       => groups.map { |x| x.to_dynamic },
      "id"           => id,
      "kind"         => kind,
      "kindString"   => kind_string,
      "originalName" => original_name,
      "sources"      => sources.map { |x| x.to_dynamic },
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :children,       Types.Array(TopLevelChild)
  attribute :flags,          GetSignatureFlags
  attribute :groups,         Types.Array(Group)
  attribute :id,             Types::Integer
  attribute :kind,           Types::Integer
  attribute :top_level_name, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      children:       d.fetch("children").map { |x| TopLevelChild.from_dynamic!(x) },
      flags:          GetSignatureFlags.from_dynamic!(d.fetch("flags")),
      groups:         d.fetch("groups").map { |x| Group.from_dynamic!(x) },
      id:             d.fetch("id"),
      kind:           d.fetch("kind"),
      top_level_name: d.fetch("name"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "children" => children.map { |x| x.to_dynamic },
      "flags"    => flags.to_dynamic,
      "groups"   => groups.map { |x| x.to_dynamic },
      "id"       => id,
      "kind"     => kind,
      "name"     => top_level_name,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
