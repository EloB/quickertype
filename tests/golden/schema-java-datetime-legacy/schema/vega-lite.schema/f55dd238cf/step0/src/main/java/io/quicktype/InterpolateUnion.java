package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

/**
 * The interpolation method for range values. By default, a general interpolator for
 * numbers, dates, strings and colors (in RGB space) is used. For color ranges, this
 * property allows interpolation in alternative color spaces. Legal values include `rgb`,
 * `hsl`, `hsl-long`, `lab`, `hcl`, `hcl-long`, `cubehelix` and `cubehelix-long` ('-long'
 * variants use longer paths in polar coordinate spaces). If object-valued, this property
 * accepts an object with a string-valued _type_ property and an optional numeric _gamma_
 * property applicable to rgb and cubehelix interpolators. For more, see the [d3-interpolate
 * documentation](https://github.com/d3/d3-interpolate).
 *
 * __Note:__ Sequential scales do not support `interpolate` as they have a fixed
 * interpolator.  Since Vega-Lite uses sequential scales for quantitative fields by default,
 * you have to set the scale `type` to other quantitative scale type such as `"linear"` to
 * customize `interpolate`.
 */
@JsonDeserialize(using = InterpolateUnion.Deserializer.class)
@JsonSerialize(using = InterpolateUnion.Serializer.class)
public class InterpolateUnion {
    public InterpolateParams interpolateParamsValue;
    public Interpolate enumValue;

    static class Deserializer extends JsonDeserializer<InterpolateUnion> {
        @Override
        public InterpolateUnion deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            InterpolateUnion value = new InterpolateUnion();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    try {
                        value.enumValue = Interpolate.forValue(string);
                    } catch (Exception ex) {
                        // Ignored
                    }
                    break;
                case START_OBJECT:
                    value.interpolateParamsValue = jsonParser.readValueAs(InterpolateParams.class);
                    break;
                default: throw new IOException("Cannot deserialize InterpolateUnion");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<InterpolateUnion> {
        @Override
        public void serialize(InterpolateUnion obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.interpolateParamsValue != null) {
                jsonGenerator.writeObject(obj.interpolateParamsValue);
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
