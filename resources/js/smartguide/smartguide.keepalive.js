var keepAliveController = {
	init: function (sgRef, warnDelay, redirDelay, keepAliveDelay, keepAlivePage, logoutUrl, redirUrl) {
		sgKeepAlive(warnDelay, redirDelay, keepAliveDelay, keepAlivePage, logoutUrl, redirUrl);		
	},

	bindEvents: function (sgRef, context) {
		
	}
}

function sgKeepAlive(warnDelay, redirDelay, keepAliveDelay, _keepAliveUrl, _logoutUrl, _redirUrl) {

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

	//A 30 seconds buffer is substracted from the configured session duration, this avoid possible timing offset errors to affect the session extension.
	if (currentLocale == 'fr' && keepAliveFlag == "True") {
		$.sessionTimeout({
			title: "Gestion de session",
			message: "Votre session expire bientôt",
			logoutButton: 'Quitter le site',
			keepAliveButton: 'Rester connecté',
			keepAliveUrl: keepAlivePage,
			logoutUrl: logoutPage,
			redirUrl: redirPage,
			warnAfter:(warnDelay*60*1000),
			redirAfter: (redirDelay*60*1000)-(30*1000),
			keepAliveInterval: keepAliveDelay*1000,
			ignoreUserActivity: false,
			keepAlive: true,
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
			warnAfter:(warnDelay*60*1000),
			redirAfter: (redirDelay*60*1000)-(30*1000), 
			keepAliveInterval: keepAliveDelay*1000,
			ignoreUserActivity: false,
			keepAlive: true,
			countdownMessage: 'Redirecting in {timer} seconds.',
			countdownBar: true
		});			
	}
}