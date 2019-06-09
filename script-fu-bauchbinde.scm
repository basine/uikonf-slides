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
		  SF-DIRNAME	 "Output Directory"   gimp-data-directory
)
(script-fu-menu-register "script-fu-bauchbinde" "<Image>/File/Create/Slides")

(script-fu-bauchbinde 1 1920 1080 "AntennaExtraCond Bold Extra-Condensed" '(65 1 1000 1 10 0 1) '(50 1 1000 1 10 0 1) '(23 116 222) '(255 255 255) "/Users/sabinegeithner/Desktop/")

(define (script-fu-bauchbinde inWidth inHeight inFont inTitleFontSize inSpeakerFontSize inFGColor inBGColor outputDirectory)
	(let * (
  	  (talkList '('()'()))
  	  (aTitle "")
  	  (aSpeaker "")
  	  (aDay "")
  	  (aSlot "")
	  		
	)
	(set! talkList (list 
		;(list "Monday" "2" "Inclusive and Accessible App Development" "Kaya Thomas")
		;(list "Monday" "3" "Detangling Gesture Recognizers" "Shannon Hughes")
		;(list "Monday" "5" "Rolling your own Network Stack" "Glenna Buford")
		;(list "Monday" "6" "Declarative Presentations" "Nataliya Patsovska")
		;(list "Monday" "8" "Internationalizing your App" "Kristina Fox")
		;(list "Monday" "9" "Mockolo: Efficient Mock Generator for Swift " "Ellie Shin")
		;(list "Monday" "10" "Consistency Principle" "Julie Yaunches")
		;(list "Monday" "12" "How to Market Your Mobile App" "Lisa Dziuba")
		;(list "Monday" "13" "Swift to Hack Hardware" "Sally Shepard")
		;(list "Tuesday" "2" "From Heroic Leaders To High Performing Teams" "Füsun Wehrmann")
		;(list "Tuesday" "3" "Swift 5 Strings" "Erica Sadun")
		;(list "Tuesday" "5" "Kotlin/Native" "Ellen Shapiro")
		;(list "Tuesday" "6" "A11y-oop: Adding new Accessibility Features to not-so-new Apps" "Alaina Kafkes")
		;(list "Tuesday" "8" "Advanced Colors in iOS" "Neha Kulkarni")
		;(list "Tuesday" "9" "Promises in iOS" "Anne Cahalan")
		;(list "Tuesday" "10" "Muse Prototype Challenges" "Julia Roggatz")
		;(list "Tuesday" "12" "What to expect when you are templating? Clue’s approach to Backend Driven UIs" "Kate Castellano")
		;(list "Tuesday" "13" "Mobile && Me == It's Complicated" "Lea Marolt")
	 ) )
	
	(map (lambda (talk) 
	       (set! aDay (car talk))
	   	   (set! aSlot (cadr talk))		
		   (set! aTitle (caddr talk))
		   (set! aSpeaker (cadddr talk))
		   
		   (script-fu-bauchbinde-single aDay aSlot inWidth inHeight aTitle aSpeaker inFont inTitleFontSize inSpeakerFontSize inFGColor inBGColor outputDirectory)
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
		  SF-DIRNAME	 "Output Directory"   gimp-data-directory
)

(define (script-fu-bauchbinde-single inDay inSlot inWidth inHeight inTitle inSpeaker inFont inTitleFontSize inSpeakerFontSize inFGColor inBGColor outputDirectory)
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
	   (drawable)
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

	(gimp-file-save RUN-NONINTERACTIVE theImage theBackgroundLayer (string-append outputDirectory "/" inDay "-" inSlot "-" inSpeaker "-"  (number->string inWidth) "x" (number->string inHeight) ".psd") "?")
	
	(gimp-image-merge-visible-layers theImage CLIP-TO-IMAGE)
	(set! drawable (car (gimp-image-get-active-layer theImage)))
	
	(gimp-file-save RUN-NONINTERACTIVE theImage drawable (string-append outputDirectory "/" inDay "-" inSlot "-" inSpeaker "-"  (number->string inWidth) "x" (number->string inHeight) ".png") "?")
	;(gimp-image-delete theImage)		
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