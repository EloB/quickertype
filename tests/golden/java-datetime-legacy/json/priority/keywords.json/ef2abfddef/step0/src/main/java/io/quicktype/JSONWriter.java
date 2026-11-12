package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class JSONWriter {
    private long jsonWriter;

    @JsonProperty("json_writer")
    public long getJSONWriter() { return jsonWriter; }
    @JsonProperty("json_writer")
    public void setJSONWriter(long value) { this.jsonWriter = value; }
}
