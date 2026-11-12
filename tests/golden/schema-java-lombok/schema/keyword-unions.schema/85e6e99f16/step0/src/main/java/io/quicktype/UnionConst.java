package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionConst.Deserializer.class)
@JsonSerialize(using = UnionConst.Serializer.class)
public class UnionConst {
    public Double doubleValue;
    public Const constValue;

    static class Deserializer extends JsonDeserializer<UnionConst> {
        @Override
        public UnionConst deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionConst value = new UnionConst();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.constValue = jsonParser.readValueAs(Const.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionConst");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionConst> {
        @Override
        public void serialize(UnionConst obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.constValue != null) {
                jsonGenerator.writeObject(obj.constValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
