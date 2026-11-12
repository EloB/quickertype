package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

/**
 * A string describing the mark type (one of `"bar"`, `"circle"`, `"square"`, `"tick"`,
 * `"line"`,
 * * `"area"`, `"point"`, `"rule"`, `"geoshape"`, and `"text"`) or a [mark definition
 * object](mark.html#mark-def).
 */
@JsonDeserialize(using = AnyMark.Deserializer.class)
@JsonSerialize(using = AnyMark.Serializer.class)
public class AnyMark {
    public MarkDef markDefValue;
    public Mark enumValue;

    static class Deserializer extends JsonDeserializer<AnyMark> {
        @Override
        public AnyMark deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            AnyMark value = new AnyMark();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    try {
                        value.enumValue = Mark.forValue(string);
                    } catch (Exception ex) {
                        // Ignored
                    }
                    break;
                case START_OBJECT:
                    value.markDefValue = jsonParser.readValueAs(MarkDef.class);
                    break;
                default: throw new IOException("Cannot deserialize AnyMark");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<AnyMark> {
        @Override
        public void serialize(AnyMark obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.markDefValue != null) {
                jsonGenerator.writeObject(obj.markDefValue);
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
