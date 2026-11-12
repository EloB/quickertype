package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionIterable.Deserializer.class)
@JsonSerialize(using = UnionIterable.Serializer.class)
public class UnionIterable {
    public Double doubleValue;
    public Iterable iterableValue;

    static class Deserializer extends JsonDeserializer<UnionIterable> {
        @Override
        public UnionIterable deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionIterable value = new UnionIterable();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.iterableValue = jsonParser.readValueAs(Iterable.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionIterable");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionIterable> {
        @Override
        public void serialize(UnionIterable obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.iterableValue != null) {
                jsonGenerator.writeObject(obj.iterableValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
