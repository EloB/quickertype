package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class FluffyResponses {
    private Fluffy200 the200;

    @JsonProperty("200")
    public Fluffy200 getThe200() { return the200; }
    @JsonProperty("200")
    public void setThe200(Fluffy200 value) { this.the200 = value; }
}
