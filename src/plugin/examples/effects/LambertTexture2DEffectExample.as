package plugin.examples.effects 
{
	import io.plugin.core.graphics.Color;
	import io.plugin.math.algebra.APoint;
	import io.plugin.utils.Stats;
	import zest3d.applications.Zest3DApplication;
	import zest3d.effects.local.LambertTexture2DEffect;
	import zest3d.primitives.TorusPrimitive;
	import zest3d.resources.Texture2D;
	import zest3d.scenegraph.enum.LightType;
	import zest3d.scenegraph.Light;
	
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class LambertTexture2DEffectExample extends Zest3DApplication 
	{
		[Embed(source="../../../assets/atf/bw_checked.atf", mimeType="application/octet-stream")]
		private var Tex2DATF:Class;
		
		private var _torus:TorusPrimitive;
		override public function initialize():void 
		{
			addChild( new Stats() );
			clearColor = new Color( .8, .2, .3 );
			
			var Tex2D:Texture2D = Texture2D.fromByteArray( new Tex2DATF() );
			
			var light:Light = new Light( LightType.AMBIENT );
			light.position = new APoint( 10, 0, -10 );
			light.ambient = new Color( 0.1, 0.2, 0.3 );
			
			var effect:LambertTexture2DEffect = new LambertTexture2DEffect( Tex2D, light );
			
			_torus = new TorusPrimitive( effect, true, true );
			
			scene.addChild( _torus );
		}
		
		override protected function update(appTime:Number):void 
		{
			_torus.rotationY += 0.01;
		}
	}

}