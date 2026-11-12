package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionS.Deserializer.class)
@JsonSerialize(using = UnionS.Serializer.class)
public class UnionS {
    public Double doubleValue;
    public S sValue;

    static class Deserializer extends JsonDeserializer<UnionS> {
        @Override
        public UnionS deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionS value = new UnionS();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.sValue = jsonParser.readValueAs(S.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionS");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionS> {
        @Override
        public void serialize(UnionS obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.sValue != null) {
                jsonGenerator.writeObject(obj.sValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
