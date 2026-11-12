package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class WcharT {
    private long wcharT;

    @JsonProperty("wchar_t")
    public long getWcharT() { return wcharT; }
    @JsonProperty("wchar_t")
    public void setWcharT(long value) { this.wcharT = value; }
}
