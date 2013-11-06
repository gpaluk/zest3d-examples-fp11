package plugin.examples.effects 
{
	import io.plugin.core.graphics.Color;
	import io.plugin.math.algebra.APoint;
	import zest3d.applications.Zest3DApplication;
	import zest3d.effects.PhongTexture2DEffect;
	import zest3d.primitives.CubePrimitive;
	import zest3d.primitives.CylinderPrimitive;
	import zest3d.primitives.PlanePrimitive;
	import zest3d.primitives.SpherePrimitive;
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
		
		[Embed(source = "../../../../../../../DocumentsFlash Documents/Zest3D API/lib/grid.atf", mimeType = "application/octet-stream")]
		private var Tex2DATF:Class;
		
		private var _torus:TorusPrimitive;
		override public function initialize():void 
		{
			_camera.position = new APoint( 0, 0, -3 );
			clearColor = Color.fromHexRGB( 0x000000 );
			var Tex2D:Texture2D = Texture2D.fromByteArray( new Tex2DATF() );
			
			var light:Light = new Light( LightType.POINT );
			light.position = new APoint( 0, -8, -20 );
			light.ambient = new Color( 0, 0, 0 );
			light.specular = new Color( 1, 1, 1, 10 );
			
			var effect:PhongTexture2DEffect = new PhongTexture2DEffect( Tex2D, light );
			
			_torus = new TorusPrimitive( effect, true, true, 128, 64 );
			scene.addChild( _torus );
		}
		
		override protected function update(appTime:Number):void 
		{
			_torus.rotationY += 0.01;
		}
	}
}