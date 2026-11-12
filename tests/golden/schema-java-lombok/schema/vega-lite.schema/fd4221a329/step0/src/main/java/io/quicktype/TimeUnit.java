package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

/**
 * Time unit for the field to be filtered.
 *
 * time unit for the field to be filtered.
 *
 * Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
 * or [a temporal field that gets casted as ordinal](type.html#cast).
 *
 * __Default value:__ `undefined` (None)
 *
 * The timeUnit.
 */
public enum TimeUnit {
    YEAR, QUARTER, MONTH, DAY, DATE, HOURS, MINUTES, SECONDS, MILLISECONDS, UTCYEAR, UTCQUARTER, UTCMONTH, UTCDAY, UTCDATE, UTCHOURS, UTCMINUTES, UTCSECONDS, UTCMILLISECONDS, YEARQUARTER, YEARQUARTERMONTH, YEARMONTH, YEARMONTHDATE, YEARMONTHDATEHOURS, YEARMONTHDATEHOURSMINUTES, YEARMONTHDATEHOURSMINUTESSECONDS, QUARTERMONTH, MONTHDATE, HOURSMINUTES, HOURSMINUTESSECONDS, MINUTESSECONDS, SECONDSMILLISECONDS, UTCYEARQUARTER, UTCYEARQUARTERMONTH, UTCYEARMONTH, UTCYEARMONTHDATE, UTCYEARMONTHDATEHOURS, UTCYEARMONTHDATEHOURSMINUTES, UTCYEARMONTHDATEHOURSMINUTESSECONDS, UTCQUARTERMONTH, UTCMONTHDATE, UTCHOURSMINUTES, UTCHOURSMINUTESSECONDS, UTCMINUTESSECONDS, UTCSECONDSMILLISECONDS;

    @JsonValue
    public String toValue() {
        switch (this) {
            case YEAR: return "year";
            case QUARTER: return "quarter";
            case MONTH: return "month";
            case DAY: return "day";
            case DATE: return "date";
            case HOURS: return "hours";
            case MINUTES: return "minutes";
            case SECONDS: return "seconds";
            case MILLISECONDS: return "milliseconds";
            case UTCYEAR: return "utcyear";
            case UTCQUARTER: return "utcquarter";
            case UTCMONTH: return "utcmonth";
            case UTCDAY: return "utcday";
            case UTCDATE: return "utcdate";
            case UTCHOURS: return "utchours";
            case UTCMINUTES: return "utcminutes";
            case UTCSECONDS: return "utcseconds";
            case UTCMILLISECONDS: return "utcmilliseconds";
            case YEARQUARTER: return "yearquarter";
            case YEARQUARTERMONTH: return "yearquartermonth";
            case YEARMONTH: return "yearmonth";
            case YEARMONTHDATE: return "yearmonthdate";
            case YEARMONTHDATEHOURS: return "yearmonthdatehours";
            case YEARMONTHDATEHOURSMINUTES: return "yearmonthdatehoursminutes";
            case YEARMONTHDATEHOURSMINUTESSECONDS: return "yearmonthdatehoursminutesseconds";
            case QUARTERMONTH: return "quartermonth";
            case MONTHDATE: return "monthdate";
            case HOURSMINUTES: return "hoursminutes";
            case HOURSMINUTESSECONDS: return "hoursminutesseconds";
            case MINUTESSECONDS: return "minutesseconds";
            case SECONDSMILLISECONDS: return "secondsmilliseconds";
            case UTCYEARQUARTER: return "utcyearquarter";
            case UTCYEARQUARTERMONTH: return "utcyearquartermonth";
            case UTCYEARMONTH: return "utcyearmonth";
            case UTCYEARMONTHDATE: return "utcyearmonthdate";
            case UTCYEARMONTHDATEHOURS: return "utcyearmonthdatehours";
            case UTCYEARMONTHDATEHOURSMINUTES: return "utcyearmonthdatehoursminutes";
            case UTCYEARMONTHDATEHOURSMINUTESSECONDS: return "utcyearmonthdatehoursminutesseconds";
            case UTCQUARTERMONTH: return "utcquartermonth";
            case UTCMONTHDATE: return "utcmonthdate";
            case UTCHOURSMINUTES: return "utchoursminutes";
            case UTCHOURSMINUTESSECONDS: return "utchoursminutesseconds";
            case UTCMINUTESSECONDS: return "utcminutesseconds";
            case UTCSECONDSMILLISECONDS: return "utcsecondsmilliseconds";
        }
        return null;
    }

    @JsonCreator
    public static TimeUnit forValue(String value) throws IOException {
        if (value.equals("year")) return YEAR;
        if (value.equals("quarter")) return QUARTER;
        if (value.equals("month")) return MONTH;
        if (value.equals("day")) return DAY;
        if (value.equals("date")) return DATE;
        if (value.equals("hours")) return HOURS;
        if (value.equals("minutes")) return MINUTES;
        if (value.equals("seconds")) return SECONDS;
        if (value.equals("milliseconds")) return MILLISECONDS;
        if (value.equals("utcyear")) return UTCYEAR;
        if (value.equals("utcquarter")) return UTCQUARTER;
        if (value.equals("utcmonth")) return UTCMONTH;
        if (value.equals("utcday")) return UTCDAY;
        if (value.equals("utcdate")) return UTCDATE;
        if (value.equals("utchours")) return UTCHOURS;
        if (value.equals("utcminutes")) return UTCMINUTES;
        if (value.equals("utcseconds")) return UTCSECONDS;
        if (value.equals("utcmilliseconds")) return UTCMILLISECONDS;
        if (value.equals("yearquarter")) return YEARQUARTER;
        if (value.equals("yearquartermonth")) return YEARQUARTERMONTH;
        if (value.equals("yearmonth")) return YEARMONTH;
        if (value.equals("yearmonthdate")) return YEARMONTHDATE;
        if (value.equals("yearmonthdatehours")) return YEARMONTHDATEHOURS;
        if (value.equals("yearmonthdatehoursminutes")) return YEARMONTHDATEHOURSMINUTES;
        if (value.equals("yearmonthdatehoursminutesseconds")) return YEARMONTHDATEHOURSMINUTESSECONDS;
        if (value.equals("quartermonth")) return QUARTERMONTH;
        if (value.equals("monthdate")) return MONTHDATE;
        if (value.equals("hoursminutes")) return HOURSMINUTES;
        if (value.equals("hoursminutesseconds")) return HOURSMINUTESSECONDS;
        if (value.equals("minutesseconds")) return MINUTESSECONDS;
        if (value.equals("secondsmilliseconds")) return SECONDSMILLISECONDS;
        if (value.equals("utcyearquarter")) return UTCYEARQUARTER;
        if (value.equals("utcyearquartermonth")) return UTCYEARQUARTERMONTH;
        if (value.equals("utcyearmonth")) return UTCYEARMONTH;
        if (value.equals("utcyearmonthdate")) return UTCYEARMONTHDATE;
        if (value.equals("utcyearmonthdatehours")) return UTCYEARMONTHDATEHOURS;
        if (value.equals("utcyearmonthdatehoursminutes")) return UTCYEARMONTHDATEHOURSMINUTES;
        if (value.equals("utcyearmonthdatehoursminutesseconds")) return UTCYEARMONTHDATEHOURSMINUTESSECONDS;
        if (value.equals("utcquartermonth")) return UTCQUARTERMONTH;
        if (value.equals("utcmonthdate")) return UTCMONTHDATE;
        if (value.equals("utchoursminutes")) return UTCHOURSMINUTES;
        if (value.equals("utchoursminutesseconds")) return UTCHOURSMINUTESSECONDS;
        if (value.equals("utcminutesseconds")) return UTCMINUTESSECONDS;
        if (value.equals("utcsecondsmilliseconds")) return UTCSECONDSMILLISECONDS;
        throw new IOException("Cannot deserialize TimeUnit");
    }
}
