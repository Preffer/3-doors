$ ->
	(->
		randomSort = (a, b)->
			return Math.random() > 0.5 ? -1 : 1

		window.names = ['A', 'B', 'C']
		window.secret = [0, 1, 2]
		window.secret.sort(randomSort)
		window.secret.sort(randomSort)

		$('div#landscape .door').eq(window.secret[2]).css('background-image': 'url(../img/success.jpg)')
		window.times = 0
	)()

	$('div#portrait .button').on 'click', ->
		$('div#portrait').animate
			height: "45vh"
		, 500, ->
			$('div#tip').fadeIn(500)

	$('div#landscape #know').on 'click', ->
		$('div#rule').slideUp(500)
		$('div#doorGroup p.cute').fadeIn(500)
		window.shakeHandler = setInterval ->
			$('div#doorGroup p.cute').effect('shake', {distance: 5})
		, 1000

	$('div#landscape .door').on 'click', ->
		if window.times == 0
			firstChoice(this)
		else if window.times == 1
			secondChoice(this)

		window.times++

firstChoice = (self)->
	$(self).addClass('door-selected')
	clearInterval(window.shakeHandler)
	$('div#doorGroup p.cute').fadeOut(500)

	window.select = Number($(self).attr('index'))
	window.answer = window.secret.pop()

	if window.select == window.answer
		window.wrong = window.secret.pop()
		window.suggest = window.secret.pop()
	else
		window.secret.splice(window.secret.indexOf(window.select), 1)
		window.wrong = window.secret.pop()
		window.suggest = window.answer

	$('div#confirm p#feedback').text(
		"你选了#{window.names[window.select]}门 我可以确定#{window.names[window.wrong]}门一定不对"
	)
	$('div#landscape div#confirm').addClass('confirm-up')

	setTimeout ->
		$('div#landscape p.cute').eq(window.wrong).empty()
		$('div#landscape .swing').eq(window.wrong).addClass('door-open')
		setTimeout ->
			$('div#doorGroup p.cute').fadeIn(500)
			window.shakeHandler = setInterval ->
				$('div#doorGroup p.cute').effect('shake', {distance: 5})
			, 1000
		, 800
	, 800

secondChoice = (self)->
	clearInterval(window.shakeHandler)
	$('div#doorGroup p.cute').fadeOut(500)
	$('div#landscape div#confirm').slideUp(500)
	$('div#landscape .door-selected').removeClass('door-selected')
	$(self).addClass('door-selected')
	$(self).children('.swing').addClass('door-open')

	newSelect = Number($(self).attr('index'))
	setTimeout ->
		if newSelect == window.select
			lastDoor = $('div#landscape p.cute').eq(window.suggest)
		else
			lastDoor = $('div#landscape p.cute').eq(window.select)
		if newSelect == window.answer
			lastDoor.text('机智！！').fadeIn(500)
		else
			lastDoor.text('傻逼了吧，叫你不选我').fadeIn(500)
	, 800