package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class PurpleChild {
    private List<FluffyChild> children;
    private StickyComment comment;
    private String defaultValue;
    private List<ExtendedBy> extendedBy;
    private List<ExtendedBy> extendedTypes;
    private IndecentFlags flags;
    private List<Group> groups;
    private long id;
    private List<ExtendedBy> implementedBy;
    private List<ExtendedBy> implementedTypes;
    private long kind;
    private FluffyKindString kindString;
    private String name;
    private List<StickySignature> signatures;
    private List<Source> sources;
    private MagentaType type;
    private List<TypeParameter> typeParameter;

    @JsonProperty("children")
    public List<FluffyChild> getChildren() { return children; }
    @JsonProperty("children")
    public void setChildren(List<FluffyChild> value) { this.children = value; }

    @JsonProperty("comment")
    public StickyComment getComment() { return comment; }
    @JsonProperty("comment")
    public void setComment(StickyComment value) { this.comment = value; }

    @JsonProperty("defaultValue")
    public String getDefaultValue() { return defaultValue; }
    @JsonProperty("defaultValue")
    public void setDefaultValue(String value) { this.defaultValue = value; }

    @JsonProperty("extendedBy")
    public List<ExtendedBy> getExtendedBy() { return extendedBy; }
    @JsonProperty("extendedBy")
    public void setExtendedBy(List<ExtendedBy> value) { this.extendedBy = value; }

    @JsonProperty("extendedTypes")
    public List<ExtendedBy> getExtendedTypes() { return extendedTypes; }
    @JsonProperty("extendedTypes")
    public void setExtendedTypes(List<ExtendedBy> value) { this.extendedTypes = value; }

    @JsonProperty("flags")
    public IndecentFlags getFlags() { return flags; }
    @JsonProperty("flags")
    public void setFlags(IndecentFlags value) { this.flags = value; }

    @JsonProperty("groups")
    public List<Group> getGroups() { return groups; }
    @JsonProperty("groups")
    public void setGroups(List<Group> value) { this.groups = value; }

    @JsonProperty("id")
    public long getID() { return id; }
    @JsonProperty("id")
    public void setID(long value) { this.id = value; }

    @JsonProperty("implementedBy")
    public List<ExtendedBy> getImplementedBy() { return implementedBy; }
    @JsonProperty("implementedBy")
    public void setImplementedBy(List<ExtendedBy> value) { this.implementedBy = value; }

    @JsonProperty("implementedTypes")
    public List<ExtendedBy> getImplementedTypes() { return implementedTypes; }
    @JsonProperty("implementedTypes")
    public void setImplementedTypes(List<ExtendedBy> value) { this.implementedTypes = value; }

    @JsonProperty("kind")
    public long getKind() { return kind; }
    @JsonProperty("kind")
    public void setKind(long value) { this.kind = value; }

    @JsonProperty("kindString")
    public FluffyKindString getKindString() { return kindString; }
    @JsonProperty("kindString")
    public void setKindString(FluffyKindString value) { this.kindString = value; }

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }

    @JsonProperty("signatures")
    public List<StickySignature> getSignatures() { return signatures; }
    @JsonProperty("signatures")
    public void setSignatures(List<StickySignature> value) { this.signatures = value; }

    @JsonProperty("sources")
    public List<Source> getSources() { return sources; }
    @JsonProperty("sources")
    public void setSources(List<Source> value) { this.sources = value; }

    @JsonProperty("type")
    public MagentaType getType() { return type; }
    @JsonProperty("type")
    public void setType(MagentaType value) { this.type = value; }

    @JsonProperty("typeParameter")
    public List<TypeParameter> getTypeParameter() { return typeParameter; }
    @JsonProperty("typeParameter")
    public void setTypeParameter(List<TypeParameter> value) { this.typeParameter = value; }
}
