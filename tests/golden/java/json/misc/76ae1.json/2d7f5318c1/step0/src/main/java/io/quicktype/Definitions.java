package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Definitions {
    private Article article;
    private Article center;
    private DeMinimis deMinimis;
    private Article event;
    private FAQ faq;
    private Article lead;
    private Article list;
    private Article marketIntelligence;
    private Article office;
    private Article provider;
    private Article rate;
    private Report report;
    private Taxonomy taxonomy;

    @JsonProperty("Article")
    public Article getArticle() { return article; }
    @JsonProperty("Article")
    public void setArticle(Article value) { this.article = value; }

    @JsonProperty("Center")
    public Article getCenter() { return center; }
    @JsonProperty("Center")
    public void setCenter(Article value) { this.center = value; }

    @JsonProperty("DeMinimis")
    public DeMinimis getDeMinimis() { return deMinimis; }
    @JsonProperty("DeMinimis")
    public void setDeMinimis(DeMinimis value) { this.deMinimis = value; }

    @JsonProperty("Event")
    public Article getEvent() { return event; }
    @JsonProperty("Event")
    public void setEvent(Article value) { this.event = value; }

    @JsonProperty("FAQ")
    public FAQ getFAQ() { return faq; }
    @JsonProperty("FAQ")
    public void setFAQ(FAQ value) { this.faq = value; }

    @JsonProperty("Lead")
    public Article getLead() { return lead; }
    @JsonProperty("Lead")
    public void setLead(Article value) { this.lead = value; }

    @JsonProperty("List")
    public Article getList() { return list; }
    @JsonProperty("List")
    public void setList(Article value) { this.list = value; }

    @JsonProperty("MarketIntelligence")
    public Article getMarketIntelligence() { return marketIntelligence; }
    @JsonProperty("MarketIntelligence")
    public void setMarketIntelligence(Article value) { this.marketIntelligence = value; }

    @JsonProperty("Office")
    public Article getOffice() { return office; }
    @JsonProperty("Office")
    public void setOffice(Article value) { this.office = value; }

    @JsonProperty("Provider")
    public Article getProvider() { return provider; }
    @JsonProperty("Provider")
    public void setProvider(Article value) { this.provider = value; }

    @JsonProperty("Rate")
    public Article getRate() { return rate; }
    @JsonProperty("Rate")
    public void setRate(Article value) { this.rate = value; }

    @JsonProperty("Report")
    public Report getReport() { return report; }
    @JsonProperty("Report")
    public void setReport(Report value) { this.report = value; }

    @JsonProperty("Taxonomy")
    public Taxonomy getTaxonomy() { return taxonomy; }
    @JsonProperty("Taxonomy")
    public void setTaxonomy(Taxonomy value) { this.taxonomy = value; }
}
