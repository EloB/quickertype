package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class MetadataPropertyHandling {
    private long metadataPropertyHandling;

    @JsonProperty("metadata_property_handling")
    public long getMetadataPropertyHandling() { return metadataPropertyHandling; }
    @JsonProperty("metadata_property_handling")
    public void setMetadataPropertyHandling(long value) { this.metadataPropertyHandling = value; }
}
