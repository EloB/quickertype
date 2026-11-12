package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;

@JsonDeserialize(using = OutrivalElement.Deserializer.class)
@JsonSerialize(using = OutrivalElement.Serializer.class)
public class OutrivalElement {
    public OutrivalClass outrivalClassValue;
    public Double doubleValue;

    static class Deserializer extends JsonDeserializer<OutrivalElement> {
        @Override
        public OutrivalElement deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            OutrivalElement value = new OutrivalElement();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.outrivalClassValue = jsonParser.readValueAs(OutrivalClass.class);
                    break;
                default: throw new IOException("Cannot deserialize OutrivalElement");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<OutrivalElement> {
        @Override
        public void serialize(OutrivalElement obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.outrivalClassValue != null) {
                jsonGenerator.writeObject(obj.outrivalClassValue);
                return;
            }
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
