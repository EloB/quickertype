package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class TopLevel {
    private List<Invoice> invoices;

    @JsonProperty("invoices")
    public List<Invoice> getInvoices() { return invoices; }
    @JsonProperty("invoices")
    public void setInvoices(List<Invoice> value) { this.invoices = value; }
}
