package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionIf.Deserializer.class)
@JsonSerialize(using = UnionIf.Serializer.class)
public class UnionIf {
    public Double doubleValue;
    public If ifValue;

    static class Deserializer extends JsonDeserializer<UnionIf> {
        @Override
        public UnionIf deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionIf value = new UnionIf();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.ifValue = jsonParser.readValueAs(If.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionIf");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionIf> {
        @Override
        public void serialize(UnionIf obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.ifValue != null) {
                jsonGenerator.writeObject(obj.ifValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
