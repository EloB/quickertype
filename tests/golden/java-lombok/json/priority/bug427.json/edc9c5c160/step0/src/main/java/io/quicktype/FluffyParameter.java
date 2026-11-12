package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class FluffyParameter {
    private FluffyComment comment;
    private FluffyFlags flags;
    private long id;
    private long kind;
    private String kindString;
    private String name;
    private List<Source> sources;
    private ElementType type;

    @JsonProperty("comment")
    public FluffyComment getComment() { return comment; }
    @JsonProperty("comment")
    public void setComment(FluffyComment value) { this.comment = value; }

    @JsonProperty("flags")
    public FluffyFlags getFlags() { return flags; }
    @JsonProperty("flags")
    public void setFlags(FluffyFlags value) { this.flags = value; }

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

    @JsonProperty("sources")
    public List<Source> getSources() { return sources; }
    @JsonProperty("sources")
    public void setSources(List<Source> value) { this.sources = value; }

    @JsonProperty("type")
    public ElementType getType() { return type; }
    @JsonProperty("type")
    public void setType(ElementType value) { this.type = value; }
}
