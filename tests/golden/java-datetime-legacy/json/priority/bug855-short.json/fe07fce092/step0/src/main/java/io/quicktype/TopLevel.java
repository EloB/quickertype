package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private String channelID;
    private String channelName;
    private String code;
    private long emoticonSet;
    private long id;

    @JsonProperty("channel_id")
    public String getChannelID() { return channelID; }
    @JsonProperty("channel_id")
    public void setChannelID(String value) { this.channelID = value; }

    @JsonProperty("channel_name")
    public String getChannelName() { return channelName; }
    @JsonProperty("channel_name")
    public void setChannelName(String value) { this.channelName = value; }

    @JsonProperty("code")
    public String getCode() { return code; }
    @JsonProperty("code")
    public void setCode(String value) { this.code = value; }

    @JsonProperty("emoticon_set")
    public long getEmoticonSet() { return emoticonSet; }
    @JsonProperty("emoticon_set")
    public void setEmoticonSet(long value) { this.emoticonSet = value; }

    @JsonProperty("id")
    public long getID() { return id; }
    @JsonProperty("id")
    public void setID(long value) { this.id = value; }
}
