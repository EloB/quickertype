package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class YObjectLongStringsJSON {
    private String id;
    private List<X> x;

    @JsonProperty("id")
    public String getID() { return id; }
    @JsonProperty("id")
    public void setID(String value) { this.id = value; }

    @JsonProperty("x")
    public List<X> getX() { return x; }
    @JsonProperty("x")
    public void setX(List<X> value) { this.x = value; }
}
