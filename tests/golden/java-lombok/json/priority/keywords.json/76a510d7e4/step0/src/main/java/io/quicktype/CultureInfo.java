package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class CultureInfo {
    private long cultureInfo;

    @JsonProperty("CultureInfo")
    public long getCultureInfo() { return cultureInfo; }
    @JsonProperty("CultureInfo")
    public void setCultureInfo(long value) { this.cultureInfo = value; }
}
