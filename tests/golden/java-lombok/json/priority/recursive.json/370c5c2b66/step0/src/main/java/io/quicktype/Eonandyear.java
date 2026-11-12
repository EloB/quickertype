package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Eonandyear {
    private long lowestsetbit;

    @JsonProperty("lowestsetbit")
    public long getLowestsetbit() { return lowestsetbit; }
    @JsonProperty("lowestsetbit")
    public void setLowestsetbit(long value) { this.lowestsetbit = value; }
}
