package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class StickySignature {
    private StickyComment comment;
    private IndigoFlags flags;
    private long id;
    private long kind;
    private SignatureKindString kindString;
    private String name;
    private List<TentacledParameter> parameters;
    private CunningType type;
    private List<GetSignature> typeParameter;

    @JsonProperty("comment")
    public StickyComment getComment() { return comment; }
    @JsonProperty("comment")
    public void setComment(StickyComment value) { this.comment = value; }

    @JsonProperty("flags")
    public IndigoFlags getFlags() { return flags; }
    @JsonProperty("flags")
    public void setFlags(IndigoFlags value) { this.flags = value; }

    @JsonProperty("id")
    public long getID() { return id; }
    @JsonProperty("id")
    public void setID(long value) { this.id = value; }

    @JsonProperty("kind")
    public long getKind() { return kind; }
    @JsonProperty("kind")
    public void setKind(long value) { this.kind = value; }

    @JsonProperty("kindString")
    public SignatureKindString getKindString() { return kindString; }
    @JsonProperty("kindString")
    public void setKindString(SignatureKindString value) { this.kindString = value; }

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }

    @JsonProperty("parameters")
    public List<TentacledParameter> getParameters() { return parameters; }
    @JsonProperty("parameters")
    public void setParameters(List<TentacledParameter> value) { this.parameters = value; }

    @JsonProperty("type")
    public CunningType getType() { return type; }
    @JsonProperty("type")
    public void setType(CunningType value) { this.type = value; }

    @JsonProperty("typeParameter")
    public List<GetSignature> getTypeParameter() { return typeParameter; }
    @JsonProperty("typeParameter")
    public void setTypeParameter(List<GetSignature> value) { this.typeParameter = value; }
}
