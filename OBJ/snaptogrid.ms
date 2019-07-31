(  -- start script
	
global rltGridSnapVerts
try destroyDialog rltGridSnapVerts catch()
	
rollout rltGridSnapVerts "Grid Snap Verts" width:132
(
	spinner spnStep "Grid Spacing: " range:[0,10000,1]  width:120 align:#center
	button btnDoIt "Snap'em verts!" tooltip:"Ehr... press me?" width:120 align:#center
	
	fn step_round val step = (floor((val as float) / step + .5)) * step
	
	on btnDoIt pressed do undo "Grid Snap Verts" on
	(
		theStep = spnStep.value
	
		for obj in selection where (superClassOf obj == GeometryClass \
		              and (try getNumVerts obj.mesh != 0 catch(false))) do
		(
			isPolyMesh = classOf obj == Editable_Poly \
			           or classOf obj == PolyMeshObject
			convertToMesh obj
	
			for v = 1 to getNumVerts obj do
			(
				aXYZ = getVert obj v
				for i = 1 to 3 do aXYZ[i] = step_round aXYZ[i] theStep
				setVert obj v aXYZ
			)  -- end v loop
	
			update obj
			--print obj.name
			if isPolyMesh do convertTo obj Editable_Poly
	
		)  -- end obj loop
	
	)  -- end btnDoIt pressed
	
)  -- end rollout
	
createDialog rltGridSnapVerts
)  -- end script