package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Value {
    EMPTY, SOUTH_ASIA, SUB_SAHARAN_AFRICA_EXCLUDING_HIGH_INCOME, EUROPE_CENTRAL_ASIA_EXCLUDING_HIGH_INCOME, LATIN_AMERICA_CARIBBEAN_EXCLUDING_HIGH_INCOME, EAST_ASIA_PACIFIC_EXCLUDING_HIGH_INCOME, MIDDLE_EAST_NORTH_AFRICA_EXCLUDING_HIGH_INCOME, HIGH_INCOME, LOW_INCOME, AGGREGATES, LOWER_MIDDLE_INCOME, UPPER_MIDDLE_INCOME, NOT_CLASSIFIED, IDA, IBRD, BLEND, LATIN_AMERICA_CARIBBEAN, SUB_SAHARAN_AFRICA, EUROPE_CENTRAL_ASIA, MIDDLE_EAST_NORTH_AFRICA, EAST_ASIA_PACIFIC, NORTH_AMERICA;

    @JsonValue
    public String toValue() {
        switch (this) {
            case EMPTY: return "";
            case SOUTH_ASIA: return "South Asia";
            case SUB_SAHARAN_AFRICA_EXCLUDING_HIGH_INCOME: return "Sub-Saharan Africa (excluding high income)";
            case EUROPE_CENTRAL_ASIA_EXCLUDING_HIGH_INCOME: return "Europe & Central Asia (excluding high income)";
            case LATIN_AMERICA_CARIBBEAN_EXCLUDING_HIGH_INCOME: return "Latin America & Caribbean (excluding high income)";
            case EAST_ASIA_PACIFIC_EXCLUDING_HIGH_INCOME: return "East Asia & Pacific (excluding high income)";
            case MIDDLE_EAST_NORTH_AFRICA_EXCLUDING_HIGH_INCOME: return "Middle East & North Africa (excluding high income)";
            case HIGH_INCOME: return "High income";
            case LOW_INCOME: return "Low income";
            case AGGREGATES: return "Aggregates";
            case LOWER_MIDDLE_INCOME: return "Lower middle income";
            case UPPER_MIDDLE_INCOME: return "Upper middle income";
            case NOT_CLASSIFIED: return "Not classified";
            case IDA: return "IDA";
            case IBRD: return "IBRD";
            case BLEND: return "Blend";
            case LATIN_AMERICA_CARIBBEAN: return "Latin America & Caribbean ";
            case SUB_SAHARAN_AFRICA: return "Sub-Saharan Africa ";
            case EUROPE_CENTRAL_ASIA: return "Europe & Central Asia";
            case MIDDLE_EAST_NORTH_AFRICA: return "Middle East & North Africa";
            case EAST_ASIA_PACIFIC: return "East Asia & Pacific";
            case NORTH_AMERICA: return "North America";
        }
        return null;
    }

    @JsonCreator
    public static Value forValue(String value) throws IOException {
        if (value.equals("")) return EMPTY;
        if (value.equals("South Asia")) return SOUTH_ASIA;
        if (value.equals("Sub-Saharan Africa (excluding high income)")) return SUB_SAHARAN_AFRICA_EXCLUDING_HIGH_INCOME;
        if (value.equals("Europe & Central Asia (excluding high income)")) return EUROPE_CENTRAL_ASIA_EXCLUDING_HIGH_INCOME;
        if (value.equals("Latin America & Caribbean (excluding high income)")) return LATIN_AMERICA_CARIBBEAN_EXCLUDING_HIGH_INCOME;
        if (value.equals("East Asia & Pacific (excluding high income)")) return EAST_ASIA_PACIFIC_EXCLUDING_HIGH_INCOME;
        if (value.equals("Middle East & North Africa (excluding high income)")) return MIDDLE_EAST_NORTH_AFRICA_EXCLUDING_HIGH_INCOME;
        if (value.equals("High income")) return HIGH_INCOME;
        if (value.equals("Low income")) return LOW_INCOME;
        if (value.equals("Aggregates")) return AGGREGATES;
        if (value.equals("Lower middle income")) return LOWER_MIDDLE_INCOME;
        if (value.equals("Upper middle income")) return UPPER_MIDDLE_INCOME;
        if (value.equals("Not classified")) return NOT_CLASSIFIED;
        if (value.equals("IDA")) return IDA;
        if (value.equals("IBRD")) return IBRD;
        if (value.equals("Blend")) return BLEND;
        if (value.equals("Latin America & Caribbean ")) return LATIN_AMERICA_CARIBBEAN;
        if (value.equals("Sub-Saharan Africa ")) return SUB_SAHARAN_AFRICA;
        if (value.equals("Europe & Central Asia")) return EUROPE_CENTRAL_ASIA;
        if (value.equals("Middle East & North Africa")) return MIDDLE_EAST_NORTH_AFRICA;
        if (value.equals("East Asia & Pacific")) return EAST_ASIA_PACIFIC;
        if (value.equals("North America")) return NORTH_AMERICA;
        throw new IOException("Cannot deserialize Value");
    }
}
