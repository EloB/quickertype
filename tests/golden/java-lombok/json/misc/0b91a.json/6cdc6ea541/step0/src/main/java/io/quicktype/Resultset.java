package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Resultset {
    private long count;
    private long page;
    private long pagesize;

    @JsonProperty("count")
    public long getCount() { return count; }
    @JsonProperty("count")
    public void setCount(long value) { this.count = value; }

    @JsonProperty("page")
    public long getPage() { return page; }
    @JsonProperty("page")
    public void setPage(long value) { this.page = value; }

    @JsonProperty("pagesize")
    public long getPagesize() { return pagesize; }
    @JsonProperty("pagesize")
    public void setPagesize(long value) { this.pagesize = value; }
}
