package io.quicktype;

import com.fasterxml.jackson.annotation.*;

/**
 * Comment delimiters:
 * * /
 * / *
 * {-
 * -}
 * """
 * </summary> & <br>
 * }
 * }
 * }
 * }
 * }
 */
public class TopLevel {
    private String trailingBackslash;
    private String trailingQuote;
    private String trailingTripleQuote;
    private String value;

    /**
     * Ends with a backslash \
     */
    @JsonProperty("trailingBackslash")
    public String getTrailingBackslash() { return trailingBackslash; }
    @JsonProperty("trailingBackslash")
    public void setTrailingBackslash(String value) { this.trailingBackslash = value; }

    /**
     * Ends with a quote "
     */
    @JsonProperty("trailingQuote")
    public String getTrailingQuote() { return trailingQuote; }
    @JsonProperty("trailingQuote")
    public void setTrailingQuote(String value) { this.trailingQuote = value; }

    /**
     * Ends with a triple quote """
     */
    @JsonProperty("trailingTripleQuote")
    public String getTrailingTripleQuote() { return trailingTripleQuote; }
    @JsonProperty("trailingTripleQuote")
    public void setTrailingTripleQuote(String value) { this.trailingTripleQuote = value; }

    /**
     * Property delimiters:
     * * /
     * / *
     * {-
     * -}
     * """
     * </summary> & <br>
     * }
     * }
     * }
     * }
     * }
     */
    @JsonProperty("value")
    public String getValue() { return value; }
    @JsonProperty("value")
    public void setValue(String value) { this.value = value; }
}
