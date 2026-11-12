package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class IndigoType {
    private ExtendedBy constraint;
    private FluffyDeclaration declaration;
    private ExtendedBy elementType;
    private List<ElementType> elements;
    private Long id;
    private String name;
    private TypeEnum type;
    private List<PurpleTypeArgument> typeArguments;
    private List<TypeElement> types;

    @JsonProperty("constraint")
    public ExtendedBy getConstraint() { return constraint; }
    @JsonProperty("constraint")
    public void setConstraint(ExtendedBy value) { this.constraint = value; }

    @JsonProperty("declaration")
    public FluffyDeclaration getDeclaration() { return declaration; }
    @JsonProperty("declaration")
    public void setDeclaration(FluffyDeclaration value) { this.declaration = value; }

    @JsonProperty("elementType")
    public ExtendedBy getElementType() { return elementType; }
    @JsonProperty("elementType")
    public void setElementType(ExtendedBy value) { this.elementType = value; }

    @JsonProperty("elements")
    public List<ElementType> getElements() { return elements; }
    @JsonProperty("elements")
    public void setElements(List<ElementType> value) { this.elements = value; }

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
    public List<PurpleTypeArgument> getTypeArguments() { return typeArguments; }
    @JsonProperty("typeArguments")
    public void setTypeArguments(List<PurpleTypeArgument> value) { this.typeArguments = value; }

    @JsonProperty("types")
    public List<TypeElement> getTypes() { return types; }
    @JsonProperty("types")
    public void setTypes(List<TypeElement> value) { this.types = value; }
}
