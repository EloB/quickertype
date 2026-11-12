package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class DeserializationFeatureClass {
    private long deserializationFeature;

    @JsonProperty("DeserializationFeature")
    public long getDeserializationFeature() { return deserializationFeature; }
    @JsonProperty("DeserializationFeature")
    public void setDeserializationFeature(long value) { this.deserializationFeature = value; }
}
