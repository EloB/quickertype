package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionExport.Deserializer.class)
@JsonSerialize(using = UnionExport.Serializer.class)
public class UnionExport {
    public Double doubleValue;
    public Export exportValue;

    static class Deserializer extends JsonDeserializer<UnionExport> {
        @Override
        public UnionExport deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionExport value = new UnionExport();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.exportValue = jsonParser.readValueAs(Export.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionExport");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionExport> {
        @Override
        public void serialize(UnionExport obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.exportValue != null) {
                jsonGenerator.writeObject(obj.exportValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
