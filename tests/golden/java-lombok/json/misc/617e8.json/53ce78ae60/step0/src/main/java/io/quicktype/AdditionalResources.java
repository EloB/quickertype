package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class AdditionalResources {
    private String seeAlso;

    @JsonProperty("See Also")
    public String getSeeAlso() { return seeAlso; }
    @JsonProperty("See Also")
    public void setSeeAlso(String value) { this.seeAlso = value; }
}
