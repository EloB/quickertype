package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionNotEq.Deserializer.class)
@JsonSerialize(using = UnionNotEq.Serializer.class)
public class UnionNotEq {
    public Double doubleValue;
    public NotEq notEqValue;

    static class Deserializer extends JsonDeserializer<UnionNotEq> {
        @Override
        public UnionNotEq deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionNotEq value = new UnionNotEq();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.notEqValue = jsonParser.readValueAs(NotEq.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionNotEq");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionNotEq> {
        @Override
        public void serialize(UnionNotEq obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.notEqValue != null) {
                jsonGenerator.writeObject(obj.notEqValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
