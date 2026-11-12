package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionWhile.Deserializer.class)
@JsonSerialize(using = UnionWhile.Serializer.class)
public class UnionWhile {
    public Double doubleValue;
    public While whileValue;

    static class Deserializer extends JsonDeserializer<UnionWhile> {
        @Override
        public UnionWhile deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionWhile value = new UnionWhile();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.whileValue = jsonParser.readValueAs(While.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionWhile");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionWhile> {
        @Override
        public void serialize(UnionWhile obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.whileValue != null) {
                jsonGenerator.writeObject(obj.whileValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
