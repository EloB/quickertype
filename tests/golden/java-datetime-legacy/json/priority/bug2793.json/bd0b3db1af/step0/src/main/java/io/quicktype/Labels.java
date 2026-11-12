package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Labels {
    private String accountNumber;
    private String title;

    @JsonProperty("AccountNumber")
    public String getAccountNumber() { return accountNumber; }
    @JsonProperty("AccountNumber")
    public void setAccountNumber(String value) { this.accountNumber = value; }

    @JsonProperty("Title")
    public String getTitle() { return title; }
    @JsonProperty("Title")
    public void setTitle(String value) { this.title = value; }
}
