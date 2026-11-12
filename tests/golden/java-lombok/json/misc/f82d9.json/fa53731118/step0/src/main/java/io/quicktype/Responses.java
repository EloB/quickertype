package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Responses {
    private The200 the200;

    @JsonProperty("200")
    public The200 getThe200() { return the200; }
    @JsonProperty("200")
    public void setThe200(The200 value) { this.the200 = value; }
}
