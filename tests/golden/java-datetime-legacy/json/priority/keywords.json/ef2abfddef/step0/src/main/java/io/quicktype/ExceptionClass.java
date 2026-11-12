package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class ExceptionClass {
    private long exception;

    @JsonProperty("exception")
    public long getException() { return exception; }
    @JsonProperty("exception")
    public void setException(long value) { this.exception = value; }
}
