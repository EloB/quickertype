package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class IndecentType {
    private GetSignature declaration;
    private List<ElementType> elements;
    private Name name;
    private TypeEnum type;

    @JsonProperty("declaration")
    public GetSignature getDeclaration() { return declaration; }
    @JsonProperty("declaration")
    public void setDeclaration(GetSignature value) { this.declaration = value; }

    @JsonProperty("elements")
    public List<ElementType> getElements() { return elements; }
    @JsonProperty("elements")
    public void setElements(List<ElementType> value) { this.elements = value; }

    @JsonProperty("name")
    public Name getName() { return name; }
    @JsonProperty("name")
    public void setName(Name value) { this.name = value; }

    @JsonProperty("type")
    public TypeEnum getType() { return type; }
    @JsonProperty("type")
    public void setType(TypeEnum value) { this.type = value; }
}
