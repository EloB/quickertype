package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionFloat.Deserializer.class)
@JsonSerialize(using = UnionFloat.Serializer.class)
public class UnionFloat {
    public Double doubleValue;
    public Float floatValue;

    static class Deserializer extends JsonDeserializer<UnionFloat> {
        @Override
        public UnionFloat deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionFloat value = new UnionFloat();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.floatValue = jsonParser.readValueAs(Float.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionFloat");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionFloat> {
        @Override
        public void serialize(UnionFloat obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.floatValue != null) {
                jsonGenerator.writeObject(obj.floatValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
