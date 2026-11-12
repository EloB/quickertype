package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class YObjectEmptyKeyJSON {
    private long empty;

    @JsonAnyGetter
    public java.util.Map<String, Object> getEmpty() { return java.util.Collections.<String, Object>singletonMap("", empty); }
    @JsonAnySetter
    public void setEmpty(String key, long value) { if (key.isEmpty()) this.empty = value; }
}
