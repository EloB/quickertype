package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private String empty;
    private String purpleX;
    private String topLevel;
    private String topLevelContinue;
    private String topLevelNull;
    private String topLevelX;
    private String undefined;
    private String x;
    private String xY;

    @JsonAnyGetter
    public java.util.Map<String, Object> getEmpty() { return java.util.Collections.<String, Object>singletonMap("", empty); }
    @JsonAnySetter
    public void setEmpty(String key, String value) { if (key.isEmpty()) this.empty = value; }

    @JsonProperty("x'")
    public String getPurpleX() { return purpleX; }
    @JsonProperty("x'")
    public void setPurpleX(String value) { this.purpleX = value; }

    @JsonProperty("{}")
    public String getTopLevel() { return topLevel; }
    @JsonProperty("{}")
    public void setTopLevel(String value) { this.topLevel = value; }

    @JsonProperty("continue")
    public String getTopLevelContinue() { return topLevelContinue; }
    @JsonProperty("continue")
    public void setTopLevelContinue(String value) { this.topLevelContinue = value; }

    @JsonProperty("null")
    public String getTopLevelNull() { return topLevelNull; }
    @JsonProperty("null")
    public void setTopLevelNull(String value) { this.topLevelNull = value; }

    @JsonProperty("x\"")
    public String getTopLevelX() { return topLevelX; }
    @JsonProperty("x\"")
    public void setTopLevelX(String value) { this.topLevelX = value; }

    @JsonProperty("undefined")
    public String getUndefined() { return undefined; }
    @JsonProperty("undefined")
    public void setUndefined(String value) { this.undefined = value; }

    @JsonProperty("x")
    public String getX() { return x; }
    @JsonProperty("x")
    public void setX(String value) { this.x = value; }

    @JsonProperty("x y")
    public String getXY() { return xY; }
    @JsonProperty("x y")
    public void setXY(String value) { this.xY = value; }
}
