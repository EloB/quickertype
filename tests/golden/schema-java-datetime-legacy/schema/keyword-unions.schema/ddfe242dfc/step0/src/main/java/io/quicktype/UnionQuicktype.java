package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionQuicktype.Deserializer.class)
@JsonSerialize(using = UnionQuicktype.Serializer.class)
public class UnionQuicktype {
    public Double doubleValue;
    public Quicktype quicktypeValue;

    static class Deserializer extends JsonDeserializer<UnionQuicktype> {
        @Override
        public UnionQuicktype deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionQuicktype value = new UnionQuicktype();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.quicktypeValue = jsonParser.readValueAs(Quicktype.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionQuicktype");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionQuicktype> {
        @Override
        public void serialize(UnionQuicktype obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.quicktypeValue != null) {
                jsonGenerator.writeObject(obj.quicktypeValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
