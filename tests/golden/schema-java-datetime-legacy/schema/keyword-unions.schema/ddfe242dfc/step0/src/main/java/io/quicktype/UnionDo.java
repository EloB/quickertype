package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionDo.Deserializer.class)
@JsonSerialize(using = UnionDo.Serializer.class)
public class UnionDo {
    public Double doubleValue;
    public Do doValue;

    static class Deserializer extends JsonDeserializer<UnionDo> {
        @Override
        public UnionDo deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionDo value = new UnionDo();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.doValue = jsonParser.readValueAs(Do.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionDo");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionDo> {
        @Override
        public void serialize(UnionDo obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.doValue != null) {
                jsonGenerator.writeObject(obj.doValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
