package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Results {
    private Channel channel;

    @JsonProperty("channel")
    public Channel getChannel() { return channel; }
    @JsonProperty("channel")
    public void setChannel(Channel value) { this.channel = value; }
}
