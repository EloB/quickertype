package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private Response response;

    @JsonProperty("response")
    public Response getResponse() { return response; }
    @JsonProperty("response")
    public void setResponse(Response value) { this.response = value; }
}
