package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class FluffyFlags {
    private Boolean isOptional;

    @JsonProperty("isOptional")
    public Boolean getIsOptional() { return isOptional; }
    @JsonProperty("isOptional")
    public void setIsOptional(Boolean value) { this.isOptional = value; }
}
