package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionUnionUnion.Deserializer.class)
@JsonSerialize(using = UnionUnionUnion.Serializer.class)
public class UnionUnionUnion {
    public Double doubleValue;
    public Union unionValue;

    static class Deserializer extends JsonDeserializer<UnionUnionUnion> {
        @Override
        public UnionUnionUnion deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionUnionUnion value = new UnionUnionUnion();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.unionValue = jsonParser.readValueAs(Union.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionUnionUnion");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionUnionUnion> {
        @Override
        public void serialize(UnionUnionUnion obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.unionValue != null) {
                jsonGenerator.writeObject(obj.unionValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
