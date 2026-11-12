package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionNullUnion.Deserializer.class)
@JsonSerialize(using = UnionNullUnion.Serializer.class)
public class UnionNullUnion {
    public Double doubleValue;
    public NullClass nullClassValue;

    static class Deserializer extends JsonDeserializer<UnionNullUnion> {
        @Override
        public UnionNullUnion deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionNullUnion value = new UnionNullUnion();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.nullClassValue = jsonParser.readValueAs(NullClass.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionNullUnion");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionNullUnion> {
        @Override
        public void serialize(UnionNullUnion obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.nullClassValue != null) {
                jsonGenerator.writeObject(obj.nullClassValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
