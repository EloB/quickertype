package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

/**
 * The value that the field should be equal to.
 */
@JsonDeserialize(using = OneOfElement.Deserializer.class)
@JsonSerialize(using = OneOfElement.Serializer.class)
public class OneOfElement {
    public Double doubleValue;
    public Boolean boolValue;
    public DateTime dateTimeValue;
    public String stringValue;

    static class Deserializer extends JsonDeserializer<OneOfElement> {
        @Override
        public OneOfElement deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            OneOfElement value = new OneOfElement();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case VALUE_TRUE:
                case VALUE_FALSE:
                    value.boolValue = jsonParser.readValueAs(Boolean.class);
                    break;
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    value.stringValue = string;
                    break;
                case START_OBJECT:
                    value.dateTimeValue = jsonParser.readValueAs(DateTime.class);
                    break;
                default: throw new IOException("Cannot deserialize OneOfElement");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<OneOfElement> {
        @Override
        public void serialize(OneOfElement obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.boolValue != null) {
                jsonGenerator.writeObject(obj.boolValue);
                return;
            }
            if (obj.dateTimeValue != null) {
                jsonGenerator.writeObject(obj.dateTimeValue);
                return;
            }
            if (obj.stringValue != null) {
                jsonGenerator.writeObject(obj.stringValue);
                return;
            }
            throw new IOException("OneOfElement must not be null");
        }
    }
}
