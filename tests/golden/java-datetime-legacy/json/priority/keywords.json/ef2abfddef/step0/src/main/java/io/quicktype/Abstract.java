package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Abstract {
    private long abstractAbstract;

    @JsonProperty("abstract")
    public long getAbstractAbstract() { return abstractAbstract; }
    @JsonProperty("abstract")
    public void setAbstractAbstract(long value) { this.abstractAbstract = value; }
}
