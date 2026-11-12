package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class LightParams {
    private String appID;
    private String outletID;
    private String rgba;

    @JsonProperty("app_id")
    public String getAppID() { return appID; }
    @JsonProperty("app_id")
    public void setAppID(String value) { this.appID = value; }

    @JsonProperty("outlet_id")
    public String getOutletID() { return outletID; }
    @JsonProperty("outlet_id")
    public void setOutletID(String value) { this.outletID = value; }

    @JsonProperty("rgba")
    public String getRGBA() { return rgba; }
    @JsonProperty("rgba")
    public void setRGBA(String value) { this.rgba = value; }
}
