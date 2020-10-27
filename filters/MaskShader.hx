package filters;

import openfl.display.BitmapData;
import zero.utilities.Color;
import openfl.display.Shader;

class MaskShader extends Shader 
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
		uniform sampler2D mask;

		void main(void) {
			vec4 color = texture2D (bitmap, openfl_TextureCoordv);
			float mask = texture2D (mask, openfl_TextureCoordv * 2.0).a;
			
			if (color.a == 0.0 || mask == 0.0) {
				gl_FragColor = vec4 (0.0, 0.0, 0.0, 0.0);
			} 
			else {
				gl_FragColor = vec4 (color.rgb / color.a, mask * color.a * openfl_Alphav);
			}
		}
	")

	public function new(mask:BitmapData) {
		super();
		data.mask.input = mask;
	}
	
}