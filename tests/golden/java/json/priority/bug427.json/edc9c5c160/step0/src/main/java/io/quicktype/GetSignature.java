package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class GetSignature {
    private List<GetSignatureChild> children;
    private GetSignatureComment comment;
    private String defaultValue;
    private GetSignatureFlags flags;
    private List<Group> groups;
    private long id;
    private long kind;
    private String kindString;
    private String name;
    private List<GetSignatureParameter> parameters;
    private List<IndexSignatureElement> signatures;
    private List<Source> sources;
    private GetSignatureType type;
    private List<GetSignature> typeParameter;

    @JsonProperty("children")
    public List<GetSignatureChild> getChildren() { return children; }
    @JsonProperty("children")
    public void setChildren(List<GetSignatureChild> value) { this.children = value; }

    @JsonProperty("comment")
    public GetSignatureComment getComment() { return comment; }
    @JsonProperty("comment")
    public void setComment(GetSignatureComment value) { this.comment = value; }

    @JsonProperty("defaultValue")
    public String getDefaultValue() { return defaultValue; }
    @JsonProperty("defaultValue")
    public void setDefaultValue(String value) { this.defaultValue = value; }

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

    @JsonProperty("parameters")
    public List<GetSignatureParameter> getParameters() { return parameters; }
    @JsonProperty("parameters")
    public void setParameters(List<GetSignatureParameter> value) { this.parameters = value; }

    @JsonProperty("signatures")
    public List<IndexSignatureElement> getSignatures() { return signatures; }
    @JsonProperty("signatures")
    public void setSignatures(List<IndexSignatureElement> value) { this.signatures = value; }

    @JsonProperty("sources")
    public List<Source> getSources() { return sources; }
    @JsonProperty("sources")
    public void setSources(List<Source> value) { this.sources = value; }

    @JsonProperty("type")
    public GetSignatureType getType() { return type; }
    @JsonProperty("type")
    public void setType(GetSignatureType value) { this.type = value; }

    @JsonProperty("typeParameter")
    public List<GetSignature> getTypeParameter() { return typeParameter; }
    @JsonProperty("typeParameter")
    public void setTypeParameter(List<GetSignature> value) { this.typeParameter = value; }
}
