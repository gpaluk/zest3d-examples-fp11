package plugin.examples.oimo 
{
	import com.element.oimo.physics.collision.shape.BoxShape;
	import com.element.oimo.physics.collision.shape.CylinderShape;
	import com.element.oimo.physics.collision.shape.ShapeConfig;
	import com.element.oimo.physics.collision.shape.SphereShape;
	import com.element.oimo.physics.dynamics.RigidBody;
	import io.plugin.core.graphics.Color;
	import io.plugin.math.algebra.APoint;
	import io.plugin.utils.Stats;
	import plugin.examples.oimo.helpers.OimoMesh3D;
	import plugin.examples.oimo.helpers.Zest3DOimo;
	import zest3d.applications.Zest3DApplication;
	import zest3d.effects.local.PhongEffect;
	import zest3d.geometry.SkyboxGeometry;
	import zest3d.primitives.CubePrimitive;
	import zest3d.primitives.CylinderPrimitive;
	import zest3d.primitives.SpherePrimitive;
	import zest3d.resources.Texture2D;
	import zest3d.resources.TextureCube;
	import zest3d.scenegraph.enum.CullingType;
	import zest3d.scenegraph.enum.LightType;
	import zest3d.scenegraph.Light;
	import zest3d.scenegraph.TriMesh;
	
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public class OimoExample extends Zest3DApplication 
	{
		
		[Embed(source="../../../assets/atfcube/skybox.atf", mimeType="application/octet-stream")]
		private var SkyboxTexture:Class;
		
		[Embed(source="../../../assets/atf/space.atf", mimeType="application/octet-stream")]
		private var GridTexture:Class;
		
		private var _oimoWorld:Zest3DOimo;
		
		override protected function initialize():void 
		{
			clearColor = Color.fromHexRGB( 0xFFFFFF );
			
			// set the camera position
			camera.position = new APoint( 0, -6, -25 );
			
			// add stats
			addChild( new Stats() );
			
			// set the clear color
			clearColor = new Color( 0, 0, 0, 1 );
			
			// create texture and effect
			var gridTexture:Texture2D = Texture2D.fromByteArray( new GridTexture() );
			
			var light:Light = new Light();
			light.position = new APoint( 0, -10, -80 );
			light.ambient = new Color( 0.3, 0.3, 0.3 );
			light.specular = new Color( 1, 1, 1 );
			light.exponent = 6;
			
			var gridEffect:PhongEffect = new PhongEffect( gridTexture, light );
			
			var skyboxTexture:TextureCube = TextureCube.fromByteArray( new SkyboxTexture() );
			
			// Oimo
			_oimoWorld = new Zest3DOimo( 30 );
			
			// Add Ground
			var plane:CubePrimitive = new CubePrimitive( gridEffect, true, true, 10, 10, 10 );
			plane.culling = CullingType.NEVER;
			scene.addChild( plane );
			
			var planeConfig:ShapeConfig = new ShapeConfig();
			planeConfig.position.init( 0, 10, 0 );
			var groundShape:BoxShape = new BoxShape( 20, 20, 20, planeConfig );
			var ground:OimoMesh3D = new OimoMesh3D( groundShape, plane as TriMesh, RigidBody.BODY_STATIC );
			_oimoWorld.addChild( ground );
			
			var i:int;
			
			// Add Boxes
			for ( i = 0; i < 100; ++i )
			{
				var cube:CubePrimitive = new CubePrimitive( gridEffect, true, true, 1, 1, 1, false ); 
				scene.addChild( cube );
				
				var cubeConfig:ShapeConfig = new ShapeConfig();
				cubeConfig.position.init( (Math.random()*10)-5, (-Math.random() * 1500)-5, (Math.random()*10)-5 );
				var boxShape:BoxShape = new BoxShape( 2, 2, 2, cubeConfig ); // ***note*** that Zest3D primitives use extends rather than width, height & depth
				var boxMesh3D:OimoMesh3D = new OimoMesh3D( boxShape, cube );
				boxMesh3D.friction = 1.5;
				boxMesh3D.restitution = 0.5;
				_oimoWorld.addChild( boxMesh3D );
			}
			
			// Add Spheres
			for ( i = 0; i < 100; ++i )
			{
				var sphere:SpherePrimitive = new SpherePrimitive( gridEffect, true, true, 16, 16, 1, false, false );
				scene.addChild( sphere );
				
				var sphereConfig:ShapeConfig = new ShapeConfig();
				sphereConfig.position.init( (Math.random()*10)-5, (-Math.random() * 1500)-5, (Math.random()*10)-5 );
				var sphereShape:SphereShape = new SphereShape( 1, sphereConfig );
				var sphereMesh3D:OimoMesh3D = new OimoMesh3D( sphereShape, sphere );
				sphereMesh3D.friction = 1.5;
				sphereMesh3D.restitution = 0.5;
				_oimoWorld.addChild( sphereMesh3D );
			}
			
			// Add Cylinders
			for ( i = 0; i < 100; ++i )
			{
				var cylinder:CylinderPrimitive = new CylinderPrimitive( gridEffect, true, true, 4, 16, 1, 2, false, false, false );
				scene.addChild( cylinder );
				var cylinderConfig:ShapeConfig = new ShapeConfig();
				cylinderConfig.position.init( (Math.random()*10)-5, ( -Math.random() * 1500)-5, (Math.random()*10)-5 );
				
				cylinderConfig.rotation = cylinderConfig.rotation.mulRotate( cylinderConfig.rotation, 90 * (Math.PI / 180), 1, 0, 0 ); // make the Zest3D and Oimo cylinders orientation the same.
				
				var cylinderShape:CylinderShape = new CylinderShape( 1, 2, cylinderConfig );
				var cylinderMesh3D:OimoMesh3D = new OimoMesh3D( cylinderShape, cylinder );
				cylinderMesh3D.friction = 1.5;
				cylinderMesh3D.restitution = 0.5;
				_oimoWorld.addChild( cylinderMesh3D );
			}
			
			skybox = new SkyboxGeometry( skyboxTexture );
		}
		
		override protected function update(appTime:Number):void 
		{
			_oimoWorld.step();
		}
		
	}
}