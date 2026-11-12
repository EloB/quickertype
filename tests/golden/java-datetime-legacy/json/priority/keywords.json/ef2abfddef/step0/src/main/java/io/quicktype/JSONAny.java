package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class JSONAny {
    private Object jsonAny;

    @JsonProperty("JSONAny")
    public Object getJSONAny() { return jsonAny; }
    @JsonProperty("JSONAny")
    public void setJSONAny(Object value) { this.jsonAny = value; }
}
