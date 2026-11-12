package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class FAQProperties {
    private Property answer;
    private Property countries;
    private Property firstPublishedDate;
    private Property id;
    private Property industries;
    private Property lastPublishedDate;
    private Property question;
    private Property topics;
    private Property tradeRegions;
    private Property url;
    private Property worldRegions;

    @JsonProperty("answer")
    public Property getAnswer() { return answer; }
    @JsonProperty("answer")
    public void setAnswer(Property value) { this.answer = value; }

    @JsonProperty("countries")
    public Property getCountries() { return countries; }
    @JsonProperty("countries")
    public void setCountries(Property value) { this.countries = value; }

    @JsonProperty("first_published_date")
    public Property getFirstPublishedDate() { return firstPublishedDate; }
    @JsonProperty("first_published_date")
    public void setFirstPublishedDate(Property value) { this.firstPublishedDate = value; }

    @JsonProperty("id")
    public Property getID() { return id; }
    @JsonProperty("id")
    public void setID(Property value) { this.id = value; }

    @JsonProperty("industries")
    public Property getIndustries() { return industries; }
    @JsonProperty("industries")
    public void setIndustries(Property value) { this.industries = value; }

    @JsonProperty("last_published_date")
    public Property getLastPublishedDate() { return lastPublishedDate; }
    @JsonProperty("last_published_date")
    public void setLastPublishedDate(Property value) { this.lastPublishedDate = value; }

    @JsonProperty("question")
    public Property getQuestion() { return question; }
    @JsonProperty("question")
    public void setQuestion(Property value) { this.question = value; }

    @JsonProperty("topics")
    public Property getTopics() { return topics; }
    @JsonProperty("topics")
    public void setTopics(Property value) { this.topics = value; }

    @JsonProperty("trade_regions")
    public Property getTradeRegions() { return tradeRegions; }
    @JsonProperty("trade_regions")
    public void setTradeRegions(Property value) { this.tradeRegions = value; }

    @JsonProperty("url")
    public Property getURL() { return url; }
    @JsonProperty("url")
    public void setURL(Property value) { this.url = value; }

    @JsonProperty("world_regions")
    public Property getWorldRegions() { return worldRegions; }
    @JsonProperty("world_regions")
    public void setWorldRegions(Property value) { this.worldRegions = value; }
}
