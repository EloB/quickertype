package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionTypeid.Deserializer.class)
@JsonSerialize(using = UnionTypeid.Serializer.class)
public class UnionTypeid {
    public Double doubleValue;
    public Typeid typeidValue;

    static class Deserializer extends JsonDeserializer<UnionTypeid> {
        @Override
        public UnionTypeid deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionTypeid value = new UnionTypeid();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.typeidValue = jsonParser.readValueAs(Typeid.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionTypeid");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionTypeid> {
        @Override
        public void serialize(UnionTypeid obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.typeidValue != null) {
                jsonGenerator.writeObject(obj.typeidValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
