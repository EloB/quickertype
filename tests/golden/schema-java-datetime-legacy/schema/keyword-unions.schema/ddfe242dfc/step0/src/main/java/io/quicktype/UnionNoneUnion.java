package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionNoneUnion.Deserializer.class)
@JsonSerialize(using = UnionNoneUnion.Serializer.class)
public class UnionNoneUnion {
    public Double doubleValue;
    public UnionNoneNone unionNoneNoneValue;

    static class Deserializer extends JsonDeserializer<UnionNoneUnion> {
        @Override
        public UnionNoneUnion deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionNoneUnion value = new UnionNoneUnion();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.unionNoneNoneValue = jsonParser.readValueAs(UnionNoneNone.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionNoneUnion");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionNoneUnion> {
        @Override
        public void serialize(UnionNoneUnion obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.unionNoneNoneValue != null) {
                jsonGenerator.writeObject(obj.unionNoneNoneValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
