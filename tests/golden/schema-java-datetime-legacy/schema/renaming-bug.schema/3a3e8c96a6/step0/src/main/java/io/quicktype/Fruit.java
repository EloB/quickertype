package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class Fruit {
    private Boolean apple;
    private List<Berry> berries;
    private Boolean orange;

    @JsonProperty("apple")
    public Boolean getApple() { return apple; }
    @JsonProperty("apple")
    public void setApple(Boolean value) { this.apple = value; }

    @JsonProperty("berries")
    public List<Berry> getBerries() { return berries; }
    @JsonProperty("berries")
    public void setBerries(List<Berry> value) { this.berries = value; }

    @JsonProperty("orange")
    public Boolean getOrange() { return orange; }
    @JsonProperty("orange")
    public void setOrange(Boolean value) { this.orange = value; }
}
