package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import java.util.Map;

@JsonDeserialize(using = Generalissimo.Deserializer.class)
@JsonSerialize(using = Generalissimo.Serializer.class)
public class Generalissimo {
    public Boolean boolValue;
    public Map<String, Long> integerMapValue;

    static class Deserializer extends JsonDeserializer<Generalissimo> {
        @Override
        public Generalissimo deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Generalissimo value = new Generalissimo();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_TRUE:
                case VALUE_FALSE:
                    value.boolValue = jsonParser.readValueAs(Boolean.class);
                    break;
                case START_OBJECT:
                    value.integerMapValue = jsonParser.readValueAs(Map.class);
                    break;
                default: throw new IOException("Cannot deserialize Generalissimo");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Generalissimo> {
        @Override
        public void serialize(Generalissimo obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.boolValue != null) {
                jsonGenerator.writeObject(obj.boolValue);
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
