package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;
import java.util.List;

@JsonDeserialize(using = DeruralizeElement.Deserializer.class)
@JsonSerialize(using = DeruralizeElement.Serializer.class)
public class DeruralizeElement {
    public List<Object> nullArrayValue;
    public Boolean boolValue;
    public DeruralizeClass deruralizeClassValue;

    static class Deserializer extends JsonDeserializer<DeruralizeElement> {
        @Override
        public DeruralizeElement deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            DeruralizeElement value = new DeruralizeElement();
            switch (jsonParser.currentToken()) {
                case VALUE_TRUE:
                case VALUE_FALSE:
                    value.boolValue = jsonParser.readValueAs(Boolean.class);
                    break;
                case START_ARRAY:
                    value.nullArrayValue = jsonParser.readValueAs(new TypeReference<List<Object>>() {});
                    break;
                case START_OBJECT:
                    value.deruralizeClassValue = jsonParser.readValueAs(DeruralizeClass.class);
                    break;
                default: throw new IOException("Cannot deserialize DeruralizeElement");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<DeruralizeElement> {
        @Override
        public void serialize(DeruralizeElement obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.nullArrayValue != null) {
                jsonGenerator.writeObject(obj.nullArrayValue);
                return;
            }
            if (obj.boolValue != null) {
                jsonGenerator.writeObject(obj.boolValue);
                return;
            }
            if (obj.deruralizeClassValue != null) {
                jsonGenerator.writeObject(obj.deruralizeClassValue);
                return;
            }
            throw new IOException("DeruralizeElement must not be null");
        }
    }
}
