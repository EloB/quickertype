require "json"

class TopLevel
  include JSON::Serializable

  property invoices : Array(Invoice)
end

class Invoice
  include JSON::Serializable

  @[JSON::Field(key: "createdAt")]
  property created_at : String?

  @[JSON::Field(key: "dueDate")]
  property due_date : String?

  property name : String
end
