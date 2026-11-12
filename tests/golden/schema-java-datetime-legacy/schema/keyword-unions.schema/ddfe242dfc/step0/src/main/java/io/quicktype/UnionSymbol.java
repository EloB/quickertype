package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionSymbol.Deserializer.class)
@JsonSerialize(using = UnionSymbol.Serializer.class)
public class UnionSymbol {
    public Double doubleValue;
    public Symbol symbolValue;

    static class Deserializer extends JsonDeserializer<UnionSymbol> {
        @Override
        public UnionSymbol deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionSymbol value = new UnionSymbol();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.symbolValue = jsonParser.readValueAs(Symbol.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionSymbol");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionSymbol> {
        @Override
        public void serialize(UnionSymbol obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.symbolValue != null) {
                jsonGenerator.writeObject(obj.symbolValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
