package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;

@JsonDeserialize(using = CoadjustElement.Deserializer.class)
@JsonSerialize(using = CoadjustElement.Serializer.class)
public class CoadjustElement {
    public CoadjustClass coadjustClassValue;
    public Double doubleValue;

    static class Deserializer extends JsonDeserializer<CoadjustElement> {
        @Override
        public CoadjustElement deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            CoadjustElement value = new CoadjustElement();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.coadjustClassValue = jsonParser.readValueAs(CoadjustClass.class);
                    break;
                default: throw new IOException("Cannot deserialize CoadjustElement");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<CoadjustElement> {
        @Override
        public void serialize(CoadjustElement obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.coadjustClassValue != null) {
                jsonGenerator.writeObject(obj.coadjustClassValue);
                return;
            }
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            throw new IOException("CoadjustElement must not be null");
        }
    }
}
