package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class ProductProduct {
    private long categoryid;
    private Currency currency;
    private boolean eco;
    private boolean fulldescription;
    private boolean hasmetasearch;
    private long id;
    private List<LinkElement> links;
    private long numoffers;
    private String pricemax;
    private String pricemin;
    private String productname;
    private long quantity;
    private Rating rating;
    private Specification specification;
    private FormatsClass thumbnail;
    private long totalsellers;

    @JsonProperty("categoryid")
    public long getCategoryid() { return categoryid; }
    @JsonProperty("categoryid")
    public void setCategoryid(long value) { this.categoryid = value; }

    @JsonProperty("currency")
    public Currency getCurrency() { return currency; }
    @JsonProperty("currency")
    public void setCurrency(Currency value) { this.currency = value; }

    @JsonProperty("eco")
    public boolean getEco() { return eco; }
    @JsonProperty("eco")
    public void setEco(boolean value) { this.eco = value; }

    @JsonProperty("fulldescription")
    public boolean getFulldescription() { return fulldescription; }
    @JsonProperty("fulldescription")
    public void setFulldescription(boolean value) { this.fulldescription = value; }

    @JsonProperty("hasmetasearch")
    public boolean getHasmetasearch() { return hasmetasearch; }
    @JsonProperty("hasmetasearch")
    public void setHasmetasearch(boolean value) { this.hasmetasearch = value; }

    @JsonProperty("id")
    public long getID() { return id; }
    @JsonProperty("id")
    public void setID(long value) { this.id = value; }

    @JsonProperty("links")
    public List<LinkElement> getLinks() { return links; }
    @JsonProperty("links")
    public void setLinks(List<LinkElement> value) { this.links = value; }

    @JsonProperty("numoffers")
    public long getNumoffers() { return numoffers; }
    @JsonProperty("numoffers")
    public void setNumoffers(long value) { this.numoffers = value; }

    @JsonProperty("pricemax")
    public String getPricemax() { return pricemax; }
    @JsonProperty("pricemax")
    public void setPricemax(String value) { this.pricemax = value; }

    @JsonProperty("pricemin")
    public String getPricemin() { return pricemin; }
    @JsonProperty("pricemin")
    public void setPricemin(String value) { this.pricemin = value; }

    @JsonProperty("productname")
    public String getProductname() { return productname; }
    @JsonProperty("productname")
    public void setProductname(String value) { this.productname = value; }

    @JsonProperty("quantity")
    public long getQuantity() { return quantity; }
    @JsonProperty("quantity")
    public void setQuantity(long value) { this.quantity = value; }

    @JsonProperty("rating")
    public Rating getRating() { return rating; }
    @JsonProperty("rating")
    public void setRating(Rating value) { this.rating = value; }

    @JsonProperty("specification")
    public Specification getSpecification() { return specification; }
    @JsonProperty("specification")
    public void setSpecification(Specification value) { this.specification = value; }

    @JsonProperty("thumbnail")
    public FormatsClass getThumbnail() { return thumbnail; }
    @JsonProperty("thumbnail")
    public void setThumbnail(FormatsClass value) { this.thumbnail = value; }

    @JsonProperty("totalsellers")
    public long getTotalsellers() { return totalsellers; }
    @JsonProperty("totalsellers")
    public void setTotalsellers(long value) { this.totalsellers = value; }
}
