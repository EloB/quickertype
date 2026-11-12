package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;

@JsonDeserialize(using = FlagmakingElement.Deserializer.class)
@JsonSerialize(using = FlagmakingElement.Serializer.class)
public class FlagmakingElement {
    public Boolean boolValue;
    public FlagmakingClass flagmakingClassValue;
    public Double doubleValue;

    static class Deserializer extends JsonDeserializer<FlagmakingElement> {
        @Override
        public FlagmakingElement deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            FlagmakingElement value = new FlagmakingElement();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case VALUE_TRUE:
                case VALUE_FALSE:
                    value.boolValue = jsonParser.readValueAs(Boolean.class);
                    break;
                case START_OBJECT:
                    value.flagmakingClassValue = jsonParser.readValueAs(FlagmakingClass.class);
                    break;
                default: throw new IOException("Cannot deserialize FlagmakingElement");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<FlagmakingElement> {
        @Override
        public void serialize(FlagmakingElement obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.boolValue != null) {
                jsonGenerator.writeObject(obj.boolValue);
                return;
            }
            if (obj.flagmakingClassValue != null) {
                jsonGenerator.writeObject(obj.flagmakingClassValue);
                return;
            }
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            throw new IOException("FlagmakingElement must not be null");
        }
    }
}
