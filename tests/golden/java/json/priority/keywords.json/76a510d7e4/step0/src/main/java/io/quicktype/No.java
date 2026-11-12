package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class No {
    private long no;

    @JsonProperty("NO")
    public long getNo() { return no; }
    @JsonProperty("NO")
    public void setNo(long value) { this.no = value; }
}
