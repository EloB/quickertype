package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;
import java.util.List;

@JsonDeserialize(using = AnkeeElement.Deserializer.class)
@JsonSerialize(using = AnkeeElement.Serializer.class)
public class AnkeeElement {
    public List<Long> integerArrayValue;
    public AnkeeClass ankeeClassValue;
    public Long integerValue;

    static class Deserializer extends JsonDeserializer<AnkeeElement> {
        @Override
        public AnkeeElement deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            AnkeeElement value = new AnkeeElement();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                    value.integerValue = jsonParser.readValueAs(Long.class);
                    break;
                case START_ARRAY:
                    value.integerArrayValue = jsonParser.readValueAs(new TypeReference<List<Long>>() {});
                    break;
                case START_OBJECT:
                    value.ankeeClassValue = jsonParser.readValueAs(AnkeeClass.class);
                    break;
                default: throw new IOException("Cannot deserialize AnkeeElement");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<AnkeeElement> {
        @Override
        public void serialize(AnkeeElement obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.integerArrayValue != null) {
                jsonGenerator.writeObject(obj.integerArrayValue);
                return;
            }
            if (obj.ankeeClassValue != null) {
                jsonGenerator.writeObject(obj.ankeeClassValue);
                return;
            }
            if (obj.integerValue != null) {
                jsonGenerator.writeObject(obj.integerValue);
                return;
            }
            throw new IOException("AnkeeElement must not be null");
        }
    }
}
