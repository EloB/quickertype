package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionFinally.Deserializer.class)
@JsonSerialize(using = UnionFinally.Serializer.class)
public class UnionFinally {
    public Double doubleValue;
    public Finally finallyValue;

    static class Deserializer extends JsonDeserializer<UnionFinally> {
        @Override
        public UnionFinally deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionFinally value = new UnionFinally();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.finallyValue = jsonParser.readValueAs(Finally.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionFinally");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionFinally> {
        @Override
        public void serialize(UnionFinally obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.finallyValue != null) {
                jsonGenerator.writeObject(obj.finallyValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
