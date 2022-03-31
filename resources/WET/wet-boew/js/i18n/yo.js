/*
* Web Experience Toolkit (WET) / Boîte à outils de l"expérience Web (BOEW)
* wet-boew.github.io/wet-boew/License-en.html / wet-boew.github.io/wet-boew/Licence-fr.html
*/
/*
----- Yoruba dictionary (il8n) ---
*/
( function( wb ) {
"use strict";

/* main index */
wb.i18nDict = {
	"lang-code": "yo",
	"lang-native": "Yoruba",
	add: "Fikun",
	all: "Gbogbo",
	tphp: "Oke oju-iwe",
	load: "Loading ...",
	process: "Ṣiṣẹ ...",
	srch: "Ṣewadii",
	"no-match": "Ko si ibaamu kan",
	matches: {
		mixin: "[Potein] ibaamu (es) ri"
	},
	current: "(lọwọlọwọ)",
	hide: "Pamọ",
	err: "Aṣiṣe",
	colon: ":",
	hyphen: " -",
	"full-stop": ".",
	"comma-space": ",",
	space: "& 32;",
	start: "Bẹrẹ",
	stop: "Duro",
	back: "Ẹhin",
	cancel: "Fagilee",
	"min-ago": "Iṣẹju kan sẹhin",
	"coup-mins": "Awọn iṣẹju meji sẹhin",
	"mins-ago": {
		mixin: "[Potein] iṣẹju sẹyin"
	},
	"hour-ago": "wakati kan sẹhin",
	"hours-ago": {
		mixin: "[Poterin] awọn wakati sẹhin"
	},
	"days-ago": {
		mixin: "[Potein]"
	},
	yesterday: "ana",

	nxt: "Itele",
	"nxt-r": "Next (bọtini itọka ọtun)",
	prv: "Ṣaaju",
	"prv-l": "Ti tẹlẹ (bọtini itọka osi)",
	first: "Akoko",
	last: "Kọja",
	page: "Lọ si: Oju-iwe",
	"srch-menus": "Wiwa ati awọn akojọ aṣayan",
	email: "Imeeli",
	"menu-close": "Ṣeto akojọ aṣayan",
	"overlay-close": "Sunmọ overlay",
	"esc-key": "(Ona abayo)",
	show: "Fihan",

	/* Tabbed interface */
	"tab-rot": {
		off: "Duro iyipo iyipo",
		on: "Bibẹrẹ Yiyi Yipada"
	},
	"tab-list": "Atokọ taabu",
	"tab-pnl-end1": "Ipari ti nronu taabu yii.",
	"tab-pnl-end2": "Pada si atokọ taabu",
	"tab-pnl-end3": "tabi tẹsiwaju si iyokù ti oju-iwe.",
	"tab-play": "Mu ṣiṣẹ",

	/* Multimedia player */
	"mmp-play": "Mu ṣiṣẹ",
	pause: "Sinmi",
	open: "Ṣii",
	close: "Sunmọ",
	volume: "Iwọn didun",
	mute: {
		on: "Duro",
		off: "Aiduro"
	},
	cc: {
		off: "Tọju ọrọ ti o wa ni pipade",
		on: "Fifihan fi opin si"
	},
	"cc-err": "Aṣiṣe Loading Awọn akọle pipade",
	adesc: {
		on: "Mu ijuwe ohun ṣiṣẹ",
		off: "Mu apejuwe Audio"
	},
	pos: "Ipo lọwọlọwọ:",
	dur: "Opo akoko:",

	/* Share widget */
	"shr-txt": "Pin",
	"shr-pg": " Oju-iwe yii",
	"shr-vid": " Fidio yii",
	"shr-aud": " Faili Audio yii",
	"shr-hnt": " pẹlu {s}",
	"shr-disc": "Ko si ifọwọsi ti eyikeyi awọn ọja tabi awọn iṣẹ ti han tabi mimọ.",

	/* Form validation */
	"frm-nosubmit": "Fọọmu naa ko le fi silẹ nitori",
	"errs-fnd": " a rii awọn aṣiṣe.",
	"err-fnd": " a ri aṣiṣe.",
	"err-correct": "(Ti o tọ ati resubmimi)",

	/* Date picker */
	"date-hide": "Tọju kalẹnda",
	"date-show": "Mu ọjọ kan lati kalẹnda fun aaye:",
	"date-sel": "Ti yan",

	/* Calendar */
	days: [
		"Ọjọ Sundee",
		"Ọjọ Aarọ",
		"Ọjọ Iṣẹsẹ",
		"Ọjọ-aye",
		"Ọjọbọ",
		"Ọjọ Jimọ",
		"Satidee"
	],
	mnths: [
		"Oṣu Kini",
		"Oṣu Keji",
		"Oṣu Kẹta",
		"Oṣu Kẹrin",
		"Le",
		"Oṣu Kẹfa",
		"Oṣu Keje",
		"Oṣu Kẹjọ",
		"Oṣu Kẹsan",
		"Oṣu Kẹwa",
		"Oṣuṣu",
		"Oṣu Kejila"
	],
	cal: "Kalẹnda",
	"cal-format": "<SPAN CLAD = 'WB-pe'> {DDD}, {M} </ </ span>",
	currDay: "(Ọjọ lọwọlọwọ)",
	"cal-goToLnk": "Lọ si Kilasi SPAN = \"WB-LOB-In\" Oṣu Kẹwa ti Odun </ Span>",
	"cal-goToTtl": "Lọ si oṣu ti ọdun",
	"cal-goToMnth": "Oṣu:",
	"cal-goToYr": "Odun:",
	"cal-goToBtn": "Lọ",
	prvMnth: "Oṣu iṣaaju:",
	nxtMnth: "Oṣu ti n bọ:",

	/* Lightbox */
	"lb-curr": "Nkan% Curc% ti% lapapọ%",
	"lb-xhr-err": "Akoonu yii kuna lati fifuye.",
	"lb-img-err": "Aworan yii kuna lati fifuye.",

	/* Charts widget */
	"tbl-txt": "Tabili",
	"tbl-dtls": "Aworan apẹrẹ. Awọn alaye ninu tabili atẹle.",
	"chrt-cmbslc": "Bibẹ pẹlẹbẹ",

	/* Session timeout */
	"st-to-msg-bgn": "Igba rẹ yoo pari laifọwọyi ni # min # min # iṣẹju-aaya # iṣẹju-aaya.",
	"st-to-msg-end": "Yan \"Tẹsiwaju igba\" lati fa igba rẹ kun.",
	"st-msgbx-ttl": "Ikilọ akoko akoko",
	"st-alrdy-to-msg": "Ma binu pe igba rẹ ti pari tẹlẹ. Jọwọ wọle lẹẹkansii.",
	"st-btn-cont": "Tẹsiwaju igba",
	"st-btn-end": "Ikẹhin igba bayi",

	/* Toggle details */
	"td-toggle": "Siggle gbogbo",
	"td-open": "Faagun gbogbo rẹ",
	"td-close": "Pa gbogbo",
	"td-ttl-open": "Faagun gbogbo awọn apakan ti akoonu",
	"td-ttl-close": "Ba gbogbo awọn apakan ti akoonu",

	/* Table enhancement */
	sortAsc: ": mu ṣiṣẹ fun ipinle ibigbogbo",
	sortDesc: ": Mu ṣiṣẹ fun sọkalẹ akoko",
	emptyTbl: "Ko si data wa ninu tabili",
	infoEntr: "Fifihan _start_ To _end_ ti _total_ Awọn titẹ sii",
	infoEmpty: "Ifihan 0 si 0 ti awọn titẹ sii 0",
	infoFilt: "(filtered lati _ax_ awọn titẹ sii lapapọ)",
	info1000: ",",
	lenMenu: "Fihan _menu_ Awọn titẹ sii",
	filter: "Awọn nkan àlẹmọ",

	/* Geomap */
	"geo-mapctrl": "@geo-mapctrl@",
	"geo-zmin": "Sun sinu",
	"geo-zmout": "Sun sita",
	"geo-zmwrld": "Sunmọ si ipòp",
	"geo-zmfeat": "Sun si ipin",
	"geo-sclln": "Maase asekale",
	"geo-msepos": "Fount ati gigun gigun ti kọsọ Asin",
	"geo-ariamap": "Maapu maapu. Awọn apejuwe ti awọn ẹya maapu wa ninu tabili ni isalẹ.",
	"geo-ally": "<Laisi> Awọn olumulo keyboard: </ lagbara> Nigbati maapu ba wa ni idojukọ, lo awọn bọtini itọka lati pan maapu ati awọn bọtini sẹẹli ati awọn bọtini iyokuro lati sun. Awọn bọtini itọka ko ni pan aworan naa nigbati o ba tẹẹrẹ si maapu maapu.",
	"geo-allyttl": "Awọn itọsọna: Lilọ kiri Max",
	"geo-tgllyr": "Yi ifihan ti Layer naa",
	"geo-hdnlyr": "Layer yii ni o farapamọ.",
	"geo-bmap-url": "//Gappext.nrcan.ca.ca/arcgis/rest/Siserices/bassimaps/BBS3978/MSSTSTS/WMts/",
	"geo-bmap-matrix-set": "Aiyipada28mm",
	"geo-bmapttl": "Basimaps_cbmt3978",
	"geo-bmapurltxt": "//Gappext.nrcan.ca.ca marcgis/rest/Siserve/cbt_3978/ } .jpg",
	"geo-attrlnk": "//gograatis.cg.ca/cogratis/cbm_cbc?",
	"geo-attrttl": "Sibẹsibẹ - Maata mimọ Map",
	"geo-sel": "Yan",
	"geo-lblsel": "Ṣayẹwo lati yan ẹya lori maapu",
	"geo-locurl-geogratis": "//Gogratis.ca.ca/suction/gelolocation/en/cate",
	"geo-loc-placeholder": "Tẹ tẹ & # 44; Koodu ifiweranse & # 44; Adirẹsi Street & # 44; Nọmba NTS ...",
	"geo-loc-label": "Ipo",
	"geo-aoi-north": "Ariwa",
	"geo-aoi-east": "Ila-oorun",
	"geo-aoi-south": "Guusu",
	"geo-aoi-west": "Iwọ oorun",
	"geo-aoi-instructions": "Fa apoti lori maapu tabi tẹ awọn ipoidojui isalẹ ki o tẹ bọtini \"Fikun\".",
	"geo-aoi-title": "Fa apoti lori maapu tabi tẹ awọn ipoidojuko",
	"geo-aoi-btndraw": "Ya",
	"geo-aoi-btnclear": "Ko kuro",
	"geo-geoloc-btn": "Sun si ipo lọwọlọwọ",
	"geo-geoloc-fail": "Geolate ti kuna. Jọwọ rii daju pe awọn iṣẹ agbegbe ti ṣiṣẹ.",
	"geo-geoloc-uncapable": "Geograpin ko ni atilẹyin nipasẹ ẹrọ aṣawakiri rẹ.",
	"geo-lgnd-grphc": "Arosọ ti aworan fun aworan ayẹwo.",

	/* Disable/enable WET plugins and polyfills */
	"wb-disable": "Yipada si ẹya HTML ipilẹ",
	"wb-enable": "Yipada si ẹya idiwọn",
	"disable-notice-h": "Akiyesi: Inchml ipilẹ",
	"disable-notice": "O n wo wiwo HTML ipilẹ. Diẹ ninu awọn ẹya le jẹ alaabo.",
	"skip-prefix": "Rekọja si:",

	/* Dismissable content */
	"dismiss": "Tuka",

	/* Template */
	"tmpl-signin": "wọle",

	/* Filter */
	"fltr-lbl": "Àlẹmọ",
	"fltr-info": "Fifihan _nbime_ filtered lati _total_ awọn titẹ sii lapapọ"
};

} )( wb );
