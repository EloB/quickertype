package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

type TopLevel = List[TopLevelElement]
given (using ev : TopLevelElement): Encoder[Seq[TopLevelElement]] = Encoder.encodeSeq[TopLevelElement]

case class TopLevelElement (
    val actor : Actor,
    val created_at : java.time.Instant,
    val id : String,
    val org : Option[Actor] = None,
    val payload : Payload,
    val public : Boolean,
    val repo : TopLevelRepo,
    val `type` : Type
) derives Encoder.AsObject, Decoder

case class Actor (
    val avatar_url : String,
    val display_login : Option[String] = None,
    val gravatar_id : String,
    val id : Long,
    val login : String,
    val url : String
) derives Encoder.AsObject, Decoder

case class Payload (
    val action : Option[String] = None,
    val before : Option[String] = None,
    val commits : Option[Seq[Commit]] = None,
    val description : Option[String] = None,
    val distinct_size : Option[Long] = None,
    val head : Option[String] = None,
    val master_branch : Option[String] = None,
    val number : Option[Long] = None,
    val pull_request : Option[PullRequest] = None,
    val push_id : Option[Long] = None,
    val pusher_type : Option[String] = None,
    val ref : Option[String] = None,
    val ref_type : Option[String] = None,
    val size : Option[Long] = None
) derives Encoder.AsObject, Decoder

case class Commit (
    val author : Author,
    val distinct : Boolean,
    val message : String,
    val sha : String,
    val url : String
) derives Encoder.AsObject, Decoder

case class Author (
    val email : String,
    val name : String
) derives Encoder.AsObject, Decoder

case class PullRequest (
    val additions : Long,
    val assignee : Option[Json] = None,
    val assignees : Seq[Option[Json]],
    val base : Base,
    val body : String,
    val changed_files : Long,
    val closed_at : java.time.Instant,
    val comments : Long,
    val comments_url : String,
    val commits : Long,
    val commits_url : String,
    val created_at : java.time.Instant,
    val deletions : Long,
    val diff_url : String,
    val head : Base,
    val html_url : String,
    val id : Long,
    val issue_url : String,
    val _links : Links,
    val locked : Boolean,
    val maintainer_can_modify : Boolean,
    val merge_commit_sha : String,
    val mergeable : Option[Json] = None,
    val mergeable_state : String,
    val merged : Boolean,
    val merged_at : java.time.Instant,
    val merged_by : MergedBy,
    val milestone : Option[Json] = None,
    val number : Long,
    val patch_url : String,
    val rebaseable : Option[Json] = None,
    val requested_reviewers : Seq[Option[Json]],
    val review_comment_url : String,
    val review_comments : Long,
    val review_comments_url : String,
    val state : String,
    val statuses_url : String,
    val title : String,
    val updated_at : java.time.Instant,
    val url : String,
    val user : MergedBy
) derives Encoder.AsObject, Decoder

case class Base (
    val label : String,
    val ref : String,
    val repo : BaseRepo,
    val sha : String,
    val user : MergedBy
) derives Encoder.AsObject, Decoder

case class BaseRepo (
    val archive_url : String,
    val assignees_url : String,
    val blobs_url : String,
    val branches_url : String,
    val clone_url : String,
    val collaborators_url : String,
    val comments_url : String,
    val commits_url : String,
    val compare_url : String,
    val contents_url : String,
    val contributors_url : String,
    val created_at : java.time.Instant,
    val default_branch : String,
    val deployments_url : String,
    val description : Option[Json] = None,
    val downloads_url : String,
    val events_url : String,
    val fork : Boolean,
    val forks : Long,
    val forks_count : Long,
    val forks_url : String,
    val full_name : String,
    val git_commits_url : String,
    val git_refs_url : String,
    val git_tags_url : String,
    val git_url : String,
    val has_downloads : Boolean,
    val has_issues : Boolean,
    val has_pages : Boolean,
    val has_projects : Boolean,
    val has_wiki : Boolean,
    val homepage : Option[Json] = None,
    val hooks_url : String,
    val html_url : String,
    val id : Long,
    val issue_comment_url : String,
    val issue_events_url : String,
    val issues_url : String,
    val keys_url : String,
    val labels_url : String,
    val language : String,
    val languages_url : String,
    val merges_url : String,
    val milestones_url : String,
    val mirror_url : Option[Json] = None,
    val name : String,
    val notifications_url : String,
    val open_issues : Long,
    val open_issues_count : Long,
    val owner : MergedBy,
    val pulls_url : String,
    val pushed_at : java.time.Instant,
    val releases_url : String,
    val `private` : Boolean,
    val size : Long,
    val ssh_url : String,
    val stargazers_count : Long,
    val stargazers_url : String,
    val statuses_url : String,
    val subscribers_url : String,
    val subscription_url : String,
    val svn_url : String,
    val tags_url : String,
    val teams_url : String,
    val trees_url : String,
    val updated_at : java.time.Instant,
    val url : String,
    val watchers : Long,
    val watchers_count : Long
) derives Encoder.AsObject, Decoder

case class MergedBy (
    val avatar_url : String,
    val events_url : String,
    val followers_url : String,
    val following_url : String,
    val gists_url : String,
    val gravatar_id : String,
    val html_url : String,
    val id : Long,
    val login : String,
    val `type` : String,
    val organizations_url : String,
    val received_events_url : String,
    val repos_url : String,
    val site_admin : Boolean,
    val starred_url : String,
    val subscriptions_url : String,
    val url : String
) derives Encoder.AsObject, Decoder

case class Links (
    val comments : Comments,
    val commits : Comments,
    val html : Comments,
    val issue : Comments,
    val review_comment : Comments,
    val review_comments : Comments,
    val self : Comments,
    val statuses : Comments
) derives Encoder.AsObject, Decoder

case class Comments (
    val href : String
) derives Encoder.AsObject, Decoder

case class TopLevelRepo (
    val id : Long,
    val name : String,
    val url : String
) derives Encoder.AsObject, Decoder

enum Type : 
    case PushEvent
    case CreateEvent
    case WatchEvent
    case PullRequestEvent
    case DeleteEvent

given Decoder[Type] = Decoder.decodeString.emap {
    case "PushEvent" => scala.Right(Type.PushEvent)
    case "CreateEvent" => scala.Right(Type.CreateEvent)
    case "WatchEvent" => scala.Right(Type.WatchEvent)
    case "PullRequestEvent" => scala.Right(Type.PullRequestEvent)
    case "DeleteEvent" => scala.Right(Type.DeleteEvent)
    case other => scala.Left("invalid Type: " + other)
}
given Encoder[Type] = Encoder.encodeString.contramap {
    case Type.PushEvent => "PushEvent"
    case Type.CreateEvent => "CreateEvent"
    case Type.WatchEvent => "WatchEvent"
    case Type.PullRequestEvent => "PullRequestEvent"
    case Type.DeleteEvent => "DeleteEvent"
}
