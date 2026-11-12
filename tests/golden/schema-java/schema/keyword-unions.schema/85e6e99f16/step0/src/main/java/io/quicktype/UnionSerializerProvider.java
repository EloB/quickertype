package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionSerializerProvider.Deserializer.class)
@JsonSerialize(using = UnionSerializerProvider.Serializer.class)
public class UnionSerializerProvider {
    public Double doubleValue;
    public SerializerProviderClass serializerProviderClassValue;

    static class Deserializer extends JsonDeserializer<UnionSerializerProvider> {
        @Override
        public UnionSerializerProvider deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionSerializerProvider value = new UnionSerializerProvider();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.serializerProviderClassValue = jsonParser.readValueAs(SerializerProviderClass.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionSerializerProvider");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionSerializerProvider> {
        @Override
        public void serialize(UnionSerializerProvider obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.serializerProviderClassValue != null) {
                jsonGenerator.writeObject(obj.serializerProviderClassValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
