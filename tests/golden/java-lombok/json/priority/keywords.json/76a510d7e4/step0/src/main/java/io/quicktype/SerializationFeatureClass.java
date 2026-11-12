package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class SerializationFeatureClass {
    private long serializationFeature;

    @JsonProperty("SerializationFeature")
    public long getSerializationFeature() { return serializationFeature; }
    @JsonProperty("SerializationFeature")
    public void setSerializationFeature(long value) { this.serializationFeature = value; }
}
