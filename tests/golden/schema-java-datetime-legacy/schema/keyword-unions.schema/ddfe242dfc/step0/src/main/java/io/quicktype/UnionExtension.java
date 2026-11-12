package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionExtension.Deserializer.class)
@JsonSerialize(using = UnionExtension.Serializer.class)
public class UnionExtension {
    public Double doubleValue;
    public Extension extensionValue;

    static class Deserializer extends JsonDeserializer<UnionExtension> {
        @Override
        public UnionExtension deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionExtension value = new UnionExtension();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.extensionValue = jsonParser.readValueAs(Extension.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionExtension");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionExtension> {
        @Override
        public void serialize(UnionExtension obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.extensionValue != null) {
                jsonGenerator.writeObject(obj.extensionValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
