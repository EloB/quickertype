package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionReturn.Deserializer.class)
@JsonSerialize(using = UnionReturn.Serializer.class)
public class UnionReturn {
    public Double doubleValue;
    public Return returnValue;

    static class Deserializer extends JsonDeserializer<UnionReturn> {
        @Override
        public UnionReturn deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionReturn value = new UnionReturn();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.returnValue = jsonParser.readValueAs(Return.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionReturn");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionReturn> {
        @Override
        public void serialize(UnionReturn obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.returnValue != null) {
                jsonGenerator.writeObject(obj.returnValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
