package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionDeclare.Deserializer.class)
@JsonSerialize(using = UnionDeclare.Serializer.class)
public class UnionDeclare {
    public Double doubleValue;
    public Declare declareValue;

    static class Deserializer extends JsonDeserializer<UnionDeclare> {
        @Override
        public UnionDeclare deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionDeclare value = new UnionDeclare();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.declareValue = jsonParser.readValueAs(Declare.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionDeclare");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionDeclare> {
        @Override
        public void serialize(UnionDeclare obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.declareValue != null) {
                jsonGenerator.writeObject(obj.declareValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
