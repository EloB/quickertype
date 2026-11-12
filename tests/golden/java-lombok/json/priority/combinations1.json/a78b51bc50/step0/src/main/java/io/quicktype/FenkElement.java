package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = FenkElement.Deserializer.class)
@JsonSerialize(using = FenkElement.Serializer.class)
public class FenkElement {
    public FenkClass fenkClassValue;
    public String stringValue;

    static class Deserializer extends JsonDeserializer<FenkElement> {
        @Override
        public FenkElement deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            FenkElement value = new FenkElement();
            switch (jsonParser.currentToken()) {
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    value.stringValue = string;
                    break;
                case START_OBJECT:
                    value.fenkClassValue = jsonParser.readValueAs(FenkClass.class);
                    break;
                default: throw new IOException("Cannot deserialize FenkElement");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<FenkElement> {
        @Override
        public void serialize(FenkElement obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.fenkClassValue != null) {
                jsonGenerator.writeObject(obj.fenkClassValue);
                return;
            }
            if (obj.stringValue != null) {
                jsonGenerator.writeObject(obj.stringValue);
                return;
            }
            throw new IOException("FenkElement must not be null");
        }
    }
}
