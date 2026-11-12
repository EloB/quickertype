package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Meta {
    private long limit;
    private long offset;
    private long totalCount;

    @JsonProperty("limit")
    public long getLimit() { return limit; }
    @JsonProperty("limit")
    public void setLimit(long value) { this.limit = value; }

    @JsonProperty("offset")
    public long getOffset() { return offset; }
    @JsonProperty("offset")
    public void setOffset(long value) { this.offset = value; }

    @JsonProperty("total_count")
    public long getTotalCount() { return totalCount; }
    @JsonProperty("total_count")
    public void setTotalCount(long value) { this.totalCount = value; }
}
