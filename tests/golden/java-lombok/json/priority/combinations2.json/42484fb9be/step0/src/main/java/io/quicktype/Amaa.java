package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;

@JsonDeserialize(using = Amaa.Deserializer.class)
@JsonSerialize(using = Amaa.Serializer.class)
public class Amaa {
    public Boolean boolValue;
    public Rebecca rebeccaValue;
    public Long integerValue;

    static class Deserializer extends JsonDeserializer<Amaa> {
        @Override
        public Amaa deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Amaa value = new Amaa();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                    value.integerValue = jsonParser.readValueAs(Long.class);
                    break;
                case VALUE_TRUE:
                case VALUE_FALSE:
                    value.boolValue = jsonParser.readValueAs(Boolean.class);
                    break;
                case START_OBJECT:
                    value.rebeccaValue = jsonParser.readValueAs(Rebecca.class);
                    break;
                default: throw new IOException("Cannot deserialize Amaa");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Amaa> {
        @Override
        public void serialize(Amaa obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.boolValue != null) {
                jsonGenerator.writeObject(obj.boolValue);
                return;
            }
            if (obj.rebeccaValue != null) {
                jsonGenerator.writeObject(obj.rebeccaValue);
                return;
            }
            if (obj.integerValue != null) {
                jsonGenerator.writeObject(obj.integerValue);
                return;
            }
            throw new IOException("Amaa must not be null");
        }
    }
}
