package filters;

import zero.utilities.Color;
import openfl.display.Shader;

class OutlineShader extends Shader 
{	
	
	@:glVertexSource("
		attribute float openfl_Alpha;
		attribute vec4 openfl_ColorMultiplier;
		attribute vec4 openfl_ColorOffset;
		attribute vec4 openfl_Position;
		attribute vec2 openfl_TextureCoord;
		
		varying float openfl_Alphav;
		varying vec4 openfl_ColorMultiplierv;
		varying vec4 openfl_ColorOffsetv;
		varying vec2 openfl_TextureCoordv;
		
		uniform mat4 openfl_Matrix;
		uniform bool openfl_HasColorTransform;
		uniform vec2 openfl_TextureSize;
	
		void main(void) {
			openfl_Alphav = openfl_Alpha;
			openfl_TextureCoordv = openfl_TextureCoord;
			
			if (openfl_HasColorTransform) {
				openfl_ColorMultiplierv = openfl_ColorMultiplier;
				openfl_ColorOffsetv = openfl_ColorOffset / 255.0;
			}
			
			gl_Position = openfl_Matrix * openfl_Position;
		}
	")
	
	@:glFragmentSource("
		varying float openfl_Alphav;
		varying vec4 openfl_ColorMultiplierv;
		varying vec4 openfl_ColorOffsetv;
		varying vec2 openfl_TextureCoordv;

		uniform bool openfl_HasColorTransform;
		uniform vec2 openfl_TextureSize;
		uniform sampler2D bitmap;

		uniform vec4 color;
		uniform float thickness;
		const int samples = 16;

		void main(void) {
			vec4 col = vec4(color.r, color.g, color.b, 1.);
			vec4 sample = texture2D(bitmap, openfl_TextureCoordv);
			float radius = thickness / ((openfl_TextureSize.x + openfl_TextureSize.y) / 2.);
			float a = 0.;
			float angle;
			vec2 p;
			for (int i = 0; i < samples; i++) {
				angle = 360./float(samples) * float(i);
				p = vec2(cos(angle), sin(angle)) * radius + openfl_TextureCoordv;
				a += texture2D(bitmap, p).a;
			}
			if (sample.a < 1.) {
				col.a = a;
				sample += col;
			}
			gl_FragColor = sample;
		}
	")

	public function new(color:Color, thickness:Float = 3) {
		super();
		data.color.value = color;
		data.thickness.value = [thickness];
	}
	
}