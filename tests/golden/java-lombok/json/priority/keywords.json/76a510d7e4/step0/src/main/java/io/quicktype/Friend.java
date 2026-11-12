package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Friend {
    private long friend;

    @JsonProperty("friend")
    public long getFriend() { return friend; }
    @JsonProperty("friend")
    public void setFriend(long value) { this.friend = value; }
}
