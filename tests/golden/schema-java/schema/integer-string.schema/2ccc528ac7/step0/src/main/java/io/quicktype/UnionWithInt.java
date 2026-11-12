package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionWithInt.Deserializer.class)
@JsonSerialize(using = UnionWithInt.Serializer.class)
public class UnionWithInt {
    public Long integerValue;
    public String stringValue;

    static class Deserializer extends JsonDeserializer<UnionWithInt> {
        @Override
        public UnionWithInt deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionWithInt value = new UnionWithInt();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                    value.integerValue = jsonParser.readValueAs(Long.class);
                    break;
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    value.stringValue = string;
                    break;
                default: throw new IOException("Cannot deserialize UnionWithInt");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionWithInt> {
        @Override
        public void serialize(UnionWithInt obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.integerValue != null) {
                jsonGenerator.writeObject(obj.integerValue);
                return;
            }
            if (obj.stringValue != null) {
                jsonGenerator.writeObject(obj.stringValue);
                return;
            }
            throw new IOException("UnionWithInt must not be null");
        }
    }
}
