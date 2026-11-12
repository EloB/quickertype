package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Meta {
    private String msg;
    private String responseID;
    private long status;

    @JsonProperty("msg")
    public String getMsg() { return msg; }
    @JsonProperty("msg")
    public void setMsg(String value) { this.msg = value; }

    @JsonProperty("response_id")
    public String getResponseID() { return responseID; }
    @JsonProperty("response_id")
    public void setResponseID(String value) { this.responseID = value; }

    @JsonProperty("status")
    public long getStatus() { return status; }
    @JsonProperty("status")
    public void setStatus(long value) { this.status = value; }
}
