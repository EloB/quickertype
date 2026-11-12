package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionFalseUnion.Deserializer.class)
@JsonSerialize(using = UnionFalseUnion.Serializer.class)
public class UnionFalseUnion {
    public Double doubleValue;
    public FalseClass falseClassValue;

    static class Deserializer extends JsonDeserializer<UnionFalseUnion> {
        @Override
        public UnionFalseUnion deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionFalseUnion value = new UnionFalseUnion();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.falseClassValue = jsonParser.readValueAs(FalseClass.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionFalseUnion");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionFalseUnion> {
        @Override
        public void serialize(UnionFalseUnion obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.falseClassValue != null) {
                jsonGenerator.writeObject(obj.falseClassValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
