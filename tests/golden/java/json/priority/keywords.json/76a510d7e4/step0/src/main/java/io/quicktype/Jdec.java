package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Jdec {
    private long jdec;

    @JsonProperty("jdec")
    public long getJdec() { return jdec; }
    @JsonProperty("jdec")
    public void setJdec(long value) { this.jdec = value; }
}
