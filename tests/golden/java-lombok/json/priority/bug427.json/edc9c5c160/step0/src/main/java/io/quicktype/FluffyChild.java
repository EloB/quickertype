package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class FluffyChild {
    private List<TentacledChild> children;
    private StickyComment comment;
    private String defaultValue;
    private StickyFlags flags;
    private GetSignature getSignature;
    private List<Group> groups;
    private long id;
    private ExtendedBy implementationOf;
    private ExtendedBy inheritedFrom;
    private long kind;
    private PurpleKindString kindString;
    private String name;
    private ExtendedBy overwrites;
    private GetSignature setSignature;
    private List<FluffySignature> signatures;
    private List<Source> sources;
    private IndigoType type;

    @JsonProperty("children")
    public List<TentacledChild> getChildren() { return children; }
    @JsonProperty("children")
    public void setChildren(List<TentacledChild> value) { this.children = value; }

    @JsonProperty("comment")
    public StickyComment getComment() { return comment; }
    @JsonProperty("comment")
    public void setComment(StickyComment value) { this.comment = value; }

    @JsonProperty("defaultValue")
    public String getDefaultValue() { return defaultValue; }
    @JsonProperty("defaultValue")
    public void setDefaultValue(String value) { this.defaultValue = value; }

    @JsonProperty("flags")
    public StickyFlags getFlags() { return flags; }
    @JsonProperty("flags")
    public void setFlags(StickyFlags value) { this.flags = value; }

    @JsonProperty("getSignature")
    public GetSignature getGetSignature() { return getSignature; }
    @JsonProperty("getSignature")
    public void setGetSignature(GetSignature value) { this.getSignature = value; }

    @JsonProperty("groups")
    public List<Group> getGroups() { return groups; }
    @JsonProperty("groups")
    public void setGroups(List<Group> value) { this.groups = value; }

    @JsonProperty("id")
    public long getID() { return id; }
    @JsonProperty("id")
    public void setID(long value) { this.id = value; }

    @JsonProperty("implementationOf")
    public ExtendedBy getImplementationOf() { return implementationOf; }
    @JsonProperty("implementationOf")
    public void setImplementationOf(ExtendedBy value) { this.implementationOf = value; }

    @JsonProperty("inheritedFrom")
    public ExtendedBy getInheritedFrom() { return inheritedFrom; }
    @JsonProperty("inheritedFrom")
    public void setInheritedFrom(ExtendedBy value) { this.inheritedFrom = value; }

    @JsonProperty("kind")
    public long getKind() { return kind; }
    @JsonProperty("kind")
    public void setKind(long value) { this.kind = value; }

    @JsonProperty("kindString")
    public PurpleKindString getKindString() { return kindString; }
    @JsonProperty("kindString")
    public void setKindString(PurpleKindString value) { this.kindString = value; }

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }

    @JsonProperty("overwrites")
    public ExtendedBy getOverwrites() { return overwrites; }
    @JsonProperty("overwrites")
    public void setOverwrites(ExtendedBy value) { this.overwrites = value; }

    @JsonProperty("setSignature")
    public GetSignature getSetSignature() { return setSignature; }
    @JsonProperty("setSignature")
    public void setSetSignature(GetSignature value) { this.setSignature = value; }

    @JsonProperty("signatures")
    public List<FluffySignature> getSignatures() { return signatures; }
    @JsonProperty("signatures")
    public void setSignatures(List<FluffySignature> value) { this.signatures = value; }

    @JsonProperty("sources")
    public List<Source> getSources() { return sources; }
    @JsonProperty("sources")
    public void setSources(List<Source> value) { this.sources = value; }

    @JsonProperty("type")
    public IndigoType getType() { return type; }
    @JsonProperty("type")
    public void setType(IndigoType value) { this.type = value; }
}
