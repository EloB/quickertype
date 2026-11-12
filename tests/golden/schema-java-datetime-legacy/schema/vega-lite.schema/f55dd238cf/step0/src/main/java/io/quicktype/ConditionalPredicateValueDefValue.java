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
@JsonDeserialize(using = ConditionalPredicateValueDefValue.Deserializer.class)
@JsonSerialize(using = ConditionalPredicateValueDefValue.Serializer.class)
public class ConditionalPredicateValueDefValue {
    public Double doubleValue;
    public Boolean boolValue;
    public String stringValue;

    static class Deserializer extends JsonDeserializer<ConditionalPredicateValueDefValue> {
        @Override
        public ConditionalPredicateValueDefValue deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            ConditionalPredicateValueDefValue value = new ConditionalPredicateValueDefValue();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
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
                default: throw new IOException("Cannot deserialize ConditionalPredicateValueDefValue");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<ConditionalPredicateValueDefValue> {
        @Override
        public void serialize(ConditionalPredicateValueDefValue obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
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
            jsonGenerator.writeNull();
        }
    }
}
