package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Metadata {
    private double executionTime;
    private ResponseInfo responseInfo;
    private Resultset resultset;

    @JsonProperty("executionTime")
    public double getExecutionTime() { return executionTime; }
    @JsonProperty("executionTime")
    public void setExecutionTime(double value) { this.executionTime = value; }

    @JsonProperty("responseInfo")
    public ResponseInfo getResponseInfo() { return responseInfo; }
    @JsonProperty("responseInfo")
    public void setResponseInfo(ResponseInfo value) { this.responseInfo = value; }

    @JsonProperty("resultset")
    public Resultset getResultset() { return resultset; }
    @JsonProperty("resultset")
    public void setResultset(Resultset value) { this.resultset = value; }
}
