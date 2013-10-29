package plugin.examples.oimo.helpers
{
	import com.element.oimo.physics.dynamics.RigidBody;
	import com.element.oimo.physics.dynamics.World;
	import io.plugin.math.algebra.APoint;
	import io.plugin.math.algebra.HMatrix;
	import zest3d.scenegraph.TriMesh;
	
	public class Zest3DOimo
	{
		public var world:World
		private var _meshList:Vector.<OimoMesh3D>;
		
		public function Zest3DOimo(stepPerSecound:Number = 30)
		{
			world = new World(stepPerSecound);
			_meshList = new Vector.<OimoMesh3D>();
		}
		
		public function addChild(oimoMesh3D:OimoMesh3D):void
		{
			_meshList.push( oimoMesh3D );
			world.addRigidBody(oimoMesh3D.rigidBody);
		}
		
		public function step():void
		{
			var r:RigidBody;
			var obj:TriMesh;
			for each( var i:OimoMesh3D in _meshList )
			{
				r = i.rigidBody;
				obj = i.mesh;
				
				//TODO pool these objects
				var translate:APoint = new APoint();
				var rotate:HMatrix = new HMatrix();
				
				rotate.m00 = r.rotation.e00;
				rotate.m01 = r.rotation.e01;
				rotate.m02 = r.rotation.e02;
				
				rotate.m10 = r.rotation.e10;
				rotate.m11 = r.rotation.e11;
				rotate.m12 = r.rotation.e12;
				
				rotate.m20 = r.rotation.e20;
				rotate.m21 = r.rotation.e21;
				rotate.m22 = r.rotation.e22;
				
				translate.x = r.position.x;
				translate.y = r.position.y;
				translate.z = r.position.z;
				
				obj.localTransform.rotate = rotate;
				obj.localTransform.translate = translate;
			}
			world.step();
		}
	}
}