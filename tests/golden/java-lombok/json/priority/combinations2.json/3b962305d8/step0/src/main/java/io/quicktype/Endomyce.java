package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = Endomyce.Deserializer.class)
@JsonSerialize(using = Endomyce.Serializer.class)
public class Endomyce {
    public Long integerValue;
    public String stringValue;

    static class Deserializer extends JsonDeserializer<Endomyce> {
        @Override
        public Endomyce deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Endomyce value = new Endomyce();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                    value.integerValue = jsonParser.readValueAs(Long.class);
                    break;
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    value.stringValue = string;
                    break;
                default: throw new IOException("Cannot deserialize Endomyce");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Endomyce> {
        @Override
        public void serialize(Endomyce obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.integerValue != null) {
                jsonGenerator.writeObject(obj.integerValue);
                return;
            }
            if (obj.stringValue != null) {
                jsonGenerator.writeObject(obj.stringValue);
                return;
            }
            throw new IOException("Endomyce must not be null");
        }
    }
}
