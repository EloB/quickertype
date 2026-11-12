package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class FluffyTypeArgument {
    private TypeEnum type;
    private List<ElementType> types;

    @JsonProperty("type")
    public TypeEnum getType() { return type; }
    @JsonProperty("type")
    public void setType(TypeEnum value) { this.type = value; }

    @JsonProperty("types")
    public List<ElementType> getTypes() { return types; }
    @JsonProperty("types")
    public void setTypes(List<ElementType> value) { this.types = value; }
}
