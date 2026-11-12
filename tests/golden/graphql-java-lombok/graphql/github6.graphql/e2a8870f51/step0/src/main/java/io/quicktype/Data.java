package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Data {
    private UniformResourceLocatable resource;

    @JsonProperty("resource")
    public UniformResourceLocatable getResource() { return resource; }
    @JsonProperty("resource")
    public void setResource(UniformResourceLocatable value) { this.resource = value; }
}
