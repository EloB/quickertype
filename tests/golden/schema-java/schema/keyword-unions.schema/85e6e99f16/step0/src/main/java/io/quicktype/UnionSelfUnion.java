package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionSelfUnion.Deserializer.class)
@JsonSerialize(using = UnionSelfUnion.Serializer.class)
public class UnionSelfUnion {
    public Double doubleValue;
    public SelfClass selfClassValue;

    static class Deserializer extends JsonDeserializer<UnionSelfUnion> {
        @Override
        public UnionSelfUnion deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionSelfUnion value = new UnionSelfUnion();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.selfClassValue = jsonParser.readValueAs(SelfClass.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionSelfUnion");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionSelfUnion> {
        @Override
        public void serialize(UnionSelfUnion obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.selfClassValue != null) {
                jsonGenerator.writeObject(obj.selfClassValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
