package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionThrow.Deserializer.class)
@JsonSerialize(using = UnionThrow.Serializer.class)
public class UnionThrow {
    public Double doubleValue;
    public Throw throwValue;

    static class Deserializer extends JsonDeserializer<UnionThrow> {
        @Override
        public UnionThrow deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionThrow value = new UnionThrow();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.throwValue = jsonParser.readValueAs(Throw.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionThrow");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionThrow> {
        @Override
        public void serialize(UnionThrow obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.throwValue != null) {
                jsonGenerator.writeObject(obj.throwValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
