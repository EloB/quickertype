package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Image {
    private long favs;
    private long id;
    private String thumbnail;
    private Type type;
    private String url;

    @JsonProperty("favs")
    public long getFavs() { return favs; }
    @JsonProperty("favs")
    public void setFavs(long value) { this.favs = value; }

    @JsonProperty("id")
    public long getID() { return id; }
    @JsonProperty("id")
    public void setID(long value) { this.id = value; }

    @JsonProperty("thumbnail")
    public String getThumbnail() { return thumbnail; }
    @JsonProperty("thumbnail")
    public void setThumbnail(String value) { this.thumbnail = value; }

    @JsonProperty("type")
    public Type getType() { return type; }
    @JsonProperty("type")
    public void setType(Type value) { this.type = value; }

    @JsonProperty("url")
    public String getURL() { return url; }
    @JsonProperty("url")
    public void setURL(String value) { this.url = value; }
}
