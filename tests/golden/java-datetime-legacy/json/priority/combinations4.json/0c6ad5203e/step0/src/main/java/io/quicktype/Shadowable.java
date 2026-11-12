package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;

@JsonDeserialize(using = Shadowable.Deserializer.class)
@JsonSerialize(using = Shadowable.Serializer.class)
public class Shadowable {
    public Long[] unionArrayValue;
    public Boolean boolValue;

    static class Deserializer extends JsonDeserializer<Shadowable> {
        @Override
        public Shadowable deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Shadowable value = new Shadowable();
            switch (jsonParser.currentToken()) {
                case VALUE_TRUE:
                case VALUE_FALSE:
                    value.boolValue = jsonParser.readValueAs(Boolean.class);
                    break;
                case START_ARRAY:
                    value.unionArrayValue = jsonParser.readValueAs(Long[].class);
                    break;
                default: throw new IOException("Cannot deserialize Shadowable");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Shadowable> {
        @Override
        public void serialize(Shadowable obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.unionArrayValue != null) {
                jsonGenerator.writeObject(obj.unionArrayValue);
                return;
            }
            if (obj.boolValue != null) {
                jsonGenerator.writeObject(obj.boolValue);
                return;
            }
            throw new IOException("Shadowable must not be null");
        }
    }
}
