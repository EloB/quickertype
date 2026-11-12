package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionFunction.Deserializer.class)
@JsonSerialize(using = UnionFunction.Serializer.class)
public class UnionFunction {
    public Double doubleValue;
    public Function functionValue;

    static class Deserializer extends JsonDeserializer<UnionFunction> {
        @Override
        public UnionFunction deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionFunction value = new UnionFunction();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.functionValue = jsonParser.readValueAs(Function.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionFunction");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionFunction> {
        @Override
        public void serialize(UnionFunction obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.functionValue != null) {
                jsonGenerator.writeObject(obj.functionValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
