package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionDictionary.Deserializer.class)
@JsonSerialize(using = UnionDictionary.Serializer.class)
public class UnionDictionary {
    public Double doubleValue;
    public Dictionary dictionaryValue;

    static class Deserializer extends JsonDeserializer<UnionDictionary> {
        @Override
        public UnionDictionary deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionDictionary value = new UnionDictionary();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.dictionaryValue = jsonParser.readValueAs(Dictionary.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionDictionary");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionDictionary> {
        @Override
        public void serialize(UnionDictionary obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.dictionaryValue != null) {
                jsonGenerator.writeObject(obj.dictionaryValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
