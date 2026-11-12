package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionAtomicNoexcept.Deserializer.class)
@JsonSerialize(using = UnionAtomicNoexcept.Serializer.class)
public class UnionAtomicNoexcept {
    public Double doubleValue;
    public AtomicNoexcept atomicNoexceptValue;

    static class Deserializer extends JsonDeserializer<UnionAtomicNoexcept> {
        @Override
        public UnionAtomicNoexcept deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionAtomicNoexcept value = new UnionAtomicNoexcept();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.atomicNoexceptValue = jsonParser.readValueAs(AtomicNoexcept.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionAtomicNoexcept");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionAtomicNoexcept> {
        @Override
        public void serialize(UnionAtomicNoexcept obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.atomicNoexceptValue != null) {
                jsonGenerator.writeObject(obj.atomicNoexceptValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
