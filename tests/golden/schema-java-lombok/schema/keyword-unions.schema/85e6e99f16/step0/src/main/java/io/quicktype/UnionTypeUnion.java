package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionTypeUnion.Deserializer.class)
@JsonSerialize(using = UnionTypeUnion.Serializer.class)
public class UnionTypeUnion {
    public Double doubleValue;
    public TypeClass typeClassValue;

    static class Deserializer extends JsonDeserializer<UnionTypeUnion> {
        @Override
        public UnionTypeUnion deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionTypeUnion value = new UnionTypeUnion();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.typeClassValue = jsonParser.readValueAs(TypeClass.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionTypeUnion");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionTypeUnion> {
        @Override
        public void serialize(UnionTypeUnion obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.typeClassValue != null) {
                jsonGenerator.writeObject(obj.typeClassValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
