package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionPrintf.Deserializer.class)
@JsonSerialize(using = UnionPrintf.Serializer.class)
public class UnionPrintf {
    public Double doubleValue;
    public Printf printfValue;

    static class Deserializer extends JsonDeserializer<UnionPrintf> {
        @Override
        public UnionPrintf deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionPrintf value = new UnionPrintf();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.printfValue = jsonParser.readValueAs(Printf.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionPrintf");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionPrintf> {
        @Override
        public void serialize(UnionPrintf obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.printfValue != null) {
                jsonGenerator.writeObject(obj.printfValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
