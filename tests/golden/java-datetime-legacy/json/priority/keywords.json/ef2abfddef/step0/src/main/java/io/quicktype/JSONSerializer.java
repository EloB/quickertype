package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class JSONSerializer {
    private long jsonSerializer;

    @JsonProperty("json_serializer")
    public long getJSONSerializer() { return jsonSerializer; }
    @JsonProperty("json_serializer")
    public void setJSONSerializer(long value) { this.jsonSerializer = value; }
}
