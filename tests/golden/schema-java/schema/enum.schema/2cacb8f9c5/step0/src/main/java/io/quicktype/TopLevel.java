package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class TopLevel {
    private List<Arr> arr;
    private String topLevelFor;
    private Gve gve;
    private Lvc lvc;
    private List<OtherArr> otherArr;

    @JsonProperty("arr")
    public List<Arr> getArr() { return arr; }
    @JsonProperty("arr")
    public void setArr(List<Arr> value) { this.arr = value; }

    @JsonProperty("for")
    public String getTopLevelFor() { return topLevelFor; }
    @JsonProperty("for")
    public void setTopLevelFor(String value) { this.topLevelFor = value; }

    @JsonProperty("gve")
    public Gve getGve() { return gve; }
    @JsonProperty("gve")
    public void setGve(Gve value) { this.gve = value; }

    @JsonProperty("lvc")
    public Lvc getLvc() { return lvc; }
    @JsonProperty("lvc")
    public void setLvc(Lvc value) { this.lvc = value; }

    @JsonProperty("otherArr")
    public List<OtherArr> getOtherArr() { return otherArr; }
    @JsonProperty("otherArr")
    public void setOtherArr(List<OtherArr> value) { this.otherArr = value; }
}
