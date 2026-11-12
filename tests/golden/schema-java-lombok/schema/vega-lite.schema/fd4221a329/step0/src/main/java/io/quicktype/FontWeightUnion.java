package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

/**
 * The font weight (e.g., `"bold"`).
 *
 * Font weight for title text.
 */
@JsonDeserialize(using = FontWeightUnion.Deserializer.class)
@JsonSerialize(using = FontWeightUnion.Serializer.class)
public class FontWeightUnion {
    public Double doubleValue;
    public FontWeight enumValue;

    static class Deserializer extends JsonDeserializer<FontWeightUnion> {
        @Override
        public FontWeightUnion deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            FontWeightUnion value = new FontWeightUnion();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    try {
                        value.enumValue = FontWeight.forValue(string);
                    } catch (Exception ex) {
                        // Ignored
                    }
                    break;
                default: throw new IOException("Cannot deserialize FontWeightUnion");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<FontWeightUnion> {
        @Override
        public void serialize(FontWeightUnion obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.enumValue != null) {
                jsonGenerator.writeObject(obj.enumValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
