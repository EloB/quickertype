package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private PC pc;
    private PC ps3;
    private PC ps4;
    private PC xbox;
    private PC xone;

    @JsonProperty("pc")
    public PC getPC() { return pc; }
    @JsonProperty("pc")
    public void setPC(PC value) { this.pc = value; }

    @JsonProperty("ps3")
    public PC getPs3() { return ps3; }
    @JsonProperty("ps3")
    public void setPs3(PC value) { this.ps3 = value; }

    @JsonProperty("ps4")
    public PC getPs4() { return ps4; }
    @JsonProperty("ps4")
    public void setPs4(PC value) { this.ps4 = value; }

    @JsonProperty("xbox")
    public PC getXbox() { return xbox; }
    @JsonProperty("xbox")
    public void setXbox(PC value) { this.xbox = value; }

    @JsonProperty("xone")
    public PC getXone() { return xone; }
    @JsonProperty("xone")
    public void setXone(PC value) { this.xone = value; }
}
