package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Location {
    private String administrativeArea;
    private String country;
    private String faxNumber;
    private String locality;
    private String mobileNumber;
    private String phoneNumber;
    private String phoneNumberExtension;
    private String postalCode;
    private Object subPremise;
    private String thoroughfare;

    @JsonProperty("administrative_area")
    public String getAdministrativeArea() { return administrativeArea; }
    @JsonProperty("administrative_area")
    public void setAdministrativeArea(String value) { this.administrativeArea = value; }

    @JsonProperty("country")
    public String getCountry() { return country; }
    @JsonProperty("country")
    public void setCountry(String value) { this.country = value; }

    @JsonProperty("fax_number")
    public String getFaxNumber() { return faxNumber; }
    @JsonProperty("fax_number")
    public void setFaxNumber(String value) { this.faxNumber = value; }

    @JsonProperty("locality")
    public String getLocality() { return locality; }
    @JsonProperty("locality")
    public void setLocality(String value) { this.locality = value; }

    @JsonProperty("mobile_number")
    public String getMobileNumber() { return mobileNumber; }
    @JsonProperty("mobile_number")
    public void setMobileNumber(String value) { this.mobileNumber = value; }

    @JsonProperty("phone_number")
    public String getPhoneNumber() { return phoneNumber; }
    @JsonProperty("phone_number")
    public void setPhoneNumber(String value) { this.phoneNumber = value; }

    @JsonProperty("phone_number_extension")
    public String getPhoneNumberExtension() { return phoneNumberExtension; }
    @JsonProperty("phone_number_extension")
    public void setPhoneNumberExtension(String value) { this.phoneNumberExtension = value; }

    @JsonProperty("postal_code")
    public String getPostalCode() { return postalCode; }
    @JsonProperty("postal_code")
    public void setPostalCode(String value) { this.postalCode = value; }

    @JsonProperty("sub_premise")
    public Object getSubPremise() { return subPremise; }
    @JsonProperty("sub_premise")
    public void setSubPremise(Object value) { this.subPremise = value; }

    @JsonProperty("thoroughfare")
    public String getThoroughfare() { return thoroughfare; }
    @JsonProperty("thoroughfare")
    public void setThoroughfare(String value) { this.thoroughfare = value; }
}
