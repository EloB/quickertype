package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Namespace {
    private long namespace;

    @JsonProperty("namespace")
    public long getNamespace() { return namespace; }
    @JsonProperty("namespace")
    public void setNamespace(long value) { this.namespace = value; }
}
