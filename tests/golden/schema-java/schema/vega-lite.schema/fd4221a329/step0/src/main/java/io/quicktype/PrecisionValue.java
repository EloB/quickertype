package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

/**
 * Font weight of the title. (e.g., `"bold"`).
 *
 * The font weight of the legend title.
 */
@JsonDeserialize(using = PrecisionValue.Deserializer.class)
@JsonSerialize(using = PrecisionValue.Serializer.class)
public class PrecisionValue {
    public Double doubleValue;
    public String stringValue;

    static class Deserializer extends JsonDeserializer<PrecisionValue> {
        @Override
        public PrecisionValue deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            PrecisionValue value = new PrecisionValue();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    value.stringValue = string;
                    break;
                default: throw new IOException("Cannot deserialize PrecisionValue");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<PrecisionValue> {
        @Override
        public void serialize(PrecisionValue obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.stringValue != null) {
                jsonGenerator.writeObject(obj.stringValue);
                return;
            }
            throw new IOException("PrecisionValue must not be null");
        }
    }
}
