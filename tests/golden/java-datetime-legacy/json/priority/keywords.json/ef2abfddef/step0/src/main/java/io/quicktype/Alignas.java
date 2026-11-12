package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Alignas {
    private long alignas;

    @JsonProperty("alignas")
    public long getAlignas() { return alignas; }
    @JsonProperty("alignas")
    public void setAlignas(long value) { this.alignas = value; }
}
