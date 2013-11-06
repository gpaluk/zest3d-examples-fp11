package plugin.examples.effects 
{
	import io.plugin.core.graphics.Color;
	import io.plugin.math.algebra.APoint;
	import zest3d.applications.Zest3DApplication;
	import zest3d.effects.NormalMapTexture2DEffect;
	import zest3d.primitives.TorusPrimitive;
	import zest3d.resources.Texture2D;
	import zest3d.scenegraph.enum.LightType;
	import zest3d.scenegraph.enum.UpdateType;
	import zest3d.scenegraph.Light;
	
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class NormalMapTexture2DEffectExample extends Zest3DApplication 
	{
		[Embed(source = "../../../assets/atf/bw_checked.atf", mimeType = "application/octet-stream")]
		private var Tex2DATF:Class;
		
		[Embed(source = "../../../assets/atf/sand_normals.atf", mimeType = "application/octet-stream")]
		private var NormalsATF:Class;
		
		private var _torus:TorusPrimitive;
		
		override public function initialize():void 
		{
			_camera.position = new APoint( 0, 0, -3 );
			clearColor = Color.fromHexRGB( 0x000000 );
			
			var Tex2D:Texture2D = Texture2D.fromByteArray( new Tex2DATF() );
			var Normals:Texture2D = Texture2D.fromByteArray( new NormalsATF() );
			
			var light:Light = new Light( LightType.POINT );
			light.position = new APoint( 0, -8, -20 );
			light.ambient = new Color( 0.1, 0.1, 0.1 );
			light.specular = new Color( 0.9, 0.9, 0.9, 10 );
			
			var effect:NormalMapTexture2DEffect = new NormalMapTexture2DEffect( Tex2D, Normals, light );
			
			_torus = new TorusPrimitive( effect, true, true, 128, 64 );
			//_torus.updateModelSpace( new UpdateType.USE_GEOMETRY
			scene.addChild( _torus );
		}
		
		override protected function update(appTime:Number):void 
		{
			_torus.rotationY += 0.01;
		}
		
	}

}