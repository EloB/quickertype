package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionChan.Deserializer.class)
@JsonSerialize(using = UnionChan.Serializer.class)
public class UnionChan {
    public Double doubleValue;
    public Chan chanValue;

    static class Deserializer extends JsonDeserializer<UnionChan> {
        @Override
        public UnionChan deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionChan value = new UnionChan();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.chanValue = jsonParser.readValueAs(Chan.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionChan");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionChan> {
        @Override
        public void serialize(UnionChan obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.chanValue != null) {
                jsonGenerator.writeObject(obj.chanValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
