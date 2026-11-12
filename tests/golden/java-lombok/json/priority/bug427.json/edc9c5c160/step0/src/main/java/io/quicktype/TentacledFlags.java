package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TentacledFlags {
    private Boolean isOptional;
    private Boolean isREST;

    @JsonProperty("isOptional")
    public Boolean getIsOptional() { return isOptional; }
    @JsonProperty("isOptional")
    public void setIsOptional(Boolean value) { this.isOptional = value; }

    @JsonProperty("isRest")
    public Boolean getIsREST() { return isREST; }
    @JsonProperty("isRest")
    public void setIsREST(Boolean value) { this.isREST = value; }
}
