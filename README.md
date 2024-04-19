Simple 3D Platformer and Level Editor

Using the prototyping possibilities in godot 4 to quickly create and modify 3D terrain 



3D platformer instructions:
-  WSAD for movement
-  SPACE for jump
-  C for changing the view between 1st and 3rd person


Editor instructions:

Create 3d terrain segments using Godot's CSG prototyping nodes. For creating a new terrain 'segment' use this workflow:

- Optional: If you want to make a shape based on a curve3D (bezier curve), Use a Path3D node as the root and add the CSGcollider to it as a child
- Make a new CSGCollider node
- Add any number of CSG<shape> nodes under it, modify them to your liking.
- Optional: set bool operators for how the csg nodes under the collider: intersect, substract or union to further modify the shape
- select the CSGcollider node and click "Convert CSG to MeshInstance"

