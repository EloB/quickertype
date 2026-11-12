package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class Query {
    private List<OrderBy> orderBys;

    @JsonProperty("orderBys")
    public List<OrderBy> getOrderBys() { return orderBys; }
    @JsonProperty("orderBys")
    public void setOrderBys(List<OrderBy> value) { this.orderBys = value; }
}
