package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionGoto.Deserializer.class)
@JsonSerialize(using = UnionGoto.Serializer.class)
public class UnionGoto {
    public Double doubleValue;
    public Goto gotoValue;

    static class Deserializer extends JsonDeserializer<UnionGoto> {
        @Override
        public UnionGoto deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionGoto value = new UnionGoto();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.gotoValue = jsonParser.readValueAs(Goto.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionGoto");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionGoto> {
        @Override
        public void serialize(UnionGoto obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.gotoValue != null) {
                jsonGenerator.writeObject(obj.gotoValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
