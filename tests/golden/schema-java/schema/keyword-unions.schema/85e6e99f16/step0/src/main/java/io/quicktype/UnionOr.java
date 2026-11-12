package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionOr.Deserializer.class)
@JsonSerialize(using = UnionOr.Serializer.class)
public class UnionOr {
    public Double doubleValue;
    public Or orValue;

    static class Deserializer extends JsonDeserializer<UnionOr> {
        @Override
        public UnionOr deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionOr value = new UnionOr();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.orValue = jsonParser.readValueAs(Or.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionOr");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionOr> {
        @Override
        public void serialize(UnionOr obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.orValue != null) {
                jsonGenerator.writeObject(obj.orValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
