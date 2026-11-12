package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

/**
 * A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
 * `0` to `1` for opacity).
 *
 * A constant value in visual domain.
 */
@JsonDeserialize(using = ConditionalValueDefValue.Deserializer.class)
@JsonSerialize(using = ConditionalValueDefValue.Serializer.class)
public class ConditionalValueDefValue {
    public Double doubleValue;
    public Boolean boolValue;
    public String stringValue;

    static class Deserializer extends JsonDeserializer<ConditionalValueDefValue> {
        @Override
        public ConditionalValueDefValue deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            ConditionalValueDefValue value = new ConditionalValueDefValue();
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
                default: throw new IOException("Cannot deserialize ConditionalValueDefValue");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<ConditionalValueDefValue> {
        @Override
        public void serialize(ConditionalValueDefValue obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.boolValue != null) {
                jsonGenerator.writeObject(obj.boolValue);
                return;
            }
            if (obj.stringValue != null) {
                jsonGenerator.writeObject(obj.stringValue);
                return;
            }
            throw new IOException("ConditionalValueDefValue must not be null");
        }
    }
}
