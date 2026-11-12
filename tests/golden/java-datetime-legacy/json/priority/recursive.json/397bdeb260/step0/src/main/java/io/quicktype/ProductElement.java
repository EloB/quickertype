package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class ProductElement {
    private ProductProduct product;

    @JsonProperty("product")
    public ProductProduct getProduct() { return product; }
    @JsonProperty("product")
    public void setProduct(ProductProduct value) { this.product = value; }
}
