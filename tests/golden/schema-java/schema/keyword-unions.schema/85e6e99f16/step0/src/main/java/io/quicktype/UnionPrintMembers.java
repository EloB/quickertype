package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionPrintMembers.Deserializer.class)
@JsonSerialize(using = UnionPrintMembers.Serializer.class)
public class UnionPrintMembers {
    public Double doubleValue;
    public PrintMembers printMembersValue;

    static class Deserializer extends JsonDeserializer<UnionPrintMembers> {
        @Override
        public UnionPrintMembers deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionPrintMembers value = new UnionPrintMembers();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.printMembersValue = jsonParser.readValueAs(PrintMembers.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionPrintMembers");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionPrintMembers> {
        @Override
        public void serialize(UnionPrintMembers obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.printMembersValue != null) {
                jsonGenerator.writeObject(obj.printMembersValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
