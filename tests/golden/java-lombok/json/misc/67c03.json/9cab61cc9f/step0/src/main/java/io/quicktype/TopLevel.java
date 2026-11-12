package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class TopLevel {
    private String message;
    private long number;
    private List<Person> people;

    @JsonProperty("message")
    public String getMessage() { return message; }
    @JsonProperty("message")
    public void setMessage(String value) { this.message = value; }

    @JsonProperty("number")
    public long getNumber() { return number; }
    @JsonProperty("number")
    public void setNumber(long value) { this.number = value; }

    @JsonProperty("people")
    public List<Person> getPeople() { return people; }
    @JsonProperty("people")
    public void setPeople(List<Person> value) { this.people = value; }
}
