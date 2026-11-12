package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionOut.Deserializer.class)
@JsonSerialize(using = UnionOut.Serializer.class)
public class UnionOut {
    public Double doubleValue;
    public Out outValue;

    static class Deserializer extends JsonDeserializer<UnionOut> {
        @Override
        public UnionOut deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionOut value = new UnionOut();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.outValue = jsonParser.readValueAs(Out.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionOut");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionOut> {
        @Override
        public void serialize(UnionOut obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.outValue != null) {
                jsonGenerator.writeObject(obj.outValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
