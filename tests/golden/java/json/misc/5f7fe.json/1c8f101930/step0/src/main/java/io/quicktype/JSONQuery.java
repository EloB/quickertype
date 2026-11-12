package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class JSONQuery {
    private List<Order> order;

    @JsonProperty("order")
    public List<Order> getOrder() { return order; }
    @JsonProperty("order")
    public void setOrder(List<Order> value) { this.order = value; }
}
