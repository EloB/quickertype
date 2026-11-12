package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Nonatomic {
    private long nonatomic;

    @JsonProperty("nonatomic")
    public long getNonatomic() { return nonatomic; }
    @JsonProperty("nonatomic")
    public void setNonatomic(long value) { this.nonatomic = value; }
}
