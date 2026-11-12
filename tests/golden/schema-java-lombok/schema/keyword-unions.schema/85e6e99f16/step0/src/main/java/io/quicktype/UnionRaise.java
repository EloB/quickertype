package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionRaise.Deserializer.class)
@JsonSerialize(using = UnionRaise.Serializer.class)
public class UnionRaise {
    public Double doubleValue;
    public Raise raiseValue;

    static class Deserializer extends JsonDeserializer<UnionRaise> {
        @Override
        public UnionRaise deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionRaise value = new UnionRaise();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.raiseValue = jsonParser.readValueAs(Raise.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionRaise");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionRaise> {
        @Override
        public void serialize(UnionRaise obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.raiseValue != null) {
                jsonGenerator.writeObject(obj.raiseValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
