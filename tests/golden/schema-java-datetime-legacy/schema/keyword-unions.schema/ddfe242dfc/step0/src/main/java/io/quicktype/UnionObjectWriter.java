package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionObjectWriter.Deserializer.class)
@JsonSerialize(using = UnionObjectWriter.Serializer.class)
public class UnionObjectWriter {
    public Double doubleValue;
    public ObjectWriterClass objectWriterClassValue;

    static class Deserializer extends JsonDeserializer<UnionObjectWriter> {
        @Override
        public UnionObjectWriter deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionObjectWriter value = new UnionObjectWriter();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.objectWriterClassValue = jsonParser.readValueAs(ObjectWriterClass.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionObjectWriter");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionObjectWriter> {
        @Override
        public void serialize(UnionObjectWriter obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.objectWriterClassValue != null) {
                jsonGenerator.writeObject(obj.objectWriterClassValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
