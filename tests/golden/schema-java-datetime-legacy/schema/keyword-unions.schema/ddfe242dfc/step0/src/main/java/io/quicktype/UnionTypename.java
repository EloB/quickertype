package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionTypename.Deserializer.class)
@JsonSerialize(using = UnionTypename.Serializer.class)
public class UnionTypename {
    public Double doubleValue;
    public Typename typenameValue;

    static class Deserializer extends JsonDeserializer<UnionTypename> {
        @Override
        public UnionTypename deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionTypename value = new UnionTypename();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.typenameValue = jsonParser.readValueAs(Typename.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionTypename");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionTypename> {
        @Override
        public void serialize(UnionTypename obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.typenameValue != null) {
                jsonGenerator.writeObject(obj.typenameValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
