package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Compl {
    private long compl;

    @JsonProperty("compl")
    public long getCompl() { return compl; }
    @JsonProperty("compl")
    public void setCompl(long value) { this.compl = value; }
}
