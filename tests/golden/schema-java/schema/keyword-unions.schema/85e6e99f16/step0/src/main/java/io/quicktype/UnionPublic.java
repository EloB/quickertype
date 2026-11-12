package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionPublic.Deserializer.class)
@JsonSerialize(using = UnionPublic.Serializer.class)
public class UnionPublic {
    public Double doubleValue;
    public Public publicValue;

    static class Deserializer extends JsonDeserializer<UnionPublic> {
        @Override
        public UnionPublic deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionPublic value = new UnionPublic();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.publicValue = jsonParser.readValueAs(Public.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionPublic");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionPublic> {
        @Override
        public void serialize(UnionPublic obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.publicValue != null) {
                jsonGenerator.writeObject(obj.publicValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
