package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class PaddingClass {
    private Double bottom;
    private Double left;
    private Double right;
    private Double top;

    @JsonProperty("bottom")
    public Double getBottom() { return bottom; }
    @JsonProperty("bottom")
    public void setBottom(Double value) { this.bottom = value; }

    @JsonProperty("left")
    public Double getLeft() { return left; }
    @JsonProperty("left")
    public void setLeft(Double value) { this.left = value; }

    @JsonProperty("right")
    public Double getRight() { return right; }
    @JsonProperty("right")
    public void setRight(Double value) { this.right = value; }

    @JsonProperty("top")
    public Double getTop() { return top; }
    @JsonProperty("top")
    public void setTop(Double value) { this.top = value; }
}
