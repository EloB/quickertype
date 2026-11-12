package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionAnyUnion.Deserializer.class)
@JsonSerialize(using = UnionAnyUnion.Serializer.class)
public class UnionAnyUnion {
    public Double doubleValue;
    public AnyClass anyClassValue;

    static class Deserializer extends JsonDeserializer<UnionAnyUnion> {
        @Override
        public UnionAnyUnion deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionAnyUnion value = new UnionAnyUnion();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.anyClassValue = jsonParser.readValueAs(AnyClass.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionAnyUnion");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionAnyUnion> {
        @Override
        public void serialize(UnionAnyUnion obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.anyClassValue != null) {
                jsonGenerator.writeObject(obj.anyClassValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
