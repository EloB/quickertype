package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionAtomicCommit.Deserializer.class)
@JsonSerialize(using = UnionAtomicCommit.Serializer.class)
public class UnionAtomicCommit {
    public Double doubleValue;
    public AtomicCommit atomicCommitValue;

    static class Deserializer extends JsonDeserializer<UnionAtomicCommit> {
        @Override
        public UnionAtomicCommit deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionAtomicCommit value = new UnionAtomicCommit();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.atomicCommitValue = jsonParser.readValueAs(AtomicCommit.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionAtomicCommit");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionAtomicCommit> {
        @Override
        public void serialize(UnionAtomicCommit obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.atomicCommitValue != null) {
                jsonGenerator.writeObject(obj.atomicCommitValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
