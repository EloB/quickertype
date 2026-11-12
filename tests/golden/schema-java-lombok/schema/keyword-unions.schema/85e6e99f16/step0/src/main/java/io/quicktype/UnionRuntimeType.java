package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionRuntimeType.Deserializer.class)
@JsonSerialize(using = UnionRuntimeType.Serializer.class)
public class UnionRuntimeType {
    public Double doubleValue;
    public RuntimeType runtimeTypeValue;

    static class Deserializer extends JsonDeserializer<UnionRuntimeType> {
        @Override
        public UnionRuntimeType deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionRuntimeType value = new UnionRuntimeType();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.runtimeTypeValue = jsonParser.readValueAs(RuntimeType.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionRuntimeType");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionRuntimeType> {
        @Override
        public void serialize(UnionRuntimeType obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.runtimeTypeValue != null) {
                jsonGenerator.writeObject(obj.runtimeTypeValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
