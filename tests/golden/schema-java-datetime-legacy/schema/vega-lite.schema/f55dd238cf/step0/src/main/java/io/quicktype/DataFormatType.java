package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

/**
 * Type of input data: `"json"`, `"csv"`, `"tsv"`.
 * The default format type is determined by the extension of the file URL.
 * If no extension is detected, `"json"` will be used by default.
 */
public enum DataFormatType {
    CSV, TSV, JSON, TOPOJSON;

    @JsonValue
    public String toValue() {
        switch (this) {
            case CSV: return "csv";
            case TSV: return "tsv";
            case JSON: return "json";
            case TOPOJSON: return "topojson";
        }
        return null;
    }

    @JsonCreator
    public static DataFormatType forValue(String value) throws IOException {
        if (value.equals("csv")) return CSV;
        if (value.equals("tsv")) return TSV;
        if (value.equals("json")) return JSON;
        if (value.equals("topojson")) return TOPOJSON;
        throw new IOException("Cannot deserialize DataFormatType");
    }
}
