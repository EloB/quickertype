package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionInout.Deserializer.class)
@JsonSerialize(using = UnionInout.Serializer.class)
public class UnionInout {
    public Double doubleValue;
    public Inout inoutValue;

    static class Deserializer extends JsonDeserializer<UnionInout> {
        @Override
        public UnionInout deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionInout value = new UnionInout();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.inoutValue = jsonParser.readValueAs(Inout.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionInout");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionInout> {
        @Override
        public void serialize(UnionInout obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.inoutValue != null) {
                jsonGenerator.writeObject(obj.inoutValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
