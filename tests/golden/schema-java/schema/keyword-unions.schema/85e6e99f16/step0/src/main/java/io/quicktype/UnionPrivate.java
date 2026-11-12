package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionPrivate.Deserializer.class)
@JsonSerialize(using = UnionPrivate.Serializer.class)
public class UnionPrivate {
    public Double doubleValue;
    public Private privateValue;

    static class Deserializer extends JsonDeserializer<UnionPrivate> {
        @Override
        public UnionPrivate deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionPrivate value = new UnionPrivate();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.privateValue = jsonParser.readValueAs(Private.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionPrivate");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionPrivate> {
        @Override
        public void serialize(UnionPrivate obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.privateValue != null) {
                jsonGenerator.writeObject(obj.privateValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
