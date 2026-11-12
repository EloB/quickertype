package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class TentacledChild {
    private PurpleComment comment;
    private String defaultValue;
    private PurpleFlags flags;
    private long id;
    private long kind;
    private PurpleKindString kindString;
    private String name;
    private List<PurpleSignature> signatures;
    private List<Source> sources;
    private TypeElement type;

    @JsonProperty("comment")
    public PurpleComment getComment() { return comment; }
    @JsonProperty("comment")
    public void setComment(PurpleComment value) { this.comment = value; }

    @JsonProperty("defaultValue")
    public String getDefaultValue() { return defaultValue; }
    @JsonProperty("defaultValue")
    public void setDefaultValue(String value) { this.defaultValue = value; }

    @JsonProperty("flags")
    public PurpleFlags getFlags() { return flags; }
    @JsonProperty("flags")
    public void setFlags(PurpleFlags value) { this.flags = value; }

    @JsonProperty("id")
    public long getID() { return id; }
    @JsonProperty("id")
    public void setID(long value) { this.id = value; }

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

    @JsonProperty("signatures")
    public List<PurpleSignature> getSignatures() { return signatures; }
    @JsonProperty("signatures")
    public void setSignatures(List<PurpleSignature> value) { this.signatures = value; }

    @JsonProperty("sources")
    public List<Source> getSources() { return sources; }
    @JsonProperty("sources")
    public void setSources(List<Source> value) { this.sources = value; }

    @JsonProperty("type")
    public TypeElement getType() { return type; }
    @JsonProperty("type")
    public void setType(TypeElement value) { this.type = value; }
}
