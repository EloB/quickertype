package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class ObjectMapperClass {
    private long objectMapper;

    @JsonProperty("ObjectMapper")
    public long getObjectMapper() { return objectMapper; }
    @JsonProperty("ObjectMapper")
    public void setObjectMapper(long value) { this.objectMapper = value; }
}
