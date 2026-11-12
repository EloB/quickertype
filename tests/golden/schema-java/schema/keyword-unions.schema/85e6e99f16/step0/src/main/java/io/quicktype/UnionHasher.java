package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionHasher.Deserializer.class)
@JsonSerialize(using = UnionHasher.Serializer.class)
public class UnionHasher {
    public Double doubleValue;
    public Hasher hasherValue;

    static class Deserializer extends JsonDeserializer<UnionHasher> {
        @Override
        public UnionHasher deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionHasher value = new UnionHasher();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.hasherValue = jsonParser.readValueAs(Hasher.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionHasher");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionHasher> {
        @Override
        public void serialize(UnionHasher obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.hasherValue != null) {
                jsonGenerator.writeObject(obj.hasherValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
