package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;
import java.util.List;
import java.util.Map;

@JsonDeserialize(using = Poormaster.Deserializer.class)
@JsonSerialize(using = Poormaster.Serializer.class)
public class Poormaster {
    public List<Long> integerArrayValue;
    public Map<String, Long> integerMapValue;

    static class Deserializer extends JsonDeserializer<Poormaster> {
        @Override
        public Poormaster deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Poormaster value = new Poormaster();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case START_ARRAY:
                    value.integerArrayValue = jsonParser.readValueAs(new TypeReference<List<Long>>() {});
                    break;
                case START_OBJECT:
                    value.integerMapValue = jsonParser.readValueAs(Map.class);
                    break;
                default: throw new IOException("Cannot deserialize Poormaster");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Poormaster> {
        @Override
        public void serialize(Poormaster obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.integerArrayValue != null) {
                jsonGenerator.writeObject(obj.integerArrayValue);
                return;
            }
            if (obj.integerMapValue != null) {
                jsonGenerator.writeObject(obj.integerMapValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
