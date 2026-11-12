package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;

@JsonDeserialize(using = Poliorcetic.Deserializer.class)
@JsonSerialize(using = Poliorcetic.Serializer.class)
public class Poliorcetic {
    public Boolean boolValue;
    public MonaziteClass monaziteClassValue;

    static class Deserializer extends JsonDeserializer<Poliorcetic> {
        @Override
        public Poliorcetic deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Poliorcetic value = new Poliorcetic();
            switch (jsonParser.currentToken()) {
                case VALUE_TRUE:
                case VALUE_FALSE:
                    value.boolValue = jsonParser.readValueAs(Boolean.class);
                    break;
                case START_OBJECT:
                    value.monaziteClassValue = jsonParser.readValueAs(MonaziteClass.class);
                    break;
                default: throw new IOException("Cannot deserialize Poliorcetic");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Poliorcetic> {
        @Override
        public void serialize(Poliorcetic obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.boolValue != null) {
                jsonGenerator.writeObject(obj.boolValue);
                return;
            }
            if (obj.monaziteClassValue != null) {
                jsonGenerator.writeObject(obj.monaziteClassValue);
                return;
            }
            throw new IOException("Poliorcetic must not be null");
        }
    }
}
