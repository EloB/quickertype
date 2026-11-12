package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class TopLevelChild {
    private List<PurpleChild> children;
    private IndecentComment comment;
    private PurpleFlags flags;
    private List<Group> groups;
    private long id;
    private long kind;
    private TentacledKindString kindString;
    private String name;
    private String originalName;
    private List<Source> sources;

    @JsonProperty("children")
    public List<PurpleChild> getChildren() { return children; }
    @JsonProperty("children")
    public void setChildren(List<PurpleChild> value) { this.children = value; }

    @JsonProperty("comment")
    public IndecentComment getComment() { return comment; }
    @JsonProperty("comment")
    public void setComment(IndecentComment value) { this.comment = value; }

    @JsonProperty("flags")
    public PurpleFlags getFlags() { return flags; }
    @JsonProperty("flags")
    public void setFlags(PurpleFlags value) { this.flags = value; }

    @JsonProperty("groups")
    public List<Group> getGroups() { return groups; }
    @JsonProperty("groups")
    public void setGroups(List<Group> value) { this.groups = value; }

    @JsonProperty("id")
    public long getID() { return id; }
    @JsonProperty("id")
    public void setID(long value) { this.id = value; }

    @JsonProperty("kind")
    public long getKind() { return kind; }
    @JsonProperty("kind")
    public void setKind(long value) { this.kind = value; }

    @JsonProperty("kindString")
    public TentacledKindString getKindString() { return kindString; }
    @JsonProperty("kindString")
    public void setKindString(TentacledKindString value) { this.kindString = value; }

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }

    @JsonProperty("originalName")
    public String getOriginalName() { return originalName; }
    @JsonProperty("originalName")
    public void setOriginalName(String value) { this.originalName = value; }

    @JsonProperty("sources")
    public List<Source> getSources() { return sources; }
    @JsonProperty("sources")
    public void setSources(List<Source> value) { this.sources = value; }
}
