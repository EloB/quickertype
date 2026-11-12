package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Dictionary {
    private long dictionary;

    @JsonProperty("dictionary")
    public long getDictionary() { return dictionary; }
    @JsonProperty("dictionary")
    public void setDictionary(long value) { this.dictionary = value; }
}
