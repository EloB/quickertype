package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;
import java.util.Map;

public class TopLevel {
    private String stringValue;
    private String dateValue;
    private String uuidValue;
    private Object nameWithSpaces;
    private double doubleValue;
    private long intValue;
    private boolean booleanValue;
    private Object nullValue;
    private List<List<IntOrString>> tuples;
    private PurplePerson person;
    private List<PersonElement> people;
    private List<DifferentThingElement> differentThings;
    private Map<String, Long> mapValue;
    private Map<String, Long> nullableMapValue;

    @JsonProperty("stringValue")
    public String getStringValue() { return stringValue; }
    @JsonProperty("stringValue")
    public void setStringValue(String value) { this.stringValue = value; }

    @JsonProperty("dateValue")
    public String getDateValue() { return dateValue; }
    @JsonProperty("dateValue")
    public void setDateValue(String value) { this.dateValue = value; }

    @JsonProperty("uuidValue")
    public String getUUIDValue() { return uuidValue; }
    @JsonProperty("uuidValue")
    public void setUUIDValue(String value) { this.uuidValue = value; }

    @JsonProperty("name with spaces")
    public Object getNameWithSpaces() { return nameWithSpaces; }
    @JsonProperty("name with spaces")
    public void setNameWithSpaces(Object value) { this.nameWithSpaces = value; }

    @JsonProperty("doubleValue")
    public double getDoubleValue() { return doubleValue; }
    @JsonProperty("doubleValue")
    public void setDoubleValue(double value) { this.doubleValue = value; }

    @JsonProperty("intValue")
    public long getIntValue() { return intValue; }
    @JsonProperty("intValue")
    public void setIntValue(long value) { this.intValue = value; }

    @JsonProperty("booleanValue")
    public boolean getBooleanValue() { return booleanValue; }
    @JsonProperty("booleanValue")
    public void setBooleanValue(boolean value) { this.booleanValue = value; }

    @JsonProperty("nullValue")
    public Object getNullValue() { return nullValue; }
    @JsonProperty("nullValue")
    public void setNullValue(Object value) { this.nullValue = value; }

    @JsonProperty("tuples")
    public List<List<IntOrString>> getTuples() { return tuples; }
    @JsonProperty("tuples")
    public void setTuples(List<List<IntOrString>> value) { this.tuples = value; }

    @JsonProperty("person")
    public PurplePerson getPerson() { return person; }
    @JsonProperty("person")
    public void setPerson(PurplePerson value) { this.person = value; }

    @JsonProperty("people")
    public List<PersonElement> getPeople() { return people; }
    @JsonProperty("people")
    public void setPeople(List<PersonElement> value) { this.people = value; }

    @JsonProperty("differentThings")
    public List<DifferentThingElement> getDifferentThings() { return differentThings; }
    @JsonProperty("differentThings")
    public void setDifferentThings(List<DifferentThingElement> value) { this.differentThings = value; }

    @JsonProperty("mapValue")
    public Map<String, Long> getMapValue() { return mapValue; }
    @JsonProperty("mapValue")
    public void setMapValue(Map<String, Long> value) { this.mapValue = value; }

    @JsonProperty("nullableMapValue")
    public Map<String, Long> getNullableMapValue() { return nullableMapValue; }
    @JsonProperty("nullableMapValue")
    public void setNullableMapValue(Map<String, Long> value) { this.nullableMapValue = value; }
}
