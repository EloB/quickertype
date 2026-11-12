package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionDel.Deserializer.class)
@JsonSerialize(using = UnionDel.Serializer.class)
public class UnionDel {
    public Double doubleValue;
    public Del delValue;

    static class Deserializer extends JsonDeserializer<UnionDel> {
        @Override
        public UnionDel deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionDel value = new UnionDel();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.delValue = jsonParser.readValueAs(Del.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionDel");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionDel> {
        @Override
        public void serialize(UnionDel obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.delValue != null) {
                jsonGenerator.writeObject(obj.delValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
