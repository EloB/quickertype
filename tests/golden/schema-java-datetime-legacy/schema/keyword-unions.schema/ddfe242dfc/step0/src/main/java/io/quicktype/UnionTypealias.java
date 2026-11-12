package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionTypealias.Deserializer.class)
@JsonSerialize(using = UnionTypealias.Serializer.class)
public class UnionTypealias {
    public Double doubleValue;
    public Typealias typealiasValue;

    static class Deserializer extends JsonDeserializer<UnionTypealias> {
        @Override
        public UnionTypealias deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionTypealias value = new UnionTypealias();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.typealiasValue = jsonParser.readValueAs(Typealias.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionTypealias");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionTypealias> {
        @Override
        public void serialize(UnionTypealias obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.typealiasValue != null) {
                jsonGenerator.writeObject(obj.typealiasValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
