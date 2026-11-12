package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class EqualityContract {
    private long equalityContract;

    @JsonProperty("equalityContract")
    public long getEqualityContract() { return equalityContract; }
    @JsonProperty("equalityContract")
    public void setEqualityContract(long value) { this.equalityContract = value; }
}
