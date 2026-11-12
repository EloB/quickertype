package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionDecltype.Deserializer.class)
@JsonSerialize(using = UnionDecltype.Serializer.class)
public class UnionDecltype {
    public Double doubleValue;
    public Decltype decltypeValue;

    static class Deserializer extends JsonDeserializer<UnionDecltype> {
        @Override
        public UnionDecltype deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionDecltype value = new UnionDecltype();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.decltypeValue = jsonParser.readValueAs(Decltype.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionDecltype");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionDecltype> {
        @Override
        public void serialize(UnionDecltype obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.decltypeValue != null) {
                jsonGenerator.writeObject(obj.decltypeValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
