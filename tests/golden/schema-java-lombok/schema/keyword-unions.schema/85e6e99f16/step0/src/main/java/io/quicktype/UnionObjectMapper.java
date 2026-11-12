package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionObjectMapper.Deserializer.class)
@JsonSerialize(using = UnionObjectMapper.Serializer.class)
public class UnionObjectMapper {
    public Double doubleValue;
    public ObjectMapperClass objectMapperClassValue;

    static class Deserializer extends JsonDeserializer<UnionObjectMapper> {
        @Override
        public UnionObjectMapper deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionObjectMapper value = new UnionObjectMapper();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.objectMapperClassValue = jsonParser.readValueAs(ObjectMapperClass.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionObjectMapper");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionObjectMapper> {
        @Override
        public void serialize(UnionObjectMapper obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.objectMapperClassValue != null) {
                jsonGenerator.writeObject(obj.objectMapperClassValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
