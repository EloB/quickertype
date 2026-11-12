package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Typealias {
    private long typealias;

    @JsonProperty("typealias")
    public long getTypealias() { return typealias; }
    @JsonProperty("typealias")
    public void setTypealias(long value) { this.typealias = value; }
}
