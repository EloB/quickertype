package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionThrows.Deserializer.class)
@JsonSerialize(using = UnionThrows.Serializer.class)
public class UnionThrows {
    public Double doubleValue;
    public Throws throwsValue;

    static class Deserializer extends JsonDeserializer<UnionThrows> {
        @Override
        public UnionThrows deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionThrows value = new UnionThrows();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.throwsValue = jsonParser.readValueAs(Throws.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionThrows");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionThrows> {
        @Override
        public void serialize(UnionThrows obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.throwsValue != null) {
                jsonGenerator.writeObject(obj.throwsValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
