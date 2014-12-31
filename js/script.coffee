$ ->
	$('div.door').on 'mouseenter', ->
		$(this).children('.swing').addClass('door-open')
		$(this).find('#tip').fadeIn(300)

	$('div.door').on 'mouseleave', ->
		$(this).children('.swing').addClass('door-close')
		$(this).find('#tip').fadeOut(300)
		self = this
		setTimeout ->
			$(self).children('.swing').removeClass('door-open')
			$(self).children('.swing').removeClass('door-close')
		, 1000

	$('div#know').on 'click', ->
		$('div#alert').slideUp(500)
		$('div#mask').fadeOut(500)

	$('div.door').on 'click', ->
		$(this).children().addClass('door-open')
		$(this).find('#tip').text('选我了').fadeIn(300)
		$(this).css('border', '5px solid #E01031')
		index = $(this).attr('index')
		window.select = Number(index)
		makeConfirm()

	index = Math.floor((Math.random() * 10)) % 3
	window.answer = index
	window.map = ['A', 'B', 'C']
	$("[index]").css({'background-image':'url(../img/fail.jpg)','background-size':'cover'})
	$("[index=#{window.answer}]").css({'background-image':'url(../img/success.jpg)','background-size':'cover'})
	
	makeConfirm = ->
		if window.select == window.answer
			window.wrong = Math.floor((Math.random() * 10)) % 3
			while window.wrong == window.select
				window.wrong = Math.floor((Math.random() * 10)) % 3
		else
			window.wrong = Math.floor((Math.random() * 10)) % 3
			while window.wrong == window.select or window.wrong == window.answer
				window.wrong = Math.floor((Math.random() * 10)) % 3

		$('div#confirm p#select').text("你选了#{window.map[window.select]}门")
		$('div#confirm p#wrong').text("我可以确定#{window.map[window.wrong]}门一定不对")
		$('div#confirm div#stick').text("不改，选#{window.map[window.select]}门")
		
		window.newOption = Math.floor((Math.random() * 10)) % 3
		while window.newOption == window.select or window.newOption == window.wrong
			window.newOption = Math.floor((Math.random() * 10)) % 3
		$('div#confirm div#switch').text("改，选#{window.map[window.newOption]}门")

		$('div#mask').css('opacity', '0.3')
		$('div#mask').fadeIn(500)
		$('div#confirm').addClass('confirm-down')

		setTimeout ->
			$("[index=#{window.wrong}]").children('.swing').addClass('door-open-full')
		, 600

	$('div#stick').on 'click', ->
		$('div#confirm').slideUp(500)
		$('div#mask').fadeOut(500)
		setTimeout ->
			$("[index=#{window.select}]").children('.swing').addClass('door-open-full')
		, 500

	$('div#switch').on 'click', ->
		$('div#confirm').slideUp(500)
		$('div#mask').fadeOut(500)
		setTimeout ->
			$("[index=#{window.newOption}]").children('.swing').addClass('door-open-full')
		, 500
