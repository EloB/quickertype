package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import java.util.Map;

@JsonDeserialize(using = Kongoni.Deserializer.class)
@JsonSerialize(using = Kongoni.Serializer.class)
public class Kongoni {
    public long[] integerArrayValue;
    public Map<String, Long> integerMapValue;

    static class Deserializer extends JsonDeserializer<Kongoni> {
        @Override
        public Kongoni deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Kongoni value = new Kongoni();
            switch (jsonParser.currentToken()) {
                case START_ARRAY:
                    value.integerArrayValue = jsonParser.readValueAs(long[].class);
                    break;
                case START_OBJECT:
                    value.integerMapValue = jsonParser.readValueAs(Map.class);
                    break;
                default: throw new IOException("Cannot deserialize Kongoni");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Kongoni> {
        @Override
        public void serialize(Kongoni obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.integerArrayValue != null) {
                jsonGenerator.writeObject(obj.integerArrayValue);
                return;
            }
            if (obj.integerMapValue != null) {
                jsonGenerator.writeObject(obj.integerMapValue);
                return;
            }
            throw new IOException("Kongoni must not be null");
        }
    }
}
