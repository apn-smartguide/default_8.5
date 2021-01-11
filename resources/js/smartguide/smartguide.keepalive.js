var keepAliveController = {
	init: function (sgRef, warnDelay, redirDelay, keepAliveDelay, keepAlivePage, logoutUrl, redirUrl) {
		keepAlive(warnDelay, redirDelay, keepAliveDelay, keepAlivePage, logoutUrl, redirUrl);		
	},

	bindEvents: function (sgRef, context) {
		
	}
}

function keepAlive(warnDelay, redirDelay, keepAliveDelay, _keepAliveUrl, _logoutUrl, _redirUrl) {

	if(typeof _keepAliveUrl !== 'undefined' && _keepAliveUrl != "") {
		keepAlivePage = _keepAliveUrl;
	}

	if(typeof _logoutUrl !== 'undefined' && _logoutUrl != "") {
		logoutPage = _logoutUrl;
	}

	if(typeof logoutPage === 'undefined' || logoutPage == "") {
		logoutPage = '/smartlets/do.aspx?interviewID=logout&workspace=' + workspace + '&lang=' + currentLocale + '&session-timeout=true';
	}

	if(typeof _redirUrl !== 'undefined' && _redirUrl != "") {
		redirPage = _redirUrl;
	}

	if(typeof redirPage === 'undefined' || redirPage == "") {
		redirPage = logoutPage;
	}

	if (currentLocale == 'fr' && keepAliveFlag == "True") {
		$.sessionTimeout({
			title: "Gestion de session",
			message: "Votre session expire bientôt",
			logoutButton: 'Quitter le site',
			keepAliveButton: 'Rester connecté',
			keepAliveUrl: keepAlivePage,
			logoutUrl: logoutPage,
			redirUrl: redirPage,
			warnAfter:warnDelay*60*1000,
			redirAfter: redirDelay*60*1000,
			keepAliveInterval: keepAliveDelay*1000,
			countdownMessage: 'Redirection dans {timer} secondes.',
			countdownBar: true
		});			
	}
	if (currentLocale == 'en' && keepAliveFlag == "True") {
		$.sessionTimeout({
			title: "Timeout management",
			message: "Your session will expire soon",
			logoutButton: 'Leave site',
			keepAliveButton: 'Stay connected',
			keepAliveUrl: keepAlivePage,
			logoutUrl: logoutPage,
			redirUrl: redirPage,
			warnAfter:warnDelay*60*1000,
			redirAfter: redirDelay*60*1000,
			keepAliveInterval: keepAliveDelay*1000,
			countdownMessage: 'Redirecting in {timer} seconds.',
			countdownBar: true
		});			
	}
}