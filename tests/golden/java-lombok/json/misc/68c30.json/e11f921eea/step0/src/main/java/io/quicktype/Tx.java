package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class Tx {
    private boolean doubleSpend;
    private String hash;
    private List<Input> inputs;
    private long lockTime;
    private List<Out> out;
    private String relayedBy;
    private long size;
    private long time;
    private long txIndex;
    private long ver;
    private long vinSz;
    private long voutSz;

    @JsonProperty("double_spend")
    public boolean getDoubleSpend() { return doubleSpend; }
    @JsonProperty("double_spend")
    public void setDoubleSpend(boolean value) { this.doubleSpend = value; }

    @JsonProperty("hash")
    public String getHash() { return hash; }
    @JsonProperty("hash")
    public void setHash(String value) { this.hash = value; }

    @JsonProperty("inputs")
    public List<Input> getInputs() { return inputs; }
    @JsonProperty("inputs")
    public void setInputs(List<Input> value) { this.inputs = value; }

    @JsonProperty("lock_time")
    public long getLockTime() { return lockTime; }
    @JsonProperty("lock_time")
    public void setLockTime(long value) { this.lockTime = value; }

    @JsonProperty("out")
    public List<Out> getOut() { return out; }
    @JsonProperty("out")
    public void setOut(List<Out> value) { this.out = value; }

    @JsonProperty("relayed_by")
    public String getRelayedBy() { return relayedBy; }
    @JsonProperty("relayed_by")
    public void setRelayedBy(String value) { this.relayedBy = value; }

    @JsonProperty("size")
    public long getSize() { return size; }
    @JsonProperty("size")
    public void setSize(long value) { this.size = value; }

    @JsonProperty("time")
    public long getTime() { return time; }
    @JsonProperty("time")
    public void setTime(long value) { this.time = value; }

    @JsonProperty("tx_index")
    public long getTxIndex() { return txIndex; }
    @JsonProperty("tx_index")
    public void setTxIndex(long value) { this.txIndex = value; }

    @JsonProperty("ver")
    public long getVer() { return ver; }
    @JsonProperty("ver")
    public void setVer(long value) { this.ver = value; }

    @JsonProperty("vin_sz")
    public long getVinSz() { return vinSz; }
    @JsonProperty("vin_sz")
    public void setVinSz(long value) { this.vinSz = value; }

    @JsonProperty("vout_sz")
    public long getVoutSz() { return voutSz; }
    @JsonProperty("vout_sz")
    public void setVoutSz(long value) { this.voutSz = value; }
}
