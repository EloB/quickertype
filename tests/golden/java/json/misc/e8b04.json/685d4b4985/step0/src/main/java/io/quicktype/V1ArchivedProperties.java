package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class V1ArchivedProperties {
    private AccessPoints accessPoints;
    private String blistID;
    private V1ArchivedPropertiesRenderTypeConfig renderTypeConfig;

    @JsonProperty("accessPoints")
    public AccessPoints getAccessPoints() { return accessPoints; }
    @JsonProperty("accessPoints")
    public void setAccessPoints(AccessPoints value) { this.accessPoints = value; }

    @JsonProperty("blist_id")
    public String getBlistID() { return blistID; }
    @JsonProperty("blist_id")
    public void setBlistID(String value) { this.blistID = value; }

    @JsonProperty("renderTypeConfig")
    public V1ArchivedPropertiesRenderTypeConfig getRenderTypeConfig() { return renderTypeConfig; }
    @JsonProperty("renderTypeConfig")
    public void setRenderTypeConfig(V1ArchivedPropertiesRenderTypeConfig value) { this.renderTypeConfig = value; }
}
