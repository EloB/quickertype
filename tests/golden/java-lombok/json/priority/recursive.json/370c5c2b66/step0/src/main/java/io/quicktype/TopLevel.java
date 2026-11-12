package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class TopLevel {
    private Category category;
    private Details details;
    private String match;
    private long page;
    private List<ProductElement> product;
    private boolean schk;
    private long totallooseoffers;
    private long totalpages;
    private long totalresultsavailable;
    private long totalresultsreturned;

    @JsonProperty("category")
    public Category getCategory() { return category; }
    @JsonProperty("category")
    public void setCategory(Category value) { this.category = value; }

    @JsonProperty("details")
    public Details getDetails() { return details; }
    @JsonProperty("details")
    public void setDetails(Details value) { this.details = value; }

    @JsonProperty("match")
    public String getMatch() { return match; }
    @JsonProperty("match")
    public void setMatch(String value) { this.match = value; }

    @JsonProperty("page")
    public long getPage() { return page; }
    @JsonProperty("page")
    public void setPage(long value) { this.page = value; }

    @JsonProperty("product")
    public List<ProductElement> getProduct() { return product; }
    @JsonProperty("product")
    public void setProduct(List<ProductElement> value) { this.product = value; }

    @JsonProperty("schk")
    public boolean getSchk() { return schk; }
    @JsonProperty("schk")
    public void setSchk(boolean value) { this.schk = value; }

    @JsonProperty("totallooseoffers")
    public long getTotallooseoffers() { return totallooseoffers; }
    @JsonProperty("totallooseoffers")
    public void setTotallooseoffers(long value) { this.totallooseoffers = value; }

    @JsonProperty("totalpages")
    public long getTotalpages() { return totalpages; }
    @JsonProperty("totalpages")
    public void setTotalpages(long value) { this.totalpages = value; }

    @JsonProperty("totalresultsavailable")
    public long getTotalresultsavailable() { return totalresultsavailable; }
    @JsonProperty("totalresultsavailable")
    public void setTotalresultsavailable(long value) { this.totalresultsavailable = value; }

    @JsonProperty("totalresultsreturned")
    public long getTotalresultsreturned() { return totalresultsreturned; }
    @JsonProperty("totalresultsreturned")
    public void setTotalresultsreturned(long value) { this.totalresultsreturned = value; }
}
