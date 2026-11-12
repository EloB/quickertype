package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class PrintMembers {
    private long printMembers;

    @JsonProperty("printMembers")
    public long getPrintMembers() { return printMembers; }
    @JsonProperty("printMembers")
    public void setPrintMembers(long value) { this.printMembers = value; }
}
