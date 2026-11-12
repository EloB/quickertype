package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionAuto.Deserializer.class)
@JsonSerialize(using = UnionAuto.Serializer.class)
public class UnionAuto {
    public Double doubleValue;
    public Auto autoValue;

    static class Deserializer extends JsonDeserializer<UnionAuto> {
        @Override
        public UnionAuto deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionAuto value = new UnionAuto();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.autoValue = jsonParser.readValueAs(Auto.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionAuto");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionAuto> {
        @Override
        public void serialize(UnionAuto obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.autoValue != null) {
                jsonGenerator.writeObject(obj.autoValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
