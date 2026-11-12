package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionFunc.Deserializer.class)
@JsonSerialize(using = UnionFunc.Serializer.class)
public class UnionFunc {
    public Double doubleValue;
    public Func funcValue;

    static class Deserializer extends JsonDeserializer<UnionFunc> {
        @Override
        public UnionFunc deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionFunc value = new UnionFunc();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.funcValue = jsonParser.readValueAs(Func.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionFunc");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionFunc> {
        @Override
        public void serialize(UnionFunc obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.funcValue != null) {
                jsonGenerator.writeObject(obj.funcValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
