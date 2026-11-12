-- To decode the JSON data, add this file to your project, run
--
--     elm install NoRedInk/elm-json-decode-pipeline
--
-- add these imports
--
--     import Json.Decode exposing (decodeString)
--     import QuickType exposing (quickType)
--
-- and you're off to the races with
--
--     decodeString quickType myJsonString

module QuickType exposing
    ( QuickType
    , quickTypeToString
    , quickType
    , QuickTypeElement
    , Actor
    , Payload
    , Comment
    , UserClass
    , Commit
    , Author
    , Issue
    , Label
    , Milestone
    , IssuePullRequest
    , PayloadPullRequest
    , Base
    , BaseRepo
    , Links
    , Comments
    , QuickTypeRepo
    , Type(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType = List QuickTypeElement

type alias QuickTypeElement =
    { actor : Actor
    , createdAt : String
    , id : String
    , org : Maybe Actor
    , payload : Payload
    , public : Bool
    , quickTypeType : String
    , repo : QuickTypeRepo
    }

type alias Actor =
    { avatarURL : String
    , displayLogin : Maybe String
    , gravatarID : String
    , id : Int
    , login : String
    , url : String
    }

type alias Payload =
    { action : Maybe String
    , before : Maybe String
    , comment : Maybe Comment
    , commits : Maybe (List Commit)
    , description : Maybe String
    , distinctSize : Maybe Int
    , head : Maybe String
    , issue : Maybe Issue
    , masterBranch : Maybe String
    , number : Maybe Int
    , pullRequest : Maybe PayloadPullRequest
    , pushID : Maybe Int
    , pusherType : Maybe String
    , ref : Maybe String
    , refType : Maybe String
    , size : Maybe Int
    }

type alias Comment =
    { body : String
    , createdAt : String
    , htmlURL : String
    , id : Int
    , issueURL : String
    , updatedAt : String
    , url : String
    , user : UserClass
    }

type alias UserClass =
    { avatarURL : String
    , eventsURL : String
    , followersURL : String
    , followingURL : String
    , gistsURL : String
    , gravatarID : String
    , htmlURL : String
    , id : Int
    , login : String
    , organizationsURL : String
    , receivedEventsURL : String
    , reposURL : String
    , siteAdmin : Bool
    , starredURL : String
    , subscriptionsURL : String
    , url : String
    , userType : Type
    }

type Type
    = User
    | Organization

type alias Commit =
    { author : Author
    , distinct : Bool
    , message : String
    , sha : String
    , url : String
    }

type alias Author =
    { email : String
    , name : String
    }

type alias Issue =
    { assignee : ()
    , assignees : List Jdec.Value
    , body : String
    , closedAt : Maybe String
    , comments : Int
    , commentsURL : String
    , createdAt : String
    , eventsURL : String
    , htmlURL : String
    , id : Int
    , labels : List Label
    , labelsURL : String
    , locked : Bool
    , milestone : Maybe Milestone
    , number : Int
    , pullRequest : Maybe IssuePullRequest
    , repositoryURL : String
    , state : String
    , title : String
    , updatedAt : String
    , url : String
    , user : UserClass
    }

type alias Label =
    { color : String
    , default : Bool
    , id : Int
    , name : String
    , url : String
    }

type alias Milestone =
    { closedAt : ()
    , closedIssues : Int
    , createdAt : String
    , creator : UserClass
    , description : String
    , dueOn : Maybe String
    , htmlURL : String
    , id : Int
    , labelsURL : String
    , number : Int
    , openIssues : Int
    , state : String
    , title : String
    , updatedAt : String
    , url : String
    }

type alias IssuePullRequest =
    { diffURL : String
    , htmlURL : String
    , patchURL : String
    , url : String
    }

type alias PayloadPullRequest =
    { additions : Int
    , assignee : ()
    , assignees : List Jdec.Value
    , base : Base
    , body : String
    , changedFiles : Int
    , closedAt : String
    , comments : Int
    , commentsURL : String
    , commits : Int
    , commitsURL : String
    , createdAt : String
    , deletions : Int
    , diffURL : String
    , head : Base
    , htmlURL : String
    , id : Int
    , issueURL : String
    , links : Links
    , locked : Bool
    , maintainerCanModify : Bool
    , mergeCommitSHA : String
    , mergeable : ()
    , mergeableState : String
    , merged : Bool
    , mergedAt : String
    , mergedBy : UserClass
    , milestone : ()
    , number : Int
    , patchURL : String
    , rebaseable : ()
    , requestedReviewers : List Jdec.Value
    , reviewCommentURL : String
    , reviewComments : Int
    , reviewCommentsURL : String
    , state : String
    , statusesURL : String
    , title : String
    , updatedAt : String
    , url : String
    , user : UserClass
    }

type alias Base =
    { label : String
    , ref : String
    , repo : BaseRepo
    , sha : String
    , user : UserClass
    }

type alias BaseRepo =
    { archiveURL : String
    , assigneesURL : String
    , blobsURL : String
    , branchesURL : String
    , cloneURL : String
    , collaboratorsURL : String
    , commentsURL : String
    , commitsURL : String
    , compareURL : String
    , contentsURL : String
    , contributorsURL : String
    , createdAt : String
    , defaultBranch : String
    , deploymentsURL : String
    , description : String
    , downloadsURL : String
    , eventsURL : String
    , fork : Bool
    , forks : Int
    , forksCount : Int
    , forksURL : String
    , fullName : String
    , gitCommitsURL : String
    , gitRefsURL : String
    , gitTagsURL : String
    , gitURL : String
    , hasDownloads : Bool
    , hasIssues : Bool
    , hasPages : Bool
    , hasProjects : Bool
    , hasWiki : Bool
    , homepage : String
    , hooksURL : String
    , htmlURL : String
    , id : Int
    , issueCommentURL : String
    , issueEventsURL : String
    , issuesURL : String
    , keysURL : String
    , labelsURL : String
    , language : String
    , languagesURL : String
    , mergesURL : String
    , milestonesURL : String
    , mirrorURL : ()
    , name : String
    , notificationsURL : String
    , openIssues : Int
    , openIssuesCount : Int
    , owner : UserClass
    , private : Bool
    , pullsURL : String
    , pushedAt : String
    , releasesURL : String
    , size : Int
    , sshURL : String
    , stargazersCount : Int
    , stargazersURL : String
    , statusesURL : String
    , subscribersURL : String
    , subscriptionURL : String
    , svnURL : String
    , tagsURL : String
    , teamsURL : String
    , treesURL : String
    , updatedAt : String
    , url : String
    , watchers : Int
    , watchersCount : Int
    }

type alias Links =
    { comments : Comments
    , commits : Comments
    , html : Comments
    , issue : Comments
    , reviewComment : Comments
    , reviewComments : Comments
    , self : Comments
    , statuses : Comments
    }

type alias Comments =
    { href : String
    }

type alias QuickTypeRepo =
    { id : Int
    , name : String
    , url : String
    }

-- decoders and encoders
optionalField key decoder fallback =
    Jdec.dict Jdec.value
        |> Jdec.andThen (\m ->
            case Dict.get key m of
                Nothing -> Jdec.succeed fallback
                Just x -> Jdec.decodeValue decoder x |> Result.map Jdec.succeed |> Result.withDefault (Jdec.fail ("Invalid " ++ key)))

quickType : Jdec.Decoder QuickType
quickType = Jdec.list quickTypeElement 

quickTypeToString : QuickType -> String
quickTypeToString r = Jenc.encode 0 (Jenc.list encodeQuickTypeElement r)

quickTypeElement : Jdec.Decoder QuickTypeElement
quickTypeElement =
    Jdec.succeed QuickTypeElement
        |> Jpipe.required "actor" actor
        |> Jpipe.required "created_at" Jdec.string
        |> Jpipe.required "id" Jdec.string
        |> Jpipe.custom (optionalField "org" (Jdec.map Just actor) Nothing)
        |> Jpipe.required "payload" payload
        |> Jpipe.required "public" Jdec.bool
        |> Jpipe.required "type" Jdec.string
        |> Jpipe.required "repo" quickTypeRepo

encodeQuickTypeElement : QuickTypeElement -> Jenc.Value
encodeQuickTypeElement x =
    Jenc.object
        [ ("actor", encodeActor x.actor)
        , ("created_at", Jenc.string x.createdAt)
        , ("id", Jenc.string x.id)
        , ("org", makeNullableEncoder encodeActor x.org)
        , ("payload", encodePayload x.payload)
        , ("public", Jenc.bool x.public)
        , ("type", Jenc.string x.quickTypeType)
        , ("repo", encodeQuickTypeRepo x.repo)
        ]

actor : Jdec.Decoder Actor
actor =
    Jdec.succeed Actor
        |> Jpipe.required "avatar_url" Jdec.string
        |> Jpipe.custom (optionalField "display_login" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.required "gravatar_id" Jdec.string
        |> Jpipe.required "id" Jdec.int
        |> Jpipe.required "login" Jdec.string
        |> Jpipe.required "url" Jdec.string

encodeActor : Actor -> Jenc.Value
encodeActor x =
    Jenc.object
        [ ("avatar_url", Jenc.string x.avatarURL)
        , ("display_login", makeNullableEncoder Jenc.string x.displayLogin)
        , ("gravatar_id", Jenc.string x.gravatarID)
        , ("id", Jenc.int x.id)
        , ("login", Jenc.string x.login)
        , ("url", Jenc.string x.url)
        ]

payload : Jdec.Decoder Payload
payload =
    Jdec.succeed Payload
        |> Jpipe.custom (optionalField "action" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "before" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "comment" (Jdec.map Just comment) Nothing)
        |> Jpipe.custom (optionalField "commits" (Jdec.map Just (Jdec.list commit )) Nothing)
        |> Jpipe.custom (optionalField "description" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "distinct_size" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "head" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "issue" (Jdec.map Just issue) Nothing)
        |> Jpipe.custom (optionalField "master_branch" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "number" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "pull_request" (Jdec.map Just payloadPullRequest) Nothing)
        |> Jpipe.custom (optionalField "push_id" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "pusher_type" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "ref" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "ref_type" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "size" (Jdec.map Just Jdec.int) Nothing)

encodePayload : Payload -> Jenc.Value
encodePayload x =
    Jenc.object
        [ ("action", makeNullableEncoder Jenc.string x.action)
        , ("before", makeNullableEncoder Jenc.string x.before)
        , ("comment", makeNullableEncoder encodeComment x.comment)
        , ("commits", makeNullableEncoder (Jenc.list encodeCommit) x.commits)
        , ("description", makeNullableEncoder Jenc.string x.description)
        , ("distinct_size", makeNullableEncoder Jenc.int x.distinctSize)
        , ("head", makeNullableEncoder Jenc.string x.head)
        , ("issue", makeNullableEncoder encodeIssue x.issue)
        , ("master_branch", makeNullableEncoder Jenc.string x.masterBranch)
        , ("number", makeNullableEncoder Jenc.int x.number)
        , ("pull_request", makeNullableEncoder encodePayloadPullRequest x.pullRequest)
        , ("push_id", makeNullableEncoder Jenc.int x.pushID)
        , ("pusher_type", makeNullableEncoder Jenc.string x.pusherType)
        , ("ref", makeNullableEncoder Jenc.string x.ref)
        , ("ref_type", makeNullableEncoder Jenc.string x.refType)
        , ("size", makeNullableEncoder Jenc.int x.size)
        ]

comment : Jdec.Decoder Comment
comment =
    Jdec.succeed Comment
        |> Jpipe.required "body" Jdec.string
        |> Jpipe.required "created_at" Jdec.string
        |> Jpipe.required "html_url" Jdec.string
        |> Jpipe.required "id" Jdec.int
        |> Jpipe.required "issue_url" Jdec.string
        |> Jpipe.required "updated_at" Jdec.string
        |> Jpipe.required "url" Jdec.string
        |> Jpipe.required "user" userClass

encodeComment : Comment -> Jenc.Value
encodeComment x =
    Jenc.object
        [ ("body", Jenc.string x.body)
        , ("created_at", Jenc.string x.createdAt)
        , ("html_url", Jenc.string x.htmlURL)
        , ("id", Jenc.int x.id)
        , ("issue_url", Jenc.string x.issueURL)
        , ("updated_at", Jenc.string x.updatedAt)
        , ("url", Jenc.string x.url)
        , ("user", encodeUserClass x.user)
        ]

userClass : Jdec.Decoder UserClass
userClass =
    Jdec.succeed UserClass
        |> Jpipe.required "avatar_url" Jdec.string
        |> Jpipe.required "events_url" Jdec.string
        |> Jpipe.required "followers_url" Jdec.string
        |> Jpipe.required "following_url" Jdec.string
        |> Jpipe.required "gists_url" Jdec.string
        |> Jpipe.required "gravatar_id" Jdec.string
        |> Jpipe.required "html_url" Jdec.string
        |> Jpipe.required "id" Jdec.int
        |> Jpipe.required "login" Jdec.string
        |> Jpipe.required "organizations_url" Jdec.string
        |> Jpipe.required "received_events_url" Jdec.string
        |> Jpipe.required "repos_url" Jdec.string
        |> Jpipe.required "site_admin" Jdec.bool
        |> Jpipe.required "starred_url" Jdec.string
        |> Jpipe.required "subscriptions_url" Jdec.string
        |> Jpipe.required "url" Jdec.string
        |> Jpipe.required "type" purpleType

encodeUserClass : UserClass -> Jenc.Value
encodeUserClass x =
    Jenc.object
        [ ("avatar_url", Jenc.string x.avatarURL)
        , ("events_url", Jenc.string x.eventsURL)
        , ("followers_url", Jenc.string x.followersURL)
        , ("following_url", Jenc.string x.followingURL)
        , ("gists_url", Jenc.string x.gistsURL)
        , ("gravatar_id", Jenc.string x.gravatarID)
        , ("html_url", Jenc.string x.htmlURL)
        , ("id", Jenc.int x.id)
        , ("login", Jenc.string x.login)
        , ("organizations_url", Jenc.string x.organizationsURL)
        , ("received_events_url", Jenc.string x.receivedEventsURL)
        , ("repos_url", Jenc.string x.reposURL)
        , ("site_admin", Jenc.bool x.siteAdmin)
        , ("starred_url", Jenc.string x.starredURL)
        , ("subscriptions_url", Jenc.string x.subscriptionsURL)
        , ("url", Jenc.string x.url)
        , ("type", encodeType x.userType)
        ]

purpleType : Jdec.Decoder Type
purpleType =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "User" -> Jdec.succeed User
                "Organization" -> Jdec.succeed Organization
                somethingElse -> Jdec.fail <| "Invalid Type: " ++ somethingElse
        )

encodeType : Type -> Jenc.Value
encodeType x = case x of
    User -> Jenc.string "User"
    Organization -> Jenc.string "Organization"

commit : Jdec.Decoder Commit
commit =
    Jdec.succeed Commit
        |> Jpipe.required "author" author
        |> Jpipe.required "distinct" Jdec.bool
        |> Jpipe.required "message" Jdec.string
        |> Jpipe.required "sha" Jdec.string
        |> Jpipe.required "url" Jdec.string

encodeCommit : Commit -> Jenc.Value
encodeCommit x =
    Jenc.object
        [ ("author", encodeAuthor x.author)
        , ("distinct", Jenc.bool x.distinct)
        , ("message", Jenc.string x.message)
        , ("sha", Jenc.string x.sha)
        , ("url", Jenc.string x.url)
        ]

author : Jdec.Decoder Author
author =
    Jdec.succeed Author
        |> Jpipe.required "email" Jdec.string
        |> Jpipe.required "name" Jdec.string

encodeAuthor : Author -> Jenc.Value
encodeAuthor x =
    Jenc.object
        [ ("email", Jenc.string x.email)
        , ("name", Jenc.string x.name)
        ]

issue : Jdec.Decoder Issue
issue =
    Jdec.succeed Issue
        |> Jpipe.required "assignee" (Jdec.null ())
        |> Jpipe.required "assignees" (Jdec.list Jdec.value )
        |> Jpipe.required "body" Jdec.string
        |> Jpipe.required "closed_at" (Jdec.nullable Jdec.string)
        |> Jpipe.required "comments" Jdec.int
        |> Jpipe.required "comments_url" Jdec.string
        |> Jpipe.required "created_at" Jdec.string
        |> Jpipe.required "events_url" Jdec.string
        |> Jpipe.required "html_url" Jdec.string
        |> Jpipe.required "id" Jdec.int
        |> Jpipe.required "labels" (Jdec.list label )
        |> Jpipe.required "labels_url" Jdec.string
        |> Jpipe.required "locked" Jdec.bool
        |> Jpipe.required "milestone" (Jdec.nullable milestone)
        |> Jpipe.required "number" Jdec.int
        |> Jpipe.custom (optionalField "pull_request" (Jdec.map Just issuePullRequest) Nothing)
        |> Jpipe.required "repository_url" Jdec.string
        |> Jpipe.required "state" Jdec.string
        |> Jpipe.required "title" Jdec.string
        |> Jpipe.required "updated_at" Jdec.string
        |> Jpipe.required "url" Jdec.string
        |> Jpipe.required "user" userClass

encodeIssue : Issue -> Jenc.Value
encodeIssue x =
    Jenc.object
        [ ("assignee", always Jenc.null x.assignee)
        , ("assignees", Jenc.list identity x.assignees)
        , ("body", Jenc.string x.body)
        , ("closed_at", makeNullableEncoder Jenc.string x.closedAt)
        , ("comments", Jenc.int x.comments)
        , ("comments_url", Jenc.string x.commentsURL)
        , ("created_at", Jenc.string x.createdAt)
        , ("events_url", Jenc.string x.eventsURL)
        , ("html_url", Jenc.string x.htmlURL)
        , ("id", Jenc.int x.id)
        , ("labels", Jenc.list encodeLabel x.labels)
        , ("labels_url", Jenc.string x.labelsURL)
        , ("locked", Jenc.bool x.locked)
        , ("milestone", makeNullableEncoder encodeMilestone x.milestone)
        , ("number", Jenc.int x.number)
        , ("pull_request", makeNullableEncoder encodeIssuePullRequest x.pullRequest)
        , ("repository_url", Jenc.string x.repositoryURL)
        , ("state", Jenc.string x.state)
        , ("title", Jenc.string x.title)
        , ("updated_at", Jenc.string x.updatedAt)
        , ("url", Jenc.string x.url)
        , ("user", encodeUserClass x.user)
        ]

label : Jdec.Decoder Label
label =
    Jdec.succeed Label
        |> Jpipe.required "color" Jdec.string
        |> Jpipe.required "default" Jdec.bool
        |> Jpipe.required "id" Jdec.int
        |> Jpipe.required "name" Jdec.string
        |> Jpipe.required "url" Jdec.string

encodeLabel : Label -> Jenc.Value
encodeLabel x =
    Jenc.object
        [ ("color", Jenc.string x.color)
        , ("default", Jenc.bool x.default)
        , ("id", Jenc.int x.id)
        , ("name", Jenc.string x.name)
        , ("url", Jenc.string x.url)
        ]

milestone : Jdec.Decoder Milestone
milestone =
    Jdec.succeed Milestone
        |> Jpipe.required "closed_at" (Jdec.null ())
        |> Jpipe.required "closed_issues" Jdec.int
        |> Jpipe.required "created_at" Jdec.string
        |> Jpipe.required "creator" userClass
        |> Jpipe.required "description" Jdec.string
        |> Jpipe.required "due_on" (Jdec.nullable Jdec.string)
        |> Jpipe.required "html_url" Jdec.string
        |> Jpipe.required "id" Jdec.int
        |> Jpipe.required "labels_url" Jdec.string
        |> Jpipe.required "number" Jdec.int
        |> Jpipe.required "open_issues" Jdec.int
        |> Jpipe.required "state" Jdec.string
        |> Jpipe.required "title" Jdec.string
        |> Jpipe.required "updated_at" Jdec.string
        |> Jpipe.required "url" Jdec.string

encodeMilestone : Milestone -> Jenc.Value
encodeMilestone x =
    Jenc.object
        [ ("closed_at", always Jenc.null x.closedAt)
        , ("closed_issues", Jenc.int x.closedIssues)
        , ("created_at", Jenc.string x.createdAt)
        , ("creator", encodeUserClass x.creator)
        , ("description", Jenc.string x.description)
        , ("due_on", makeNullableEncoder Jenc.string x.dueOn)
        , ("html_url", Jenc.string x.htmlURL)
        , ("id", Jenc.int x.id)
        , ("labels_url", Jenc.string x.labelsURL)
        , ("number", Jenc.int x.number)
        , ("open_issues", Jenc.int x.openIssues)
        , ("state", Jenc.string x.state)
        , ("title", Jenc.string x.title)
        , ("updated_at", Jenc.string x.updatedAt)
        , ("url", Jenc.string x.url)
        ]

issuePullRequest : Jdec.Decoder IssuePullRequest
issuePullRequest =
    Jdec.succeed IssuePullRequest
        |> Jpipe.required "diff_url" Jdec.string
        |> Jpipe.required "html_url" Jdec.string
        |> Jpipe.required "patch_url" Jdec.string
        |> Jpipe.required "url" Jdec.string

encodeIssuePullRequest : IssuePullRequest -> Jenc.Value
encodeIssuePullRequest x =
    Jenc.object
        [ ("diff_url", Jenc.string x.diffURL)
        , ("html_url", Jenc.string x.htmlURL)
        , ("patch_url", Jenc.string x.patchURL)
        , ("url", Jenc.string x.url)
        ]

payloadPullRequest : Jdec.Decoder PayloadPullRequest
payloadPullRequest =
    Jdec.succeed PayloadPullRequest
        |> Jpipe.required "additions" Jdec.int
        |> Jpipe.required "assignee" (Jdec.null ())
        |> Jpipe.required "assignees" (Jdec.list Jdec.value )
        |> Jpipe.required "base" base
        |> Jpipe.required "body" Jdec.string
        |> Jpipe.required "changed_files" Jdec.int
        |> Jpipe.required "closed_at" Jdec.string
        |> Jpipe.required "comments" Jdec.int
        |> Jpipe.required "comments_url" Jdec.string
        |> Jpipe.required "commits" Jdec.int
        |> Jpipe.required "commits_url" Jdec.string
        |> Jpipe.required "created_at" Jdec.string
        |> Jpipe.required "deletions" Jdec.int
        |> Jpipe.required "diff_url" Jdec.string
        |> Jpipe.required "head" base
        |> Jpipe.required "html_url" Jdec.string
        |> Jpipe.required "id" Jdec.int
        |> Jpipe.required "issue_url" Jdec.string
        |> Jpipe.required "_links" links
        |> Jpipe.required "locked" Jdec.bool
        |> Jpipe.required "maintainer_can_modify" Jdec.bool
        |> Jpipe.required "merge_commit_sha" Jdec.string
        |> Jpipe.required "mergeable" (Jdec.null ())
        |> Jpipe.required "mergeable_state" Jdec.string
        |> Jpipe.required "merged" Jdec.bool
        |> Jpipe.required "merged_at" Jdec.string
        |> Jpipe.required "merged_by" userClass
        |> Jpipe.required "milestone" (Jdec.null ())
        |> Jpipe.required "number" Jdec.int
        |> Jpipe.required "patch_url" Jdec.string
        |> Jpipe.required "rebaseable" (Jdec.null ())
        |> Jpipe.required "requested_reviewers" (Jdec.list Jdec.value )
        |> Jpipe.required "review_comment_url" Jdec.string
        |> Jpipe.required "review_comments" Jdec.int
        |> Jpipe.required "review_comments_url" Jdec.string
        |> Jpipe.required "state" Jdec.string
        |> Jpipe.required "statuses_url" Jdec.string
        |> Jpipe.required "title" Jdec.string
        |> Jpipe.required "updated_at" Jdec.string
        |> Jpipe.required "url" Jdec.string
        |> Jpipe.required "user" userClass

encodePayloadPullRequest : PayloadPullRequest -> Jenc.Value
encodePayloadPullRequest x =
    Jenc.object
        [ ("additions", Jenc.int x.additions)
        , ("assignee", always Jenc.null x.assignee)
        , ("assignees", Jenc.list identity x.assignees)
        , ("base", encodeBase x.base)
        , ("body", Jenc.string x.body)
        , ("changed_files", Jenc.int x.changedFiles)
        , ("closed_at", Jenc.string x.closedAt)
        , ("comments", Jenc.int x.comments)
        , ("comments_url", Jenc.string x.commentsURL)
        , ("commits", Jenc.int x.commits)
        , ("commits_url", Jenc.string x.commitsURL)
        , ("created_at", Jenc.string x.createdAt)
        , ("deletions", Jenc.int x.deletions)
        , ("diff_url", Jenc.string x.diffURL)
        , ("head", encodeBase x.head)
        , ("html_url", Jenc.string x.htmlURL)
        , ("id", Jenc.int x.id)
        , ("issue_url", Jenc.string x.issueURL)
        , ("_links", encodeLinks x.links)
        , ("locked", Jenc.bool x.locked)
        , ("maintainer_can_modify", Jenc.bool x.maintainerCanModify)
        , ("merge_commit_sha", Jenc.string x.mergeCommitSHA)
        , ("mergeable", always Jenc.null x.mergeable)
        , ("mergeable_state", Jenc.string x.mergeableState)
        , ("merged", Jenc.bool x.merged)
        , ("merged_at", Jenc.string x.mergedAt)
        , ("merged_by", encodeUserClass x.mergedBy)
        , ("milestone", always Jenc.null x.milestone)
        , ("number", Jenc.int x.number)
        , ("patch_url", Jenc.string x.patchURL)
        , ("rebaseable", always Jenc.null x.rebaseable)
        , ("requested_reviewers", Jenc.list identity x.requestedReviewers)
        , ("review_comment_url", Jenc.string x.reviewCommentURL)
        , ("review_comments", Jenc.int x.reviewComments)
        , ("review_comments_url", Jenc.string x.reviewCommentsURL)
        , ("state", Jenc.string x.state)
        , ("statuses_url", Jenc.string x.statusesURL)
        , ("title", Jenc.string x.title)
        , ("updated_at", Jenc.string x.updatedAt)
        , ("url", Jenc.string x.url)
        , ("user", encodeUserClass x.user)
        ]

base : Jdec.Decoder Base
base =
    Jdec.succeed Base
        |> Jpipe.required "label" Jdec.string
        |> Jpipe.required "ref" Jdec.string
        |> Jpipe.required "repo" baseRepo
        |> Jpipe.required "sha" Jdec.string
        |> Jpipe.required "user" userClass

encodeBase : Base -> Jenc.Value
encodeBase x =
    Jenc.object
        [ ("label", Jenc.string x.label)
        , ("ref", Jenc.string x.ref)
        , ("repo", encodeBaseRepo x.repo)
        , ("sha", Jenc.string x.sha)
        , ("user", encodeUserClass x.user)
        ]

baseRepo : Jdec.Decoder BaseRepo
baseRepo =
    Jdec.succeed BaseRepo
        |> Jpipe.required "archive_url" Jdec.string
        |> Jpipe.required "assignees_url" Jdec.string
        |> Jpipe.required "blobs_url" Jdec.string
        |> Jpipe.required "branches_url" Jdec.string
        |> Jpipe.required "clone_url" Jdec.string
        |> Jpipe.required "collaborators_url" Jdec.string
        |> Jpipe.required "comments_url" Jdec.string
        |> Jpipe.required "commits_url" Jdec.string
        |> Jpipe.required "compare_url" Jdec.string
        |> Jpipe.required "contents_url" Jdec.string
        |> Jpipe.required "contributors_url" Jdec.string
        |> Jpipe.required "created_at" Jdec.string
        |> Jpipe.required "default_branch" Jdec.string
        |> Jpipe.required "deployments_url" Jdec.string
        |> Jpipe.required "description" Jdec.string
        |> Jpipe.required "downloads_url" Jdec.string
        |> Jpipe.required "events_url" Jdec.string
        |> Jpipe.required "fork" Jdec.bool
        |> Jpipe.required "forks" Jdec.int
        |> Jpipe.required "forks_count" Jdec.int
        |> Jpipe.required "forks_url" Jdec.string
        |> Jpipe.required "full_name" Jdec.string
        |> Jpipe.required "git_commits_url" Jdec.string
        |> Jpipe.required "git_refs_url" Jdec.string
        |> Jpipe.required "git_tags_url" Jdec.string
        |> Jpipe.required "git_url" Jdec.string
        |> Jpipe.required "has_downloads" Jdec.bool
        |> Jpipe.required "has_issues" Jdec.bool
        |> Jpipe.required "has_pages" Jdec.bool
        |> Jpipe.required "has_projects" Jdec.bool
        |> Jpipe.required "has_wiki" Jdec.bool
        |> Jpipe.required "homepage" Jdec.string
        |> Jpipe.required "hooks_url" Jdec.string
        |> Jpipe.required "html_url" Jdec.string
        |> Jpipe.required "id" Jdec.int
        |> Jpipe.required "issue_comment_url" Jdec.string
        |> Jpipe.required "issue_events_url" Jdec.string
        |> Jpipe.required "issues_url" Jdec.string
        |> Jpipe.required "keys_url" Jdec.string
        |> Jpipe.required "labels_url" Jdec.string
        |> Jpipe.required "language" Jdec.string
        |> Jpipe.required "languages_url" Jdec.string
        |> Jpipe.required "merges_url" Jdec.string
        |> Jpipe.required "milestones_url" Jdec.string
        |> Jpipe.required "mirror_url" (Jdec.null ())
        |> Jpipe.required "name" Jdec.string
        |> Jpipe.required "notifications_url" Jdec.string
        |> Jpipe.required "open_issues" Jdec.int
        |> Jpipe.required "open_issues_count" Jdec.int
        |> Jpipe.required "owner" userClass
        |> Jpipe.required "private" Jdec.bool
        |> Jpipe.required "pulls_url" Jdec.string
        |> Jpipe.required "pushed_at" Jdec.string
        |> Jpipe.required "releases_url" Jdec.string
        |> Jpipe.required "size" Jdec.int
        |> Jpipe.required "ssh_url" Jdec.string
        |> Jpipe.required "stargazers_count" Jdec.int
        |> Jpipe.required "stargazers_url" Jdec.string
        |> Jpipe.required "statuses_url" Jdec.string
        |> Jpipe.required "subscribers_url" Jdec.string
        |> Jpipe.required "subscription_url" Jdec.string
        |> Jpipe.required "svn_url" Jdec.string
        |> Jpipe.required "tags_url" Jdec.string
        |> Jpipe.required "teams_url" Jdec.string
        |> Jpipe.required "trees_url" Jdec.string
        |> Jpipe.required "updated_at" Jdec.string
        |> Jpipe.required "url" Jdec.string
        |> Jpipe.required "watchers" Jdec.int
        |> Jpipe.required "watchers_count" Jdec.int

encodeBaseRepo : BaseRepo -> Jenc.Value
encodeBaseRepo x =
    Jenc.object
        [ ("archive_url", Jenc.string x.archiveURL)
        , ("assignees_url", Jenc.string x.assigneesURL)
        , ("blobs_url", Jenc.string x.blobsURL)
        , ("branches_url", Jenc.string x.branchesURL)
        , ("clone_url", Jenc.string x.cloneURL)
        , ("collaborators_url", Jenc.string x.collaboratorsURL)
        , ("comments_url", Jenc.string x.commentsURL)
        , ("commits_url", Jenc.string x.commitsURL)
        , ("compare_url", Jenc.string x.compareURL)
        , ("contents_url", Jenc.string x.contentsURL)
        , ("contributors_url", Jenc.string x.contributorsURL)
        , ("created_at", Jenc.string x.createdAt)
        , ("default_branch", Jenc.string x.defaultBranch)
        , ("deployments_url", Jenc.string x.deploymentsURL)
        , ("description", Jenc.string x.description)
        , ("downloads_url", Jenc.string x.downloadsURL)
        , ("events_url", Jenc.string x.eventsURL)
        , ("fork", Jenc.bool x.fork)
        , ("forks", Jenc.int x.forks)
        , ("forks_count", Jenc.int x.forksCount)
        , ("forks_url", Jenc.string x.forksURL)
        , ("full_name", Jenc.string x.fullName)
        , ("git_commits_url", Jenc.string x.gitCommitsURL)
        , ("git_refs_url", Jenc.string x.gitRefsURL)
        , ("git_tags_url", Jenc.string x.gitTagsURL)
        , ("git_url", Jenc.string x.gitURL)
        , ("has_downloads", Jenc.bool x.hasDownloads)
        , ("has_issues", Jenc.bool x.hasIssues)
        , ("has_pages", Jenc.bool x.hasPages)
        , ("has_projects", Jenc.bool x.hasProjects)
        , ("has_wiki", Jenc.bool x.hasWiki)
        , ("homepage", Jenc.string x.homepage)
        , ("hooks_url", Jenc.string x.hooksURL)
        , ("html_url", Jenc.string x.htmlURL)
        , ("id", Jenc.int x.id)
        , ("issue_comment_url", Jenc.string x.issueCommentURL)
        , ("issue_events_url", Jenc.string x.issueEventsURL)
        , ("issues_url", Jenc.string x.issuesURL)
        , ("keys_url", Jenc.string x.keysURL)
        , ("labels_url", Jenc.string x.labelsURL)
        , ("language", Jenc.string x.language)
        , ("languages_url", Jenc.string x.languagesURL)
        , ("merges_url", Jenc.string x.mergesURL)
        , ("milestones_url", Jenc.string x.milestonesURL)
        , ("mirror_url", always Jenc.null x.mirrorURL)
        , ("name", Jenc.string x.name)
        , ("notifications_url", Jenc.string x.notificationsURL)
        , ("open_issues", Jenc.int x.openIssues)
        , ("open_issues_count", Jenc.int x.openIssuesCount)
        , ("owner", encodeUserClass x.owner)
        , ("private", Jenc.bool x.private)
        , ("pulls_url", Jenc.string x.pullsURL)
        , ("pushed_at", Jenc.string x.pushedAt)
        , ("releases_url", Jenc.string x.releasesURL)
        , ("size", Jenc.int x.size)
        , ("ssh_url", Jenc.string x.sshURL)
        , ("stargazers_count", Jenc.int x.stargazersCount)
        , ("stargazers_url", Jenc.string x.stargazersURL)
        , ("statuses_url", Jenc.string x.statusesURL)
        , ("subscribers_url", Jenc.string x.subscribersURL)
        , ("subscription_url", Jenc.string x.subscriptionURL)
        , ("svn_url", Jenc.string x.svnURL)
        , ("tags_url", Jenc.string x.tagsURL)
        , ("teams_url", Jenc.string x.teamsURL)
        , ("trees_url", Jenc.string x.treesURL)
        , ("updated_at", Jenc.string x.updatedAt)
        , ("url", Jenc.string x.url)
        , ("watchers", Jenc.int x.watchers)
        , ("watchers_count", Jenc.int x.watchersCount)
        ]

links : Jdec.Decoder Links
links =
    Jdec.succeed Links
        |> Jpipe.required "comments" comments
        |> Jpipe.required "commits" comments
        |> Jpipe.required "html" comments
        |> Jpipe.required "issue" comments
        |> Jpipe.required "review_comment" comments
        |> Jpipe.required "review_comments" comments
        |> Jpipe.required "self" comments
        |> Jpipe.required "statuses" comments

encodeLinks : Links -> Jenc.Value
encodeLinks x =
    Jenc.object
        [ ("comments", encodeComments x.comments)
        , ("commits", encodeComments x.commits)
        , ("html", encodeComments x.html)
        , ("issue", encodeComments x.issue)
        , ("review_comment", encodeComments x.reviewComment)
        , ("review_comments", encodeComments x.reviewComments)
        , ("self", encodeComments x.self)
        , ("statuses", encodeComments x.statuses)
        ]

comments : Jdec.Decoder Comments
comments =
    Jdec.succeed Comments
        |> Jpipe.required "href" Jdec.string

encodeComments : Comments -> Jenc.Value
encodeComments x =
    Jenc.object
        [ ("href", Jenc.string x.href)
        ]

quickTypeRepo : Jdec.Decoder QuickTypeRepo
quickTypeRepo =
    Jdec.succeed QuickTypeRepo
        |> Jpipe.required "id" Jdec.int
        |> Jpipe.required "name" Jdec.string
        |> Jpipe.required "url" Jdec.string

encodeQuickTypeRepo : QuickTypeRepo -> Jenc.Value
encodeQuickTypeRepo x =
    Jenc.object
        [ ("id", Jenc.int x.id)
        , ("name", Jenc.string x.name)
        , ("url", Jenc.string x.url)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
