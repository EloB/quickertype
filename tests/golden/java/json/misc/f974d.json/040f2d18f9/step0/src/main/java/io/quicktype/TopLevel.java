package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class TopLevel {
    private long blockIndex;
    private String hash;
    private long height;
    private long time;
    private List<Long> txIndexes;

    @JsonProperty("block_index")
    public long getBlockIndex() { return blockIndex; }
    @JsonProperty("block_index")
    public void setBlockIndex(long value) { this.blockIndex = value; }

    @JsonProperty("hash")
    public String getHash() { return hash; }
    @JsonProperty("hash")
    public void setHash(String value) { this.hash = value; }

    @JsonProperty("height")
    public long getHeight() { return height; }
    @JsonProperty("height")
    public void setHeight(long value) { this.height = value; }

    @JsonProperty("time")
    public long getTime() { return time; }
    @JsonProperty("time")
    public void setTime(long value) { this.time = value; }

    @JsonProperty("txIndexes")
    public List<Long> getTxIndexes() { return txIndexes; }
    @JsonProperty("txIndexes")
    public void setTxIndexes(List<Long> value) { this.txIndexes = value; }
}
