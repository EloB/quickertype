package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class History {
    private String historyClass;

    @JsonProperty("class")
    public String getHistoryClass() { return historyClass; }
    @JsonProperty("class")
    public void setHistoryClass(String value) { this.historyClass = value; }
}
