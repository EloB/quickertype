package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionThen.Deserializer.class)
@JsonSerialize(using = UnionThen.Serializer.class)
public class UnionThen {
    public Double doubleValue;
    public Then thenValue;

    static class Deserializer extends JsonDeserializer<UnionThen> {
        @Override
        public UnionThen deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionThen value = new UnionThen();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.thenValue = jsonParser.readValueAs(Then.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionThen");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionThen> {
        @Override
        public void serialize(UnionThen obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.thenValue != null) {
                jsonGenerator.writeObject(obj.thenValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
