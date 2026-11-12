package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionInit.Deserializer.class)
@JsonSerialize(using = UnionInit.Serializer.class)
public class UnionInit {
    public Double doubleValue;
    public Init initValue;

    static class Deserializer extends JsonDeserializer<UnionInit> {
        @Override
        public UnionInit deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionInit value = new UnionInit();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.initValue = jsonParser.readValueAs(Init.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionInit");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionInit> {
        @Override
        public void serialize(UnionInit obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.initValue != null) {
                jsonGenerator.writeObject(obj.initValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
