package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class ExtendedBy {
    private ExtendedBy constraint;
    private Long id;
    private String name;
    private TypeEnum type;
    private List<ExtendedBy> typeArguments;

    @JsonProperty("constraint")
    public ExtendedBy getConstraint() { return constraint; }
    @JsonProperty("constraint")
    public void setConstraint(ExtendedBy value) { this.constraint = value; }

    @JsonProperty("id")
    public Long getID() { return id; }
    @JsonProperty("id")
    public void setID(Long value) { this.id = value; }

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }

    @JsonProperty("type")
    public TypeEnum getType() { return type; }
    @JsonProperty("type")
    public void setType(TypeEnum value) { this.type = value; }

    @JsonProperty("typeArguments")
    public List<ExtendedBy> getTypeArguments() { return typeArguments; }
    @JsonProperty("typeArguments")
    public void setTypeArguments(List<ExtendedBy> value) { this.typeArguments = value; }
}
