package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = FagginglyElement.Deserializer.class)
@JsonSerialize(using = FagginglyElement.Serializer.class)
public class FagginglyElement {
    public FagginglyClass fagginglyClassValue;
    public Double doubleValue;

    static class Deserializer extends JsonDeserializer<FagginglyElement> {
        @Override
        public FagginglyElement deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            FagginglyElement value = new FagginglyElement();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.fagginglyClassValue = jsonParser.readValueAs(FagginglyClass.class);
                    break;
                default: throw new IOException("Cannot deserialize FagginglyElement");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<FagginglyElement> {
        @Override
        public void serialize(FagginglyElement obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.fagginglyClassValue != null) {
                jsonGenerator.writeObject(obj.fagginglyClassValue);
                return;
            }
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            throw new IOException("FagginglyElement must not be null");
        }
    }
}
