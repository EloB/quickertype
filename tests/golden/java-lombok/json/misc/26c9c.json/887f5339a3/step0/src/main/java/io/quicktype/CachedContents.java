package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class CachedContents {
    private String average;
    private long cachedContentsNull;
    private String largest;
    private long nonNull;
    private String smallest;
    private String sum;
    private List<Top> top;

    @JsonProperty("average")
    public String getAverage() { return average; }
    @JsonProperty("average")
    public void setAverage(String value) { this.average = value; }

    @JsonProperty("null")
    public long getCachedContentsNull() { return cachedContentsNull; }
    @JsonProperty("null")
    public void setCachedContentsNull(long value) { this.cachedContentsNull = value; }

    @JsonProperty("largest")
    public String getLargest() { return largest; }
    @JsonProperty("largest")
    public void setLargest(String value) { this.largest = value; }

    @JsonProperty("non_null")
    public long getNonNull() { return nonNull; }
    @JsonProperty("non_null")
    public void setNonNull(long value) { this.nonNull = value; }

    @JsonProperty("smallest")
    public String getSmallest() { return smallest; }
    @JsonProperty("smallest")
    public void setSmallest(String value) { this.smallest = value; }

    @JsonProperty("sum")
    public String getSum() { return sum; }
    @JsonProperty("sum")
    public void setSum(String value) { this.sum = value; }

    @JsonProperty("top")
    public List<Top> getTop() { return top; }
    @JsonProperty("top")
    public void setTop(List<Top> value) { this.top = value; }
}
