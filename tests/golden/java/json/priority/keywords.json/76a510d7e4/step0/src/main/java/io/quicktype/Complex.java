package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Complex {
    private long complex;

    @JsonProperty("_Complex")
    public long getComplex() { return complex; }
    @JsonProperty("_Complex")
    public void setComplex(long value) { this.complex = value; }
}
