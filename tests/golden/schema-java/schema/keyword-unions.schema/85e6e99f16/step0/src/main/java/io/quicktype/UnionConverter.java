package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionConverter.Deserializer.class)
@JsonSerialize(using = UnionConverter.Serializer.class)
public class UnionConverter {
    public Double doubleValue;
    public ConverterClass converterClassValue;

    static class Deserializer extends JsonDeserializer<UnionConverter> {
        @Override
        public UnionConverter deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionConverter value = new UnionConverter();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.converterClassValue = jsonParser.readValueAs(ConverterClass.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionConverter");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionConverter> {
        @Override
        public void serialize(UnionConverter obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.converterClassValue != null) {
                jsonGenerator.writeObject(obj.converterClassValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
