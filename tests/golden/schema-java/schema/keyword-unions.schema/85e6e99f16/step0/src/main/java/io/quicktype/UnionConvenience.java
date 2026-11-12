package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionConvenience.Deserializer.class)
@JsonSerialize(using = UnionConvenience.Serializer.class)
public class UnionConvenience {
    public Double doubleValue;
    public Convenience convenienceValue;

    static class Deserializer extends JsonDeserializer<UnionConvenience> {
        @Override
        public UnionConvenience deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionConvenience value = new UnionConvenience();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.convenienceValue = jsonParser.readValueAs(Convenience.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionConvenience");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionConvenience> {
        @Override
        public void serialize(UnionConvenience obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.convenienceValue != null) {
                jsonGenerator.writeObject(obj.convenienceValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
