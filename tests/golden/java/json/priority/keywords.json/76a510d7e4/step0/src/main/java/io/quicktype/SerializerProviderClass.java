package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class SerializerProviderClass {
    private long serializerProvider;

    @JsonProperty("SerializerProvider")
    public long getSerializerProvider() { return serializerProvider; }
    @JsonProperty("SerializerProvider")
    public void setSerializerProvider(long value) { this.serializerProvider = value; }
}
