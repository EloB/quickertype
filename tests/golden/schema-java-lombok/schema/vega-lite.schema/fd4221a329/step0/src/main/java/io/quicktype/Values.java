package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;
import java.util.List;
import java.util.Map;

/**
 * The full data set, included inline. This can be an array of objects or primitive values
 * or a string.
 * Arrays of primitive values are ingested as objects with a `data` property. Strings are
 * parsed according to the specified format type.
 */
@JsonDeserialize(using = Values.Deserializer.class)
@JsonSerialize(using = Values.Serializer.class)
public class Values {
    public List<ValuesValue> unionArrayValue;
    public Map<String, Object> anythingMapValue;
    public String stringValue;

    static class Deserializer extends JsonDeserializer<Values> {
        @Override
        public Values deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Values value = new Values();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    value.stringValue = string;
                    break;
                case START_ARRAY:
                    value.unionArrayValue = jsonParser.readValueAs(new TypeReference<List<ValuesValue>>() {});
                    break;
                case START_OBJECT:
                    value.anythingMapValue = jsonParser.readValueAs(Map.class);
                    break;
                default: throw new IOException("Cannot deserialize Values");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Values> {
        @Override
        public void serialize(Values obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.unionArrayValue != null) {
                jsonGenerator.writeObject(obj.unionArrayValue);
                return;
            }
            if (obj.anythingMapValue != null) {
                jsonGenerator.writeObject(obj.anythingMapValue);
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
