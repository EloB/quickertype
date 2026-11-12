package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class NSError {
    private long nsError;

    @JsonProperty("NSError")
    public long getNSError() { return nsError; }
    @JsonProperty("NSError")
    public void setNSError(long value) { this.nsError = value; }
}
