package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionNamespace.Deserializer.class)
@JsonSerialize(using = UnionNamespace.Serializer.class)
public class UnionNamespace {
    public Double doubleValue;
    public Namespace namespaceValue;

    static class Deserializer extends JsonDeserializer<UnionNamespace> {
        @Override
        public UnionNamespace deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionNamespace value = new UnionNamespace();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.namespaceValue = jsonParser.readValueAs(Namespace.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionNamespace");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionNamespace> {
        @Override
        public void serialize(UnionNamespace obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.namespaceValue != null) {
                jsonGenerator.writeObject(obj.namespaceValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
