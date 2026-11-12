package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionRegExp.Deserializer.class)
@JsonSerialize(using = UnionRegExp.Serializer.class)
public class UnionRegExp {
    public Double doubleValue;
    public RegExp regExpValue;

    static class Deserializer extends JsonDeserializer<UnionRegExp> {
        @Override
        public UnionRegExp deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionRegExp value = new UnionRegExp();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.regExpValue = jsonParser.readValueAs(RegExp.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionRegExp");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionRegExp> {
        @Override
        public void serialize(UnionRegExp obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.regExpValue != null) {
                jsonGenerator.writeObject(obj.regExpValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
