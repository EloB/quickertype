package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class RegExp {
    private String pattern3;

    @JsonProperty("pattern3")
    public String getPattern3() { return pattern3; }
    @JsonProperty("pattern3")
    public void setPattern3(String value) { this.pattern3 = value; }
}
