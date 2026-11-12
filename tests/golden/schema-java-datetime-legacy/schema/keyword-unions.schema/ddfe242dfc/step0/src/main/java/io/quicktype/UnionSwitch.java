package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionSwitch.Deserializer.class)
@JsonSerialize(using = UnionSwitch.Serializer.class)
public class UnionSwitch {
    public Double doubleValue;
    public Switch switchValue;

    static class Deserializer extends JsonDeserializer<UnionSwitch> {
        @Override
        public UnionSwitch deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionSwitch value = new UnionSwitch();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.switchValue = jsonParser.readValueAs(Switch.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionSwitch");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionSwitch> {
        @Override
        public void serialize(UnionSwitch obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.switchValue != null) {
                jsonGenerator.writeObject(obj.switchValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
