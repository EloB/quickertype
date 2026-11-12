package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TypeParameter {
    private PurpleComment comment;
    private GetSignatureFlags flags;
    private long id;
    private long kind;
    private String kindString;
    private String name;
    private MischievousType type;

    @JsonProperty("comment")
    public PurpleComment getComment() { return comment; }
    @JsonProperty("comment")
    public void setComment(PurpleComment value) { this.comment = value; }

    @JsonProperty("flags")
    public GetSignatureFlags getFlags() { return flags; }
    @JsonProperty("flags")
    public void setFlags(GetSignatureFlags value) { this.flags = value; }

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

    @JsonProperty("type")
    public MischievousType getType() { return type; }
    @JsonProperty("type")
    public void setType(MischievousType value) { this.type = value; }
}
