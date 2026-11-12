package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Input {
    private Out prevOut;
    private String script;
    private long sequence;

    @JsonProperty("prev_out")
    public Out getPrevOut() { return prevOut; }
    @JsonProperty("prev_out")
    public void setPrevOut(Out value) { this.prevOut = value; }

    @JsonProperty("script")
    public String getScript() { return script; }
    @JsonProperty("script")
    public void setScript(String value) { this.script = value; }

    @JsonProperty("sequence")
    public long getSequence() { return sequence; }
    @JsonProperty("sequence")
    public void setSequence(long value) { this.sequence = value; }
}
