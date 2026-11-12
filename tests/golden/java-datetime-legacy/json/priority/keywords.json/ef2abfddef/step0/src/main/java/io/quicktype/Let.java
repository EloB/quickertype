package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Let {
    private long let;

    @JsonProperty("let")
    public long getLet() { return let; }
    @JsonProperty("let")
    public void setLet(long value) { this.let = value; }
}
