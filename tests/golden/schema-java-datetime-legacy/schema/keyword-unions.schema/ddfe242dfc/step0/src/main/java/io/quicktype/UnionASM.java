package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionASM.Deserializer.class)
@JsonSerialize(using = UnionASM.Serializer.class)
public class UnionASM {
    public Double doubleValue;
    public ASM asmValue;

    static class Deserializer extends JsonDeserializer<UnionASM> {
        @Override
        public UnionASM deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionASM value = new UnionASM();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.asmValue = jsonParser.readValueAs(ASM.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionASM");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionASM> {
        @Override
        public void serialize(UnionASM obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.asmValue != null) {
                jsonGenerator.writeObject(obj.asmValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
