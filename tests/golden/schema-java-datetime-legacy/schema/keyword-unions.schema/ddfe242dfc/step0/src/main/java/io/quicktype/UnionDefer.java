package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionDefer.Deserializer.class)
@JsonSerialize(using = UnionDefer.Serializer.class)
public class UnionDefer {
    public Double doubleValue;
    public Defer deferValue;

    static class Deserializer extends JsonDeserializer<UnionDefer> {
        @Override
        public UnionDefer deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionDefer value = new UnionDefer();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.deferValue = jsonParser.readValueAs(Defer.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionDefer");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionDefer> {
        @Override
        public void serialize(UnionDefer obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.deferValue != null) {
                jsonGenerator.writeObject(obj.deferValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
