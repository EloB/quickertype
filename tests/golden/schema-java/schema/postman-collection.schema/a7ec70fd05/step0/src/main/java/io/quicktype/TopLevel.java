package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

/**
 * Postman collection
 */
public class TopLevel {
    private List<TopLevel> item;
    private String name;
    private List<Response> response;

    @JsonProperty("item")
    public List<TopLevel> getItem() { return item; }
    @JsonProperty("item")
    public void setItem(List<TopLevel> value) { this.item = value; }

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }

    @JsonProperty("response")
    public List<Response> getResponse() { return response; }
    @JsonProperty("response")
    public void setResponse(List<Response> value) { this.response = value; }
}
