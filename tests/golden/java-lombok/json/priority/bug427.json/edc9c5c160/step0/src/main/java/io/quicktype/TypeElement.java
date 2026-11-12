package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class TypeElement {
    private GetSignature declaration;
    private ElementType elementType;
    private Name name;
    private TypeEnum type;
    private List<ElementType> typeArguments;

    @JsonProperty("declaration")
    public GetSignature getDeclaration() { return declaration; }
    @JsonProperty("declaration")
    public void setDeclaration(GetSignature value) { this.declaration = value; }

    @JsonProperty("elementType")
    public ElementType getElementType() { return elementType; }
    @JsonProperty("elementType")
    public void setElementType(ElementType value) { this.elementType = value; }

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
