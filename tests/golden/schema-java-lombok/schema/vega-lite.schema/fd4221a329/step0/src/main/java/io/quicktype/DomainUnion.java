package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;
import java.util.List;

/**
 * Customized domain values.
 *
 * For _quantitative_ fields, `domain` can take the form of a two-element array with minimum
 * and maximum values.  [Piecewise scales](scale.html#piecewise) can be created by providing
 * a `domain` with more than two entries.
 * If the input field is aggregated, `domain` can also be a string value `"unaggregated"`,
 * indicating that the domain should include the raw data values prior to the aggregation.
 *
 * For _temporal_ fields, `domain` can be a two-element array minimum and maximum values, in
 * the form of either timestamps or the [DateTime definition objects](types.html#datetime).
 *
 * For _ordinal_ and _nominal_ fields, `domain` can be an array that lists valid input
 * values.
 *
 * The `selection` property can be used to [interactively
 * determine](selection.html#scale-domains) the scale domain.
 */
@JsonDeserialize(using = DomainUnion.Deserializer.class)
@JsonSerialize(using = DomainUnion.Serializer.class)
public class DomainUnion {
    public List<OneOfElement> unionArrayValue;
    public DomainClass domainClassValue;
    public Domain enumValue;

    static class Deserializer extends JsonDeserializer<DomainUnion> {
        @Override
        public DomainUnion deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            DomainUnion value = new DomainUnion();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    try {
                        value.enumValue = Domain.forValue(string);
                    } catch (Exception ex) {
                        // Ignored
                    }
                    break;
                case START_ARRAY:
                    value.unionArrayValue = jsonParser.readValueAs(new TypeReference<List<OneOfElement>>() {});
                    break;
                case START_OBJECT:
                    value.domainClassValue = jsonParser.readValueAs(DomainClass.class);
                    break;
                default: throw new IOException("Cannot deserialize DomainUnion");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<DomainUnion> {
        @Override
        public void serialize(DomainUnion obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.unionArrayValue != null) {
                jsonGenerator.writeObject(obj.unionArrayValue);
                return;
            }
            if (obj.domainClassValue != null) {
                jsonGenerator.writeObject(obj.domainClassValue);
                return;
            }
            if (obj.enumValue != null) {
                jsonGenerator.writeObject(obj.enumValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
