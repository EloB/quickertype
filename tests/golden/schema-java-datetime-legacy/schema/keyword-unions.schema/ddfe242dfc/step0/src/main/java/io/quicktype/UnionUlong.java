package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionUlong.Deserializer.class)
@JsonSerialize(using = UnionUlong.Serializer.class)
public class UnionUlong {
    public Double doubleValue;
    public Ulong ulongValue;

    static class Deserializer extends JsonDeserializer<UnionUlong> {
        @Override
        public UnionUlong deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionUlong value = new UnionUlong();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.ulongValue = jsonParser.readValueAs(Ulong.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionUlong");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionUlong> {
        @Override
        public void serialize(UnionUlong obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.ulongValue != null) {
                jsonGenerator.writeObject(obj.ulongValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
