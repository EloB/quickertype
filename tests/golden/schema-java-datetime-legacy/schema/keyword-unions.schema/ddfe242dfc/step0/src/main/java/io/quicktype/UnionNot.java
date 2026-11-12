package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionNot.Deserializer.class)
@JsonSerialize(using = UnionNot.Serializer.class)
public class UnionNot {
    public Double doubleValue;
    public Not notValue;

    static class Deserializer extends JsonDeserializer<UnionNot> {
        @Override
        public UnionNot deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionNot value = new UnionNot();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.notValue = jsonParser.readValueAs(Not.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionNot");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionNot> {
        @Override
        public void serialize(UnionNot obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.notValue != null) {
                jsonGenerator.writeObject(obj.notValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
