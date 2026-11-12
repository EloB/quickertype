package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Lambda {
    private long lambda;

    @JsonProperty("lambda")
    public long getLambda() { return lambda; }
    @JsonProperty("lambda")
    public void setLambda(long value) { this.lambda = value; }
}
