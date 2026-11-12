package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class TopLevel {
    private String id;
    private List<Identifier> identifiers;
    private List<String> keywords;
    private List<Link> links;
    private String name;
    private List<Object> otherNames;
    private Object supersededBy;
    private List<Text> text;

    @JsonProperty("id")
    public String getID() { return id; }
    @JsonProperty("id")
    public void setID(String value) { this.id = value; }

    @JsonProperty("identifiers")
    public List<Identifier> getIdentifiers() { return identifiers; }
    @JsonProperty("identifiers")
    public void setIdentifiers(List<Identifier> value) { this.identifiers = value; }

    @JsonProperty("keywords")
    public List<String> getKeywords() { return keywords; }
    @JsonProperty("keywords")
    public void setKeywords(List<String> value) { this.keywords = value; }

    @JsonProperty("links")
    public List<Link> getLinks() { return links; }
    @JsonProperty("links")
    public void setLinks(List<Link> value) { this.links = value; }

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }

    @JsonProperty("other_names")
    public List<Object> getOtherNames() { return otherNames; }
    @JsonProperty("other_names")
    public void setOtherNames(List<Object> value) { this.otherNames = value; }

    @JsonProperty("superseded_by")
    public Object getSupersededBy() { return supersededBy; }
    @JsonProperty("superseded_by")
    public void setSupersededBy(Object value) { this.supersededBy = value; }

    @JsonProperty("text")
    public List<Text> getText() { return text; }
    @JsonProperty("text")
    public void setText(List<Text> value) { this.text = value; }
}
