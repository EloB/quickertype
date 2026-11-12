package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class VoteScore {
    private long avg;
    private long score;
    private long total;

    @JsonProperty("avg")
    public long getAvg() { return avg; }
    @JsonProperty("avg")
    public void setAvg(long value) { this.avg = value; }

    @JsonProperty("score")
    public long getScore() { return score; }
    @JsonProperty("score")
    public void setScore(long value) { this.score = value; }

    @JsonProperty("total")
    public long getTotal() { return total; }
    @JsonProperty("total")
    public void setTotal(long value) { this.total = value; }
}
