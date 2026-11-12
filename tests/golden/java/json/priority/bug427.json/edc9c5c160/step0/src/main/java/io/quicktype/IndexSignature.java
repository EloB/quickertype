package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class IndexSignature {
    private GetSignatureFlags flags;
    private long id;
    private long kind;
    private String kindString;
    private String name;
    private List<GetSignature> parameters;
    private HilariousType type;

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

    @JsonProperty("parameters")
    public List<GetSignature> getParameters() { return parameters; }
    @JsonProperty("parameters")
    public void setParameters(List<GetSignature> value) { this.parameters = value; }

    @JsonProperty("type")
    public HilariousType getType() { return type; }
    @JsonProperty("type")
    public void setType(HilariousType value) { this.type = value; }
}
