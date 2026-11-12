package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionGuard.Deserializer.class)
@JsonSerialize(using = UnionGuard.Serializer.class)
public class UnionGuard {
    public Double doubleValue;
    public Guard guardValue;

    static class Deserializer extends JsonDeserializer<UnionGuard> {
        @Override
        public UnionGuard deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionGuard value = new UnionGuard();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.guardValue = jsonParser.readValueAs(Guard.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionGuard");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionGuard> {
        @Override
        public void serialize(UnionGuard obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.guardValue != null) {
                jsonGenerator.writeObject(obj.guardValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
