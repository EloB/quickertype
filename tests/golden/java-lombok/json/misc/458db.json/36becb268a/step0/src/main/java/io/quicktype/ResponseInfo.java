package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class ResponseInfo {
    private String developerMessage;
    private long status;

    @JsonProperty("developerMessage")
    public String getDeveloperMessage() { return developerMessage; }
    @JsonProperty("developerMessage")
    public void setDeveloperMessage(String value) { this.developerMessage = value; }

    @JsonProperty("status")
    public long getStatus() { return status; }
    @JsonProperty("status")
    public void setStatus(long value) { this.status = value; }
}
