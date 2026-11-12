package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

/**
 * Secondary data reference.
 */
public class LookupData {
    private Data data;
    private List<String> fields;
    private String key;

    /**
     * Secondary data source to lookup in.
     */
    @JsonProperty("data")
    public Data getData() { return data; }
    @JsonProperty("data")
    public void setData(Data value) { this.data = value; }

    /**
     * Fields in foreign data to lookup.
     * If not specified, the entire object is queried.
     */
    @JsonProperty("fields")
    public List<String> getFields() { return fields; }
    @JsonProperty("fields")
    public void setFields(List<String> value) { this.fields = value; }

    /**
     * Key in data to lookup.
     */
    @JsonProperty("key")
    public String getKey() { return key; }
    @JsonProperty("key")
    public void setKey(String value) { this.key = value; }
}
