package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class TopLevel {
    private List<Tx> txs;

    @JsonProperty("txs")
    public List<Tx> getTxs() { return txs; }
    @JsonProperty("txs")
    public void setTxs(List<Tx> value) { this.txs = value; }
}
