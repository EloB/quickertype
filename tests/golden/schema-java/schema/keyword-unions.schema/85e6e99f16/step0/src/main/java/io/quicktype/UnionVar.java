package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionVar.Deserializer.class)
@JsonSerialize(using = UnionVar.Serializer.class)
public class UnionVar {
    public Double doubleValue;
    public Var varValue;

    static class Deserializer extends JsonDeserializer<UnionVar> {
        @Override
        public UnionVar deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionVar value = new UnionVar();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.varValue = jsonParser.readValueAs(Var.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionVar");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionVar> {
        @Override
        public void serialize(UnionVar obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.varValue != null) {
                jsonGenerator.writeObject(obj.varValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
