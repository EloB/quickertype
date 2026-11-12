package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

/**
 * Aggregation function for the field
 * (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
 *
 * __Default value:__ `undefined` (None)
 *
 * An [aggregate operation](aggregate.html#ops) to perform on the field prior to sorting
 * (e.g., `"count"`, `"mean"` and `"median"`).
 * This property is required in cases where the sort field and the data reference field do
 * not match.
 * The input data objects will be aggregated, grouped by the encoded data field.
 *
 * For a full list of operations, please see the documentation for
 * [aggregate](aggregate.html#ops).
 *
 * The aggregation operations to apply to the fields, such as sum, average or count.
 * See the [full list of supported aggregation
 * operations](https://vega.github.io/vega-lite/docs/aggregate.html#ops)
 * for more information.
 */
public enum AggregateOp {
    ARGMAX, ARGMIN, AVERAGE, COUNT, DISTINCT, MAX, MEAN, MEDIAN, MIN, MISSING, Q1, Q3, CI0, CI1, STDEV, STDEVP, SUM, VALID, VALUES, VARIANCE, VARIANCEP;

    @JsonValue
    public String toValue() {
        switch (this) {
            case ARGMAX: return "argmax";
            case ARGMIN: return "argmin";
            case AVERAGE: return "average";
            case COUNT: return "count";
            case DISTINCT: return "distinct";
            case MAX: return "max";
            case MEAN: return "mean";
            case MEDIAN: return "median";
            case MIN: return "min";
            case MISSING: return "missing";
            case Q1: return "q1";
            case Q3: return "q3";
            case CI0: return "ci0";
            case CI1: return "ci1";
            case STDEV: return "stdev";
            case STDEVP: return "stdevp";
            case SUM: return "sum";
            case VALID: return "valid";
            case VALUES: return "values";
            case VARIANCE: return "variance";
            case VARIANCEP: return "variancep";
        }
        return null;
    }

    @JsonCreator
    public static AggregateOp forValue(String value) throws IOException {
        if (value.equals("argmax")) return ARGMAX;
        if (value.equals("argmin")) return ARGMIN;
        if (value.equals("average")) return AVERAGE;
        if (value.equals("count")) return COUNT;
        if (value.equals("distinct")) return DISTINCT;
        if (value.equals("max")) return MAX;
        if (value.equals("mean")) return MEAN;
        if (value.equals("median")) return MEDIAN;
        if (value.equals("min")) return MIN;
        if (value.equals("missing")) return MISSING;
        if (value.equals("q1")) return Q1;
        if (value.equals("q3")) return Q3;
        if (value.equals("ci0")) return CI0;
        if (value.equals("ci1")) return CI1;
        if (value.equals("stdev")) return STDEV;
        if (value.equals("stdevp")) return STDEVP;
        if (value.equals("sum")) return SUM;
        if (value.equals("valid")) return VALID;
        if (value.equals("values")) return VALUES;
        if (value.equals("variance")) return VARIANCE;
        if (value.equals("variancep")) return VARIANCEP;
        throw new IOException("Cannot deserialize AggregateOp");
    }
}
