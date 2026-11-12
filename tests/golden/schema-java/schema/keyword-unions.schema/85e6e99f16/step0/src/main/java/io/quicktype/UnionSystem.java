package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionSystem.Deserializer.class)
@JsonSerialize(using = UnionSystem.Serializer.class)
public class UnionSystem {
    public Double doubleValue;
    public SystemClass systemClassValue;

    static class Deserializer extends JsonDeserializer<UnionSystem> {
        @Override
        public UnionSystem deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionSystem value = new UnionSystem();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.systemClassValue = jsonParser.readValueAs(SystemClass.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionSystem");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionSystem> {
        @Override
        public void serialize(UnionSystem obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.systemClassValue != null) {
                jsonGenerator.writeObject(obj.systemClassValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
