package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionUnion.Deserializer.class)
@JsonSerialize(using = UnionUnion.Serializer.class)
public class UnionUnion {
    public Double doubleValue;
    public Empty emptyValue;

    static class Deserializer extends JsonDeserializer<UnionUnion> {
        @Override
        public UnionUnion deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionUnion value = new UnionUnion();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.emptyValue = jsonParser.readValueAs(Empty.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionUnion");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionUnion> {
        @Override
        public void serialize(UnionUnion obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.emptyValue != null) {
                jsonGenerator.writeObject(obj.emptyValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
