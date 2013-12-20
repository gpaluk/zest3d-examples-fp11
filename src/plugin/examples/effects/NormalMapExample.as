package plugin.examples.effects 
{
	import io.plugin.core.graphics.Color;
	import io.plugin.math.algebra.APoint;
	import io.plugin.utils.Stats;
	import zest3d.applications.Zest3DApplication;
	import zest3d.effects.local.NormalMapEffect;
	import zest3d.primitives.TorusPrimitive;
	import zest3d.resources.Texture2D;
	import zest3d.scenegraph.enum.LightType;
	import zest3d.scenegraph.enum.UpdateType;
	import zest3d.scenegraph.Light;
	
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class NormalMapExample extends Zest3DApplication 
	{
		[Embed(source = "../../../assets/atf/bw_checked.atf", mimeType = "application/octet-stream")]
		private const CHECKED_ATF:Class;
		
		[Embed(source = "../../../assets/atf/sand_normals.atf", mimeType = "application/octet-stream")]
		private const NORMALS_ATF:Class;
		
		private var _torus:TorusPrimitive;
		
		override protected function initialize():void 
		{
			addChild( new Stats() );
			camera.position = new APoint( 0, 0, -3 );
			clearColor = Color.fromHexRGB( 0x000000 );
			
			var checkedTexture:Texture2D = Texture2D.fromByteArray( new CHECKED_ATF() );
			var normalsTexture:Texture2D = Texture2D.fromByteArray( new NORMALS_ATF() );
			
			var light:Light = new Light();
			light.position = new APoint( 0, -8, -20 );
			light.ambient = new Color( 0.1, 0.1, 0.1 );
			light.specular = new Color( 0.9, 0.9, 0.9, 10 );
			
			var effect:NormalMapEffect = new NormalMapEffect( checkedTexture, normalsTexture, light );
			
			_torus = new TorusPrimitive( effect, true, true, 128, 64 );
			_torus.updateModelSpace( UpdateType.USE_GEOMETRY );
			scene.addChild( _torus );
		}
		
		override protected function update(appTime:Number):void 
		{
			_torus.rotationY = appTime * 0.001;
		}
		
	}

}