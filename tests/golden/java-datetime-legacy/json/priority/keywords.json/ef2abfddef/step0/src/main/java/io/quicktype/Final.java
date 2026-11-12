package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Final {
    private long finalFinal;

    @JsonProperty("final")
    public long getFinalFinal() { return finalFinal; }
    @JsonProperty("final")
    public void setFinalFinal(long value) { this.finalFinal = value; }
}
