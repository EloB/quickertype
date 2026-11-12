package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TrueClass {
    private long trueTrue;

    @JsonProperty("true")
    public long getTrueTrue() { return trueTrue; }
    @JsonProperty("true")
    public void setTrueTrue(long value) { this.trueTrue = value; }
}
