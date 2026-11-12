package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class MagentaType {
    private StickyDeclaration declaration;
    private ElementType elementType;
    private List<ExtendedBy> elements;
    private Long id;
    private String name;
    private TypeEnum type;
    private List<FluffyTypeArgument> typeArguments;
    private List<ExtendedBy> types;
    private String value;

    @JsonProperty("declaration")
    public StickyDeclaration getDeclaration() { return declaration; }
    @JsonProperty("declaration")
    public void setDeclaration(StickyDeclaration value) { this.declaration = value; }

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
    public List<FluffyTypeArgument> getTypeArguments() { return typeArguments; }
    @JsonProperty("typeArguments")
    public void setTypeArguments(List<FluffyTypeArgument> value) { this.typeArguments = value; }

    @JsonProperty("types")
    public List<ExtendedBy> getTypes() { return types; }
    @JsonProperty("types")
    public void setTypes(List<ExtendedBy> value) { this.types = value; }

    @JsonProperty("value")
    public String getValue() { return value; }
    @JsonProperty("value")
    public void setValue(String value) { this.value = value; }
}
