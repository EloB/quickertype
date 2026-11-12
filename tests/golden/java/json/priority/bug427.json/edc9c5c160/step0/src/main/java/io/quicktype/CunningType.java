package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class CunningType {
    private PurpleDeclaration declaration;
    private Long id;
    private Name name;
    private TypeEnum type;
    private List<ElementType> typeArguments;

    @JsonProperty("declaration")
    public PurpleDeclaration getDeclaration() { return declaration; }
    @JsonProperty("declaration")
    public void setDeclaration(PurpleDeclaration value) { this.declaration = value; }

    @JsonProperty("id")
    public Long getID() { return id; }
    @JsonProperty("id")
    public void setID(Long value) { this.id = value; }

    @JsonProperty("name")
    public Name getName() { return name; }
    @JsonProperty("name")
    public void setName(Name value) { this.name = value; }

    @JsonProperty("type")
    public TypeEnum getType() { return type; }
    @JsonProperty("type")
    public void setType(TypeEnum value) { this.type = value; }

    @JsonProperty("typeArguments")
    public List<ElementType> getTypeArguments() { return typeArguments; }
    @JsonProperty("typeArguments")
    public void setTypeArguments(List<ElementType> value) { this.typeArguments = value; }
}
