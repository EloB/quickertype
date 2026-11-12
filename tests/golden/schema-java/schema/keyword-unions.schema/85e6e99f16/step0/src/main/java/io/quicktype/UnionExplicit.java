package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionExplicit.Deserializer.class)
@JsonSerialize(using = UnionExplicit.Serializer.class)
public class UnionExplicit {
    public Double doubleValue;
    public Explicit explicitValue;

    static class Deserializer extends JsonDeserializer<UnionExplicit> {
        @Override
        public UnionExplicit deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionExplicit value = new UnionExplicit();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.explicitValue = jsonParser.readValueAs(Explicit.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionExplicit");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionExplicit> {
        @Override
        public void serialize(UnionExplicit obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.explicitValue != null) {
                jsonGenerator.writeObject(obj.explicitValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
