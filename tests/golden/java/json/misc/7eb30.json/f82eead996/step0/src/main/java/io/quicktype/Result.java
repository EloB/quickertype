package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Result {
    private String code;
    private String english;
    private boolean fav;
    private Group group;
    private Location location;
    private long minScreens;
    private long numViews;
    private String showtimes;
    private long stars;
    private Tel tel;
    private String thai;
    private long todayScreens;
    private String url;
    private String website;

    @JsonProperty("code")
    public String getCode() { return code; }
    @JsonProperty("code")
    public void setCode(String value) { this.code = value; }

    @JsonProperty("english")
    public String getEnglish() { return english; }
    @JsonProperty("english")
    public void setEnglish(String value) { this.english = value; }

    @JsonProperty("fav")
    public boolean getFav() { return fav; }
    @JsonProperty("fav")
    public void setFav(boolean value) { this.fav = value; }

    @JsonProperty("group")
    public Group getGroup() { return group; }
    @JsonProperty("group")
    public void setGroup(Group value) { this.group = value; }

    @JsonProperty("location")
    public Location getLocation() { return location; }
    @JsonProperty("location")
    public void setLocation(Location value) { this.location = value; }

    @JsonProperty("min_screens")
    public long getMinScreens() { return minScreens; }
    @JsonProperty("min_screens")
    public void setMinScreens(long value) { this.minScreens = value; }

    @JsonProperty("num_views")
    public long getNumViews() { return numViews; }
    @JsonProperty("num_views")
    public void setNumViews(long value) { this.numViews = value; }

    @JsonProperty("showtimes")
    public String getShowtimes() { return showtimes; }
    @JsonProperty("showtimes")
    public void setShowtimes(String value) { this.showtimes = value; }

    @JsonProperty("stars")
    public long getStars() { return stars; }
    @JsonProperty("stars")
    public void setStars(long value) { this.stars = value; }

    @JsonProperty("tel")
    public Tel getTel() { return tel; }
    @JsonProperty("tel")
    public void setTel(Tel value) { this.tel = value; }

    @JsonProperty("thai")
    public String getThai() { return thai; }
    @JsonProperty("thai")
    public void setThai(String value) { this.thai = value; }

    @JsonProperty("today_screens")
    public long getTodayScreens() { return todayScreens; }
    @JsonProperty("today_screens")
    public void setTodayScreens(long value) { this.todayScreens = value; }

    @JsonProperty("url")
    public String getURL() { return url; }
    @JsonProperty("url")
    public void setURL(String value) { this.url = value; }

    @JsonProperty("website")
    public String getWebsite() { return website; }
    @JsonProperty("website")
    public void setWebsite(String value) { this.website = value; }
}
