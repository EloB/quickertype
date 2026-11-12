package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import java.util.Map;

@JsonDeserialize(using = Undesirability.Deserializer.class)
@JsonSerialize(using = Undesirability.Serializer.class)
public class Undesirability {
    public long[] integerArrayValue;
    public Map<String, Long> integerMapValue;
    public String stringValue;

    static class Deserializer extends JsonDeserializer<Undesirability> {
        @Override
        public Undesirability deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Undesirability value = new Undesirability();
            switch (jsonParser.currentToken()) {
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    value.stringValue = string;
                    break;
                case START_ARRAY:
                    value.integerArrayValue = jsonParser.readValueAs(long[].class);
                    break;
                case START_OBJECT:
                    value.integerMapValue = jsonParser.readValueAs(Map.class);
                    break;
                default: throw new IOException("Cannot deserialize Undesirability");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Undesirability> {
        @Override
        public void serialize(Undesirability obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.integerArrayValue != null) {
                jsonGenerator.writeObject(obj.integerArrayValue);
                return;
            }
            if (obj.integerMapValue != null) {
                jsonGenerator.writeObject(obj.integerMapValue);
                return;
            }
            if (obj.stringValue != null) {
                jsonGenerator.writeObject(obj.stringValue);
                return;
            }
            throw new IOException("Undesirability must not be null");
        }
    }
}
