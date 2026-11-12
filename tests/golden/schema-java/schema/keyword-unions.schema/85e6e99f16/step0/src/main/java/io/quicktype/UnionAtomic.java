package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionAtomic.Deserializer.class)
@JsonSerialize(using = UnionAtomic.Serializer.class)
public class UnionAtomic {
    public Double doubleValue;
    public Atomic atomicValue;

    static class Deserializer extends JsonDeserializer<UnionAtomic> {
        @Override
        public UnionAtomic deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionAtomic value = new UnionAtomic();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.atomicValue = jsonParser.readValueAs(Atomic.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionAtomic");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionAtomic> {
        @Override
        public void serialize(UnionAtomic obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.atomicValue != null) {
                jsonGenerator.writeObject(obj.atomicValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
