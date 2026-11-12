package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Response {
    private long playerCount;
    private long result;

    @JsonProperty("player_count")
    public long getPlayerCount() { return playerCount; }
    @JsonProperty("player_count")
    public void setPlayerCount(long value) { this.playerCount = value; }

    @JsonProperty("result")
    public long getResult() { return result; }
    @JsonProperty("result")
    public void setResult(long value) { this.result = value; }
}
