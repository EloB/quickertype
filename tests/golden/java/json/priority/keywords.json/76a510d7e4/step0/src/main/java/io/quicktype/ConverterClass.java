package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class ConverterClass {
    private long converter;

    @JsonProperty("converter")
    public long getConverter() { return converter; }
    @JsonProperty("converter")
    public void setConverter(long value) { this.converter = value; }
}
