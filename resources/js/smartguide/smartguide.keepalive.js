var keepAliveController = {
	init: function (sgRef, warnDelay, redirDelay, keepAliveDelay, keepAlivePage, logoutUrl, redirUrl) {
		keepAlive(warnDelay, redirDelay, keepAliveDelay, keepAlivePage, logoutUrl, redirUrl);		
	},

	bindEvents: function (sgRef, context) {
		
	}
}

function keepAlive(warnDelay, redirDelay, keepAliveDelay, keepAlivePage, logoutPage, redirPage) {
	if(typeof logoutPage === 'undefined' || logoutPage == "") {
		logoutPage = '/smartlets/do.aspx?interviewID=logout&workspace=' + workspace + '&lang=' + currentLocale + '&session-timeout=true';
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