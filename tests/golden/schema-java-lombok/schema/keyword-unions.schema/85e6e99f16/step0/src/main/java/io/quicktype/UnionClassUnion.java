package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionClassUnion.Deserializer.class)
@JsonSerialize(using = UnionClassUnion.Serializer.class)
public class UnionClassUnion {
    public Double doubleValue;
    public UnionClassClass unionClassClassValue;

    static class Deserializer extends JsonDeserializer<UnionClassUnion> {
        @Override
        public UnionClassUnion deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionClassUnion value = new UnionClassUnion();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.unionClassClassValue = jsonParser.readValueAs(UnionClassClass.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionClassUnion");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionClassUnion> {
        @Override
        public void serialize(UnionClassUnion obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.unionClassClassValue != null) {
                jsonGenerator.writeObject(obj.unionClassClassValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
