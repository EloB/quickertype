package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = CerographElement.Deserializer.class)
@JsonSerialize(using = CerographElement.Serializer.class)
public class CerographElement {
    public CerographClass cerographClassValue;
    public String stringValue;

    static class Deserializer extends JsonDeserializer<CerographElement> {
        @Override
        public CerographElement deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            CerographElement value = new CerographElement();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    value.stringValue = string;
                    break;
                case START_OBJECT:
                    value.cerographClassValue = jsonParser.readValueAs(CerographClass.class);
                    break;
                default: throw new IOException("Cannot deserialize CerographElement");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<CerographElement> {
        @Override
        public void serialize(CerographElement obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.cerographClassValue != null) {
                jsonGenerator.writeObject(obj.cerographClassValue);
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
