package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = Bin.Deserializer.class)
@JsonSerialize(using = Bin.Serializer.class)
public class Bin {
    public Boolean boolValue;
    public BinParams binParamsValue;

    static class Deserializer extends JsonDeserializer<Bin> {
        @Override
        public Bin deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Bin value = new Bin();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_TRUE:
                case VALUE_FALSE:
                    value.boolValue = jsonParser.readValueAs(Boolean.class);
                    break;
                case START_OBJECT:
                    value.binParamsValue = jsonParser.readValueAs(BinParams.class);
                    break;
                default: throw new IOException("Cannot deserialize Bin");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Bin> {
        @Override
        public void serialize(Bin obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.boolValue != null) {
                jsonGenerator.writeObject(obj.boolValue);
                return;
            }
            if (obj.binParamsValue != null) {
                jsonGenerator.writeObject(obj.binParamsValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
