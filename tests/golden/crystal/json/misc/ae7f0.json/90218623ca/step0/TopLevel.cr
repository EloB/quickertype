require "json"

class TopLevel
  include JSON::Serializable

  property data : TopLevelData

  property kind : String
end

class TopLevelData
  include JSON::Serializable

  property after : String

  property before : Nil

  property children : Array(Child)

  property modhash : String
end

class Child
  include JSON::Serializable

  property data : ChildData

  property kind : String
end

class ChildData
  include JSON::Serializable

  property approved_at_utc : Nil

  property approved_by : Nil

  property archived : Bool

  property author : String

  property author_flair_css_class : Nil

  property author_flair_text : Nil

  property banned_at_utc : Nil

  property banned_by : Nil

  property brand_safe : Bool

  property can_gild : Bool

  property can_mod_post : Bool

  property clicked : Bool

  property contest_mode : Bool

  property created : Float64

  property created_utc : Float64

  property distinguished : Nil

  property domain : String

  property downs : Int64

  property edited : Bool

  property gilded : Int64

  property hidden : Bool

  property hide_score : Bool

  property id : String

  property is_self : Bool

  property is_video : Bool

  property likes : Nil

  property link_flair_css_class : String?

  property link_flair_text : String?

  property locked : Bool

  property media : Nil

  property media_embed : MediaEmbed

  property mod_reports : Array(JSON::Any?)

  property name : String

  property num_comments : Int64

  property num_reports : Nil

  property over_18 : Bool

  property permalink : String

  property quarantine : Bool

  property removal_reason : Nil

  property report_reasons : Nil

  property saved : Bool

  property score : Int64

  property secure_media : Nil

  property secure_media_embed : MediaEmbed

  property selftext : String

  property selftext_html : Nil

  property spoiler : Bool

  property stickied : Bool

  property subreddit : String

  property subreddit_id : String

  property subreddit_name_prefixed : String

  property subreddit_type : String

  property suggested_sort : Nil

  property thumbnail : String

  property title : String

  property ups : Int64

  property url : String

  property user_reports : Array(JSON::Any?)

  property view_count : Nil

  property visited : Bool
end

class MediaEmbed
  include JSON::Serializable

end
