package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.Date;

public class Item {
    private Address address;
    private Date createdAt;
    private String name;
    private Long sex;

    @JsonProperty("address")
    public Address getAddress() { return address; }
    @JsonProperty("address")
    public void setAddress(Address value) { this.address = value; }

    @JsonProperty("created_at")
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss.SSSX", timezone = "UTC")
    public Date getCreatedAt() { return createdAt; }
    @JsonProperty("created_at")
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss.SSSX", timezone = "UTC")
    public void setCreatedAt(Date value) { this.createdAt = value; }

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }

    @JsonProperty("sex")
    public Long getSex() { return sex; }
    @JsonProperty("sex")
    public void setSex(Long value) { this.sex = value; }
}
