package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.Map;

public class TopLevel {
    private Map<String, Pair> pairs;
    private long serverTime;

    @JsonProperty("pairs")
    public Map<String, Pair> getPairs() { return pairs; }
    @JsonProperty("pairs")
    public void setPairs(Map<String, Pair> value) { this.pairs = value; }

    @JsonProperty("server_time")
    public long getServerTime() { return serverTime; }
    @JsonProperty("server_time")
    public void setServerTime(long value) { this.serverTime = value; }
}
