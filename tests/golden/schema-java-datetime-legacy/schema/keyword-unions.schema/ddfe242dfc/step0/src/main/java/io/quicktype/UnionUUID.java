package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionUUID.Deserializer.class)
@JsonSerialize(using = UnionUUID.Serializer.class)
public class UnionUUID {
    public Double doubleValue;
    public UUIDClass uuidClassValue;

    static class Deserializer extends JsonDeserializer<UnionUUID> {
        @Override
        public UnionUUID deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionUUID value = new UnionUUID();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.uuidClassValue = jsonParser.readValueAs(UUIDClass.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionUUID");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionUUID> {
        @Override
        public void serialize(UnionUUID obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.uuidClassValue != null) {
                jsonGenerator.writeObject(obj.uuidClassValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
