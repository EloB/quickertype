package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = LadronismElement.Deserializer.class)
@JsonSerialize(using = LadronismElement.Serializer.class)
public class LadronismElement {
    public LadronismClass ladronismClassValue;
    public Double doubleValue;
    public String stringValue;

    static class Deserializer extends JsonDeserializer<LadronismElement> {
        @Override
        public LadronismElement deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            LadronismElement value = new LadronismElement();
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
                    value.ladronismClassValue = jsonParser.readValueAs(LadronismClass.class);
                    break;
                default: throw new IOException("Cannot deserialize LadronismElement");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<LadronismElement> {
        @Override
        public void serialize(LadronismElement obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.ladronismClassValue != null) {
                jsonGenerator.writeObject(obj.ladronismClassValue);
                return;
            }
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.stringValue != null) {
                jsonGenerator.writeObject(obj.stringValue);
                return;
            }
            throw new IOException("LadronismElement must not be null");
        }
    }
}
