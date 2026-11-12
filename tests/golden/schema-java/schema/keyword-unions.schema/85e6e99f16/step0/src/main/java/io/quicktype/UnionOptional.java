package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionOptional.Deserializer.class)
@JsonSerialize(using = UnionOptional.Serializer.class)
public class UnionOptional {
    public Double doubleValue;
    public Optional optionalValue;

    static class Deserializer extends JsonDeserializer<UnionOptional> {
        @Override
        public UnionOptional deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionOptional value = new UnionOptional();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.optionalValue = jsonParser.readValueAs(Optional.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionOptional");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionOptional> {
        @Override
        public void serialize(UnionOptional obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.optionalValue != null) {
                jsonGenerator.writeObject(obj.optionalValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
