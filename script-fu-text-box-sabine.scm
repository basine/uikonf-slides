(script-fu-register
          "script-fu-talks"                 ;func name
          "Slides"                                  ;menu label
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
(script-fu-menu-register "script-fu-talks" "<Image>/File/Create/Slides")

(define (script-fu-talks inWidth inHeight inFont inFontSize)
	(let * (
  	  (talkList '('()'()))
  	  (aTitle "")
  	  (aSpeaker "")
  	  (aDay "")
  	  (aSlot "")
	  		
	)
	(set! talkList 
		(list 			
			;(list "Monday" "1" "Welcome" "")
			;(list "Monday" "2" "(Community Ethics)" "Kamilah Taylor")
			;(list "Monday" "3" "The Magic of UI Testing" "John Sundell")
			;(list "Monday" "4" "Coffee Break" "")
			(list "Monday" "5" "10 Things You Need to Know Before Implementing Cryptography" "Anastasia Voitova")
			;(list "Monday" "6" "Compilers and LLVM Demystified" "Edward Valentini")
			;(list "Monday" "7" "Lunch Break" "")
			;(list "Monday" "8" "Swift in Space – The N-Body Problem" "Daniel Jilg")
			;(list "Monday" "9" "Advanced Debugging Techniques" "Carola Nitz")
			;(list "Monday" "10" "MVC is Not Your Problem" "Joachim Kurz")
			;(list "Monday" "11" "Coffee Break" "")
			;(list "Monday" "12" "An Engineer’s Code of Ethics" "Agis Tsaraboulidis")
			;(list "Monday" "13" "(Fashion Tech)" "Esther Zahn")
			;(list "Monday" "14" "See you tomorrow!" "")
			;(list "Tuesday" "1" "Welcome back!" "")
			;(list "Tuesday" "2" "(Business)" "Peter Steinberger")
			;(list "Tuesday" "3" "Gotta Go Fast (A Performance and Instruments Talk)" "Luke Parham")
			;(list "Tuesday" "4" "Coffee Break" "")
			;(list "Tuesday" "5" "End-to-End Encryption for iOS Developer" "Mihail Gerasimenko")
			;(list "Tuesday" "6" "The Code You Don’t Have to Write" "Domas Nutautas")
			;(list "Tuesday" "7" "Lunch Break" "")
			;(list "Tuesday" "8" "The Laws of Magic" "Dave DeLong")
			;(list "Tuesday" "9" "Improving Scrolling Performance through GPU Optimisation" "Janina Kutyn")
			;(list "Tuesday" "10" "Simplified VIPER architecture" "Susmita Horrow")
			;(list "Tuesday" "11" "Coffee Break" "")
			;(list "Tuesday" "12" "Scaling iOS at SoundCloud" "Vincent Garrigues")
			;(list "Tuesday" "13" "A Decade of iPhone & iOS in 40 Minutes" "Adrian Kosmaczewski")
			;(list "Tuesday" "14" "See you at Festsaal Kreuzberg!" "")
	 	) 
 	)
	
	(map (lambda (talk) 
	       (set! aDay (car talk))
	   	   (set! aSlot (cadr talk))		
		   (set! aTitle (caddr talk))
		   (set! aSpeaker (cadddr talk))
		   
		   (script-fu-text-box-sabine aDay aSlot inWidth inHeight aTitle aSpeaker inFont inFontSize)
	      )
		talkList
	)
  )
)

(script-fu-register
          "script-fu-text-box-sabine"                 ;func name
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
          SF-ADJUSTMENT  "Font size"     '(90 1 1000 1 10 0 1)
)

(define (script-fu-text-box-sabine inDay inSlot inWidth inHeight inTitle inSpeaker inFont inFontSize)
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
	
    (gimp-display-new theImage)
    (list theImage theBackgroundLayer theUIKonfShapeLayer)
	(gimp-file-save RUN-NONINTERACTIVE theImage theBackgroundLayer (string-append "/Users/sabinegeithner/Desktop/" (number->string inWidth) "x" (number->string inHeight) "/" inDay "-" inSlot "-" inSpeaker "-"  (number->string inWidth) "x" (number->string inHeight) ".psd") "?")
	
	(gimp-image-merge-visible-layers theImage CLIP-TO-IMAGE)
	(set! drawable (car (gimp-image-get-active-layer theImage)))
	
	(gimp-file-save RUN-NONINTERACTIVE theImage drawable (string-append "/Users/sabinegeithner/Desktop/" (number->string inWidth) "x" (number->string inHeight) "/" inDay "-" inSlot "-" inSpeaker "-"  (number->string inWidth) "x" (number->string inHeight) ".jpg") "?")
	;(gimp-image-delete theImage)
		
  )
)



(script-fu-register
          "script-fu-add-layer-sabine"                 ;func name
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
		  SF-VALUE       "Offset"        "0"
)


(define (script-fu-add-layer-sabine inImage inColor inTitle inFont inFontSize inOffset)
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

	(set! vTitleBuffer (- (/ theImageHeight 2) (/ theTitleLayerHeight 2) inOffset))
	(set! hTitleBuffer (- (/ theImageWidth 2) (/ theTitleLayerWidth 2)))
	
    (gimp-layer-set-offsets theTitleLayer hTitleBuffer vTitleBuffer)
	
    (list inImage theTitleLayer)
		
  )
)