package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionIs.Deserializer.class)
@JsonSerialize(using = UnionIs.Serializer.class)
public class UnionIs {
    public Double doubleValue;
    public Is isValue;

    static class Deserializer extends JsonDeserializer<UnionIs> {
        @Override
        public UnionIs deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionIs value = new UnionIs();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.isValue = jsonParser.readValueAs(Is.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionIs");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionIs> {
        @Override
        public void serialize(UnionIs obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.isValue != null) {
                jsonGenerator.writeObject(obj.isValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
