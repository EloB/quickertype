package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class NSString {
    private long nsString;

    @JsonProperty("NSString")
    public long getNSString() { return nsString; }
    @JsonProperty("NSString")
    public void setNSString(long value) { this.nsString = value; }
}
