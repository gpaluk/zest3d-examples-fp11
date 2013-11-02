package plugin.examples.buffers.normal 
{
	import io.plugin.core.graphics.Color;
	import io.plugin.math.algebra.APoint;
	import io.plugin.utils.Stats;
	import zest3d.applications.Zest3DApplication;
	import zest3d.effects.NormalEffect;
	import zest3d.primitives.CubePrimitive;
	import zest3d.primitives.PlanePrimitive;
	import zest3d.primitives.TorusPrimitive;
	
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public class NormalBufferExample extends Zest3DApplication 
	{
		
		private var _torus0:TorusPrimitive;
		private var _torus1:TorusPrimitive;
		private var _torus2:TorusPrimitive;
		
		override public function initialize():void 
		{
			clearColor = Color.fromHexRGB( 0x000000 );
			
			addChild( new Stats() );
			
			_camera.position = new APoint( 0, 0, -10 );
			var normalEffect:NormalEffect = new NormalEffect();
			
			_torus0 = new TorusPrimitive( normalEffect, false, true, 64, 32 );
			_torus0.x = -3
			scene.addChild( _torus0 );
			
			_torus1 = new TorusPrimitive( normalEffect, false, true, 64, 32 );
			scene.addChild( _torus1 );
			
			_torus2 = new TorusPrimitive( normalEffect, false, true, 64, 32 );
			_torus2.x = 3
			scene.addChild( _torus2 );
			
			var plane0:PlanePrimitive = new PlanePrimitive( normalEffect, false, true, 2, 2, 5, 5 );
			plane0.rotationX = 90 * (Math.PI / 180 );
			plane0.y = 3;
			scene.addChild( plane0 );
			
			var plane1:PlanePrimitive = new PlanePrimitive( normalEffect, false, true, 2, 2, 5, 5 );
			plane1.rotationX = 270 * (Math.PI / 180 );
			plane1.y = -3;
			scene.addChild( plane1 );
			/*
			var plane2:PlanePrimitive = new PlanePrimitive( normalEffect, false, true, 2, 2, 50, 50, true );
			plane2.rotationX = 180 * (Math.PI / 180 );
			plane2.y = -3;
			scene.addChild( plane2 );*/
		}
		
		override protected function update(appTime:Number):void 
		{
			_torus0.rotationY += 0.1;
			_torus1.rotationY -= 0.1;
			_torus2.rotationY += 0.1;
		}
		
	}

}