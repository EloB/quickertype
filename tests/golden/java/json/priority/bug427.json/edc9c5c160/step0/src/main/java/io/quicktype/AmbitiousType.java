package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class AmbitiousType {
    private TentacledDeclaration declaration;
    private ElementType elementType;
    private Long id;
    private String name;
    private TypeEnum type;
    private List<ElementType> typeArguments;

    @JsonProperty("declaration")
    public TentacledDeclaration getDeclaration() { return declaration; }
    @JsonProperty("declaration")
    public void setDeclaration(TentacledDeclaration value) { this.declaration = value; }

    @JsonProperty("elementType")
    public ElementType getElementType() { return elementType; }
    @JsonProperty("elementType")
    public void setElementType(ElementType value) { this.elementType = value; }

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
