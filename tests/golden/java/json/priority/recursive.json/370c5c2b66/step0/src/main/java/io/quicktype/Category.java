package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class Category {
    private boolean concatenatecategoryname;
    private boolean hasoffer;
    private long id;
    private boolean isfinal;
    private List<LinkElement> links;
    private String name;
    private long parentcategoryid;
    private CategoryThumbnail thumbnail;

    @JsonProperty("concatenatecategoryname")
    public boolean getConcatenatecategoryname() { return concatenatecategoryname; }
    @JsonProperty("concatenatecategoryname")
    public void setConcatenatecategoryname(boolean value) { this.concatenatecategoryname = value; }

    @JsonProperty("hasoffer")
    public boolean getHasoffer() { return hasoffer; }
    @JsonProperty("hasoffer")
    public void setHasoffer(boolean value) { this.hasoffer = value; }

    @JsonProperty("id")
    public long getID() { return id; }
    @JsonProperty("id")
    public void setID(long value) { this.id = value; }

    @JsonProperty("isfinal")
    public boolean getIsfinal() { return isfinal; }
    @JsonProperty("isfinal")
    public void setIsfinal(boolean value) { this.isfinal = value; }

    @JsonProperty("links")
    public List<LinkElement> getLinks() { return links; }
    @JsonProperty("links")
    public void setLinks(List<LinkElement> value) { this.links = value; }

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }

    @JsonProperty("parentcategoryid")
    public long getParentcategoryid() { return parentcategoryid; }
    @JsonProperty("parentcategoryid")
    public void setParentcategoryid(long value) { this.parentcategoryid = value; }

    @JsonProperty("thumbnail")
    public CategoryThumbnail getThumbnail() { return thumbnail; }
    @JsonProperty("thumbnail")
    public void setThumbnail(CategoryThumbnail value) { this.thumbnail = value; }
}
