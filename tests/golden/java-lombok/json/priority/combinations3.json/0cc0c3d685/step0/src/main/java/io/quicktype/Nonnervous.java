package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = Nonnervous.Deserializer.class)
@JsonSerialize(using = Nonnervous.Serializer.class)
public class Nonnervous {
    public Boolean boolValue;
    public Long integerValue;

    static class Deserializer extends JsonDeserializer<Nonnervous> {
        @Override
        public Nonnervous deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Nonnervous value = new Nonnervous();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                    value.integerValue = jsonParser.readValueAs(Long.class);
                    break;
                case VALUE_TRUE:
                case VALUE_FALSE:
                    value.boolValue = jsonParser.readValueAs(Boolean.class);
                    break;
                default: throw new IOException("Cannot deserialize Nonnervous");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Nonnervous> {
        @Override
        public void serialize(Nonnervous obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.boolValue != null) {
                jsonGenerator.writeObject(obj.boolValue);
                return;
            }
            if (obj.integerValue != null) {
                jsonGenerator.writeObject(obj.integerValue);
                return;
            }
            throw new IOException("Nonnervous must not be null");
        }
    }
}
