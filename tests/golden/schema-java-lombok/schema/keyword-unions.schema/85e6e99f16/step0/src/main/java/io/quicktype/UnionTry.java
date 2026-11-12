package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionTry.Deserializer.class)
@JsonSerialize(using = UnionTry.Serializer.class)
public class UnionTry {
    public Double doubleValue;
    public Try tryValue;

    static class Deserializer extends JsonDeserializer<UnionTry> {
        @Override
        public UnionTry deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionTry value = new UnionTry();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.tryValue = jsonParser.readValueAs(Try.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionTry");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionTry> {
        @Override
        public void serialize(UnionTry obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.tryValue != null) {
                jsonGenerator.writeObject(obj.tryValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
