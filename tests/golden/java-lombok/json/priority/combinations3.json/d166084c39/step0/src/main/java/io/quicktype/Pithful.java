package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;

@JsonDeserialize(using = Pithful.Deserializer.class)
@JsonSerialize(using = Pithful.Serializer.class)
public class Pithful {
    public Boolean boolValue;
    public Long integerValue;

    static class Deserializer extends JsonDeserializer<Pithful> {
        @Override
        public Pithful deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Pithful value = new Pithful();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                    value.integerValue = jsonParser.readValueAs(Long.class);
                    break;
                case VALUE_TRUE:
                case VALUE_FALSE:
                    value.boolValue = jsonParser.readValueAs(Boolean.class);
                    break;
                default: throw new IOException("Cannot deserialize Pithful");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Pithful> {
        @Override
        public void serialize(Pithful obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.boolValue != null) {
                jsonGenerator.writeObject(obj.boolValue);
                return;
            }
            if (obj.integerValue != null) {
                jsonGenerator.writeObject(obj.integerValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
