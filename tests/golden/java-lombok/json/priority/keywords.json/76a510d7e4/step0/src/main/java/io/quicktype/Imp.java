package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Imp {
    private long imp;

    @JsonProperty("IMP")
    public long getImp() { return imp; }
    @JsonProperty("IMP")
    public void setImp(long value) { this.imp = value; }
}
