package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class DomainClass {
    private String field;
    private String selection;
    private String encoding;

    /**
     * The field name to extract selected values for, when a selection is
     * [projected](project.html)
     * over multiple fields or encodings.
     */
    @JsonProperty("field")
    public String getField() { return field; }
    @JsonProperty("field")
    public void setField(String value) { this.field = value; }

    /**
     * The name of a selection.
     */
    @JsonProperty("selection")
    public String getSelection() { return selection; }
    @JsonProperty("selection")
    public void setSelection(String value) { this.selection = value; }

    /**
     * The encoding channel to extract selected values for, when a selection is
     * [projected](project.html)
     * over multiple fields or encodings.
     */
    @JsonProperty("encoding")
    public String getEncoding() { return encoding; }
    @JsonProperty("encoding")
    public void setEncoding(String value) { this.encoding = value; }
}
