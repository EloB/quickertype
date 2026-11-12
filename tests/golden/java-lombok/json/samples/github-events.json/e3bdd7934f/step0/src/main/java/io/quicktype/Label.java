package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Label {
    private String color;
    private long id;
    private boolean labelDefault;
    private String name;
    private String url;

    @JsonProperty("color")
    public String getColor() { return color; }
    @JsonProperty("color")
    public void setColor(String value) { this.color = value; }

    @JsonProperty("id")
    public long getID() { return id; }
    @JsonProperty("id")
    public void setID(long value) { this.id = value; }

    @JsonProperty("default")
    public boolean getLabelDefault() { return labelDefault; }
    @JsonProperty("default")
    public void setLabelDefault(boolean value) { this.labelDefault = value; }

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }

    @JsonProperty("url")
    public String getURL() { return url; }
    @JsonProperty("url")
    public void setURL(String value) { this.url = value; }
}
