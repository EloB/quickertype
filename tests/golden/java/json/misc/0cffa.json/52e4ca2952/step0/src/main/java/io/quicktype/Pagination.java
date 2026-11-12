package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Pagination {
    private long count;
    private long offset;
    private long totalCount;

    @JsonProperty("count")
    public long getCount() { return count; }
    @JsonProperty("count")
    public void setCount(long value) { this.count = value; }

    @JsonProperty("offset")
    public long getOffset() { return offset; }
    @JsonProperty("offset")
    public void setOffset(long value) { this.offset = value; }

    @JsonProperty("total_count")
    public long getTotalCount() { return totalCount; }
    @JsonProperty("total_count")
    public void setTotalCount(long value) { this.totalCount = value; }
}
