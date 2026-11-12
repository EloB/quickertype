package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class TopLevel {
    private List<Prize> prizes;

    @JsonProperty("prizes")
    public List<Prize> getPrizes() { return prizes; }
    @JsonProperty("prizes")
    public void setPrizes(List<Prize> value) { this.prizes = value; }
}
