package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;
import java.util.Map;

/**
 * An object describing the data source
 *
 * Secondary data source to lookup in.
 */
public class Data {
    private DataFormat format;
    private String url;
    private Values values;
    private String name;

    /**
     * An object that specifies the format for parsing the data file.
     *
     * An object that specifies the format for parsing the data values.
     *
     * An object that specifies the format for parsing the data.
     */
    @JsonProperty("format")
    public DataFormat getFormat() { return format; }
    @JsonProperty("format")
    public void setFormat(DataFormat value) { this.format = value; }

    /**
     * An URL from which to load the data set. Use the `format.type` property
     * to ensure the loaded data is correctly parsed.
     */
    @JsonProperty("url")
    public String getURL() { return url; }
    @JsonProperty("url")
    public void setURL(String value) { this.url = value; }

    /**
     * The full data set, included inline. This can be an array of objects or primitive values
     * or a string.
     * Arrays of primitive values are ingested as objects with a `data` property. Strings are
     * parsed according to the specified format type.
     */
    @JsonProperty("values")
    public Values getValues() { return values; }
    @JsonProperty("values")
    public void setValues(Values value) { this.values = value; }

    /**
     * Provide a placeholder name and bind data at runtime.
     */
    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }
}
