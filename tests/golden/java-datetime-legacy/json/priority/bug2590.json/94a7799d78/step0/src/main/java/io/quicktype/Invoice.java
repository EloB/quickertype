package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.Date;

public class Invoice {
    private Date createdAt;
    private Date dueDate;
    private String name;

    @JsonProperty("createdAt")
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss.SSSX", timezone = "UTC")
    public Date getCreatedAt() { return createdAt; }
    @JsonProperty("createdAt")
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss.SSSX", timezone = "UTC")
    public void setCreatedAt(Date value) { this.createdAt = value; }

    @JsonProperty("dueDate")
    @JsonFormat(pattern = "yyyy-MM-dd")
    public Date getDueDate() { return dueDate; }
    @JsonProperty("dueDate")
    @JsonFormat(pattern = "yyyy-MM-dd")
    public void setDueDate(Date value) { this.dueDate = value; }

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }
}
