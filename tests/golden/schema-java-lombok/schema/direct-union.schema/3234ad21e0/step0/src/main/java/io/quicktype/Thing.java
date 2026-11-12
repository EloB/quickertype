package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;
import java.util.Map;

public class Thing {
    private Anything optional;
    private Anything required;

    @JsonProperty("optional")
    public Anything getOptional() { return optional; }
    @JsonProperty("optional")
    public void setOptional(Anything value) { this.optional = value; }

    @JsonProperty("required")
    public Anything getRequired() { return required; }
    @JsonProperty("required")
    public void setRequired(Anything value) { this.required = value; }
}
