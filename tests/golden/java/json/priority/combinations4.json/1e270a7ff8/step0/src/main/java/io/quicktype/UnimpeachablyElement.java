package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnimpeachablyElement.Deserializer.class)
@JsonSerialize(using = UnimpeachablyElement.Serializer.class)
public class UnimpeachablyElement {
    public Boolean boolValue;
    public UnimpeachablyClass unimpeachablyClassValue;

    static class Deserializer extends JsonDeserializer<UnimpeachablyElement> {
        @Override
        public UnimpeachablyElement deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnimpeachablyElement value = new UnimpeachablyElement();
            switch (jsonParser.currentToken()) {
                case VALUE_TRUE:
                case VALUE_FALSE:
                    value.boolValue = jsonParser.readValueAs(Boolean.class);
                    break;
                case START_OBJECT:
                    value.unimpeachablyClassValue = jsonParser.readValueAs(UnimpeachablyClass.class);
                    break;
                default: throw new IOException("Cannot deserialize UnimpeachablyElement");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnimpeachablyElement> {
        @Override
        public void serialize(UnimpeachablyElement obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.boolValue != null) {
                jsonGenerator.writeObject(obj.boolValue);
                return;
            }
            if (obj.unimpeachablyClassValue != null) {
                jsonGenerator.writeObject(obj.unimpeachablyClassValue);
                return;
            }
            throw new IOException("UnimpeachablyElement must not be null");
        }
    }
}
