package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private Category category;

    @JsonProperty("category")
    public Category getCategory() { return category; }
    @JsonProperty("category")
    public void setCategory(Category value) { this.category = value; }
}
