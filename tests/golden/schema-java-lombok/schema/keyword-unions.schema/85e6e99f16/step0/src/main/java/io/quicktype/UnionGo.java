package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionGo.Deserializer.class)
@JsonSerialize(using = UnionGo.Serializer.class)
public class UnionGo {
    public Double doubleValue;
    public Go goValue;

    static class Deserializer extends JsonDeserializer<UnionGo> {
        @Override
        public UnionGo deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionGo value = new UnionGo();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.goValue = jsonParser.readValueAs(Go.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionGo");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionGo> {
        @Override
        public void serialize(UnionGo obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.goValue != null) {
                jsonGenerator.writeObject(obj.goValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
