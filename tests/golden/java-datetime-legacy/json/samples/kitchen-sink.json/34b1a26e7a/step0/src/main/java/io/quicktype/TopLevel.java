package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;
import java.util.Map;

public class TopLevel {
    private boolean booleanValue;
    private String dateValue;
    private List<DifferentThingElement> differentThings;
    private double doubleValue;
    private long intValue;
    private Map<String, Long> mapValue;
    private Object nameWithSpaces;
    private Object nullValue;
    private Map<String, Long> nullableMapValue;
    private List<PersonElement> people;
    private PurplePerson person;
    private String stringValue;
    private List<List<IntOrString>> tuples;
    private String uuidValue;

    @JsonProperty("booleanValue")
    public boolean getBooleanValue() { return booleanValue; }
    @JsonProperty("booleanValue")
    public void setBooleanValue(boolean value) { this.booleanValue = value; }

    @JsonProperty("dateValue")
    public String getDateValue() { return dateValue; }
    @JsonProperty("dateValue")
    public void setDateValue(String value) { this.dateValue = value; }

    @JsonProperty("differentThings")
    public List<DifferentThingElement> getDifferentThings() { return differentThings; }
    @JsonProperty("differentThings")
    public void setDifferentThings(List<DifferentThingElement> value) { this.differentThings = value; }

    @JsonProperty("doubleValue")
    public double getDoubleValue() { return doubleValue; }
    @JsonProperty("doubleValue")
    public void setDoubleValue(double value) { this.doubleValue = value; }

    @JsonProperty("intValue")
    public long getIntValue() { return intValue; }
    @JsonProperty("intValue")
    public void setIntValue(long value) { this.intValue = value; }

    @JsonProperty("mapValue")
    public Map<String, Long> getMapValue() { return mapValue; }
    @JsonProperty("mapValue")
    public void setMapValue(Map<String, Long> value) { this.mapValue = value; }

    @JsonProperty("name with spaces")
    public Object getNameWithSpaces() { return nameWithSpaces; }
    @JsonProperty("name with spaces")
    public void setNameWithSpaces(Object value) { this.nameWithSpaces = value; }

    @JsonProperty("nullValue")
    public Object getNullValue() { return nullValue; }
    @JsonProperty("nullValue")
    public void setNullValue(Object value) { this.nullValue = value; }

    @JsonProperty("nullableMapValue")
    public Map<String, Long> getNullableMapValue() { return nullableMapValue; }
    @JsonProperty("nullableMapValue")
    public void setNullableMapValue(Map<String, Long> value) { this.nullableMapValue = value; }

    @JsonProperty("people")
    public List<PersonElement> getPeople() { return people; }
    @JsonProperty("people")
    public void setPeople(List<PersonElement> value) { this.people = value; }

    @JsonProperty("person")
    public PurplePerson getPerson() { return person; }
    @JsonProperty("person")
    public void setPerson(PurplePerson value) { this.person = value; }

    @JsonProperty("stringValue")
    public String getStringValue() { return stringValue; }
    @JsonProperty("stringValue")
    public void setStringValue(String value) { this.stringValue = value; }

    @JsonProperty("tuples")
    public List<List<IntOrString>> getTuples() { return tuples; }
    @JsonProperty("tuples")
    public void setTuples(List<List<IntOrString>> value) { this.tuples = value; }

    @JsonProperty("uuidValue")
    public String getUUIDValue() { return uuidValue; }
    @JsonProperty("uuidValue")
    public void setUUIDValue(String value) { this.uuidValue = value; }
}
