package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class TopLevel {
    private List<X> x;
    private List<Long> y;
    private List<ZElement> z;

    @JsonProperty("x")
    public List<X> getX() { return x; }
    @JsonProperty("x")
    public void setX(List<X> value) { this.x = value; }

    @JsonProperty("y")
    public List<Long> getY() { return y; }
    @JsonProperty("y")
    public void setY(List<Long> value) { this.y = value; }

    @JsonProperty("z")
    public List<ZElement> getZ() { return z; }
    @JsonProperty("z")
    public void setZ(List<ZElement> value) { this.z = value; }
}
