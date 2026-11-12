package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private long copyWith;
    private String name;

    @JsonProperty("copyWith")
    public long getCopyWith() { return copyWith; }
    @JsonProperty("copyWith")
    public void setCopyWith(long value) { this.copyWith = value; }

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }
}
