package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Required {
    private long required;

    @JsonProperty("required")
    public long getRequired() { return required; }
    @JsonProperty("required")
    public void setRequired(long value) { this.required = value; }
}
