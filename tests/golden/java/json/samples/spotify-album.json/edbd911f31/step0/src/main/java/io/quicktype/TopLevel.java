package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class TopLevel {
    private String albumType;
    private List<Artist> artists;
    private List<String> availableMarkets;
    private List<Copyright> copyrights;
    private ExternalIDS externalIDS;
    private ExternalUrls externalUrls;
    private List<Object> genres;
    private String href;
    private String id;
    private List<Image> images;
    private String name;
    private long popularity;
    private String releaseDate;
    private String releaseDatePrecision;
    private Tracks tracks;
    private String type;
    private String uri;

    @JsonProperty("album_type")
    public String getAlbumType() { return albumType; }
    @JsonProperty("album_type")
    public void setAlbumType(String value) { this.albumType = value; }

    @JsonProperty("artists")
    public List<Artist> getArtists() { return artists; }
    @JsonProperty("artists")
    public void setArtists(List<Artist> value) { this.artists = value; }

    @JsonProperty("available_markets")
    public List<String> getAvailableMarkets() { return availableMarkets; }
    @JsonProperty("available_markets")
    public void setAvailableMarkets(List<String> value) { this.availableMarkets = value; }

    @JsonProperty("copyrights")
    public List<Copyright> getCopyrights() { return copyrights; }
    @JsonProperty("copyrights")
    public void setCopyrights(List<Copyright> value) { this.copyrights = value; }

    @JsonProperty("external_ids")
    public ExternalIDS getExternalIDS() { return externalIDS; }
    @JsonProperty("external_ids")
    public void setExternalIDS(ExternalIDS value) { this.externalIDS = value; }

    @JsonProperty("external_urls")
    public ExternalUrls getExternalUrls() { return externalUrls; }
    @JsonProperty("external_urls")
    public void setExternalUrls(ExternalUrls value) { this.externalUrls = value; }

    @JsonProperty("genres")
    public List<Object> getGenres() { return genres; }
    @JsonProperty("genres")
    public void setGenres(List<Object> value) { this.genres = value; }

    @JsonProperty("href")
    public String getHref() { return href; }
    @JsonProperty("href")
    public void setHref(String value) { this.href = value; }

    @JsonProperty("id")
    public String getID() { return id; }
    @JsonProperty("id")
    public void setID(String value) { this.id = value; }

    @JsonProperty("images")
    public List<Image> getImages() { return images; }
    @JsonProperty("images")
    public void setImages(List<Image> value) { this.images = value; }

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }

    @JsonProperty("popularity")
    public long getPopularity() { return popularity; }
    @JsonProperty("popularity")
    public void setPopularity(long value) { this.popularity = value; }

    @JsonProperty("release_date")
    public String getReleaseDate() { return releaseDate; }
    @JsonProperty("release_date")
    public void setReleaseDate(String value) { this.releaseDate = value; }

    @JsonProperty("release_date_precision")
    public String getReleaseDatePrecision() { return releaseDatePrecision; }
    @JsonProperty("release_date_precision")
    public void setReleaseDatePrecision(String value) { this.releaseDatePrecision = value; }

    @JsonProperty("tracks")
    public Tracks getTracks() { return tracks; }
    @JsonProperty("tracks")
    public void setTracks(Tracks value) { this.tracks = value; }

    @JsonProperty("type")
    public String getType() { return type; }
    @JsonProperty("type")
    public void setType(String value) { this.type = value; }

    @JsonProperty("uri")
    public String getURI() { return uri; }
    @JsonProperty("uri")
    public void setURI(String value) { this.uri = value; }
}
