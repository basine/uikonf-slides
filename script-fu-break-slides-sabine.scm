(script-fu-register
          "script-fu-breaks"                 ;func name
          "Break-Slides"                                  ;menu label
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
          SF-ADJUSTMENT  "Font size"     '(90 1 1000 1 10 0 1)
)
(script-fu-menu-register "script-fu-breaks" "<Image>/File/Create/Slides")

(define (script-fu-breaks inWidth inHeight inFont inFontSize)
	(let * (
  	  (talkList '('()'()))
  	  (aTitle "")
  	  (aSpeaker "")
  	  (aDay "")
  	  (aSlot "")
	  (theImage
		  (car
			  (gimp-xcf-load 1 "/Users/sabinegeithner/Desktop/Logos.pcx" "Logos")
		  )
	  )
	  (theDrawable
	  	  (car
		  	  (gimp-image-get-active-layer theImage)
		  )
	  )		
	)
	(set! talkList 
		(list 			
			(list "Monday" "1" "Welcome" "Test")
			;(list "Monday" "4" "Coffee Break" "")
			;(list "Monday" "7" "Lunch Break" "")
			;(list "Monday" "11" "Coffee Break" "")
			;(list "Monday" "14" "See you tomorrow!" "")
			;(list "Tuesday" "1" "Welcome back!" "")
			;(list "Tuesday" "4" "Coffee Break" "")
			;(list "Tuesday" "7" "Lunch Break" "")
			;(list "Tuesday" "11" "Coffee Break" "")
			;(list "Tuesday" "14" "See you at Festsaal Kreuzberg!" "")
	 	) 
 	)
	
	(map (lambda (talk) 
	       (set! aDay (car talk))
	   	   (set! aSlot (cadr talk))		
		   (set! aTitle (caddr talk))
		   (set! aSpeaker (cadddr talk))
		   
		   (script-fu-break-slide-sabine aDay aSlot inWidth inHeight aTitle aSpeaker inFont inFontSize theDrawable)
	      )
		talkList
	)
  )
)

(script-fu-register
          "script-fu-break-slide-sabine"                 ;func name
          "Break Slide"                                  ;menu label
          "Creates a slide with UIKonf 
		  logo, break title and subtitle and a sponsor image and saves it under the format 
		  [day]-[slot]-[title]-[width]x[height].psd"              ;description
            "Sabine Geithner"                             ;author
            "copyright 2016 Sabine Geithner"        ;copyright notice
            "May 19, 2016"                          ;date created
          ""                     ;image type that the script works on
          SF-STRING      "Day"          "The day"   ;a string variable
          SF-STRING      "Slot"         "The slot number"   ;a string variable
		  SF-VALUE       "Width"        "1920"
		  SF-VALUE       "Height"       "1080"
          SF-STRING      "Title"        "The title"   ;a string variable
          SF-STRING      "Subtitle"     "10am"   ;a string variable
          SF-FONT        "Font"         "AntennaExtraCond Bold Extra-Condensed"    ;a font variable
          SF-ADJUSTMENT  "Font size"    '(90 1 1000 1 10 0 1)
		  SF-DRAWABLE	 "SponsorDrawable"		0
)

(define (script-fu-break-slide-sabine inDay inSlot inWidth inHeight inTitle inSpeaker inFont inFontSize inDrawable)
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
                      RGB-IMAGE
                      "Background"
                      100
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
    (gimp-context-set-background '(51 153 255) )
    (gimp-context-set-foreground '(255 255 255))
    (gimp-drawable-fill theBackgroundLayer BACKGROUND-FILL)
	
	; draw circle
    (gimp-image-add-layer theImage theUIKonfShapeLayer 0 )
	(gimp-ellipse-select theImage 25 25 200 200 REPLACE 1 0 0)
	(gimp-edit-fill theUIKonfShapeLayer FOREGROUND-FILL)
	
	; resize cirlce
    (gimp-layer-resize theUIKonfShapeLayer 250 250 0 0)
	
	; move circle
	(set! vUIKonfShapeBuffer (+ (- (/ theImageHeight 2) 125) (/ theImageHeight 4)))
	(set! hUIKonfShapeBuffer (- (/ theImageWidth 2) 125))
    (gimp-layer-set-offsets theUIKonfShapeLayer hUIKonfShapeBuffer vUIKonfShapeBuffer)
	
	; add text layers
	(script-fu-add-layer-sabine theImage '(255 255 255) inTitle inFont inFontSize (* inFontSize 1.5))
	(script-fu-add-layer-sabine theImage '(255 255 255) inSpeaker inFont inFontSize 0)
	(script-fu-add-layer-sabine theImage '(51 153 255) "UIKonf" inFont 70 (- 0 (/ theImageHeight 4)))
	(gimp-image-add-layer theImage inDrawable 0 )
	
	
    (gimp-display-new theImage)
    (list theImage theBackgroundLayer theUIKonfShapeLayer)
	(gimp-file-save RUN-NONINTERACTIVE theImage theBackgroundLayer (string-append "/Users/sabinegeithner/Desktop/" (number->string inWidth) "x" (number->string inHeight) "/" inDay "-" inSlot "-" inSpeaker "-"  (number->string inWidth) "x" (number->string inHeight) ".psd") "?")
	
	(gimp-image-merge-visible-layers theImage CLIP-TO-IMAGE)
	(set! drawable (car (gimp-image-get-active-layer theImage)))
	
	(gimp-file-save RUN-NONINTERACTIVE theImage drawable (string-append "/Users/sabinegeithner/Desktop/" (number->string inWidth) "x" (number->string inHeight) "/" inDay "-" inSlot "-" inSpeaker "-"  (number->string inWidth) "x" (number->string inHeight) ".jpg") "?")
	;(gimp-image-delete theImage)
		
  )
)