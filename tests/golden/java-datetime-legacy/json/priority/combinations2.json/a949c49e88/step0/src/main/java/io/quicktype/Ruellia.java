package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;

@JsonDeserialize(using = Ruellia.Deserializer.class)
@JsonSerialize(using = Ruellia.Serializer.class)
public class Ruellia {
    public Boolean boolValue;
    public Rebecca rebeccaValue;
    public String stringValue;

    static class Deserializer extends JsonDeserializer<Ruellia> {
        @Override
        public Ruellia deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Ruellia value = new Ruellia();
            switch (jsonParser.currentToken()) {
                case VALUE_TRUE:
                case VALUE_FALSE:
                    value.boolValue = jsonParser.readValueAs(Boolean.class);
                    break;
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    value.stringValue = string;
                    break;
                case START_OBJECT:
                    value.rebeccaValue = jsonParser.readValueAs(Rebecca.class);
                    break;
                default: throw new IOException("Cannot deserialize Ruellia");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Ruellia> {
        @Override
        public void serialize(Ruellia obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.boolValue != null) {
                jsonGenerator.writeObject(obj.boolValue);
                return;
            }
            if (obj.rebeccaValue != null) {
                jsonGenerator.writeObject(obj.rebeccaValue);
                return;
            }
            if (obj.stringValue != null) {
                jsonGenerator.writeObject(obj.stringValue);
                return;
            }
            throw new IOException("Ruellia must not be null");
        }
    }
}
