package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionHashable.Deserializer.class)
@JsonSerialize(using = UnionHashable.Serializer.class)
public class UnionHashable {
    public Double doubleValue;
    public Hashable hashableValue;

    static class Deserializer extends JsonDeserializer<UnionHashable> {
        @Override
        public UnionHashable deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionHashable value = new UnionHashable();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.hashableValue = jsonParser.readValueAs(Hashable.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionHashable");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionHashable> {
        @Override
        public void serialize(UnionHashable obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.hashableValue != null) {
                jsonGenerator.writeObject(obj.hashableValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
