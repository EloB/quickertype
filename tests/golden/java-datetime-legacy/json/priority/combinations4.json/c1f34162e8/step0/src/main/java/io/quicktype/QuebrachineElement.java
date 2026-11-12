package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = QuebrachineElement.Deserializer.class)
@JsonSerialize(using = QuebrachineElement.Serializer.class)
public class QuebrachineElement {
    public Boolean boolValue;
    public QuebrachineClass quebrachineClassValue;

    static class Deserializer extends JsonDeserializer<QuebrachineElement> {
        @Override
        public QuebrachineElement deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            QuebrachineElement value = new QuebrachineElement();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_TRUE:
                case VALUE_FALSE:
                    value.boolValue = jsonParser.readValueAs(Boolean.class);
                    break;
                case START_OBJECT:
                    value.quebrachineClassValue = jsonParser.readValueAs(QuebrachineClass.class);
                    break;
                default: throw new IOException("Cannot deserialize QuebrachineElement");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<QuebrachineElement> {
        @Override
        public void serialize(QuebrachineElement obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.boolValue != null) {
                jsonGenerator.writeObject(obj.boolValue);
                return;
            }
            if (obj.quebrachineClassValue != null) {
                jsonGenerator.writeObject(obj.quebrachineClassValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
