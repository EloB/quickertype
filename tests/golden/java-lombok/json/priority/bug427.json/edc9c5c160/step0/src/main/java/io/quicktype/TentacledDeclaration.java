package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class TentacledDeclaration {
    private List<IndigoChild> children;
    private GetSignatureFlags flags;
    private List<Group> groups;
    private long id;
    private IndexSignatureElement indexSignature;
    private long kind;
    private String kindString;
    private String name;
    private List<GetSignature> signatures;
    private List<Source> sources;

    @JsonProperty("children")
    public List<IndigoChild> getChildren() { return children; }
    @JsonProperty("children")
    public void setChildren(List<IndigoChild> value) { this.children = value; }

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

    @JsonProperty("indexSignature")
    public IndexSignatureElement getIndexSignature() { return indexSignature; }
    @JsonProperty("indexSignature")
    public void setIndexSignature(IndexSignatureElement value) { this.indexSignature = value; }

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

    @JsonProperty("signatures")
    public List<GetSignature> getSignatures() { return signatures; }
    @JsonProperty("signatures")
    public void setSignatures(List<GetSignature> value) { this.signatures = value; }

    @JsonProperty("sources")
    public List<Source> getSources() { return sources; }
    @JsonProperty("sources")
    public void setSources(List<Source> value) { this.sources = value; }
}
