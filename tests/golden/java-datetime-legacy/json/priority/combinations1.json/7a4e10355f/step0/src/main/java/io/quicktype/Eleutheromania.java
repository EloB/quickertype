package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import java.util.Map;

@JsonDeserialize(using = Eleutheromania.Deserializer.class)
@JsonSerialize(using = Eleutheromania.Serializer.class)
public class Eleutheromania {
    public Double doubleValue;
    public Map<String, Long> integerMapValue;
    public String stringValue;

    static class Deserializer extends JsonDeserializer<Eleutheromania> {
        @Override
        public Eleutheromania deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Eleutheromania value = new Eleutheromania();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    value.stringValue = string;
                    break;
                case START_OBJECT:
                    value.integerMapValue = jsonParser.readValueAs(Map.class);
                    break;
                default: throw new IOException("Cannot deserialize Eleutheromania");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Eleutheromania> {
        @Override
        public void serialize(Eleutheromania obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
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
            throw new IOException("Eleutheromania must not be null");
        }
    }
}
