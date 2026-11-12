package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Test {
    private String cfpb1;

    @JsonProperty("CFPB1")
    public String getCfpb1() { return cfpb1; }
    @JsonProperty("CFPB1")
    public void setCfpb1(String value) { this.cfpb1 = value; }
}
