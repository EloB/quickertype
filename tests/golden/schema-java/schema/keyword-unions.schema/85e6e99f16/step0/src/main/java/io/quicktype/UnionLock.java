package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionLock.Deserializer.class)
@JsonSerialize(using = UnionLock.Serializer.class)
public class UnionLock {
    public Double doubleValue;
    public Lock lockValue;

    static class Deserializer extends JsonDeserializer<UnionLock> {
        @Override
        public UnionLock deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionLock value = new UnionLock();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.lockValue = jsonParser.readValueAs(Lock.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionLock");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionLock> {
        @Override
        public void serialize(UnionLock obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.lockValue != null) {
                jsonGenerator.writeObject(obj.lockValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
