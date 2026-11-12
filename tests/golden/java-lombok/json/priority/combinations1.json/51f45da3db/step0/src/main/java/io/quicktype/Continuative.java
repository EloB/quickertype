package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import java.util.Map;

@JsonDeserialize(using = Continuative.Deserializer.class)
@JsonSerialize(using = Continuative.Serializer.class)
public class Continuative {
    public Map<String, Long> integerMapValue;
    public String stringValue;

    static class Deserializer extends JsonDeserializer<Continuative> {
        @Override
        public Continuative deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Continuative value = new Continuative();
            switch (jsonParser.currentToken()) {
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    value.stringValue = string;
                    break;
                case START_OBJECT:
                    value.integerMapValue = jsonParser.readValueAs(Map.class);
                    break;
                default: throw new IOException("Cannot deserialize Continuative");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Continuative> {
        @Override
        public void serialize(Continuative obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.integerMapValue != null) {
                jsonGenerator.writeObject(obj.integerMapValue);
                return;
            }
            if (obj.stringValue != null) {
                jsonGenerator.writeObject(obj.stringValue);
                return;
            }
            throw new IOException("Continuative must not be null");
        }
    }
}
