package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionOverride.Deserializer.class)
@JsonSerialize(using = UnionOverride.Serializer.class)
public class UnionOverride {
    public Double doubleValue;
    public OverrideClass overrideClassValue;

    static class Deserializer extends JsonDeserializer<UnionOverride> {
        @Override
        public UnionOverride deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionOverride value = new UnionOverride();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.overrideClassValue = jsonParser.readValueAs(OverrideClass.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionOverride");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionOverride> {
        @Override
        public void serialize(UnionOverride obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.overrideClassValue != null) {
                jsonGenerator.writeObject(obj.overrideClassValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
