package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionImport.Deserializer.class)
@JsonSerialize(using = UnionImport.Serializer.class)
public class UnionImport {
    public Double doubleValue;
    public Import importValue;

    static class Deserializer extends JsonDeserializer<UnionImport> {
        @Override
        public UnionImport deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionImport value = new UnionImport();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.importValue = jsonParser.readValueAs(Import.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionImport");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionImport> {
        @Override
        public void serialize(UnionImport obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.importValue != null) {
                jsonGenerator.writeObject(obj.importValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
