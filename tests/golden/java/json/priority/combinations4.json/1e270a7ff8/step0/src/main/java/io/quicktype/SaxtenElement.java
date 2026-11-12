package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = SaxtenElement.Deserializer.class)
@JsonSerialize(using = SaxtenElement.Serializer.class)
public class SaxtenElement {
    public SaxtenClass saxtenClassValue;
    public String stringValue;

    static class Deserializer extends JsonDeserializer<SaxtenElement> {
        @Override
        public SaxtenElement deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            SaxtenElement value = new SaxtenElement();
            switch (jsonParser.currentToken()) {
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    value.stringValue = string;
                    break;
                case START_OBJECT:
                    value.saxtenClassValue = jsonParser.readValueAs(SaxtenClass.class);
                    break;
                default: throw new IOException("Cannot deserialize SaxtenElement");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<SaxtenElement> {
        @Override
        public void serialize(SaxtenElement obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.saxtenClassValue != null) {
                jsonGenerator.writeObject(obj.saxtenClassValue);
                return;
            }
            if (obj.stringValue != null) {
                jsonGenerator.writeObject(obj.stringValue);
                return;
            }
            throw new IOException("SaxtenElement must not be null");
        }
    }
}
