list = GetArrayVariable("LINE_PATTERN")
if isArray(list) then
  if ubound(list) > 0 then

		' based on a line pattern in 8 x inches 
		' of 10 17 31 32 10 = 100
	
    targetPixelHeight = (list(3)/10)
    targetSamples = 0

    ' calibrated for an Axis camera
    imageHeight = GetVariable("IMAGE_HEIGHT")
    cameraFieldOfView = 47.5
    targetHeight =9.3

		' determine distance in 8 x inches
    totalDistance = (((targetHeight*imageHeight)/targetPixelHeight)/2)/_
      tan(((cameraFieldOfView*3.14159)/180.0)/2.0)

		' convert to ft (12 inch per ft * 8 inch multiplier) = 96
		totalDistance = CInt((totalDistance*100)/96)/100

		' save it for use in other modules
    SetVariable "distance", totalDistance

  end if
end if		
    imagewidth = GetVariable("IMAGE_WIDTH")
    xcenter = imageWidth/2

    SetVariable "xcenter" , xcenter 
	  targetx=GetVariable("LINE_PATTERN:1")
	
	  xoffset=targetx-xcenter
		' SetVariable "xoffset", xoffset
	  xAngle=formatnumber((cameraFieldOfView * xoffset) / imageWidth,2)
		SetVariable "xAngle", xAngle

		tgtCount = GetVariable("LINE_PATTERN_COUNT")
		SetVariable "tgtCount", tgtCount
    
		boxAspectRatio = GetArrayVariable("BOX_ASPECT_RATIO")
    cogX = GetArrayVariable("COG_X")
    minY = GetArrayVariable("MIN_Y")
    maxY = GetArrayVariable("MAX_Y")
    minX = GetArrayVariable("MIN_X")
		maxX = GetArrayVariable("MAX_X")



if cogX(0)<cogX(1) then
	leftBoxAspect=boxAspectRatio(0)
	rightBoxAspect=boxAspectRatio(1)
	leftBoxHeight=maxY(0)-minY(0)
	rightBoxHeight=maxY(1)-minY(1)
	leftBoxWidth=maxX(0)-minX(0)
	rightBoxWidth=maxX(1)-minX(1)

else	
	leftBoxAspect=boxAspectRatio(1)
	rightBoxAspect=boxAspectRatio(0)
	leftBoxHeight=maxY(1)-minY(1)
	rightBoxHeight=maxY(0)-minY(0)
	leftBoxWidth=maxX(1)-minX(1)
	rightBoxWidth=maxX(0)-minX(0)

end if
	
		SetVariable "leftBoxHeight",leftBoxHeight
		SetVariable "rightBoxHeight",rightBoxHeight
		
		SetVariable "leftBoxWidth",leftBoxWidth
		SetVariable "rightBoxWidth",rightBoxWidth
		
		  	BoxAspectRatio = formatnumber(1-(leftBoxAspect/rightBoxAspect),2)
		BoxHeightRatio = formatnumber(1-(leftBoxHeight/rightBoxHeight),2)
		BoxWidthRatio = formatnumber(1-(leftBoxWidth/rightBoxWidth),2)

		SetVariable "leftBoxAspect",leftBoxAspect
		SetVariable "rightBoxAspect",rightBoxAspect
		
		SetVariable "BoxHeightRatio", BoxHeightRatio
		SetVariable "BoxWidthRatio", BoxWidthRatio
		SetVariable "BoxAspectRatio", BoxAspectRatio		
		