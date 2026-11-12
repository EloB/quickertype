package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionGlobal.Deserializer.class)
@JsonSerialize(using = UnionGlobal.Serializer.class)
public class UnionGlobal {
    public Double doubleValue;
    public Global globalValue;

    static class Deserializer extends JsonDeserializer<UnionGlobal> {
        @Override
        public UnionGlobal deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionGlobal value = new UnionGlobal();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.globalValue = jsonParser.readValueAs(Global.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionGlobal");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionGlobal> {
        @Override
        public void serialize(UnionGlobal obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.globalValue != null) {
                jsonGenerator.writeObject(obj.globalValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
