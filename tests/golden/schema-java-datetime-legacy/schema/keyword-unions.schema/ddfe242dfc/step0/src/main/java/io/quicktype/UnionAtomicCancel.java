package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionAtomicCancel.Deserializer.class)
@JsonSerialize(using = UnionAtomicCancel.Serializer.class)
public class UnionAtomicCancel {
    public Double doubleValue;
    public AtomicCancel atomicCancelValue;

    static class Deserializer extends JsonDeserializer<UnionAtomicCancel> {
        @Override
        public UnionAtomicCancel deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionAtomicCancel value = new UnionAtomicCancel();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.atomicCancelValue = jsonParser.readValueAs(AtomicCancel.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionAtomicCancel");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionAtomicCancel> {
        @Override
        public void serialize(UnionAtomicCancel obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.atomicCancelValue != null) {
                jsonGenerator.writeObject(obj.atomicCancelValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
