package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class PurpleResponses {
    private Purple200 the200;

    @JsonProperty("200")
    public Purple200 getThe200() { return the200; }
    @JsonProperty("200")
    public void setThe200(Purple200 value) { this.the200 = value; }
}
