package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;

@JsonDeserialize(using = Hoister.Deserializer.class)
@JsonSerialize(using = Hoister.Serializer.class)
public class Hoister {
    public CimeliaClass cimeliaClassValue;
    public String stringValue;

    static class Deserializer extends JsonDeserializer<Hoister> {
        @Override
        public Hoister deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Hoister value = new Hoister();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    value.stringValue = string;
                    break;
                case START_OBJECT:
                    value.cimeliaClassValue = jsonParser.readValueAs(CimeliaClass.class);
                    break;
                default: throw new IOException("Cannot deserialize Hoister");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Hoister> {
        @Override
        public void serialize(Hoister obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.cimeliaClassValue != null) {
                jsonGenerator.writeObject(obj.cimeliaClassValue);
                return;
            }
            if (obj.stringValue != null) {
                jsonGenerator.writeObject(obj.stringValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
