package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class FriskyType {
    private IndigoDeclaration declaration;
    private Name name;
    private TypeEnum type;

    @JsonProperty("declaration")
    public IndigoDeclaration getDeclaration() { return declaration; }
    @JsonProperty("declaration")
    public void setDeclaration(IndigoDeclaration value) { this.declaration = value; }

    @JsonProperty("name")
    public Name getName() { return name; }
    @JsonProperty("name")
    public void setName(Name value) { this.name = value; }

    @JsonProperty("type")
    public TypeEnum getType() { return type; }
    @JsonProperty("type")
    public void setType(TypeEnum value) { this.type = value; }
}
