package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Connection {
    private long totalCount;

    @JsonProperty("totalCount")
    public long getTotalCount() { return totalCount; }
    @JsonProperty("totalCount")
    public void setTotalCount(long value) { this.totalCount = value; }
}
