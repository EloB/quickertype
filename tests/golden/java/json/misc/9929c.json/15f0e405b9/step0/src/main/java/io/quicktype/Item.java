package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class Item {
    private Condition condition;
    private String description;
    private List<Forecast> forecast;
    private GUID guid;
    private String itemLong;
    private String lat;
    private String link;
    private String pubDate;
    private String title;

    @JsonProperty("condition")
    public Condition getCondition() { return condition; }
    @JsonProperty("condition")
    public void setCondition(Condition value) { this.condition = value; }

    @JsonProperty("description")
    public String getDescription() { return description; }
    @JsonProperty("description")
    public void setDescription(String value) { this.description = value; }

    @JsonProperty("forecast")
    public List<Forecast> getForecast() { return forecast; }
    @JsonProperty("forecast")
    public void setForecast(List<Forecast> value) { this.forecast = value; }

    @JsonProperty("guid")
    public GUID getGUID() { return guid; }
    @JsonProperty("guid")
    public void setGUID(GUID value) { this.guid = value; }

    @JsonProperty("long")
    public String getItemLong() { return itemLong; }
    @JsonProperty("long")
    public void setItemLong(String value) { this.itemLong = value; }

    @JsonProperty("lat")
    public String getLat() { return lat; }
    @JsonProperty("lat")
    public void setLat(String value) { this.lat = value; }

    @JsonProperty("link")
    public String getLink() { return link; }
    @JsonProperty("link")
    public void setLink(String value) { this.link = value; }

    @JsonProperty("pubDate")
    public String getPubDate() { return pubDate; }
    @JsonProperty("pubDate")
    public void setPubDate(String value) { this.pubDate = value; }

    @JsonProperty("title")
    public String getTitle() { return title; }
    @JsonProperty("title")
    public void setTitle(String value) { this.title = value; }
}
