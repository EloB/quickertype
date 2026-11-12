package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class StickyType {
    private ExtendedBy constraint;
    private GetSignature declaration;
    private ElementType elementType;
    private List<ExtendedBy> elements;
    private Long id;
    private String name;
    private TypeEnum type;
    private List<ElementType> typeArguments;

    @JsonProperty("constraint")
    public ExtendedBy getConstraint() { return constraint; }
    @JsonProperty("constraint")
    public void setConstraint(ExtendedBy value) { this.constraint = value; }

    @JsonProperty("declaration")
    public GetSignature getDeclaration() { return declaration; }
    @JsonProperty("declaration")
    public void setDeclaration(GetSignature value) { this.declaration = value; }

    @JsonProperty("elementType")
    public ElementType getElementType() { return elementType; }
    @JsonProperty("elementType")
    public void setElementType(ElementType value) { this.elementType = value; }

    @JsonProperty("elements")
    public List<ExtendedBy> getElements() { return elements; }
    @JsonProperty("elements")
    public void setElements(List<ExtendedBy> value) { this.elements = value; }

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
    public List<ElementType> getTypeArguments() { return typeArguments; }
    @JsonProperty("typeArguments")
    public void setTypeArguments(List<ElementType> value) { this.typeArguments = value; }
}
