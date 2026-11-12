{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , QuickTypeElement (..)
    , Actor (..)
    , Payload (..)
    , Comment (..)
    , User (..)
    , Commit (..)
    , Author (..)
    , Issue (..)
    , Label (..)
    , Milestone (..)
    , IssuePullRequest (..)
    , PayloadPullRequest (..)
    , Base (..)
    , BaseRepo (..)
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
    , quickTypeTypeQuickTypeElement :: Text
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
    , commentPayload :: Maybe Comment
    , commitsPayload :: Maybe ([Commit])
    , descriptionPayload :: Maybe Text
    , distinctSizePayload :: Maybe Int
    , headPayload :: Maybe Text
    , issuePayload :: Maybe Issue
    , masterBranchPayload :: Maybe Text
    , numberPayload :: Maybe Int
    , pullRequestPayload :: Maybe PayloadPullRequest
    , pushIDPayload :: Maybe Int
    , pusherTypePayload :: Maybe Text
    , refPayload :: Maybe Text
    , refTypePayload :: Maybe Text
    , sizePayload :: Maybe Int
    } deriving (Show)

data Comment = Comment
    { bodyComment :: Text
    , commentIDComment :: Int
    , createdAtComment :: Text
    , htmlURLComment :: Text
    , issueURLComment :: Text
    , updatedAtComment :: Text
    , urlComment :: Text
    , userComment :: User
    } deriving (Show)

data User = User
    { avatarURLUser :: Text
    , eventsURLUser :: Text
    , followersURLUser :: Text
    , followingURLUser :: Text
    , gistsURLUser :: Text
    , gravatarIDUser :: Text
    , htmlURLUser :: Text
    , loginUser :: Text
    , organizationsURLUser :: Text
    , receivedEventsURLUser :: Text
    , reposURLUser :: Text
    , siteAdminUser :: Bool
    , starredURLUser :: Text
    , subscriptionsURLUser :: Text
    , urlUser :: Text
    , userIDUser :: Int
    , userTypeUser :: Type
    } deriving (Show)

data Type
    = UserType
    | OrganizationType
    deriving (Show)

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

data Issue = Issue
    { assigneeIssue :: Maybe Text
    , assigneesIssue :: [Value]
    , bodyIssue :: Text
    , closedAtIssue :: Maybe Text
    , commentsIssue :: Int
    , commentsURLIssue :: Text
    , createdAtIssue :: Text
    , eventsURLIssue :: Text
    , htmlURLIssue :: Text
    , issueIDIssue :: Int
    , labelsIssue :: [Label]
    , labelsURLIssue :: Text
    , lockedIssue :: Bool
    , milestoneIssue :: Maybe Milestone
    , numberIssue :: Int
    , pullRequestIssue :: Maybe IssuePullRequest
    , repositoryURLIssue :: Text
    , stateIssue :: Text
    , titleIssue :: Text
    , updatedAtIssue :: Text
    , urlIssue :: Text
    , userIssue :: User
    } deriving (Show)

data Label = Label
    { colorLabel :: Text
    , labelDefaultLabel :: Bool
    , labelIDLabel :: Int
    , nameLabel :: Text
    , urlLabel :: Text
    } deriving (Show)

data Milestone = Milestone
    { closedAtMilestone :: Maybe Text
    , closedIssuesMilestone :: Int
    , createdAtMilestone :: Text
    , creatorMilestone :: User
    , descriptionMilestone :: Text
    , dueOnMilestone :: Maybe Text
    , htmlURLMilestone :: Text
    , labelsURLMilestone :: Text
    , milestoneIDMilestone :: Int
    , numberMilestone :: Int
    , openIssuesMilestone :: Int
    , stateMilestone :: Text
    , titleMilestone :: Text
    , updatedAtMilestone :: Text
    , urlMilestone :: Text
    } deriving (Show)

data IssuePullRequest = IssuePullRequest
    { diffURLIssuePullRequest :: Text
    , htmlURLIssuePullRequest :: Text
    , patchURLIssuePullRequest :: Text
    , urlIssuePullRequest :: Text
    } deriving (Show)

data PayloadPullRequest = PayloadPullRequest
    { additionsPayloadPullRequest :: Int
    , assigneePayloadPullRequest :: Maybe Text
    , assigneesPayloadPullRequest :: [Value]
    , basePayloadPullRequest :: Base
    , bodyPayloadPullRequest :: Text
    , changedFilesPayloadPullRequest :: Int
    , closedAtPayloadPullRequest :: Text
    , commentsPayloadPullRequest :: Int
    , commentsURLPayloadPullRequest :: Text
    , commitsPayloadPullRequest :: Int
    , commitsURLPayloadPullRequest :: Text
    , createdAtPayloadPullRequest :: Text
    , deletionsPayloadPullRequest :: Int
    , diffURLPayloadPullRequest :: Text
    , headPayloadPullRequest :: Base
    , htmlURLPayloadPullRequest :: Text
    , issueURLPayloadPullRequest :: Text
    , linksPayloadPullRequest :: Links
    , lockedPayloadPullRequest :: Bool
    , maintainerCanModifyPayloadPullRequest :: Bool
    , mergeCommitSHAPayloadPullRequest :: Text
    , mergeablePayloadPullRequest :: Maybe Text
    , mergeableStatePayloadPullRequest :: Text
    , mergedPayloadPullRequest :: Bool
    , mergedAtPayloadPullRequest :: Text
    , mergedByPayloadPullRequest :: User
    , milestonePayloadPullRequest :: Maybe Text
    , numberPayloadPullRequest :: Int
    , patchURLPayloadPullRequest :: Text
    , pullRequestIDPayloadPullRequest :: Int
    , rebaseablePayloadPullRequest :: Maybe Text
    , requestedReviewersPayloadPullRequest :: [Value]
    , reviewCommentURLPayloadPullRequest :: Text
    , reviewCommentsPayloadPullRequest :: Int
    , reviewCommentsURLPayloadPullRequest :: Text
    , statePayloadPullRequest :: Text
    , statusesURLPayloadPullRequest :: Text
    , titlePayloadPullRequest :: Text
    , updatedAtPayloadPullRequest :: Text
    , urlPayloadPullRequest :: Text
    , userPayloadPullRequest :: User
    } deriving (Show)

data Base = Base
    { labelBase :: Text
    , refBase :: Text
    , repoBase :: BaseRepo
    , shaBase :: Text
    , userBase :: User
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
    , descriptionBaseRepo :: Text
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
    , homepageBaseRepo :: Text
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
    , ownerBaseRepo :: User
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
    toJSON (Payload actionPayload beforePayload commentPayload commitsPayload descriptionPayload distinctSizePayload headPayload issuePayload masterBranchPayload numberPayload pullRequestPayload pushIDPayload pusherTypePayload refPayload refTypePayload sizePayload) =
        object $ foldMap (maybe [] pure)
        [ ("action" .=) <$> actionPayload
        , ("before" .=) <$> beforePayload
        , ("comment" .=) <$> commentPayload
        , ("commits" .=) <$> commitsPayload
        , ("description" .=) <$> descriptionPayload
        , ("distinct_size" .=) <$> distinctSizePayload
        , ("head" .=) <$> headPayload
        , ("issue" .=) <$> issuePayload
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
        <*> v .:! "comment"
        <*> v .:! "commits"
        <*> v .:! "description"
        <*> v .:! "distinct_size"
        <*> v .:! "head"
        <*> v .:! "issue"
        <*> v .:! "master_branch"
        <*> v .:! "number"
        <*> v .:! "pull_request"
        <*> v .:! "push_id"
        <*> v .:! "pusher_type"
        <*> v .:! "ref"
        <*> v .:! "ref_type"
        <*> v .:! "size"

instance ToJSON Comment where
    toJSON (Comment bodyComment commentIDComment createdAtComment htmlURLComment issueURLComment updatedAtComment urlComment userComment) =
        object $ foldMap (maybe [] pure)
        [ Just $ "body" .= bodyComment
        , Just $ "id" .= commentIDComment
        , Just $ "created_at" .= createdAtComment
        , Just $ "html_url" .= htmlURLComment
        , Just $ "issue_url" .= issueURLComment
        , Just $ "updated_at" .= updatedAtComment
        , Just $ "url" .= urlComment
        , Just $ "user" .= userComment
        ]

instance FromJSON Comment where
    parseJSON (Object v) = Comment
        <$> v .: "body"
        <*> v .: "id"
        <*> v .: "created_at"
        <*> v .: "html_url"
        <*> v .: "issue_url"
        <*> v .: "updated_at"
        <*> v .: "url"
        <*> v .: "user"

instance ToJSON User where
    toJSON (User avatarURLUser eventsURLUser followersURLUser followingURLUser gistsURLUser gravatarIDUser htmlURLUser loginUser organizationsURLUser receivedEventsURLUser reposURLUser siteAdminUser starredURLUser subscriptionsURLUser urlUser userIDUser userTypeUser) =
        object $ foldMap (maybe [] pure)
        [ Just $ "avatar_url" .= avatarURLUser
        , Just $ "events_url" .= eventsURLUser
        , Just $ "followers_url" .= followersURLUser
        , Just $ "following_url" .= followingURLUser
        , Just $ "gists_url" .= gistsURLUser
        , Just $ "gravatar_id" .= gravatarIDUser
        , Just $ "html_url" .= htmlURLUser
        , Just $ "login" .= loginUser
        , Just $ "organizations_url" .= organizationsURLUser
        , Just $ "received_events_url" .= receivedEventsURLUser
        , Just $ "repos_url" .= reposURLUser
        , Just $ "site_admin" .= siteAdminUser
        , Just $ "starred_url" .= starredURLUser
        , Just $ "subscriptions_url" .= subscriptionsURLUser
        , Just $ "url" .= urlUser
        , Just $ "id" .= userIDUser
        , Just $ "type" .= userTypeUser
        ]

instance FromJSON User where
    parseJSON (Object v) = User
        <$> v .: "avatar_url"
        <*> v .: "events_url"
        <*> v .: "followers_url"
        <*> v .: "following_url"
        <*> v .: "gists_url"
        <*> v .: "gravatar_id"
        <*> v .: "html_url"
        <*> v .: "login"
        <*> v .: "organizations_url"
        <*> v .: "received_events_url"
        <*> v .: "repos_url"
        <*> v .: "site_admin"
        <*> v .: "starred_url"
        <*> v .: "subscriptions_url"
        <*> v .: "url"
        <*> v .: "id"
        <*> v .: "type"

instance ToJSON Type where
    toJSON UserType = "User"
    toJSON OrganizationType = "Organization"

instance FromJSON Type where
    parseJSON = withText "Type" parseText
        where
            parseText "User" = return UserType
            parseText "Organization" = return OrganizationType

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

instance ToJSON Issue where
    toJSON (Issue assigneeIssue assigneesIssue bodyIssue closedAtIssue commentsIssue commentsURLIssue createdAtIssue eventsURLIssue htmlURLIssue issueIDIssue labelsIssue labelsURLIssue lockedIssue milestoneIssue numberIssue pullRequestIssue repositoryURLIssue stateIssue titleIssue updatedAtIssue urlIssue userIssue) =
        object $ foldMap (maybe [] pure)
        [ Just $ "assignee" .= assigneeIssue
        , Just $ "assignees" .= assigneesIssue
        , Just $ "body" .= bodyIssue
        , Just $ "closed_at" .= closedAtIssue
        , Just $ "comments" .= commentsIssue
        , Just $ "comments_url" .= commentsURLIssue
        , Just $ "created_at" .= createdAtIssue
        , Just $ "events_url" .= eventsURLIssue
        , Just $ "html_url" .= htmlURLIssue
        , Just $ "id" .= issueIDIssue
        , Just $ "labels" .= labelsIssue
        , Just $ "labels_url" .= labelsURLIssue
        , Just $ "locked" .= lockedIssue
        , Just $ "milestone" .= milestoneIssue
        , Just $ "number" .= numberIssue
        , ("pull_request" .=) <$> pullRequestIssue
        , Just $ "repository_url" .= repositoryURLIssue
        , Just $ "state" .= stateIssue
        , Just $ "title" .= titleIssue
        , Just $ "updated_at" .= updatedAtIssue
        , Just $ "url" .= urlIssue
        , Just $ "user" .= userIssue
        ]

instance FromJSON Issue where
    parseJSON (Object v) = Issue
        <$> v .: "assignee"
        <*> v .: "assignees"
        <*> v .: "body"
        <*> v .: "closed_at"
        <*> v .: "comments"
        <*> v .: "comments_url"
        <*> v .: "created_at"
        <*> v .: "events_url"
        <*> v .: "html_url"
        <*> v .: "id"
        <*> v .: "labels"
        <*> v .: "labels_url"
        <*> v .: "locked"
        <*> v .: "milestone"
        <*> v .: "number"
        <*> v .:! "pull_request"
        <*> v .: "repository_url"
        <*> v .: "state"
        <*> v .: "title"
        <*> v .: "updated_at"
        <*> v .: "url"
        <*> v .: "user"

instance ToJSON Label where
    toJSON (Label colorLabel labelDefaultLabel labelIDLabel nameLabel urlLabel) =
        object $ foldMap (maybe [] pure)
        [ Just $ "color" .= colorLabel
        , Just $ "default" .= labelDefaultLabel
        , Just $ "id" .= labelIDLabel
        , Just $ "name" .= nameLabel
        , Just $ "url" .= urlLabel
        ]

instance FromJSON Label where
    parseJSON (Object v) = Label
        <$> v .: "color"
        <*> v .: "default"
        <*> v .: "id"
        <*> v .: "name"
        <*> v .: "url"

instance ToJSON Milestone where
    toJSON (Milestone closedAtMilestone closedIssuesMilestone createdAtMilestone creatorMilestone descriptionMilestone dueOnMilestone htmlURLMilestone labelsURLMilestone milestoneIDMilestone numberMilestone openIssuesMilestone stateMilestone titleMilestone updatedAtMilestone urlMilestone) =
        object $ foldMap (maybe [] pure)
        [ Just $ "closed_at" .= closedAtMilestone
        , Just $ "closed_issues" .= closedIssuesMilestone
        , Just $ "created_at" .= createdAtMilestone
        , Just $ "creator" .= creatorMilestone
        , Just $ "description" .= descriptionMilestone
        , Just $ "due_on" .= dueOnMilestone
        , Just $ "html_url" .= htmlURLMilestone
        , Just $ "labels_url" .= labelsURLMilestone
        , Just $ "id" .= milestoneIDMilestone
        , Just $ "number" .= numberMilestone
        , Just $ "open_issues" .= openIssuesMilestone
        , Just $ "state" .= stateMilestone
        , Just $ "title" .= titleMilestone
        , Just $ "updated_at" .= updatedAtMilestone
        , Just $ "url" .= urlMilestone
        ]

instance FromJSON Milestone where
    parseJSON (Object v) = Milestone
        <$> v .: "closed_at"
        <*> v .: "closed_issues"
        <*> v .: "created_at"
        <*> v .: "creator"
        <*> v .: "description"
        <*> v .: "due_on"
        <*> v .: "html_url"
        <*> v .: "labels_url"
        <*> v .: "id"
        <*> v .: "number"
        <*> v .: "open_issues"
        <*> v .: "state"
        <*> v .: "title"
        <*> v .: "updated_at"
        <*> v .: "url"

instance ToJSON IssuePullRequest where
    toJSON (IssuePullRequest diffURLIssuePullRequest htmlURLIssuePullRequest patchURLIssuePullRequest urlIssuePullRequest) =
        object $ foldMap (maybe [] pure)
        [ Just $ "diff_url" .= diffURLIssuePullRequest
        , Just $ "html_url" .= htmlURLIssuePullRequest
        , Just $ "patch_url" .= patchURLIssuePullRequest
        , Just $ "url" .= urlIssuePullRequest
        ]

instance FromJSON IssuePullRequest where
    parseJSON (Object v) = IssuePullRequest
        <$> v .: "diff_url"
        <*> v .: "html_url"
        <*> v .: "patch_url"
        <*> v .: "url"

instance ToJSON PayloadPullRequest where
    toJSON (PayloadPullRequest additionsPayloadPullRequest assigneePayloadPullRequest assigneesPayloadPullRequest basePayloadPullRequest bodyPayloadPullRequest changedFilesPayloadPullRequest closedAtPayloadPullRequest commentsPayloadPullRequest commentsURLPayloadPullRequest commitsPayloadPullRequest commitsURLPayloadPullRequest createdAtPayloadPullRequest deletionsPayloadPullRequest diffURLPayloadPullRequest headPayloadPullRequest htmlURLPayloadPullRequest issueURLPayloadPullRequest linksPayloadPullRequest lockedPayloadPullRequest maintainerCanModifyPayloadPullRequest mergeCommitSHAPayloadPullRequest mergeablePayloadPullRequest mergeableStatePayloadPullRequest mergedPayloadPullRequest mergedAtPayloadPullRequest mergedByPayloadPullRequest milestonePayloadPullRequest numberPayloadPullRequest patchURLPayloadPullRequest pullRequestIDPayloadPullRequest rebaseablePayloadPullRequest requestedReviewersPayloadPullRequest reviewCommentURLPayloadPullRequest reviewCommentsPayloadPullRequest reviewCommentsURLPayloadPullRequest statePayloadPullRequest statusesURLPayloadPullRequest titlePayloadPullRequest updatedAtPayloadPullRequest urlPayloadPullRequest userPayloadPullRequest) =
        object $ foldMap (maybe [] pure)
        [ Just $ "additions" .= additionsPayloadPullRequest
        , Just $ "assignee" .= assigneePayloadPullRequest
        , Just $ "assignees" .= assigneesPayloadPullRequest
        , Just $ "base" .= basePayloadPullRequest
        , Just $ "body" .= bodyPayloadPullRequest
        , Just $ "changed_files" .= changedFilesPayloadPullRequest
        , Just $ "closed_at" .= closedAtPayloadPullRequest
        , Just $ "comments" .= commentsPayloadPullRequest
        , Just $ "comments_url" .= commentsURLPayloadPullRequest
        , Just $ "commits" .= commitsPayloadPullRequest
        , Just $ "commits_url" .= commitsURLPayloadPullRequest
        , Just $ "created_at" .= createdAtPayloadPullRequest
        , Just $ "deletions" .= deletionsPayloadPullRequest
        , Just $ "diff_url" .= diffURLPayloadPullRequest
        , Just $ "head" .= headPayloadPullRequest
        , Just $ "html_url" .= htmlURLPayloadPullRequest
        , Just $ "issue_url" .= issueURLPayloadPullRequest
        , Just $ "_links" .= linksPayloadPullRequest
        , Just $ "locked" .= lockedPayloadPullRequest
        , Just $ "maintainer_can_modify" .= maintainerCanModifyPayloadPullRequest
        , Just $ "merge_commit_sha" .= mergeCommitSHAPayloadPullRequest
        , Just $ "mergeable" .= mergeablePayloadPullRequest
        , Just $ "mergeable_state" .= mergeableStatePayloadPullRequest
        , Just $ "merged" .= mergedPayloadPullRequest
        , Just $ "merged_at" .= mergedAtPayloadPullRequest
        , Just $ "merged_by" .= mergedByPayloadPullRequest
        , Just $ "milestone" .= milestonePayloadPullRequest
        , Just $ "number" .= numberPayloadPullRequest
        , Just $ "patch_url" .= patchURLPayloadPullRequest
        , Just $ "id" .= pullRequestIDPayloadPullRequest
        , Just $ "rebaseable" .= rebaseablePayloadPullRequest
        , Just $ "requested_reviewers" .= requestedReviewersPayloadPullRequest
        , Just $ "review_comment_url" .= reviewCommentURLPayloadPullRequest
        , Just $ "review_comments" .= reviewCommentsPayloadPullRequest
        , Just $ "review_comments_url" .= reviewCommentsURLPayloadPullRequest
        , Just $ "state" .= statePayloadPullRequest
        , Just $ "statuses_url" .= statusesURLPayloadPullRequest
        , Just $ "title" .= titlePayloadPullRequest
        , Just $ "updated_at" .= updatedAtPayloadPullRequest
        , Just $ "url" .= urlPayloadPullRequest
        , Just $ "user" .= userPayloadPullRequest
        ]

instance FromJSON PayloadPullRequest where
    parseJSON (Object v) = PayloadPullRequest
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
