package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Finally {
    private long finallyFinally;

    @JsonProperty("finally")
    public long getFinallyFinally() { return finallyFinally; }
    @JsonProperty("finally")
    public void setFinallyFinally(long value) { this.finallyFinally = value; }
}
