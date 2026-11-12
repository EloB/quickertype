package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;

@JsonDeserialize(using = Clinodome.Deserializer.class)
@JsonSerialize(using = Clinodome.Serializer.class)
public class Clinodome {
    public Double doubleValue;
    public String stringValue;

    static class Deserializer extends JsonDeserializer<Clinodome> {
        @Override
        public Clinodome deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Clinodome value = new Clinodome();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    value.stringValue = string;
                    break;
                default: throw new IOException("Cannot deserialize Clinodome");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Clinodome> {
        @Override
        public void serialize(Clinodome obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.stringValue != null) {
                jsonGenerator.writeObject(obj.stringValue);
                return;
            }
            throw new IOException("Clinodome must not be null");
        }
    }
}
