package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionBoolUnion.Deserializer.class)
@JsonSerialize(using = UnionBoolUnion.Serializer.class)
public class UnionBoolUnion {
    public Double doubleValue;
    public BoolClass boolClassValue;

    static class Deserializer extends JsonDeserializer<UnionBoolUnion> {
        @Override
        public UnionBoolUnion deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionBoolUnion value = new UnionBoolUnion();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.boolClassValue = jsonParser.readValueAs(BoolClass.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionBoolUnion");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionBoolUnion> {
        @Override
        public void serialize(UnionBoolUnion obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.boolClassValue != null) {
                jsonGenerator.writeObject(obj.boolClassValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
