package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class GetSignatureParameter {
    private TentacledComment comment;
    private TentacledFlags flags;
    private long id;
    private long kind;
    private ParameterKindString kindString;
    private String name;
    private FluffyType type;

    @JsonProperty("comment")
    public TentacledComment getComment() { return comment; }
    @JsonProperty("comment")
    public void setComment(TentacledComment value) { this.comment = value; }

    @JsonProperty("flags")
    public TentacledFlags getFlags() { return flags; }
    @JsonProperty("flags")
    public void setFlags(TentacledFlags value) { this.flags = value; }

    @JsonProperty("id")
    public long getID() { return id; }
    @JsonProperty("id")
    public void setID(long value) { this.id = value; }

    @JsonProperty("kind")
    public long getKind() { return kind; }
    @JsonProperty("kind")
    public void setKind(long value) { this.kind = value; }

    @JsonProperty("kindString")
    public ParameterKindString getKindString() { return kindString; }
    @JsonProperty("kindString")
    public void setKindString(ParameterKindString value) { this.kindString = value; }

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }

    @JsonProperty("type")
    public FluffyType getType() { return type; }
    @JsonProperty("type")
    public void setType(FluffyType value) { this.type = value; }
}
