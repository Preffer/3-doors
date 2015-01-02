$ ->
	$('div#portrait .button').on 'click', ->
		$('div#portrait').animate
			height: "45vh"
		, 500, ->
			$('div#tip').fadeIn(500)