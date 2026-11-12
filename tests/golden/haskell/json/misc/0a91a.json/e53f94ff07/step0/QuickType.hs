{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , QuickTypeElement (..)
    , Actor (..)
    , Payload (..)
    , Commit (..)
    , Author (..)
    , PullRequest (..)
    , Base (..)
    , BaseRepo (..)
    , MergedBy (..)
    , Links (..)
    , Comments (..)
    , QuickTypeRepo (..)
    , Type (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

type QuickType = [QuickTypeElement]

data QuickTypeElement = QuickTypeElement
    { actorQuickTypeElement :: Actor
    , createdAtQuickTypeElement :: Text
    , orgQuickTypeElement :: Maybe Actor
    , payloadQuickTypeElement :: Payload
    , publicQuickTypeElement :: Bool
    , quickTypeIDQuickTypeElement :: Text
    , quickTypeTypeQuickTypeElement :: Type
    , repoQuickTypeElement :: QuickTypeRepo
    } deriving (Show)

data Actor = Actor
    { actorIDActor :: Int
    , avatarURLActor :: Text
    , displayLoginActor :: Maybe Text
    , gravatarIDActor :: Text
    , loginActor :: Text
    , urlActor :: Text
    } deriving (Show)

data Payload = Payload
    { actionPayload :: Maybe Text
    , beforePayload :: Maybe Text
    , commitsPayload :: Maybe ([Commit])
    , descriptionPayload :: Maybe (Maybe Text)
    , distinctSizePayload :: Maybe Int
    , headPayload :: Maybe Text
    , masterBranchPayload :: Maybe Text
    , numberPayload :: Maybe Int
    , pullRequestPayload :: Maybe PullRequest
    , pushIDPayload :: Maybe Int
    , pusherTypePayload :: Maybe Text
    , refPayload :: Maybe Text
    , refTypePayload :: Maybe Text
    , sizePayload :: Maybe Int
    } deriving (Show)

data Commit = Commit
    { authorCommit :: Author
    , distinctCommit :: Bool
    , messageCommit :: Text
    , shaCommit :: Text
    , urlCommit :: Text
    } deriving (Show)

data Author = Author
    { emailAuthor :: Text
    , nameAuthor :: Text
    } deriving (Show)

data PullRequest = PullRequest
    { additionsPullRequest :: Int
    , assigneePullRequest :: Maybe Text
    , assigneesPullRequest :: [Value]
    , basePullRequest :: Base
    , bodyPullRequest :: Text
    , changedFilesPullRequest :: Int
    , closedAtPullRequest :: Text
    , commentsPullRequest :: Int
    , commentsURLPullRequest :: Text
    , commitsPullRequest :: Int
    , commitsURLPullRequest :: Text
    , createdAtPullRequest :: Text
    , deletionsPullRequest :: Int
    , diffURLPullRequest :: Text
    , headPullRequest :: Base
    , htmlURLPullRequest :: Text
    , issueURLPullRequest :: Text
    , linksPullRequest :: Links
    , lockedPullRequest :: Bool
    , maintainerCanModifyPullRequest :: Bool
    , mergeCommitSHAPullRequest :: Text
    , mergeablePullRequest :: Maybe Text
    , mergeableStatePullRequest :: Text
    , mergedPullRequest :: Bool
    , mergedAtPullRequest :: Text
    , mergedByPullRequest :: MergedBy
    , milestonePullRequest :: Maybe Text
    , numberPullRequest :: Int
    , patchURLPullRequest :: Text
    , pullRequestIDPullRequest :: Int
    , rebaseablePullRequest :: Maybe Text
    , requestedReviewersPullRequest :: [Value]
    , reviewCommentURLPullRequest :: Text
    , reviewCommentsPullRequest :: Int
    , reviewCommentsURLPullRequest :: Text
    , statePullRequest :: Text
    , statusesURLPullRequest :: Text
    , titlePullRequest :: Text
    , updatedAtPullRequest :: Text
    , urlPullRequest :: Text
    , userPullRequest :: MergedBy
    } deriving (Show)

data Base = Base
    { labelBase :: Text
    , refBase :: Text
    , repoBase :: BaseRepo
    , shaBase :: Text
    , userBase :: MergedBy
    } deriving (Show)

data BaseRepo = BaseRepo
    { archiveURLBaseRepo :: Text
    , assigneesURLBaseRepo :: Text
    , blobsURLBaseRepo :: Text
    , branchesURLBaseRepo :: Text
    , cloneURLBaseRepo :: Text
    , collaboratorsURLBaseRepo :: Text
    , commentsURLBaseRepo :: Text
    , commitsURLBaseRepo :: Text
    , compareURLBaseRepo :: Text
    , contentsURLBaseRepo :: Text
    , contributorsURLBaseRepo :: Text
    , createdAtBaseRepo :: Text
    , defaultBranchBaseRepo :: Text
    , deploymentsURLBaseRepo :: Text
    , descriptionBaseRepo :: Maybe Text
    , downloadsURLBaseRepo :: Text
    , eventsURLBaseRepo :: Text
    , forkBaseRepo :: Bool
    , forksBaseRepo :: Int
    , forksCountBaseRepo :: Int
    , forksURLBaseRepo :: Text
    , fullNameBaseRepo :: Text
    , gitCommitsURLBaseRepo :: Text
    , gitRefsURLBaseRepo :: Text
    , gitTagsURLBaseRepo :: Text
    , gitURLBaseRepo :: Text
    , hasDownloadsBaseRepo :: Bool
    , hasIssuesBaseRepo :: Bool
    , hasPagesBaseRepo :: Bool
    , hasProjectsBaseRepo :: Bool
    , hasWikiBaseRepo :: Bool
    , homepageBaseRepo :: Maybe Text
    , hooksURLBaseRepo :: Text
    , htmlURLBaseRepo :: Text
    , issueCommentURLBaseRepo :: Text
    , issueEventsURLBaseRepo :: Text
    , issuesURLBaseRepo :: Text
    , keysURLBaseRepo :: Text
    , labelsURLBaseRepo :: Text
    , languageBaseRepo :: Text
    , languagesURLBaseRepo :: Text
    , mergesURLBaseRepo :: Text
    , milestonesURLBaseRepo :: Text
    , mirrorURLBaseRepo :: Maybe Text
    , nameBaseRepo :: Text
    , notificationsURLBaseRepo :: Text
    , openIssuesBaseRepo :: Int
    , openIssuesCountBaseRepo :: Int
    , ownerBaseRepo :: MergedBy
    , privateBaseRepo :: Bool
    , pullsURLBaseRepo :: Text
    , pushedAtBaseRepo :: Text
    , releasesURLBaseRepo :: Text
    , repoIDBaseRepo :: Int
    , sizeBaseRepo :: Int
    , sshURLBaseRepo :: Text
    , stargazersCountBaseRepo :: Int
    , stargazersURLBaseRepo :: Text
    , statusesURLBaseRepo :: Text
    , subscribersURLBaseRepo :: Text
    , subscriptionURLBaseRepo :: Text
    , svnURLBaseRepo :: Text
    , tagsURLBaseRepo :: Text
    , teamsURLBaseRepo :: Text
    , treesURLBaseRepo :: Text
    , updatedAtBaseRepo :: Text
    , urlBaseRepo :: Text
    , watchersBaseRepo :: Int
    , watchersCountBaseRepo :: Int
    } deriving (Show)

data MergedBy = MergedBy
    { avatarURLMergedBy :: Text
    , eventsURLMergedBy :: Text
    , followersURLMergedBy :: Text
    , followingURLMergedBy :: Text
    , gistsURLMergedBy :: Text
    , gravatarIDMergedBy :: Text
    , htmlURLMergedBy :: Text
    , loginMergedBy :: Text
    , mergedByIDMergedBy :: Int
    , mergedByTypeMergedBy :: Text
    , organizationsURLMergedBy :: Text
    , receivedEventsURLMergedBy :: Text
    , reposURLMergedBy :: Text
    , siteAdminMergedBy :: Bool
    , starredURLMergedBy :: Text
    , subscriptionsURLMergedBy :: Text
    , urlMergedBy :: Text
    } deriving (Show)

data Links = Links
    { commentsLinks :: Comments
    , commitsLinks :: Comments
    , htmlLinks :: Comments
    , issueLinks :: Comments
    , reviewCommentLinks :: Comments
    , reviewCommentsLinks :: Comments
    , selfLinks :: Comments
    , statusesLinks :: Comments
    } deriving (Show)

data Comments = Comments
    { hrefComments :: Text
    } deriving (Show)

data Type
    = PushEventType
    | CreateEventType
    | WatchEventType
    | PullRequestEventType
    | DeleteEventType
    deriving (Show)

data QuickTypeRepo = QuickTypeRepo
    { nameQuickTypeRepo :: Text
    , repoIDQuickTypeRepo :: Int
    , urlQuickTypeRepo :: Text
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickTypeElement where
    toJSON (QuickTypeElement actorQuickTypeElement createdAtQuickTypeElement orgQuickTypeElement payloadQuickTypeElement publicQuickTypeElement quickTypeIDQuickTypeElement quickTypeTypeQuickTypeElement repoQuickTypeElement) =
        object $ foldMap (maybe [] pure)
        [ Just $ "actor" .= actorQuickTypeElement
        , Just $ "created_at" .= createdAtQuickTypeElement
        , ("org" .=) <$> orgQuickTypeElement
        , Just $ "payload" .= payloadQuickTypeElement
        , Just $ "public" .= publicQuickTypeElement
        , Just $ "id" .= quickTypeIDQuickTypeElement
        , Just $ "type" .= quickTypeTypeQuickTypeElement
        , Just $ "repo" .= repoQuickTypeElement
        ]

instance FromJSON QuickTypeElement where
    parseJSON (Object v) = QuickTypeElement
        <$> v .: "actor"
        <*> v .: "created_at"
        <*> v .:! "org"
        <*> v .: "payload"
        <*> v .: "public"
        <*> v .: "id"
        <*> v .: "type"
        <*> v .: "repo"

instance ToJSON Actor where
    toJSON (Actor actorIDActor avatarURLActor displayLoginActor gravatarIDActor loginActor urlActor) =
        object $ foldMap (maybe [] pure)
        [ Just $ "id" .= actorIDActor
        , Just $ "avatar_url" .= avatarURLActor
        , ("display_login" .=) <$> displayLoginActor
        , Just $ "gravatar_id" .= gravatarIDActor
        , Just $ "login" .= loginActor
        , Just $ "url" .= urlActor
        ]

instance FromJSON Actor where
    parseJSON (Object v) = Actor
        <$> v .: "id"
        <*> v .: "avatar_url"
        <*> v .:! "display_login"
        <*> v .: "gravatar_id"
        <*> v .: "login"
        <*> v .: "url"

instance ToJSON Payload where
    toJSON (Payload actionPayload beforePayload commitsPayload descriptionPayload distinctSizePayload headPayload masterBranchPayload numberPayload pullRequestPayload pushIDPayload pusherTypePayload refPayload refTypePayload sizePayload) =
        object $ foldMap (maybe [] pure)
        [ ("action" .=) <$> actionPayload
        , ("before" .=) <$> beforePayload
        , ("commits" .=) <$> commitsPayload
        , ("description" .=) <$> descriptionPayload
        , ("distinct_size" .=) <$> distinctSizePayload
        , ("head" .=) <$> headPayload
        , ("master_branch" .=) <$> masterBranchPayload
        , ("number" .=) <$> numberPayload
        , ("pull_request" .=) <$> pullRequestPayload
        , ("push_id" .=) <$> pushIDPayload
        , ("pusher_type" .=) <$> pusherTypePayload
        , ("ref" .=) <$> refPayload
        , ("ref_type" .=) <$> refTypePayload
        , ("size" .=) <$> sizePayload
        ]

instance FromJSON Payload where
    parseJSON (Object v) = Payload
        <$> v .:! "action"
        <*> v .:! "before"
        <*> v .:! "commits"
        <*> v .:! "description"
        <*> v .:! "distinct_size"
        <*> v .:! "head"
        <*> v .:! "master_branch"
        <*> v .:! "number"
        <*> v .:! "pull_request"
        <*> v .:! "push_id"
        <*> v .:! "pusher_type"
        <*> v .:! "ref"
        <*> v .:! "ref_type"
        <*> v .:! "size"

instance ToJSON Commit where
    toJSON (Commit authorCommit distinctCommit messageCommit shaCommit urlCommit) =
        object $ foldMap (maybe [] pure)
        [ Just $ "author" .= authorCommit
        , Just $ "distinct" .= distinctCommit
        , Just $ "message" .= messageCommit
        , Just $ "sha" .= shaCommit
        , Just $ "url" .= urlCommit
        ]

instance FromJSON Commit where
    parseJSON (Object v) = Commit
        <$> v .: "author"
        <*> v .: "distinct"
        <*> v .: "message"
        <*> v .: "sha"
        <*> v .: "url"

instance ToJSON Author where
    toJSON (Author emailAuthor nameAuthor) =
        object $ foldMap (maybe [] pure)
        [ Just $ "email" .= emailAuthor
        , Just $ "name" .= nameAuthor
        ]

instance FromJSON Author where
    parseJSON (Object v) = Author
        <$> v .: "email"
        <*> v .: "name"

instance ToJSON PullRequest where
    toJSON (PullRequest additionsPullRequest assigneePullRequest assigneesPullRequest basePullRequest bodyPullRequest changedFilesPullRequest closedAtPullRequest commentsPullRequest commentsURLPullRequest commitsPullRequest commitsURLPullRequest createdAtPullRequest deletionsPullRequest diffURLPullRequest headPullRequest htmlURLPullRequest issueURLPullRequest linksPullRequest lockedPullRequest maintainerCanModifyPullRequest mergeCommitSHAPullRequest mergeablePullRequest mergeableStatePullRequest mergedPullRequest mergedAtPullRequest mergedByPullRequest milestonePullRequest numberPullRequest patchURLPullRequest pullRequestIDPullRequest rebaseablePullRequest requestedReviewersPullRequest reviewCommentURLPullRequest reviewCommentsPullRequest reviewCommentsURLPullRequest statePullRequest statusesURLPullRequest titlePullRequest updatedAtPullRequest urlPullRequest userPullRequest) =
        object $ foldMap (maybe [] pure)
        [ Just $ "additions" .= additionsPullRequest
        , Just $ "assignee" .= assigneePullRequest
        , Just $ "assignees" .= assigneesPullRequest
        , Just $ "base" .= basePullRequest
        , Just $ "body" .= bodyPullRequest
        , Just $ "changed_files" .= changedFilesPullRequest
        , Just $ "closed_at" .= closedAtPullRequest
        , Just $ "comments" .= commentsPullRequest
        , Just $ "comments_url" .= commentsURLPullRequest
        , Just $ "commits" .= commitsPullRequest
        , Just $ "commits_url" .= commitsURLPullRequest
        , Just $ "created_at" .= createdAtPullRequest
        , Just $ "deletions" .= deletionsPullRequest
        , Just $ "diff_url" .= diffURLPullRequest
        , Just $ "head" .= headPullRequest
        , Just $ "html_url" .= htmlURLPullRequest
        , Just $ "issue_url" .= issueURLPullRequest
        , Just $ "_links" .= linksPullRequest
        , Just $ "locked" .= lockedPullRequest
        , Just $ "maintainer_can_modify" .= maintainerCanModifyPullRequest
        , Just $ "merge_commit_sha" .= mergeCommitSHAPullRequest
        , Just $ "mergeable" .= mergeablePullRequest
        , Just $ "mergeable_state" .= mergeableStatePullRequest
        , Just $ "merged" .= mergedPullRequest
        , Just $ "merged_at" .= mergedAtPullRequest
        , Just $ "merged_by" .= mergedByPullRequest
        , Just $ "milestone" .= milestonePullRequest
        , Just $ "number" .= numberPullRequest
        , Just $ "patch_url" .= patchURLPullRequest
        , Just $ "id" .= pullRequestIDPullRequest
        , Just $ "rebaseable" .= rebaseablePullRequest
        , Just $ "requested_reviewers" .= requestedReviewersPullRequest
        , Just $ "review_comment_url" .= reviewCommentURLPullRequest
        , Just $ "review_comments" .= reviewCommentsPullRequest
        , Just $ "review_comments_url" .= reviewCommentsURLPullRequest
        , Just $ "state" .= statePullRequest
        , Just $ "statuses_url" .= statusesURLPullRequest
        , Just $ "title" .= titlePullRequest
        , Just $ "updated_at" .= updatedAtPullRequest
        , Just $ "url" .= urlPullRequest
        , Just $ "user" .= userPullRequest
        ]

instance FromJSON PullRequest where
    parseJSON (Object v) = PullRequest
        <$> v .: "additions"
        <*> v .: "assignee"
        <*> v .: "assignees"
        <*> v .: "base"
        <*> v .: "body"
        <*> v .: "changed_files"
        <*> v .: "closed_at"
        <*> v .: "comments"
        <*> v .: "comments_url"
        <*> v .: "commits"
        <*> v .: "commits_url"
        <*> v .: "created_at"
        <*> v .: "deletions"
        <*> v .: "diff_url"
        <*> v .: "head"
        <*> v .: "html_url"
        <*> v .: "issue_url"
        <*> v .: "_links"
        <*> v .: "locked"
        <*> v .: "maintainer_can_modify"
        <*> v .: "merge_commit_sha"
        <*> v .: "mergeable"
        <*> v .: "mergeable_state"
        <*> v .: "merged"
        <*> v .: "merged_at"
        <*> v .: "merged_by"
        <*> v .: "milestone"
        <*> v .: "number"
        <*> v .: "patch_url"
        <*> v .: "id"
        <*> v .: "rebaseable"
        <*> v .: "requested_reviewers"
        <*> v .: "review_comment_url"
        <*> v .: "review_comments"
        <*> v .: "review_comments_url"
        <*> v .: "state"
        <*> v .: "statuses_url"
        <*> v .: "title"
        <*> v .: "updated_at"
        <*> v .: "url"
        <*> v .: "user"

instance ToJSON Base where
    toJSON (Base labelBase refBase repoBase shaBase userBase) =
        object $ foldMap (maybe [] pure)
        [ Just $ "label" .= labelBase
        , Just $ "ref" .= refBase
        , Just $ "repo" .= repoBase
        , Just $ "sha" .= shaBase
        , Just $ "user" .= userBase
        ]

instance FromJSON Base where
    parseJSON (Object v) = Base
        <$> v .: "label"
        <*> v .: "ref"
        <*> v .: "repo"
        <*> v .: "sha"
        <*> v .: "user"

instance ToJSON BaseRepo where
    toJSON (BaseRepo archiveURLBaseRepo assigneesURLBaseRepo blobsURLBaseRepo branchesURLBaseRepo cloneURLBaseRepo collaboratorsURLBaseRepo commentsURLBaseRepo commitsURLBaseRepo compareURLBaseRepo contentsURLBaseRepo contributorsURLBaseRepo createdAtBaseRepo defaultBranchBaseRepo deploymentsURLBaseRepo descriptionBaseRepo downloadsURLBaseRepo eventsURLBaseRepo forkBaseRepo forksBaseRepo forksCountBaseRepo forksURLBaseRepo fullNameBaseRepo gitCommitsURLBaseRepo gitRefsURLBaseRepo gitTagsURLBaseRepo gitURLBaseRepo hasDownloadsBaseRepo hasIssuesBaseRepo hasPagesBaseRepo hasProjectsBaseRepo hasWikiBaseRepo homepageBaseRepo hooksURLBaseRepo htmlURLBaseRepo issueCommentURLBaseRepo issueEventsURLBaseRepo issuesURLBaseRepo keysURLBaseRepo labelsURLBaseRepo languageBaseRepo languagesURLBaseRepo mergesURLBaseRepo milestonesURLBaseRepo mirrorURLBaseRepo nameBaseRepo notificationsURLBaseRepo openIssuesBaseRepo openIssuesCountBaseRepo ownerBaseRepo privateBaseRepo pullsURLBaseRepo pushedAtBaseRepo releasesURLBaseRepo repoIDBaseRepo sizeBaseRepo sshURLBaseRepo stargazersCountBaseRepo stargazersURLBaseRepo statusesURLBaseRepo subscribersURLBaseRepo subscriptionURLBaseRepo svnURLBaseRepo tagsURLBaseRepo teamsURLBaseRepo treesURLBaseRepo updatedAtBaseRepo urlBaseRepo watchersBaseRepo watchersCountBaseRepo) =
        object $ foldMap (maybe [] pure)
        [ Just $ "archive_url" .= archiveURLBaseRepo
        , Just $ "assignees_url" .= assigneesURLBaseRepo
        , Just $ "blobs_url" .= blobsURLBaseRepo
        , Just $ "branches_url" .= branchesURLBaseRepo
        , Just $ "clone_url" .= cloneURLBaseRepo
        , Just $ "collaborators_url" .= collaboratorsURLBaseRepo
        , Just $ "comments_url" .= commentsURLBaseRepo
        , Just $ "commits_url" .= commitsURLBaseRepo
        , Just $ "compare_url" .= compareURLBaseRepo
        , Just $ "contents_url" .= contentsURLBaseRepo
        , Just $ "contributors_url" .= contributorsURLBaseRepo
        , Just $ "created_at" .= createdAtBaseRepo
        , Just $ "default_branch" .= defaultBranchBaseRepo
        , Just $ "deployments_url" .= deploymentsURLBaseRepo
        , Just $ "description" .= descriptionBaseRepo
        , Just $ "downloads_url" .= downloadsURLBaseRepo
        , Just $ "events_url" .= eventsURLBaseRepo
        , Just $ "fork" .= forkBaseRepo
        , Just $ "forks" .= forksBaseRepo
        , Just $ "forks_count" .= forksCountBaseRepo
        , Just $ "forks_url" .= forksURLBaseRepo
        , Just $ "full_name" .= fullNameBaseRepo
        , Just $ "git_commits_url" .= gitCommitsURLBaseRepo
        , Just $ "git_refs_url" .= gitRefsURLBaseRepo
        , Just $ "git_tags_url" .= gitTagsURLBaseRepo
        , Just $ "git_url" .= gitURLBaseRepo
        , Just $ "has_downloads" .= hasDownloadsBaseRepo
        , Just $ "has_issues" .= hasIssuesBaseRepo
        , Just $ "has_pages" .= hasPagesBaseRepo
        , Just $ "has_projects" .= hasProjectsBaseRepo
        , Just $ "has_wiki" .= hasWikiBaseRepo
        , Just $ "homepage" .= homepageBaseRepo
        , Just $ "hooks_url" .= hooksURLBaseRepo
        , Just $ "html_url" .= htmlURLBaseRepo
        , Just $ "issue_comment_url" .= issueCommentURLBaseRepo
        , Just $ "issue_events_url" .= issueEventsURLBaseRepo
        , Just $ "issues_url" .= issuesURLBaseRepo
        , Just $ "keys_url" .= keysURLBaseRepo
        , Just $ "labels_url" .= labelsURLBaseRepo
        , Just $ "language" .= languageBaseRepo
        , Just $ "languages_url" .= languagesURLBaseRepo
        , Just $ "merges_url" .= mergesURLBaseRepo
        , Just $ "milestones_url" .= milestonesURLBaseRepo
        , Just $ "mirror_url" .= mirrorURLBaseRepo
        , Just $ "name" .= nameBaseRepo
        , Just $ "notifications_url" .= notificationsURLBaseRepo
        , Just $ "open_issues" .= openIssuesBaseRepo
        , Just $ "open_issues_count" .= openIssuesCountBaseRepo
        , Just $ "owner" .= ownerBaseRepo
        , Just $ "private" .= privateBaseRepo
        , Just $ "pulls_url" .= pullsURLBaseRepo
        , Just $ "pushed_at" .= pushedAtBaseRepo
        , Just $ "releases_url" .= releasesURLBaseRepo
        , Just $ "id" .= repoIDBaseRepo
        , Just $ "size" .= sizeBaseRepo
        , Just $ "ssh_url" .= sshURLBaseRepo
        , Just $ "stargazers_count" .= stargazersCountBaseRepo
        , Just $ "stargazers_url" .= stargazersURLBaseRepo
        , Just $ "statuses_url" .= statusesURLBaseRepo
        , Just $ "subscribers_url" .= subscribersURLBaseRepo
        , Just $ "subscription_url" .= subscriptionURLBaseRepo
        , Just $ "svn_url" .= svnURLBaseRepo
        , Just $ "tags_url" .= tagsURLBaseRepo
        , Just $ "teams_url" .= teamsURLBaseRepo
        , Just $ "trees_url" .= treesURLBaseRepo
        , Just $ "updated_at" .= updatedAtBaseRepo
        , Just $ "url" .= urlBaseRepo
        , Just $ "watchers" .= watchersBaseRepo
        , Just $ "watchers_count" .= watchersCountBaseRepo
        ]

instance FromJSON BaseRepo where
    parseJSON (Object v) = BaseRepo
        <$> v .: "archive_url"
        <*> v .: "assignees_url"
        <*> v .: "blobs_url"
        <*> v .: "branches_url"
        <*> v .: "clone_url"
        <*> v .: "collaborators_url"
        <*> v .: "comments_url"
        <*> v .: "commits_url"
        <*> v .: "compare_url"
        <*> v .: "contents_url"
        <*> v .: "contributors_url"
        <*> v .: "created_at"
        <*> v .: "default_branch"
        <*> v .: "deployments_url"
        <*> v .: "description"
        <*> v .: "downloads_url"
        <*> v .: "events_url"
        <*> v .: "fork"
        <*> v .: "forks"
        <*> v .: "forks_count"
        <*> v .: "forks_url"
        <*> v .: "full_name"
        <*> v .: "git_commits_url"
        <*> v .: "git_refs_url"
        <*> v .: "git_tags_url"
        <*> v .: "git_url"
        <*> v .: "has_downloads"
        <*> v .: "has_issues"
        <*> v .: "has_pages"
        <*> v .: "has_projects"
        <*> v .: "has_wiki"
        <*> v .: "homepage"
        <*> v .: "hooks_url"
        <*> v .: "html_url"
        <*> v .: "issue_comment_url"
        <*> v .: "issue_events_url"
        <*> v .: "issues_url"
        <*> v .: "keys_url"
        <*> v .: "labels_url"
        <*> v .: "language"
        <*> v .: "languages_url"
        <*> v .: "merges_url"
        <*> v .: "milestones_url"
        <*> v .: "mirror_url"
        <*> v .: "name"
        <*> v .: "notifications_url"
        <*> v .: "open_issues"
        <*> v .: "open_issues_count"
        <*> v .: "owner"
        <*> v .: "private"
        <*> v .: "pulls_url"
        <*> v .: "pushed_at"
        <*> v .: "releases_url"
        <*> v .: "id"
        <*> v .: "size"
        <*> v .: "ssh_url"
        <*> v .: "stargazers_count"
        <*> v .: "stargazers_url"
        <*> v .: "statuses_url"
        <*> v .: "subscribers_url"
        <*> v .: "subscription_url"
        <*> v .: "svn_url"
        <*> v .: "tags_url"
        <*> v .: "teams_url"
        <*> v .: "trees_url"
        <*> v .: "updated_at"
        <*> v .: "url"
        <*> v .: "watchers"
        <*> v .: "watchers_count"

instance ToJSON MergedBy where
    toJSON (MergedBy avatarURLMergedBy eventsURLMergedBy followersURLMergedBy followingURLMergedBy gistsURLMergedBy gravatarIDMergedBy htmlURLMergedBy loginMergedBy mergedByIDMergedBy mergedByTypeMergedBy organizationsURLMergedBy receivedEventsURLMergedBy reposURLMergedBy siteAdminMergedBy starredURLMergedBy subscriptionsURLMergedBy urlMergedBy) =
        object $ foldMap (maybe [] pure)
        [ Just $ "avatar_url" .= avatarURLMergedBy
        , Just $ "events_url" .= eventsURLMergedBy
        , Just $ "followers_url" .= followersURLMergedBy
        , Just $ "following_url" .= followingURLMergedBy
        , Just $ "gists_url" .= gistsURLMergedBy
        , Just $ "gravatar_id" .= gravatarIDMergedBy
        , Just $ "html_url" .= htmlURLMergedBy
        , Just $ "login" .= loginMergedBy
        , Just $ "id" .= mergedByIDMergedBy
        , Just $ "type" .= mergedByTypeMergedBy
        , Just $ "organizations_url" .= organizationsURLMergedBy
        , Just $ "received_events_url" .= receivedEventsURLMergedBy
        , Just $ "repos_url" .= reposURLMergedBy
        , Just $ "site_admin" .= siteAdminMergedBy
        , Just $ "starred_url" .= starredURLMergedBy
        , Just $ "subscriptions_url" .= subscriptionsURLMergedBy
        , Just $ "url" .= urlMergedBy
        ]

instance FromJSON MergedBy where
    parseJSON (Object v) = MergedBy
        <$> v .: "avatar_url"
        <*> v .: "events_url"
        <*> v .: "followers_url"
        <*> v .: "following_url"
        <*> v .: "gists_url"
        <*> v .: "gravatar_id"
        <*> v .: "html_url"
        <*> v .: "login"
        <*> v .: "id"
        <*> v .: "type"
        <*> v .: "organizations_url"
        <*> v .: "received_events_url"
        <*> v .: "repos_url"
        <*> v .: "site_admin"
        <*> v .: "starred_url"
        <*> v .: "subscriptions_url"
        <*> v .: "url"

instance ToJSON Links where
    toJSON (Links commentsLinks commitsLinks htmlLinks issueLinks reviewCommentLinks reviewCommentsLinks selfLinks statusesLinks) =
        object $ foldMap (maybe [] pure)
        [ Just $ "comments" .= commentsLinks
        , Just $ "commits" .= commitsLinks
        , Just $ "html" .= htmlLinks
        , Just $ "issue" .= issueLinks
        , Just $ "review_comment" .= reviewCommentLinks
        , Just $ "review_comments" .= reviewCommentsLinks
        , Just $ "self" .= selfLinks
        , Just $ "statuses" .= statusesLinks
        ]

instance FromJSON Links where
    parseJSON (Object v) = Links
        <$> v .: "comments"
        <*> v .: "commits"
        <*> v .: "html"
        <*> v .: "issue"
        <*> v .: "review_comment"
        <*> v .: "review_comments"
        <*> v .: "self"
        <*> v .: "statuses"

instance ToJSON Comments where
    toJSON (Comments hrefComments) =
        object $ foldMap (maybe [] pure)
        [ Just $ "href" .= hrefComments
        ]

instance FromJSON Comments where
    parseJSON (Object v) = Comments
        <$> v .: "href"

instance ToJSON Type where
    toJSON PushEventType = "PushEvent"
    toJSON CreateEventType = "CreateEvent"
    toJSON WatchEventType = "WatchEvent"
    toJSON PullRequestEventType = "PullRequestEvent"
    toJSON DeleteEventType = "DeleteEvent"

instance FromJSON Type where
    parseJSON = withText "Type" parseText
        where
            parseText "PushEvent" = return PushEventType
            parseText "CreateEvent" = return CreateEventType
            parseText "WatchEvent" = return WatchEventType
            parseText "PullRequestEvent" = return PullRequestEventType
            parseText "DeleteEvent" = return DeleteEventType

instance ToJSON QuickTypeRepo where
    toJSON (QuickTypeRepo nameQuickTypeRepo repoIDQuickTypeRepo urlQuickTypeRepo) =
        object $ foldMap (maybe [] pure)
        [ Just $ "name" .= nameQuickTypeRepo
        , Just $ "id" .= repoIDQuickTypeRepo
        , Just $ "url" .= urlQuickTypeRepo
        ]

instance FromJSON QuickTypeRepo where
    parseJSON (Object v) = QuickTypeRepo
        <$> v .: "name"
        <*> v .: "id"
        <*> v .: "url"
