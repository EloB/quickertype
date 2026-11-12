// Code generated from JSON Schema using quicktype. DO NOT EDIT.
// To parse and unparse this JSON data, add this code to your project and do:
//
//    topLevel, err := UnmarshalTopLevel(bytes)
//    bytes, err = topLevel.Marshal()

package main

import "time"

import "encoding/json"

type TopLevel []TopLevelElement

func UnmarshalTopLevel(data []byte) (TopLevel, error) {
	var r TopLevel
	err := json.Unmarshal(data, &r)
	return r, err
}

func (r *TopLevel) Marshal() ([]byte, error) {
	return json.Marshal(r)
}

type TopLevelElement struct {
	Actor     Actor        `json:"actor"`
	CreatedAt time.Time    `json:"created_at"`
	ID        string       `json:"id"`
	Org       *Actor       `json:"org,omitempty"`
	Payload   Payload      `json:"payload"`
	Public    bool         `json:"public"`
	Repo      TopLevelRepo `json:"repo"`
	Type      Type         `json:"type"`
}

type Actor struct {
	AvatarURL    string  `json:"avatar_url"`
	DisplayLogin *string `json:"display_login,omitempty"`
	GravatarID   string  `json:"gravatar_id"`
	ID           int64   `json:"id"`
	Login        string  `json:"login"`
	URL          string  `json:"url"`
}

type Payload struct {
	Action       *string      `json:"action,omitempty"`
	Before       *string      `json:"before,omitempty"`
	Commits      *[]Commit    `json:"commits,omitempty"`
	Description  *string      `json:"description"`
	DistinctSize *int64       `json:"distinct_size,omitempty"`
	Head         *string      `json:"head,omitempty"`
	MasterBranch *string      `json:"master_branch,omitempty"`
	Number       *int64       `json:"number,omitempty"`
	PullRequest  *PullRequest `json:"pull_request,omitempty"`
	PushID       *int64       `json:"push_id,omitempty"`
	PusherType   *string      `json:"pusher_type,omitempty"`
	Ref          *string      `json:"ref,omitempty"`
	RefType      *string      `json:"ref_type,omitempty"`
	Size         *int64       `json:"size,omitempty"`
}

type Commit struct {
	Author   Author `json:"author"`
	Distinct bool   `json:"distinct"`
	Message  string `json:"message"`
	SHA      string `json:"sha"`
	URL      string `json:"url"`
}

type Author struct {
	Email string `json:"email"`
	Name  string `json:"name"`
}

type PullRequest struct {
	Additions           int64         `json:"additions"`
	Assignee            interface{}   `json:"assignee"`
	Assignees           []interface{} `json:"assignees"`
	Base                Base          `json:"base"`
	Body                string        `json:"body"`
	ChangedFiles        int64         `json:"changed_files"`
	ClosedAt            time.Time     `json:"closed_at"`
	Comments            int64         `json:"comments"`
	CommentsURL         string        `json:"comments_url"`
	Commits             int64         `json:"commits"`
	CommitsURL          string        `json:"commits_url"`
	CreatedAt           time.Time     `json:"created_at"`
	Deletions           int64         `json:"deletions"`
	DiffURL             string        `json:"diff_url"`
	HTMLURL             string        `json:"html_url"`
	Head                Base          `json:"head"`
	ID                  int64         `json:"id"`
	IssueURL            string        `json:"issue_url"`
	Links               Links         `json:"_links"`
	Locked              bool          `json:"locked"`
	MaintainerCanModify bool          `json:"maintainer_can_modify"`
	MergeCommitSHA      string        `json:"merge_commit_sha"`
	Mergeable           interface{}   `json:"mergeable"`
	MergeableState      string        `json:"mergeable_state"`
	Merged              bool          `json:"merged"`
	MergedAt            time.Time     `json:"merged_at"`
	MergedBy            MergedBy      `json:"merged_by"`
	Milestone           interface{}   `json:"milestone"`
	Number              int64         `json:"number"`
	PatchURL            string        `json:"patch_url"`
	Rebaseable          interface{}   `json:"rebaseable"`
	RequestedReviewers  []interface{} `json:"requested_reviewers"`
	ReviewCommentURL    string        `json:"review_comment_url"`
	ReviewComments      int64         `json:"review_comments"`
	ReviewCommentsURL   string        `json:"review_comments_url"`
	State               string        `json:"state"`
	StatusesURL         string        `json:"statuses_url"`
	Title               string        `json:"title"`
	URL                 string        `json:"url"`
	UpdatedAt           time.Time     `json:"updated_at"`
	User                MergedBy      `json:"user"`
}

type Base struct {
	Label string   `json:"label"`
	Ref   string   `json:"ref"`
	Repo  BaseRepo `json:"repo"`
	SHA   string   `json:"sha"`
	User  MergedBy `json:"user"`
}

type BaseRepo struct {
	ArchiveURL       string      `json:"archive_url"`
	AssigneesURL     string      `json:"assignees_url"`
	BlobsURL         string      `json:"blobs_url"`
	BranchesURL      string      `json:"branches_url"`
	CloneURL         string      `json:"clone_url"`
	CollaboratorsURL string      `json:"collaborators_url"`
	CommentsURL      string      `json:"comments_url"`
	CommitsURL       string      `json:"commits_url"`
	CompareURL       string      `json:"compare_url"`
	ContentsURL      string      `json:"contents_url"`
	ContributorsURL  string      `json:"contributors_url"`
	CreatedAt        time.Time   `json:"created_at"`
	DefaultBranch    string      `json:"default_branch"`
	DeploymentsURL   string      `json:"deployments_url"`
	Description      interface{} `json:"description"`
	DownloadsURL     string      `json:"downloads_url"`
	EventsURL        string      `json:"events_url"`
	Fork             bool        `json:"fork"`
	Forks            int64       `json:"forks"`
	ForksCount       int64       `json:"forks_count"`
	ForksURL         string      `json:"forks_url"`
	FullName         string      `json:"full_name"`
	GitCommitsURL    string      `json:"git_commits_url"`
	GitRefsURL       string      `json:"git_refs_url"`
	GitTagsURL       string      `json:"git_tags_url"`
	GitURL           string      `json:"git_url"`
	HTMLURL          string      `json:"html_url"`
	HasDownloads     bool        `json:"has_downloads"`
	HasIssues        bool        `json:"has_issues"`
	HasPages         bool        `json:"has_pages"`
	HasProjects      bool        `json:"has_projects"`
	HasWiki          bool        `json:"has_wiki"`
	Homepage         interface{} `json:"homepage"`
	HooksURL         string      `json:"hooks_url"`
	ID               int64       `json:"id"`
	IssueCommentURL  string      `json:"issue_comment_url"`
	IssueEventsURL   string      `json:"issue_events_url"`
	IssuesURL        string      `json:"issues_url"`
	KeysURL          string      `json:"keys_url"`
	LabelsURL        string      `json:"labels_url"`
	Language         string      `json:"language"`
	LanguagesURL     string      `json:"languages_url"`
	MergesURL        string      `json:"merges_url"`
	MilestonesURL    string      `json:"milestones_url"`
	MirrorURL        interface{} `json:"mirror_url"`
	Name             string      `json:"name"`
	NotificationsURL string      `json:"notifications_url"`
	OpenIssues       int64       `json:"open_issues"`
	OpenIssuesCount  int64       `json:"open_issues_count"`
	Owner            MergedBy    `json:"owner"`
	Private          bool        `json:"private"`
	PullsURL         string      `json:"pulls_url"`
	PushedAt         time.Time   `json:"pushed_at"`
	ReleasesURL      string      `json:"releases_url"`
	SSHURL           string      `json:"ssh_url"`
	Size             int64       `json:"size"`
	StargazersCount  int64       `json:"stargazers_count"`
	StargazersURL    string      `json:"stargazers_url"`
	StatusesURL      string      `json:"statuses_url"`
	SubscribersURL   string      `json:"subscribers_url"`
	SubscriptionURL  string      `json:"subscription_url"`
	SvnURL           string      `json:"svn_url"`
	TagsURL          string      `json:"tags_url"`
	TeamsURL         string      `json:"teams_url"`
	TreesURL         string      `json:"trees_url"`
	URL              string      `json:"url"`
	UpdatedAt        time.Time   `json:"updated_at"`
	Watchers         int64       `json:"watchers"`
	WatchersCount    int64       `json:"watchers_count"`
}

type MergedBy struct {
	AvatarURL         string `json:"avatar_url"`
	EventsURL         string `json:"events_url"`
	FollowersURL      string `json:"followers_url"`
	FollowingURL      string `json:"following_url"`
	GistsURL          string `json:"gists_url"`
	GravatarID        string `json:"gravatar_id"`
	HTMLURL           string `json:"html_url"`
	ID                int64  `json:"id"`
	Login             string `json:"login"`
	OrganizationsURL  string `json:"organizations_url"`
	ReceivedEventsURL string `json:"received_events_url"`
	ReposURL          string `json:"repos_url"`
	SiteAdmin         bool   `json:"site_admin"`
	StarredURL        string `json:"starred_url"`
	SubscriptionsURL  string `json:"subscriptions_url"`
	Type              string `json:"type"`
	URL               string `json:"url"`
}

type Links struct {
	Comments       Comments `json:"comments"`
	Commits        Comments `json:"commits"`
	HTML           Comments `json:"html"`
	Issue          Comments `json:"issue"`
	ReviewComment  Comments `json:"review_comment"`
	ReviewComments Comments `json:"review_comments"`
	Self           Comments `json:"self"`
	Statuses       Comments `json:"statuses"`
}

type Comments struct {
	Href string `json:"href"`
}

type TopLevelRepo struct {
	ID   int64  `json:"id"`
	Name string `json:"name"`
	URL  string `json:"url"`
}

type Type string

const (
	PushEvent        Type = "PushEvent"
	CreateEvent      Type = "CreateEvent"
	WatchEvent       Type = "WatchEvent"
	PullRequestEvent Type = "PullRequestEvent"
	DeleteEvent      Type = "DeleteEvent"
)

type invalidType string
func (x invalidType) Error() string { return "invalid Type: " + string(x) }

func (x *Type) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Type(value) {
	case PushEvent, CreateEvent, WatchEvent, PullRequestEvent, DeleteEvent: *x = Type(value); return nil
	}
	return invalidType(value)
}
