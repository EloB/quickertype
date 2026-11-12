package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class Item {
    private List<Artist> artists;
    private List<String> availableMarkets;
    private long discNumber;
    private long durationMS;
    private boolean explicit;
    private ExternalUrls externalUrls;
    private String href;
    private String id;
    private String name;
    private String previewURL;
    private long trackNumber;
    private String type;
    private String uri;

    @JsonProperty("artists")
    public List<Artist> getArtists() { return artists; }
    @JsonProperty("artists")
    public void setArtists(List<Artist> value) { this.artists = value; }

    @JsonProperty("available_markets")
    public List<String> getAvailableMarkets() { return availableMarkets; }
    @JsonProperty("available_markets")
    public void setAvailableMarkets(List<String> value) { this.availableMarkets = value; }

    @JsonProperty("disc_number")
    public long getDiscNumber() { return discNumber; }
    @JsonProperty("disc_number")
    public void setDiscNumber(long value) { this.discNumber = value; }

    @JsonProperty("duration_ms")
    public long getDurationMS() { return durationMS; }
    @JsonProperty("duration_ms")
    public void setDurationMS(long value) { this.durationMS = value; }

    @JsonProperty("explicit")
    public boolean getExplicit() { return explicit; }
    @JsonProperty("explicit")
    public void setExplicit(boolean value) { this.explicit = value; }

    @JsonProperty("external_urls")
    public ExternalUrls getExternalUrls() { return externalUrls; }
    @JsonProperty("external_urls")
    public void setExternalUrls(ExternalUrls value) { this.externalUrls = value; }

    @JsonProperty("href")
    public String getHref() { return href; }
    @JsonProperty("href")
    public void setHref(String value) { this.href = value; }

    @JsonProperty("id")
    public String getID() { return id; }
    @JsonProperty("id")
    public void setID(String value) { this.id = value; }

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }

    @JsonProperty("preview_url")
    public String getPreviewURL() { return previewURL; }
    @JsonProperty("preview_url")
    public void setPreviewURL(String value) { this.previewURL = value; }

    @JsonProperty("track_number")
    public long getTrackNumber() { return trackNumber; }
    @JsonProperty("track_number")
    public void setTrackNumber(long value) { this.trackNumber = value; }

    @JsonProperty("type")
    public String getType() { return type; }
    @JsonProperty("type")
    public void setType(String value) { this.type = value; }

    @JsonProperty("uri")
    public String getURI() { return uri; }
    @JsonProperty("uri")
    public void setURI(String value) { this.uri = value; }
}
