package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Details {
    private String applicationid;
    private String applicationversion;
    private long code;
    private DateClass date;
    private long elapsedtime;
    private String message;
    private String status;

    @JsonProperty("applicationid")
    public String getApplicationid() { return applicationid; }
    @JsonProperty("applicationid")
    public void setApplicationid(String value) { this.applicationid = value; }

    @JsonProperty("applicationversion")
    public String getApplicationversion() { return applicationversion; }
    @JsonProperty("applicationversion")
    public void setApplicationversion(String value) { this.applicationversion = value; }

    @JsonProperty("code")
    public long getCode() { return code; }
    @JsonProperty("code")
    public void setCode(long value) { this.code = value; }

    @JsonProperty("date")
    public DateClass getDate() { return date; }
    @JsonProperty("date")
    public void setDate(DateClass value) { this.date = value; }

    @JsonProperty("elapsedtime")
    public long getElapsedtime() { return elapsedtime; }
    @JsonProperty("elapsedtime")
    public void setElapsedtime(long value) { this.elapsedtime = value; }

    @JsonProperty("message")
    public String getMessage() { return message; }
    @JsonProperty("message")
    public void setMessage(String value) { this.message = value; }

    @JsonProperty("status")
    public String getStatus() { return status; }
    @JsonProperty("status")
    public void setStatus(String value) { this.status = value; }
}
