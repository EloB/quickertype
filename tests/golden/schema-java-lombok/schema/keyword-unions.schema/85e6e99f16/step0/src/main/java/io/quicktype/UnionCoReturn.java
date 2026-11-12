package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionCoReturn.Deserializer.class)
@JsonSerialize(using = UnionCoReturn.Serializer.class)
public class UnionCoReturn {
    public Double doubleValue;
    public CoReturn coReturnValue;

    static class Deserializer extends JsonDeserializer<UnionCoReturn> {
        @Override
        public UnionCoReturn deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionCoReturn value = new UnionCoReturn();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.coReturnValue = jsonParser.readValueAs(CoReturn.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionCoReturn");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionCoReturn> {
        @Override
        public void serialize(UnionCoReturn obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.coReturnValue != null) {
                jsonGenerator.writeObject(obj.coReturnValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
