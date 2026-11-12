package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Throw {
    private long throwThrow;

    @JsonProperty("throw")
    public long getThrowThrow() { return throwThrow; }
    @JsonProperty("throw")
    public void setThrowThrow(long value) { this.throwThrow = value; }
}
