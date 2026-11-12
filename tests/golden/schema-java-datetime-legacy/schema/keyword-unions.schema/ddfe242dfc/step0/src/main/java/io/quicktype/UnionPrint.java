package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionPrint.Deserializer.class)
@JsonSerialize(using = UnionPrint.Serializer.class)
public class UnionPrint {
    public Double doubleValue;
    public Print printValue;

    static class Deserializer extends JsonDeserializer<UnionPrint> {
        @Override
        public UnionPrint deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionPrint value = new UnionPrint();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.printValue = jsonParser.readValueAs(Print.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionPrint");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionPrint> {
        @Override
        public void serialize(UnionPrint obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.printValue != null) {
                jsonGenerator.writeObject(obj.printValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
