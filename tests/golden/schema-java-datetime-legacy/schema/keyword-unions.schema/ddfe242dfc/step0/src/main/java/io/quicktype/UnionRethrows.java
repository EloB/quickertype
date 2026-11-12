package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionRethrows.Deserializer.class)
@JsonSerialize(using = UnionRethrows.Serializer.class)
public class UnionRethrows {
    public Double doubleValue;
    public Rethrows rethrowsValue;

    static class Deserializer extends JsonDeserializer<UnionRethrows> {
        @Override
        public UnionRethrows deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionRethrows value = new UnionRethrows();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.rethrowsValue = jsonParser.readValueAs(Rethrows.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionRethrows");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionRethrows> {
        @Override
        public void serialize(UnionRethrows obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.rethrowsValue != null) {
                jsonGenerator.writeObject(obj.rethrowsValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
