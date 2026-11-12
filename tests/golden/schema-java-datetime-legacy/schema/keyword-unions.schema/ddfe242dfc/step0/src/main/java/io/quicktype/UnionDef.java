package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionDef.Deserializer.class)
@JsonSerialize(using = UnionDef.Serializer.class)
public class UnionDef {
    public Double doubleValue;
    public Def defValue;

    static class Deserializer extends JsonDeserializer<UnionDef> {
        @Override
        public UnionDef deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionDef value = new UnionDef();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.defValue = jsonParser.readValueAs(Def.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionDef");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionDef> {
        @Override
        public void serialize(UnionDef obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.defValue != null) {
                jsonGenerator.writeObject(obj.defValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
