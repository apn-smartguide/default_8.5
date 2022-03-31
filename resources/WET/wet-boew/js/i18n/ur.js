/*
* Web Experience Toolkit (WET) / Boîte à outils de l"expérience Web (BOEW)
* wet-boew.github.io/wet-boew/License-en.html / wet-boew.github.io/wet-boew/Licence-fr.html
*/
/*
----- Urdu dictionary (il8n) ---
*/
( function( wb ) {
"use strict";

/* main index */
wb.i18nDict = {
	"lang-code": "ur",
	"lang-native": "اردو",
	add: "شامل",
	all: "سب",
	tphp: "صفحہ کے اوپر",
	load: "لوڈ کر رہا ہے ...",
	process: "پروسیسنگ ...",
	srch: "تلاش",
	"no-match": "کوئی میچ نہیں ملا",
	matches: {
		mixin: "[مکسین] میچ (ایس ایس) مل گیا"
	},
	current: "(موجودہ)",
	hide: "چھپائیں",
	err: "غلطی",
	colon: "انکار",
	hyphen: " روایات",
	"full-stop": ".",
	"comma-space": "،",
	space: "& # 32؛",
	start: "شروع",
	stop: "سٹاپ",
	back: "پیچھے",
	cancel: "منسوخ",
	"min-ago": "ایک منٹ پہلے",
	"coup-mins": "منٹ پہلے جوڑے",
	"mins-ago": {
		mixin: "[مکسین] منٹ پہلے"
	},
	"hour-ago": "ایک گھنٹے پہلے",
	"hours-ago": {
		mixin: "[مکسین] گھنٹے پہلے"
	},
	"days-ago": {
		mixin: "[مکسین] دن پہلے"
	},
	yesterday: "کل",

	nxt: "اگلے",
	"nxt-r": "اگلا (دائیں تیر کی چابی)",
	prv: "پچھلا",
	"prv-l": "پچھلا (بائیں تیر کی چابی)",
	first: "پہلا",
	last: "آخری",
	page: "پر جائیں: صفحہ",
	"srch-menus": "تلاش اور مینو",
	email: "ای میل",
	"menu-close": "بند کریں مینو",
	"overlay-close": "اوورلے بند",
	"esc-key": "(فرار کلید)",
	show: "شو",

	/* Tabbed interface */
	"tab-rot": {
		off: "ٹیب گردش بند کرو",
		on: "ٹیب گردش شروع کریں"
	},
	"tab-list": "ٹیب کی فہرست",
	"tab-pnl-end1": "اس ٹیب پینل کے اختتام.",
	"tab-pnl-end2": "ٹیب کی فہرست میں واپس جائیں",
	"tab-pnl-end3": "یا باقی صفحے پر جاری رکھیں.",
	"tab-play": "کھیلیں",

	/* Multimedia player */
	"mmp-play": "کھیلیں",
	pause: "روک دیں",
	open: "کھولیں",
	close: "بند کریں",
	volume: "حجم",
	mute: {
		on: "گونگا",
		off: "Unmute."
	},
	cc: {
		off: "بند کیپشننگ کو چھپائیں",
		on: "بند کیپشننگ دکھائیں"
	},
	"cc-err": "بند کیپشن کو لوڈ کرنے میں خرابی",
	adesc: {
		on: "آڈیو تفصیل کو فعال کریں",
		off: "آڈیو تفصیل کو غیر فعال کریں"
	},
	pos: "موجودہ پوزیشن:",
	dur: "مکمل وقت:",

	/* Share widget */
	"shr-txt": "بانٹیں",
	"shr-pg": " یہ صفحہ",
	"shr-vid": " یہ ویڈیو",
	"shr-aud": " یہ آڈیو فائل",
	"shr-hnt": " {s} کے ساتھ",
	"shr-disc": "کسی بھی مصنوعات یا خدمات کی کوئی تصدیق نہیں کی جاتی ہے یا تقاضا ہے.",

	/* Form validation */
	"frm-nosubmit": "فارم جمع نہیں کیا جاسکتا ہے",
	"errs-fnd": " غلطیاں مل گئی تھیں.",
	"err-fnd": " غلطی مل گئی تھی.",
	"err-correct": "(درست اور دوبارہ بھیج دیں)",

	/* Date picker */
	"date-hide": "کیلنڈر چھپائیں",
	"date-show": "میدان کے لئے ایک کیلنڈر سے ایک تاریخ منتخب کریں:",
	"date-sel": "منتخب شدہ",

	/* Calendar */
	days: [
		"اتوار",
		"پیر",
		"منگل کو",
		"بدھ",
		"جمعرات",
		"جمعہ",
		"ہفتہ"
	],
	mnths: [
		"جنوری",
		"فروری",
		"مارچ",
		"اپریل",
		"مئی",
		"جون",
		"جولائی",
		"اگست",
		"ستمبر",
		"اکتوبر",
		"نومبر",
		"دسمبر"
	],
	cal: "کیلنڈر",
	"cal-format": "<اسپین کلاس = 'ڈبلیو ڈی ڈی انڈی'> {DDD}، {m} </ span> {d} <span class = 'wb-invi'>، {Y} </ span>",
	currDay: "(آج کا دن)",
	"cal-goToLnk": "<span class = \"WB-SIV\"> سال کے مہینے میں جائیں </ span>",
	"cal-goToTtl": "سال کے مہینے میں جاؤ",
	"cal-goToMnth": "مہینہ:",
	"cal-goToYr": "سال:",
	"cal-goToBtn": "جاؤ",
	prvMnth: "پچھلے مہینے:",
	nxtMnth: "اگلے مہینے:",

	/* Lightbox */
	"lb-curr": "آئٹم٪ CUST٪٪ کل٪",
	"lb-xhr-err": "یہ مواد لوڈ کرنے میں ناکام رہا.",
	"lb-img-err": "یہ تصویر لوڈ کرنے میں ناکام رہی.",

	/* Charts widget */
	"tbl-txt": "ٹیبل",
	"tbl-dtls": "چارٹ. مندرجہ ذیل ٹیبل میں تفصیلات.",
	"chrt-cmbslc": "مشترکہ سلائس",

	/* Session timeout */
	"st-to-msg-bgn": "آپ کا سیشن # منٹ # منٹ # سیکنڈ # سیکنڈ میں خود کار طریقے سے ختم ہو جائے گا.",
	"st-to-msg-end": "اپنے سیشن کو بڑھانے کے لئے \"سیشن جاری رکھیں\" منتخب کریں.",
	"st-msgbx-ttl": "سیشن ٹائم آؤٹ انتباہ",
	"st-alrdy-to-msg": "معذرت، آپ کا سیشن پہلے ہی ختم ہو گیا ہے. براہ کرم دوبارہ سائن ان کریں.",
	"st-btn-cont": "سیشن جاری رکھیں",
	"st-btn-end": "اب اختتام سیشن",

	/* Toggle details */
	"td-toggle": "تمام ٹوگل",
	"td-open": "تمام توسیع",
	"td-close": "سب کو ختم",
	"td-ttl-open": "مواد کے تمام حصوں کو بڑھانا",
	"td-ttl-close": "مواد کے تمام حصوں کو ختم کرنا",

	/* Table enhancement */
	sortAsc: ": ترتیب دینے کے لئے چالو کریں",
	sortDesc: ": نیچے اتارنے کے لئے چالو کریں",
	emptyTbl: "میز میں کوئی ڈیٹا دستیاب نہیں ہے",
	infoEntr: "_TOTAL_ اندراجات کے _ _ _END_ کو دکھا رہا ہے",
	infoEmpty: "0 سے 0 0 سے 0 دکھا رہا ہے",
	infoFilt: "(_max_ کل اندراجات سے فلٹر)",
	info1000: "،",
	lenMenu: "_menu_ اندراج دکھائیں",
	filter: "فلٹر اشیاء",

	/* Geomap */
	"geo-mapctrl": "@geo-mapctrl@",
	"geo-zmin": "زوم",
	"geo-zmout": "دور کرنا",
	"geo-zmwrld": "حد تک نقشہ کرنے کے لئے زوم",
	"geo-zmfeat": "عنصر کو زوم",
	"geo-sclln": "نقشہ پیمانے پر",
	"geo-msepos": "ماؤس کرسر کی طول و عرض اور طول و عرض",
	"geo-ariamap": "نقشہ اعتراض نقشے کی خصوصیات کی وضاحت ذیل میں میز میں ہیں.",
	"geo-ally": "<مضبوط> کی بورڈ کے صارفین: </ مضبوط> جب نقشہ توجہ مرکوز میں ہے تو، نقشہ اور پلس اور مائنس کی چابیاں زوم کرنے کے لئے تیر کی چابیاں استعمال کریں. نقشہ حد تک زوم جب تیر کی چابیاں نقشے کو نہ ڈالیں گے.",
	"geo-allyttl": "ہدایات: نقشہ نیویگیشن",
	"geo-tgllyr": "پرت کے ڈسپلے کو ٹول کریں",
	"geo-hdnlyr": "یہ پرت فی الحال پوشیدہ ہے.",
	"geo-bmap-url": "//geoappext.nrcan.gc.ca/arcgis/rest/services/basemaps/cbmt3978/mapserver/wmts/",
	"geo-bmap-matrix-set": "Default028mm.",
	"geo-bmapttl": "Basemaps_CBMT3978.",
	"geo-bmapurltxt": "//geoappext.nrcan.gc.ca/arcgis/rest/services/basemaps/cbmt_txt_3978/mapserver/wmts/tile/1.0.0.0/basemaps_cbmt3978/ (stilems )/ (tilematrixset}/ (tilematrix )/hilematrix}/ (tilematrix) } .jpg.",
	"geo-attrlnk": "//geogratis.gc.ca/geogratis/cbm_cbc؟lang=en.",
	"geo-attrttl": "Geogratis - کینیڈا بیس نقشہ",
	"geo-sel": "منتخب کریں",
	"geo-lblsel": "نقشے پر عنصر منتخب کرنے کے لئے چیک کریں",
	"geo-locurl-geogratis": "//geogratis.gc.ca/services/geolcation/en/Locate.",
	"geo-loc-placeholder": "Placename اور # 44 درج کریں؛ پوسٹ کوڈ اور # 44؛ اسٹریٹ ایڈریس اور # 44؛ NTS نمبر ...",
	"geo-loc-label": "مقام",
	"geo-aoi-north": "شمال",
	"geo-aoi-east": "مشرق",
	"geo-aoi-south": "جنوب",
	"geo-aoi-west": "مغرب",
	"geo-aoi-instructions": "نقشے پر باکس ڈرائیو یا ذیل میں سمتوں میں داخل کریں اور \"شامل کریں\" بٹن پر کلک کریں.",
	"geo-aoi-title": "نقشے پر باکس ڈرائیو یا سمتوں میں داخل کریں",
	"geo-aoi-btndraw": "ڈرا",
	"geo-aoi-btnclear": "صاف",
	"geo-geoloc-btn": "موجودہ مقام پر زوم",
	"geo-geoloc-fail": "جغرافیائی نظام ناکام ہوگئی. براہ کرم یقینی بنائیں کہ مقام کی خدمات فعال ہوئیں.",
	"geo-geoloc-uncapable": "جغرافیہ آپ کے براؤزر کی طرف سے حمایت نہیں کی جاتی ہے.",
	"geo-lgnd-grphc": "نقشہ پرت کے لئے علامات گرافک.",

	/* Disable/enable WET plugins and polyfills */
	"wb-disable": "بنیادی ایچ ٹی ایم ایل ورژن پر سوئچ کریں",
	"wb-enable": "معیاری ورژن پر سوئچ کریں",
	"disable-notice-h": "نوٹس: بنیادی HTML.",
	"disable-notice": "آپ بنیادی HTML نقطہ نظر دیکھ رہے ہیں. کچھ خصوصیات غیر فعال ہوسکتی ہیں.",
	"skip-prefix": "پر جائیں:",

	/* Dismissable content */
	"dismiss": "برطرف",

	/* Template */
	"tmpl-signin": "سائن ان",

	/* Filter */
	"fltr-lbl": "فلٹر <اسپین کلاس = \"WB-INVI\"> مواد: نتائج ذیل میں ظاہر ہوتے ہیں جیسے آپ ٹائپ کریں. </ span>",
	"fltr-info": "_total_ کل اندراجوں سے فلٹرڈ _nbitem_ دکھایا"
};

} )( wb );
