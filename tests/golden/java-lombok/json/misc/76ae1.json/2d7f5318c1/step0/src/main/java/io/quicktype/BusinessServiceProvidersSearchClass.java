package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class BusinessServiceProvidersSearchClass {
    private BusinessServiceProvidersSearchGet get;

    @JsonProperty("get")
    public BusinessServiceProvidersSearchGet getGet() { return get; }
    @JsonProperty("get")
    public void setGet(BusinessServiceProvidersSearchGet value) { this.get = value; }
}
