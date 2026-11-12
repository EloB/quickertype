package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;
import java.util.List;

@JsonDeserialize(using = Monoliteral.Deserializer.class)
@JsonSerialize(using = Monoliteral.Serializer.class)
public class Monoliteral {
    public List<Object> nullArrayValue;
    public Boolean boolValue;

    static class Deserializer extends JsonDeserializer<Monoliteral> {
        @Override
        public Monoliteral deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Monoliteral value = new Monoliteral();
            switch (jsonParser.currentToken()) {
                case VALUE_TRUE:
                case VALUE_FALSE:
                    value.boolValue = jsonParser.readValueAs(Boolean.class);
                    break;
                case START_ARRAY:
                    value.nullArrayValue = jsonParser.readValueAs(new TypeReference<List<Object>>() {});
                    break;
                default: throw new IOException("Cannot deserialize Monoliteral");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Monoliteral> {
        @Override
        public void serialize(Monoliteral obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.nullArrayValue != null) {
                jsonGenerator.writeObject(obj.nullArrayValue);
                return;
            }
            if (obj.boolValue != null) {
                jsonGenerator.writeObject(obj.boolValue);
                return;
            }
            throw new IOException("Monoliteral must not be null");
        }
    }
}
