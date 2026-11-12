package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionRequire.Deserializer.class)
@JsonSerialize(using = UnionRequire.Serializer.class)
public class UnionRequire {
    public Double doubleValue;
    public Require requireValue;

    static class Deserializer extends JsonDeserializer<UnionRequire> {
        @Override
        public UnionRequire deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionRequire value = new UnionRequire();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.requireValue = jsonParser.readValueAs(Require.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionRequire");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionRequire> {
        @Override
        public void serialize(UnionRequire obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.requireValue != null) {
                jsonGenerator.writeObject(obj.requireValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
