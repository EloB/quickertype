package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.time.LocalDate;
import java.time.OffsetDateTime;
import java.time.OffsetTime;
import java.util.List;

public class TopLevel {
    private List<ComplexUnionArrayElement> complexUnionArray;
    private LocalDate date;
    private OffsetDateTime dateTime;
    private LocalDateClassClass localDateClass;
    private OffsetDateTimeClassClass offsetDateTimeClass;
    private OffsetTimeClassClass offsetTimeClass;
    private OffsetTime time;
    private List<UnionArray> unionArray;

    @JsonProperty("complex-union-array")
    public List<ComplexUnionArrayElement> getComplexUnionArray() { return complexUnionArray; }
    @JsonProperty("complex-union-array")
    public void setComplexUnionArray(List<ComplexUnionArrayElement> value) { this.complexUnionArray = value; }

    @JsonProperty("date")
    public LocalDate getDate() { return date; }
    @JsonProperty("date")
    public void setDate(LocalDate value) { this.date = value; }

    @JsonProperty("date-time")
    public OffsetDateTime getDateTime() { return dateTime; }
    @JsonProperty("date-time")
    @JsonSetter(nulls = Nulls.FAIL)
    public void setDateTime(OffsetDateTime value) { this.dateTime = value; }

    @JsonProperty("local-date-class")
    public LocalDateClassClass getLocalDateClass() { return localDateClass; }
    @JsonProperty("local-date-class")
    public void setLocalDateClass(LocalDateClassClass value) { this.localDateClass = value; }

    @JsonProperty("offset-date-time-class")
    public OffsetDateTimeClassClass getOffsetDateTimeClass() { return offsetDateTimeClass; }
    @JsonProperty("offset-date-time-class")
    public void setOffsetDateTimeClass(OffsetDateTimeClassClass value) { this.offsetDateTimeClass = value; }

    @JsonProperty("offset-time-class")
    public OffsetTimeClassClass getOffsetTimeClass() { return offsetTimeClass; }
    @JsonProperty("offset-time-class")
    public void setOffsetTimeClass(OffsetTimeClassClass value) { this.offsetTimeClass = value; }

    @JsonProperty("time")
    public OffsetTime getTime() { return time; }
    @JsonProperty("time")
    public void setTime(OffsetTime value) { this.time = value; }

    @JsonProperty("union-array")
    public List<UnionArray> getUnionArray() { return unionArray; }
    @JsonProperty("union-array")
    public void setUnionArray(List<UnionArray> value) { this.unionArray = value; }
}
