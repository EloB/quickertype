package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class ElementType {
    private Name name;
    private TypeEnum type;

    @JsonProperty("name")
    public Name getName() { return name; }
    @JsonProperty("name")
    public void setName(Name value) { this.name = value; }

    @JsonProperty("type")
    public TypeEnum getType() { return type; }
    @JsonProperty("type")
    public void setType(TypeEnum value) { this.type = value; }
}
