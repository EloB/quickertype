package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class PurpleDeclaration {
    private List<GetSignature> children;
    private GetSignatureFlags flags;
    private List<Group> groups;
    private long id;
    private long kind;
    private String kindString;
    private String name;

    @JsonProperty("children")
    public List<GetSignature> getChildren() { return children; }
    @JsonProperty("children")
    public void setChildren(List<GetSignature> value) { this.children = value; }

    @JsonProperty("flags")
    public GetSignatureFlags getFlags() { return flags; }
    @JsonProperty("flags")
    public void setFlags(GetSignatureFlags value) { this.flags = value; }

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
    public String getKindString() { return kindString; }
    @JsonProperty("kindString")
    public void setKindString(String value) { this.kindString = value; }

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }
}
