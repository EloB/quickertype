package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionUsing.Deserializer.class)
@JsonSerialize(using = UnionUsing.Serializer.class)
public class UnionUsing {
    public Double doubleValue;
    public Using usingValue;

    static class Deserializer extends JsonDeserializer<UnionUsing> {
        @Override
        public UnionUsing deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionUsing value = new UnionUsing();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.usingValue = jsonParser.readValueAs(Using.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionUsing");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionUsing> {
        @Override
        public void serialize(UnionUsing obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.usingValue != null) {
                jsonGenerator.writeObject(obj.usingValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
