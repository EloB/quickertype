package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.time.LocalDate;
import java.time.OffsetDateTime;

public class Invoice {
    private OffsetDateTime createdAt;
    private LocalDate dueDate;
    private String name;

    @JsonProperty("createdAt")
    public OffsetDateTime getCreatedAt() { return createdAt; }
    @JsonProperty("createdAt")
    public void setCreatedAt(OffsetDateTime value) { this.createdAt = value; }

    @JsonProperty("dueDate")
    public LocalDate getDueDate() { return dueDate; }
    @JsonProperty("dueDate")
    public void setDueDate(LocalDate value) { this.dueDate = value; }

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }
}
