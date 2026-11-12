package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionNonatomic.Deserializer.class)
@JsonSerialize(using = UnionNonatomic.Serializer.class)
public class UnionNonatomic {
    public Double doubleValue;
    public Nonatomic nonatomicValue;

    static class Deserializer extends JsonDeserializer<UnionNonatomic> {
        @Override
        public UnionNonatomic deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionNonatomic value = new UnionNonatomic();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.nonatomicValue = jsonParser.readValueAs(Nonatomic.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionNonatomic");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionNonatomic> {
        @Override
        public void serialize(UnionNonatomic obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.nonatomicValue != null) {
                jsonGenerator.writeObject(obj.nonatomicValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
