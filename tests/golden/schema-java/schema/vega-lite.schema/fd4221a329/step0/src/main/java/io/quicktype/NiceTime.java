package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum NiceTime {
    SECOND, MINUTE, HOUR, DAY, WEEK, MONTH, YEAR;

    @JsonValue
    public String toValue() {
        switch (this) {
            case SECOND: return "second";
            case MINUTE: return "minute";
            case HOUR: return "hour";
            case DAY: return "day";
            case WEEK: return "week";
            case MONTH: return "month";
            case YEAR: return "year";
        }
        return null;
    }

    @JsonCreator
    public static NiceTime forValue(String value) throws IOException {
        if (value.equals("second")) return SECOND;
        if (value.equals("minute")) return MINUTE;
        if (value.equals("hour")) return HOUR;
        if (value.equals("day")) return DAY;
        if (value.equals("week")) return WEEK;
        if (value.equals("month")) return MONTH;
        if (value.equals("year")) return YEAR;
        throw new IOException("Cannot deserialize NiceTime");
    }
}
