package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.time.OffsetDateTime;

public class TopLevel {
    private String computedRegionCbhkFwbd;
    private String computedRegionNnqa25F4;
    private Fall fall;
    private Geolocation geolocation;
    private String id;
    private String mass;
    private String name;
    private Nametype nametype;
    private String recclass;
    private String reclat;
    private String reclong;
    private OffsetDateTime year;

    @JsonProperty(":@computed_region_cbhk_fwbd")
    public String getComputedRegionCbhkFwbd() { return computedRegionCbhkFwbd; }
    @JsonProperty(":@computed_region_cbhk_fwbd")
    public void setComputedRegionCbhkFwbd(String value) { this.computedRegionCbhkFwbd = value; }

    @JsonProperty(":@computed_region_nnqa_25f4")
    public String getComputedRegionNnqa25F4() { return computedRegionNnqa25F4; }
    @JsonProperty(":@computed_region_nnqa_25f4")
    public void setComputedRegionNnqa25F4(String value) { this.computedRegionNnqa25F4 = value; }

    @JsonProperty("fall")
    public Fall getFall() { return fall; }
    @JsonProperty("fall")
    public void setFall(Fall value) { this.fall = value; }

    @JsonProperty("geolocation")
    public Geolocation getGeolocation() { return geolocation; }
    @JsonProperty("geolocation")
    public void setGeolocation(Geolocation value) { this.geolocation = value; }

    @JsonProperty("id")
    public String getID() { return id; }
    @JsonProperty("id")
    public void setID(String value) { this.id = value; }

    @JsonProperty("mass")
    public String getMass() { return mass; }
    @JsonProperty("mass")
    public void setMass(String value) { this.mass = value; }

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }

    @JsonProperty("nametype")
    public Nametype getNametype() { return nametype; }
    @JsonProperty("nametype")
    public void setNametype(Nametype value) { this.nametype = value; }

    @JsonProperty("recclass")
    public String getRecclass() { return recclass; }
    @JsonProperty("recclass")
    public void setRecclass(String value) { this.recclass = value; }

    @JsonProperty("reclat")
    public String getReclat() { return reclat; }
    @JsonProperty("reclat")
    public void setReclat(String value) { this.reclat = value; }

    @JsonProperty("reclong")
    public String getReclong() { return reclong; }
    @JsonProperty("reclong")
    public void setReclong(String value) { this.reclong = value; }

    @JsonProperty("year")
    public OffsetDateTime getYear() { return year; }
    @JsonProperty("year")
    public void setYear(OffsetDateTime value) { this.year = value; }
}
