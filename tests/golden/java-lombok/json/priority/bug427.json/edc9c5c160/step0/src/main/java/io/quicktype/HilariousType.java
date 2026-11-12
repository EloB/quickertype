package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class HilariousType {
    private GetSignature declaration;
    private TypeEnum type;

    @JsonProperty("declaration")
    public GetSignature getDeclaration() { return declaration; }
    @JsonProperty("declaration")
    public void setDeclaration(GetSignature value) { this.declaration = value; }

    @JsonProperty("type")
    public TypeEnum getType() { return type; }
    @JsonProperty("type")
    public void setType(TypeEnum value) { this.type = value; }
}
