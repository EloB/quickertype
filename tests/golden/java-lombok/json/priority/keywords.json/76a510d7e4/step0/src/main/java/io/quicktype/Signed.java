package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Signed {
    private long signed;

    @JsonProperty("signed")
    public long getSigned() { return signed; }
    @JsonProperty("signed")
    public void setSigned(long value) { this.signed = value; }
}
