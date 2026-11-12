package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionSuper.Deserializer.class)
@JsonSerialize(using = UnionSuper.Serializer.class)
public class UnionSuper {
    public Double doubleValue;
    public Super superValue;

    static class Deserializer extends JsonDeserializer<UnionSuper> {
        @Override
        public UnionSuper deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionSuper value = new UnionSuper();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.superValue = jsonParser.readValueAs(Super.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionSuper");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionSuper> {
        @Override
        public void serialize(UnionSuper obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.superValue != null) {
                jsonGenerator.writeObject(obj.superValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
