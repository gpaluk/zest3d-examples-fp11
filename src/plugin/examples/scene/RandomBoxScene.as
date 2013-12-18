package plugin.examples.scene 
{
	import flash.text.TextField;
	import io.plugin.core.graphics.Color;
	import io.plugin.utils.Stats;
	import zest3d.applications.Zest3DApplication;
	import zest3d.effects.local.PhongTexture2DEffect;
	import zest3d.primitives.CubePrimitive;
	import zest3d.primitives.PlanePrimitive;
	import zest3d.resources.Texture2D;
	import zest3d.scenegraph.enum.LightType;
	import zest3d.scenegraph.Light;
	import zest3d.scenegraph.LightNode;
	
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class RandomBoxScene extends Zest3DApplication 
	{
		
		[Embed(source="../../../assets/atf/white_gloss.atf", mimeType="application/octet-stream")]
		private var SPACE_ATF:Class;
		
		private var _textfield:TextField;
		private var _lightNode:LightNode;
		override public function initialize():void 
		{
			addChild( new Stats() );
			clearColor = new Color( 0.2, 0.2, 0.2 );
			
			_camera.setFrustumFOV( 80, stage.stageWidth / stage.stageHeight, 0.1, 200 );
			
			
			var light:Light = new Light( LightType.POINT );
			light.ambient = new Color( 0, 0, 0 );
			light.specular = new Color( 1, 1, 1, 40 );
			_lightNode = new LightNode( light );
			
			scene.addChild( _lightNode );
			
			var spaceTexture:Texture2D = Texture2D.fromByteArray( new SPACE_ATF() );
			var effect:PhongTexture2DEffect = new PhongTexture2DEffect( spaceTexture, light );
			var cube:CubePrimitive;
			var plane:PlanePrimitive;
			var i:int;
			for ( i = 0; i < 400; ++i )
			{
				plane = new PlanePrimitive( effect, true, true, 2, 2, 6, 1 );
				plane.rotationY = 90 * (Math.PI / 180 );
				plane.x = -3;
				plane.z = 12*i;
				scene.addChild( plane );
				
				plane = new PlanePrimitive( effect, true, true, 2, 2, 3, 6 );
				plane.rotationX = 90 * (Math.PI / 180 );
				plane.y = 1;
				plane.z = 12*i;
				scene.addChild( plane );
				
				plane = new PlanePrimitive( effect, true, true, 2, 2, 3, 6 );
				plane.rotationX = 270 * (Math.PI / 180 );
				plane.y = -1;
				plane.z = 12*i;
				scene.addChild( plane );
				
				plane = new PlanePrimitive( effect, true, true, 2, 2, 6, 1 );
				plane.rotationY = 270 * (Math.PI / 180 );
				plane.x = 3;
				plane.z = 12*i;
				scene.addChild( plane );
			}
			
			_textfield = new TextField();
			_textfield.y = 110;
			_textfield.textColor = 0xFFFFFF;
			addChild( _textfield );
		}
		
		override protected function update(appTime:Number):void 
		{
			_textfield.text = "numVisible: " + numVisibleObjects;
			moveForward();
			moveForward();
			moveForward();
			_lightNode.z = _camera.position.z + (Math.sin( appTime * 0.002 ) * 50) + 20;
		}
	}
}