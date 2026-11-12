package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Postfix {
    private long postfix;

    @JsonProperty("postfix")
    public long getPostfix() { return postfix; }
    @JsonProperty("postfix")
    public void setPostfix(long value) { this.postfix = value; }
}
