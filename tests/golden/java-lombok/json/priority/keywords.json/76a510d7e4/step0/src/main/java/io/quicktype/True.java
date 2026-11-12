package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class True {
    private long trueTrue;

    @JsonProperty("True")
    public long getTrueTrue() { return trueTrue; }
    @JsonProperty("True")
    public void setTrueTrue(long value) { this.trueTrue = value; }
}
