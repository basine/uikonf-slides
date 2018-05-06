(script-fu-register
          "script-fu-bauchbinde"                 ;func name
          "Bauchbinden"                                  ;menu label
          "Creates a simple text box, sized to fit\
            around the user's choice of text,\
            font, font size, and color."              ;description
            "Sabine Geithner"                             ;author
            "copyright 2016 Sabine Geithner"        ;copyright notice
            "May 19, 2016"                          ;date created
          ""                     ;image type that the script works on
		  SF-VALUE       "Width"        "1920"
		  SF-VALUE       "Height"        "1080"
          SF-FONT        "Font"          "AntennaExtraCond Bold Extra-Condensed"    ;a font variable
          SF-ADJUSTMENT  "Title Font size"     '(65 1 1000 1 10 0 1)
          SF-ADJUSTMENT  "Speaker Font size"     '(50 1 1000 1 10 0 1)
		  SF-COLOR       "Foreground Color"   '(23 116 222)
		  SF-COLOR       "Background Color"   '(255 255 255)
)
(script-fu-menu-register "script-fu-bauchbinde" "<Image>/File/Create/Slides")

(define (script-fu-bauchbinde inWidth inHeight inFont inTitleFontSize inSpeakerFontSize inFGColor inBGColor)
	(let * (
  	  (talkList '('()'()))
  	  (aTitle "")
  	  (aSpeaker "")
  	  (aDay "")
  	  (aSlot "")
	  		
	)
	(set! talkList (list 
		(list "Monday" "2" "YOLO Releases Considered Harmful" "Cate Huston")
		(list "Monday" "3" "Review All The Things!" "Maciej Piotrowski")
		(list "Monday" "5" "High Performance App Architecture" "Marcel Weiher")
		(list "Monday" "6" "Reactive Programming From Scratch" "Thomas Visser")
		(list "Monday" "8" "Good Typography, Better Apps" "Frank Rausch")
		(list "Monday" "9" "Unsophisticated Software Development" "Andreas Oetjen")
		(list "Monday" "10" "An iOS Developer’s Take on React Native" "Harry Tormey")
		(list "Monday" "12" "Developing Empathy" "Sarah E Olson")
		(list "Tuesday" "1" "Coding While Afraid" "Gwen Weston")
		(list "Tuesday" "2" "Move Fast and Keep Your Code Quality" "Francisco Díaz")
		(list "Tuesday" "4" "Strong Typing from the Server to the UI with GraphQL" "Martijn Walraven")
		(list "Tuesday" "5" "Code Generation in Swift — Gain Time, Type Safety and More!" "Olivier Halligon")
		(list "Tuesday" "7" "Applying Functional Insights without Losing Swift" "Rob Napier")
		(list "Tuesday" "8" "Anything You Can Do, I Can Do Better" "Brandon Williams & Lisa Luo")
		(list "Tuesday" "9" "Auto Layout — From Trailing to Leading" "Mischa Hildebrand")
		(list "Tuesday" "11" "Accessibility — iOS for All" "Sommer Panage")
	 ) )
	
	(map (lambda (talk) 
	       (set! aDay (car talk))
	   	   (set! aSlot (cadr talk))		
		   (set! aTitle (caddr talk))
		   (set! aSpeaker (cadddr talk))
		   
		   (script-fu-bauchbinde-single aDay aSlot inWidth inHeight aTitle aSpeaker inFont inTitleFontSize inSpeakerFontSize inFGColor inBGColor)
	      )
		talkList
	)
  )
)

(script-fu-register
          "script-fu-bauchbinde-single"                 ;func name
          "Text Box"                                  ;menu label
          "Creates a slide with title, subtitle and UIKonf 
		  logo and saves it under the format 
		  [day]-[slot]-[title]-[width]x[height].psd"              ;description
            "Sabine Geithner"                             ;author
            "copyright 2016 Sabine Geithner"        ;copyright notice
            "May 19, 2016"                          ;date created
          ""                     ;image type that the script works on
          SF-STRING      "Day"         "The day"   ;a string variable
          SF-STRING      "Slot"         "The slot number"   ;a string variable
		  SF-VALUE       "Width"        "1920"
		  SF-VALUE       "Height"        "1080"
          SF-STRING      "Title"         "The title"   ;a string variable
          SF-STRING      "Speaker"       "Sabine Geithner"   ;a string variable
          SF-FONT        "Font"          "AntennaExtraCond Bold Extra-Condensed"    ;a font variable
          SF-ADJUSTMENT  "Title Font size"     '(90 1 1000 1 10 0 1)
          SF-ADJUSTMENT  "Speaker Font size"     '(90 1 1000 1 10 0 1)
		  SF-COLOR       "Foreground Color"   '(255 255 255)
		  SF-COLOR       "Background Color"   '(255 255 255)
)

(define (script-fu-bauchbinde-single inDay inSlot inWidth inHeight inTitle inSpeaker inFont inTitleFontSize inSpeakerFontSize inFGColor inBGColor)
  (let*
    (
      ; define our local variables
      ; create a new image:
      (theImageWidth  inWidth)
      (theImageHeight inHeight)
	  (theUIKonfShapeLayerHeight 10)
	  (theUIKonfShapeLayerWidth 10)
      (theImage)
      (theImage
                (car
                    (gimp-image-new
                      theImageWidth
                      theImageHeight
                      RGB
                    )
                )
	  )
	  
      (vUIKonfShapeBuffer)           
      (hUIKonfShapeBuffer)
	             
      (theBackgroundLayer
                (car
                    (gimp-layer-new
                      theImage
                      theImageWidth
                      theImageHeight
                      RGBA-IMAGE
                      "Background"
                      75
                      NORMAL
                    )
                )
      )
	    (theUIKonfShapeLayer
	                    (car
		                    (gimp-layer-new
		                      theImage
		                      theImageWidth
		                      theImageHeight
		                      RGBA-IMAGE
		                      "UIKonf Shape"
		                      100
		                      NORMAL
		                    )
	                    )
	          	  )
  	)
	

	 ;end of our local variables
    (gimp-image-add-layer theImage theBackgroundLayer 0 )	
    (gimp-context-set-background inBGColor )
    (gimp-context-set-foreground inFGColor )
	
	(gimp-rect-select theImage 295 810 1540 200 REPLACE 0 0)
    (gimp-edit-fill theBackgroundLayer BACKGROUND-FILL)
	
	; draw circle
    (gimp-image-add-layer theImage theUIKonfShapeLayer 0 )
	(gimp-ellipse-select theImage 0 0 200 200 REPLACE 1 0 0)
	(gimp-edit-fill theUIKonfShapeLayer FOREGROUND-FILL)
	
	; resize cirlce
    ;(gimp-layer-resize theUIKonfShapeLayer 250 250 0 0)
	
	; move circle
	;(set! vUIKonfShapeBuffer (+ (- (/ theImageHeight 2) 125) (/ theImageHeight 4)))
	;(set! hUIKonfShapeBuffer (- (/ theImageWidth 2) 125))
    (gimp-layer-set-offsets theUIKonfShapeLayer 65 810)

	
	; add text layers
	(script-fu-add-textlayer-left-align theImage inFGColor inTitle inFont inTitleFontSize 350 830)
	(script-fu-add-textlayer-left-align theImage inFGColor inSpeaker inFont inSpeakerFontSize 350 920)
	(script-fu-add-textlayer-left-align theImage inBGColor "UIKonf" inFont 70 80 870)
	
    (gimp-display-new theImage)
    (list theImage theBackgroundLayer theUIKonfShapeLayer)
	(gimp-file-save RUN-NONINTERACTIVE theImage theBackgroundLayer (string-append "/Users/sabinegeithner/Desktop/" (number->string inWidth) "x" (number->string inHeight) "/Bauchbinden/" inDay "-" inSlot "-" inSpeaker "-"  (number->string inWidth) "x" (number->string inHeight) ".psd") "?")
		
  )
)



(script-fu-register
          "script-fu-add-textlayer-left-align"                 ;func name
          "Add Layer"                                  ;menu label
          "Adds a text layer to the center of an 
		  existing image. Adds an offset if specified." ;description
          "Sabine Geithner"                             ;author
          "copyright 2016 Sabine Geithner"        ;copyright notice
          "May 19, 2016"                          ;date created
          ""                     ;image type that the script works on
          SF-STRING      "Text"         "The text"   ;a string variable
		  SF-COLOR       "Text Color"   '(255 255 255)
          SF-FONT        "Font"          "AntennaExtraCond Bold Extra-Condensed"    ;a font variable
          SF-ADJUSTMENT  "Font size"     '(90 1 1000 1 10 0 1)
		  SF-VALUE       "x-Offset"        "0"
		  SF-VALUE       "y-Offset"        "0"
)


(define (script-fu-add-textlayer-left-align inImage inColor inTitle inFont inFontSize inXOffset inYOffset)
  (let*
    (
      ; define our local variables
      ; create a new image:
      (theImageWidth  10)
      (theImageHeight 10)
	  
	  (theTitleLayerHeight 10)
	  (theTitleLayerWidth 10)
	  
      (vTitleBuffer)           
      (hTitleBuffer)
	             
      (theTitleLayer
                (car
                    (gimp-text-layer-new
                      inImage
                      inTitle
                      inFont
                      inFontSize
                      PIXELS
                    )
                )
      	  )
  	)
	 ;end of our local variables
    (gimp-image-add-layer inImage theTitleLayer 0 )
	(gimp-text-layer-set-color theTitleLayer inColor)
	
    (set! theImageWidth (car (gimp-image-width  inImage) ) )
    (set! theImageHeight (car (gimp-image-height inImage) ) )
	
    (set! theTitleLayerWidth (car (gimp-drawable-width  theTitleLayer) ) )
    (set! theTitleLayerHeight (car (gimp-drawable-height theTitleLayer) ) )

	;(set! vTitleBuffer (- (/ theImageHeight 2) (/ theTitleLayerHeight 2) inOffset))
	;(set! hTitleBuffer (- (/ theImageWidth 2) (/ theTitleLayerWidth 2)))
	
    (gimp-layer-set-offsets theTitleLayer inXOffset inYOffset)
	
    (list inImage theTitleLayer)
		
  )
)