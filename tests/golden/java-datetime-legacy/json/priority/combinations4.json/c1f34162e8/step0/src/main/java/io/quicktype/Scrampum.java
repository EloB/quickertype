package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;
import java.util.List;

@JsonDeserialize(using = Scrampum.Deserializer.class)
@JsonSerialize(using = Scrampum.Serializer.class)
public class Scrampum {
    public List<Long> integerArrayValue;
    public Boolean boolValue;

    static class Deserializer extends JsonDeserializer<Scrampum> {
        @Override
        public Scrampum deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Scrampum value = new Scrampum();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_TRUE:
                case VALUE_FALSE:
                    value.boolValue = jsonParser.readValueAs(Boolean.class);
                    break;
                case START_ARRAY:
                    value.integerArrayValue = jsonParser.readValueAs(new TypeReference<List<Long>>() {});
                    break;
                default: throw new IOException("Cannot deserialize Scrampum");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Scrampum> {
        @Override
        public void serialize(Scrampum obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.integerArrayValue != null) {
                jsonGenerator.writeObject(obj.integerArrayValue);
                return;
            }
            if (obj.boolValue != null) {
                jsonGenerator.writeObject(obj.boolValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
