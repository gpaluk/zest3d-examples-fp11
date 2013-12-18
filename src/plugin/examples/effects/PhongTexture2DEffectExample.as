package plugin.examples.effects 
{
	import io.plugin.core.graphics.Color;
	import io.plugin.math.algebra.APoint;
	import io.plugin.utils.Stats;
	import zest3d.applications.Zest3DApplication;
	import zest3d.effects.local.PhongTexture2DEffect;
	import zest3d.primitives.TorusPrimitive;
	import zest3d.resources.Texture2D;
	import zest3d.scenegraph.enum.LightType;
	import zest3d.scenegraph.Light;
	
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class PhongTexture2DEffectExample extends Zest3DApplication 
	{
		
		[Embed(source = "../../../assets/atf/bw_checked.atf", mimeType = "application/octet-stream")]
		private var Tex2DATF:Class;
		
		private var _torus:TorusPrimitive;
		
		override public function initialize():void 
		{
			addChild( new Stats() );
			_camera.position = new APoint( 0, 0, -3 );
			clearColor = Color.fromHexRGB( 0x000000 );
			var tex2D:Texture2D = Texture2D.fromByteArray( new Tex2DATF() );
			
			var light:Light = new Light( LightType.POINT );
			light.position = new APoint( 0, -8, -20 );
			light.ambient = new Color( 0.2, 0.2, 0.2 );
			light.specular = new Color( 1, 1, 1, 10 );
			
			var effect:PhongTexture2DEffect = new PhongTexture2DEffect( tex2D, light );
			
			_torus = new TorusPrimitive( effect, true, true, 128, 64 );
			scene.addChild( _torus );
		}
		
		override protected function update(appTime:Number):void 
		{
			_torus.rotationY += 0.01;
		}
	}
}