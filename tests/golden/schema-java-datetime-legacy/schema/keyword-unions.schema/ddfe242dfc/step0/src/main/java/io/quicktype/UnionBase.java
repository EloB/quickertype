package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionBase.Deserializer.class)
@JsonSerialize(using = UnionBase.Serializer.class)
public class UnionBase {
    public Double doubleValue;
    public Base baseValue;

    static class Deserializer extends JsonDeserializer<UnionBase> {
        @Override
        public UnionBase deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionBase value = new UnionBase();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.baseValue = jsonParser.readValueAs(Base.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionBase");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionBase> {
        @Override
        public void serialize(UnionBase obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.baseValue != null) {
                jsonGenerator.writeObject(obj.baseValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
