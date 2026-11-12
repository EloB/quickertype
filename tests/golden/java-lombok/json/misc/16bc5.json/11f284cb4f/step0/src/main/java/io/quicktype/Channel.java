package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Channel {
    private Astronomy astronomy;
    private Atmosphere atmosphere;
    private String description;
    private Image image;
    private Item item;
    private String language;
    private String lastBuildDate;
    private String link;
    private Location location;
    private String title;
    private String ttl;
    private Units units;
    private Wind wind;

    @JsonProperty("astronomy")
    public Astronomy getAstronomy() { return astronomy; }
    @JsonProperty("astronomy")
    public void setAstronomy(Astronomy value) { this.astronomy = value; }

    @JsonProperty("atmosphere")
    public Atmosphere getAtmosphere() { return atmosphere; }
    @JsonProperty("atmosphere")
    public void setAtmosphere(Atmosphere value) { this.atmosphere = value; }

    @JsonProperty("description")
    public String getDescription() { return description; }
    @JsonProperty("description")
    public void setDescription(String value) { this.description = value; }

    @JsonProperty("image")
    public Image getImage() { return image; }
    @JsonProperty("image")
    public void setImage(Image value) { this.image = value; }

    @JsonProperty("item")
    public Item getItem() { return item; }
    @JsonProperty("item")
    public void setItem(Item value) { this.item = value; }

    @JsonProperty("language")
    public String getLanguage() { return language; }
    @JsonProperty("language")
    public void setLanguage(String value) { this.language = value; }

    @JsonProperty("lastBuildDate")
    public String getLastBuildDate() { return lastBuildDate; }
    @JsonProperty("lastBuildDate")
    public void setLastBuildDate(String value) { this.lastBuildDate = value; }

    @JsonProperty("link")
    public String getLink() { return link; }
    @JsonProperty("link")
    public void setLink(String value) { this.link = value; }

    @JsonProperty("location")
    public Location getLocation() { return location; }
    @JsonProperty("location")
    public void setLocation(Location value) { this.location = value; }

    @JsonProperty("title")
    public String getTitle() { return title; }
    @JsonProperty("title")
    public void setTitle(String value) { this.title = value; }

    @JsonProperty("ttl")
    public String getTTL() { return ttl; }
    @JsonProperty("ttl")
    public void setTTL(String value) { this.ttl = value; }

    @JsonProperty("units")
    public Units getUnits() { return units; }
    @JsonProperty("units")
    public void setUnits(Units value) { this.units = value; }

    @JsonProperty("wind")
    public Wind getWind() { return wind; }
    @JsonProperty("wind")
    public void setWind(Wind value) { this.wind = value; }
}
