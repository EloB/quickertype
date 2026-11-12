package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import java.util.Map;

@JsonDeserialize(using = Unvarying.Deserializer.class)
@JsonSerialize(using = Unvarying.Serializer.class)
public class Unvarying {
    public Boolean boolValue;
    public Double doubleValue;
    public Map<String, Long> integerMapValue;

    static class Deserializer extends JsonDeserializer<Unvarying> {
        @Override
        public Unvarying deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Unvarying value = new Unvarying();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case VALUE_TRUE:
                case VALUE_FALSE:
                    value.boolValue = jsonParser.readValueAs(Boolean.class);
                    break;
                case START_OBJECT:
                    value.integerMapValue = jsonParser.readValueAs(Map.class);
                    break;
                default: throw new IOException("Cannot deserialize Unvarying");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Unvarying> {
        @Override
        public void serialize(Unvarying obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.boolValue != null) {
                jsonGenerator.writeObject(obj.boolValue);
                return;
            }
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.integerMapValue != null) {
                jsonGenerator.writeObject(obj.integerMapValue);
                return;
            }
            throw new IOException("Unvarying must not be null");
        }
    }
}
