package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionOrEq.Deserializer.class)
@JsonSerialize(using = UnionOrEq.Serializer.class)
public class UnionOrEq {
    public Double doubleValue;
    public OrEq orEqValue;

    static class Deserializer extends JsonDeserializer<UnionOrEq> {
        @Override
        public UnionOrEq deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionOrEq value = new UnionOrEq();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.orEqValue = jsonParser.readValueAs(OrEq.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionOrEq");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionOrEq> {
        @Override
        public void serialize(UnionOrEq obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.orEqValue != null) {
                jsonGenerator.writeObject(obj.orEqValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
