package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;

@JsonDeserialize(using = OskarElement.Deserializer.class)
@JsonSerialize(using = OskarElement.Serializer.class)
public class OskarElement {
    public long[] integerArrayValue;
    public OskarClass oskarClassValue;

    static class Deserializer extends JsonDeserializer<OskarElement> {
        @Override
        public OskarElement deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            OskarElement value = new OskarElement();
            switch (jsonParser.currentToken()) {
                case START_ARRAY:
                    value.integerArrayValue = jsonParser.readValueAs(long[].class);
                    break;
                case START_OBJECT:
                    value.oskarClassValue = jsonParser.readValueAs(OskarClass.class);
                    break;
                default: throw new IOException("Cannot deserialize OskarElement");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<OskarElement> {
        @Override
        public void serialize(OskarElement obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.integerArrayValue != null) {
                jsonGenerator.writeObject(obj.integerArrayValue);
                return;
            }
            if (obj.oskarClassValue != null) {
                jsonGenerator.writeObject(obj.oskarClassValue);
                return;
            }
            throw new IOException("OskarElement must not be null");
        }
    }
}
