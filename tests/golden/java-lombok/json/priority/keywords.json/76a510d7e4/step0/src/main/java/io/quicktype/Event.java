package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Event {
    private long event;

    @JsonProperty("event")
    public long getEvent() { return event; }
    @JsonProperty("event")
    public void setEvent(long value) { this.event = value; }
}
