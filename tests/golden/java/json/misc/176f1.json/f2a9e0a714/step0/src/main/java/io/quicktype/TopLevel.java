package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class TopLevel {
    private List<Object> message;
    private long responseTime;
    private Results results;
    private String status;

    @JsonProperty("message")
    public List<Object> getMessage() { return message; }
    @JsonProperty("message")
    public void setMessage(List<Object> value) { this.message = value; }

    @JsonProperty("responseTime")
    public long getResponseTime() { return responseTime; }
    @JsonProperty("responseTime")
    public void setResponseTime(long value) { this.responseTime = value; }

    @JsonProperty("Results")
    public Results getResults() { return results; }
    @JsonProperty("Results")
    public void setResults(Results value) { this.results = value; }

    @JsonProperty("status")
    public String getStatus() { return status; }
    @JsonProperty("status")
    public void setStatus(String value) { this.status = value; }
}
