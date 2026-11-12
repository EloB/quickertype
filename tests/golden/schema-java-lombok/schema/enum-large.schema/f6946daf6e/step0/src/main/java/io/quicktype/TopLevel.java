package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private Callsign callsign;
    private Priority priority;

    @JsonProperty("callsign")
    public Callsign getCallsign() { return callsign; }
    @JsonProperty("callsign")
    public void setCallsign(Callsign value) { this.callsign = value; }

    @JsonProperty("priority")
    public Priority getPriority() { return priority; }
    @JsonProperty("priority")
    public void setPriority(Priority value) { this.priority = value; }
}
