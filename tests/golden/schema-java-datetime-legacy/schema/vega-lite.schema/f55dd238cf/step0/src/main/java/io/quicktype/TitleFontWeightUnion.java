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
@JsonDeserialize(using = TitleFontWeightUnion.Deserializer.class)
@JsonSerialize(using = TitleFontWeightUnion.Serializer.class)
public class TitleFontWeightUnion {
    public Double doubleValue;
    public String stringValue;

    static class Deserializer extends JsonDeserializer<TitleFontWeightUnion> {
        @Override
        public TitleFontWeightUnion deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            TitleFontWeightUnion value = new TitleFontWeightUnion();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    value.stringValue = string;
                    break;
                default: throw new IOException("Cannot deserialize TitleFontWeightUnion");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<TitleFontWeightUnion> {
        @Override
        public void serialize(TitleFontWeightUnion obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
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
