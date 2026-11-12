package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TentacledParameter {
    private TentacledComment comment;
    private String defaultValue;
    private TentacledFlags flags;
    private long id;
    private long kind;
    private ParameterKindString kindString;
    private String name;
    private String originalName;
    private AmbitiousType type;

    @JsonProperty("comment")
    public TentacledComment getComment() { return comment; }
    @JsonProperty("comment")
    public void setComment(TentacledComment value) { this.comment = value; }

    @JsonProperty("defaultValue")
    public String getDefaultValue() { return defaultValue; }
    @JsonProperty("defaultValue")
    public void setDefaultValue(String value) { this.defaultValue = value; }

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

    @JsonProperty("originalName")
    public String getOriginalName() { return originalName; }
    @JsonProperty("originalName")
    public void setOriginalName(String value) { this.originalName = value; }

    @JsonProperty("type")
    public AmbitiousType getType() { return type; }
    @JsonProperty("type")
    public void setType(AmbitiousType value) { this.type = value; }
}
