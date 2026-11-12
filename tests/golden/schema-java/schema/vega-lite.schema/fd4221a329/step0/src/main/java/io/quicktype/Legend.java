package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

/**
 * Properties of a legend or boolean flag for determining whether to show it.
 */
public class Legend {
    private Double entryPadding;
    private String format;
    private Double offset;
    private LegendOrient orient;
    private Double padding;
    private Double tickCount;
    private String title;
    private LegendType type;
    private List<LegendValue> values;
    private Double zindex;

    /**
     * Padding (in pixels) between legend entries in a symbol legend.
     */
    @JsonProperty("entryPadding")
    public Double getEntryPadding() { return entryPadding; }
    @JsonProperty("entryPadding")
    public void setEntryPadding(Double value) { this.entryPadding = value; }

    /**
     * The formatting pattern for labels. This is D3's [number format
     * pattern](https://github.com/d3/d3-format#locale_format) for quantitative fields and D3's
     * [time format pattern](https://github.com/d3/d3-time-format#locale_format) for time
     * field.
     *
     * See the [format documentation](format.html) for more information.
     *
     * __Default value:__  derived from [numberFormat](config.html#format) config for
     * quantitative fields and from [timeFormat](config.html#format) config for temporal fields.
     */
    @JsonProperty("format")
    public String getFormat() { return format; }
    @JsonProperty("format")
    public void setFormat(String value) { this.format = value; }

    /**
     * The offset, in pixels, by which to displace the legend from the edge of the enclosing
     * group or data rectangle.
     *
     * __Default value:__  `0`
     */
    @JsonProperty("offset")
    public Double getOffset() { return offset; }
    @JsonProperty("offset")
    public void setOffset(Double value) { this.offset = value; }

    /**
     * The orientation of the legend, which determines how the legend is positioned within the
     * scene. One of "left", "right", "top-left", "top-right", "bottom-left", "bottom-right",
     * "none".
     *
     * __Default value:__ `"right"`
     */
    @JsonProperty("orient")
    public LegendOrient getOrient() { return orient; }
    @JsonProperty("orient")
    public void setOrient(LegendOrient value) { this.orient = value; }

    /**
     * The padding, in pixels, between the legend and axis.
     */
    @JsonProperty("padding")
    public Double getPadding() { return padding; }
    @JsonProperty("padding")
    public void setPadding(Double value) { this.padding = value; }

    /**
     * The desired number of tick values for quantitative legends.
     */
    @JsonProperty("tickCount")
    public Double getTickCount() { return tickCount; }
    @JsonProperty("tickCount")
    public void setTickCount(Double value) { this.tickCount = value; }

    /**
     * A title for the field. If `null`, the title will be removed.
     *
     * __Default value:__  derived from the field's name and transformation function
     * (`aggregate`, `bin` and `timeUnit`).  If the field has an aggregate function, the
     * function is displayed as a part of the title (e.g., `"Sum of Profit"`). If the field is
     * binned or has a time unit applied, the applied function will be denoted in parentheses
     * (e.g., `"Profit (binned)"`, `"Transaction Date (year-month)"`).  Otherwise, the title is
     * simply the field name.
     *
     * __Note__: You can customize the default field title format by providing the [`fieldTitle`
     * property in the [config](config.html) or [`fieldTitle` function via the `compile`
     * function's options](compile.html#field-title).
     */
    @JsonProperty("title")
    public String getTitle() { return title; }
    @JsonProperty("title")
    public void setTitle(String value) { this.title = value; }

    /**
     * The type of the legend. Use `"symbol"` to create a discrete legend and `"gradient"` for a
     * continuous color gradient.
     *
     * __Default value:__ `"gradient"` for non-binned quantitative fields and temporal fields;
     * `"symbol"` otherwise.
     */
    @JsonProperty("type")
    public LegendType getType() { return type; }
    @JsonProperty("type")
    public void setType(LegendType value) { this.type = value; }

    /**
     * Explicitly set the visible legend values.
     */
    @JsonProperty("values")
    public List<LegendValue> getValues() { return values; }
    @JsonProperty("values")
    public void setValues(List<LegendValue> value) { this.values = value; }

    /**
     * A non-positive integer indicating z-index of the legend.
     * If zindex is 0, legend should be drawn behind all chart elements.
     * To put them in front, use zindex = 1.
     */
    @JsonProperty("zindex")
    public Double getZindex() { return zindex; }
    @JsonProperty("zindex")
    public void setZindex(Double value) { this.zindex = value; }
}
