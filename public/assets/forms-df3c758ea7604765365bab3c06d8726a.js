/*! iCheck v1.0.2 by Damir Sultanov, http://git.io/arlzeA, MIT Licensed */

(function(f){function A(a,b,d){var c=a[0],g=/er/.test(d)?_indeterminate:/bl/.test(d)?n:k,e=d==_update?{checked:c[k],disabled:c[n],indeterminate:"true"==a.attr(_indeterminate)||"false"==a.attr(_determinate)}:c[g];if(/^(ch|di|in)/.test(d)&&!e)x(a,g);else if(/^(un|en|de)/.test(d)&&e)q(a,g);else if(d==_update)for(var f in e)e[f]?x(a,f,!0):q(a,f,!0);else if(!b||"toggle"==d){if(!b)a[_callback]("ifClicked");e?c[_type]!==r&&q(a,g):x(a,g)}}function x(a,b,d){var c=a[0],g=a.parent(),e=b==k,u=b==_indeterminate,
    v=b==n,s=u?_determinate:e?y:"enabled",F=l(a,s+t(c[_type])),B=l(a,b+t(c[_type]));if(!0!==c[b]){if(!d&&b==k&&c[_type]==r&&c.name){var w=a.closest("form"),p='input[name="'+c.name+'"]',p=w.length?w.find(p):f(p);p.each(function(){this!==c&&f(this).data(m)&&q(f(this),b)})}u?(c[b]=!0,c[k]&&q(a,k,"force")):(d||(c[b]=!0),e&&c[_indeterminate]&&q(a,_indeterminate,!1));D(a,e,b,d)}c[n]&&l(a,_cursor,!0)&&g.find("."+C).css(_cursor,"default");g[_add](B||l(a,b)||"");g.attr("role")&&!u&&g.attr("aria-"+(v?n:k),"true");
    g[_remove](F||l(a,s)||"")}function q(a,b,d){var c=a[0],g=a.parent(),e=b==k,f=b==_indeterminate,m=b==n,s=f?_determinate:e?y:"enabled",q=l(a,s+t(c[_type])),r=l(a,b+t(c[_type]));if(!1!==c[b]){if(f||!d||"force"==d)c[b]=!1;D(a,e,s,d)}!c[n]&&l(a,_cursor,!0)&&g.find("."+C).css(_cursor,"pointer");g[_remove](r||l(a,b)||"");g.attr("role")&&!f&&g.attr("aria-"+(m?n:k),"false");g[_add](q||l(a,s)||"")}function E(a,b){if(a.data(m)){a.parent().html(a.attr("style",a.data(m).s||""));if(b)a[_callback](b);a.off(".i").unwrap();
    f(_label+'[for="'+a[0].id+'"]').add(a.closest(_label)).off(".i")}}function l(a,b,f){if(a.data(m))return a.data(m).o[b+(f?"":"Class")]}function t(a){return a.charAt(0).toUpperCase()+a.slice(1)}function D(a,b,f,c){if(!c){if(b)a[_callback]("ifToggled");a[_callback]("ifChanged")[_callback]("if"+t(f))}}var m="iCheck",C=m+"-helper",r="radio",k="checked",y="un"+k,n="disabled";_determinate="determinate";_indeterminate="in"+_determinate;_update="update";_type="type";_click="click";_touch="touchbegin.i touchend.i";
    _add="addClass";_remove="removeClass";_callback="trigger";_label="label";_cursor="cursor";_mobile=/ipad|iphone|ipod|android|blackberry|windows phone|opera mini|silk/i.test(navigator.userAgent);f.fn[m]=function(a,b){var d='input[type="checkbox"], input[type="'+r+'"]',c=f(),g=function(a){a.each(function(){var a=f(this);c=a.is(d)?c.add(a):c.add(a.find(d))})};if(/^(check|uncheck|toggle|indeterminate|determinate|disable|enable|update|destroy)$/i.test(a))return a=a.toLowerCase(),g(this),c.each(function(){var c=
        f(this);"destroy"==a?E(c,"ifDestroyed"):A(c,!0,a);f.isFunction(b)&&b()});if("object"!=typeof a&&a)return this;var e=f.extend({checkedClass:k,disabledClass:n,indeterminateClass:_indeterminate,labelHover:!0},a),l=e.handle,v=e.hoverClass||"hover",s=e.focusClass||"focus",t=e.activeClass||"active",B=!!e.labelHover,w=e.labelHoverClass||"hover",p=(""+e.increaseArea).replace("%","")|0;if("checkbox"==l||l==r)d='input[type="'+l+'"]';-50>p&&(p=-50);g(this);return c.each(function(){var a=f(this);E(a);var c=this,
        b=c.id,g=-p+"%",d=100+2*p+"%",d={position:"absolute",top:g,left:g,display:"block",width:d,height:d,margin:0,padding:0,background:"#fff",border:0,opacity:0},g=_mobile?{position:"absolute",visibility:"hidden"}:p?d:{position:"absolute",opacity:0},l="checkbox"==c[_type]?e.checkboxClass||"icheckbox":e.radioClass||"i"+r,z=f(_label+'[for="'+b+'"]').add(a.closest(_label)),u=!!e.aria,y=m+"-"+Math.random().toString(36).substr(2,6),h='<div class="'+l+'" '+(u?'role="'+c[_type]+'" ':"");u&&z.each(function(){h+=
        'aria-labelledby="';this.id?h+=this.id:(this.id=y,h+=y);h+='"'});h=a.wrap(h+"/>")[_callback]("ifCreated").parent().append(e.insert);d=f('<ins class="'+C+'"/>').css(d).appendTo(h);a.data(m,{o:e,s:a.attr("style")}).css(g);e.inheritClass&&h[_add](c.className||"");e.inheritID&&b&&h.attr("id",m+"-"+b);"static"==h.css("position")&&h.css("position","relative");A(a,!0,_update);if(z.length)z.on(_click+".i mouseover.i mouseout.i "+_touch,function(b){var d=b[_type],e=f(this);if(!c[n]){if(d==_click){if(f(b.target).is("a"))return;
        A(a,!1,!0)}else B&&(/ut|nd/.test(d)?(h[_remove](v),e[_remove](w)):(h[_add](v),e[_add](w)));if(_mobile)b.stopPropagation();else return!1}});a.on(_click+".i focus.i blur.i keyup.i keydown.i keypress.i",function(b){var d=b[_type];b=b.keyCode;if(d==_click)return!1;if("keydown"==d&&32==b)return c[_type]==r&&c[k]||(c[k]?q(a,k):x(a,k)),!1;if("keyup"==d&&c[_type]==r)!c[k]&&x(a,k);else if(/us|ur/.test(d))h["blur"==d?_remove:_add](s)});d.on(_click+" mousedown mouseup mouseover mouseout "+_touch,function(b){var d=
        b[_type],e=/wn|up/.test(d)?t:v;if(!c[n]){if(d==_click)A(a,!1,!0);else{if(/wn|er|in/.test(d))h[_add](e);else h[_remove](e+" "+t);if(z.length&&B&&e==v)z[/ut|nd/.test(d)?_remove:_add](w)}if(_mobile)b.stopPropagation();else return!1}})})}})(window.jQuery||window.Zepto);
/*! 
 * jQuery Steps v1.0.6 - 04/27/2014
 * Copyright (c) 2014 Rafael Staib (http://www.jquery-steps.com)
 * Licensed under MIT http://www.opensource.org/licenses/MIT
 */

!function(a,b){function c(a,b){o(a).push(b)}function d(d,e,f){var g=d.children(e.headerTag),h=d.children(e.bodyTag);g.length>h.length?R(Z,"contents"):g.length<h.length&&R(Z,"titles");var i=e.startIndex;if(f.stepCount=g.length,e.saveState&&a.cookie){var j=a.cookie(U+q(d)),k=parseInt(j,0);!isNaN(k)&&k<f.stepCount&&(i=k)}f.currentIndex=i,g.each(function(e){var f=a(this),g=h.eq(e),i=g.data("mode"),j=null==i?$.html:r($,/^\s*$/.test(i)||isNaN(i)?i:parseInt(i,0)),k=j===$.html||g.data("url")===b?"":g.data("url"),l=j!==$.html&&"1"===g.data("loaded"),m=a.extend({},bb,{title:f.html(),content:j===$.html?g.html():"",contentUrl:k,contentMode:j,contentLoaded:l});c(d,m)})}function e(a){a.triggerHandler("canceled")}function f(a,b){return a.currentIndex-b}function g(b,c){var d=i(b);b.unbind(d).removeData("uid").removeData("options").removeData("state").removeData("steps").removeData("eventNamespace").find(".actions a").unbind(d),b.removeClass(c.clearFixCssClass+" vertical");var e=b.find(".content > *");e.removeData("loaded").removeData("mode").removeData("url"),e.removeAttr("id").removeAttr("role").removeAttr("tabindex").removeAttr("class").removeAttr("style")._removeAria("labelledby")._removeAria("hidden"),b.find(".content > [data-mode='async'],.content > [data-mode='iframe']").empty();var f=a('<{0} class="{1}"></{0}>'.format(b.get(0).tagName,b.attr("class"))),g=b._id();return null!=g&&""!==g&&f._id(g),f.html(b.find(".content").html()),b.after(f),b.remove(),f}function h(a,b){var c=a.find(".steps li").eq(b.currentIndex);a.triggerHandler("finishing",[b.currentIndex])?(c.addClass("done").removeClass("error"),a.triggerHandler("finished",[b.currentIndex])):c.addClass("error")}function i(a){var b=a.data("eventNamespace");return null==b&&(b="."+q(a),a.data("eventNamespace",b)),b}function j(a,b){var c=q(a);return a.find("#"+c+V+b)}function k(a,b){var c=q(a);return a.find("#"+c+W+b)}function l(a,b){var c=q(a);return a.find("#"+c+X+b)}function m(a){return a.data("options")}function n(a){return a.data("state")}function o(a){return a.data("steps")}function p(a,b){var c=o(a);return(0>b||b>=c.length)&&R(Y),c[b]}function q(a){var b=a.data("uid");return null==b&&(b=a._id(),null==b&&(b="steps-uid-".concat(T),a._id(b)),T++,a.data("uid",b)),b}function r(a,c){if(S("enumType",a),S("keyOrValue",c),"string"==typeof c){var d=a[c];return d===b&&R("The enum key '{0}' does not exist.",c),d}if("number"==typeof c){for(var e in a)if(a[e]===c)return c;R("Invalid enum value '{0}'.",c)}else R("Invalid key or value type.")}function s(a,b,c){return B(a,b,c,v(c,1))}function t(a,b,c){return B(a,b,c,f(c,1))}function u(a,b,c,d){if((0>d||d>=c.stepCount)&&R(Y),!(b.forceMoveForward&&d<c.currentIndex)){var e=c.currentIndex;return a.triggerHandler("stepChanging",[c.currentIndex,d])?(c.currentIndex=d,O(a,b,c),E(a,b,c,e),D(a,b,c),A(a,b,c),P(a,b,c,d,e),a.triggerHandler("stepChanged",[d,e])):a.find(".steps li").eq(e).addClass("error"),!0}}function v(a,b){return a.currentIndex+b}function w(b){var c=a.extend(!0,{},cb,b);return this.each(function(){var b=a(this),e={currentIndex:c.startIndex,currentStep:null,stepCount:0,transitionElement:null};b.data("options",c),b.data("state",e),b.data("steps",[]),d(b,c,e),J(b,c,e),G(b,c),c.autoFocus&&0===T&&j(b,c.startIndex).focus()})}function x(b,c,d,e,f){(0>e||e>d.stepCount)&&R(Y),f=a.extend({},bb,f),y(b,e,f),d.currentIndex!==d.stepCount&&d.currentIndex>=e&&(d.currentIndex++,O(b,c,d)),d.stepCount++;var g=b.find(".content"),h=a("<{0}>{1}</{0}>".format(c.headerTag,f.title)),i=a("<{0}></{0}>".format(c.bodyTag));return(null==f.contentMode||f.contentMode===$.html)&&i.html(f.content),0===e?g.prepend(i).prepend(h):k(b,e-1).after(i).after(h),K(b,d,i,e),N(b,c,d,h,e),F(b,c,d,e),e===d.currentIndex&&E(b,c,d),D(b,c,d),b}function y(a,b,c){o(a).splice(b,0,c)}function z(b){var c=a(this),d=m(c),e=n(c);if(d.suppressPaginationOnFocus&&c.find(":focus").is(":input"))return b.preventDefault(),!1;var f={left:37,right:39};b.keyCode===f.left?(b.preventDefault(),t(c,d,e)):b.keyCode===f.right&&(b.preventDefault(),s(c,d,e))}function A(b,c,d){if(d.stepCount>0){var e=p(b,d.currentIndex);if(!c.enableContentCache||!e.contentLoaded)switch(r($,e.contentMode)){case $.iframe:b.find(".content > .body").eq(d.currentIndex).empty().html('<iframe src="'+e.contentUrl+'" frameborder="0" scrolling="no" />').data("loaded","1");break;case $.async:var f=k(b,d.currentIndex)._aria("busy","true").empty().append(M(c.loadingTemplate,{text:c.labels.loading}));a.ajax({url:e.contentUrl,cache:!1}).done(function(a){f.empty().html(a)._aria("busy","false").data("loaded","1")})}}}function B(a,b,c,d){var e=c.currentIndex;if(d>=0&&d<c.stepCount&&!(b.forceMoveForward&&d<c.currentIndex)){var f=j(a,d),g=f.parent(),h=g.hasClass("disabled");return g._enableAria(),f.click(),e===c.currentIndex&&h?(g._enableAria(!1),!1):!0}return!1}function C(b){b.preventDefault();var c=a(this),d=c.parent().parent().parent().parent(),f=m(d),g=n(d),i=c.attr("href");switch(i.substring(i.lastIndexOf("#")+1)){case"cancel":e(d);break;case"finish":h(d,g);break;case"next":s(d,f,g);break;case"previous":t(d,f,g)}}function D(a,b,c){if(b.enablePagination){var d=a.find(".actions a[href$='#finish']").parent(),e=a.find(".actions a[href$='#next']").parent();if(!b.forceMoveForward){var f=a.find(".actions a[href$='#previous']").parent();f._enableAria(c.currentIndex>0)}b.enableFinishButton&&b.showFinishButtonAlways?(d._enableAria(c.stepCount>0),e._enableAria(c.stepCount>1&&c.stepCount>c.currentIndex+1)):(d._showAria(b.enableFinishButton&&c.stepCount>=c.currentIndex+1),e._showAria(0===c.stepCount||c.stepCount>c.currentIndex+1)._enableAria(c.stepCount>c.currentIndex+1||!b.enableFinishButton))}}function E(b,c,d,e){var f=j(b,d.currentIndex),g=a('<span class="current-info audible">'+c.labels.current+" </span>"),h=b.find(".content > .title");if(null!=e){var i=j(b,e);i.parent().addClass("done").removeClass("error")._selectAria(!1),h.eq(e).removeClass("current").next(".body").removeClass("current"),g=i.find(".current-info"),f.focus()}f.prepend(g).parent()._selectAria().removeClass("done")._enableAria(),h.eq(d.currentIndex).addClass("current").next(".body").addClass("current")}function F(a,b,c,d){for(var e=q(a),f=d;f<c.stepCount;f++){var g=e+V+f,h=e+W+f,i=e+X+f,j=a.find(".title").eq(f)._id(i);a.find(".steps a").eq(f)._id(g)._aria("controls",h).attr("href","#"+i).html(M(b.titleTemplate,{index:f+1,title:j.html()})),a.find(".body").eq(f)._id(h)._aria("labelledby",i)}}function G(a,b){var c=i(a);a.bind("canceled"+c,b.onCanceled),a.bind("finishing"+c,b.onFinishing),a.bind("finished"+c,b.onFinished),a.bind("stepChanging"+c,b.onStepChanging),a.bind("stepChanged"+c,b.onStepChanged),b.enableKeyNavigation&&a.bind("keyup"+c,z),a.find(".actions a").bind("click"+c,C)}function H(a,b,c,d){return 0>d||d>=c.stepCount||c.currentIndex===d?!1:(I(a,d),c.currentIndex>d&&(c.currentIndex--,O(a,b,c)),c.stepCount--,l(a,d).remove(),k(a,d).remove(),j(a,d).parent().remove(),0===d&&a.find(".steps li").first().addClass("first"),d===c.stepCount&&a.find(".steps li").eq(d).addClass("last"),F(a,b,c,d),D(a,b,c),!0)}function I(a,b){o(a).splice(b,1)}function J(b,c,d){var e='<{0} class="{1}">{2}</{0}>',f=r(_,c.stepsOrientation),g=f===_.vertical?" vertical":"",h=a(e.format(c.contentContainerTag,"content "+c.clearFixCssClass,b.html())),i=a(e.format(c.stepsContainerTag,"steps "+c.clearFixCssClass,'<ul role="tablist"></ul>')),j=h.children(c.headerTag),k=h.children(c.bodyTag);b.attr("role","application").empty().append(i).append(h).addClass(c.cssClass+" "+c.clearFixCssClass+g),k.each(function(c){K(b,d,a(this),c)}),j.each(function(e){N(b,c,d,a(this),e)}),E(b,c,d),L(b,c,d)}function K(a,b,c,d){var e=q(a),f=e+W+d,g=e+X+d;c._id(f).attr("role","tabpanel")._aria("labelledby",g).addClass("body")._showAria(b.currentIndex===d)}function L(a,b,c){if(b.enablePagination){var d='<{0} class="actions {1}"><ul role="menu" aria-label="{2}">{3}</ul></{0}>',e='<li><a href="#{0}" role="menuitem">{1}</a></li>',f="";b.forceMoveForward||(f+=e.format("previous",b.labels.previous)),f+=e.format("next",b.labels.next),b.enableFinishButton&&(f+=e.format("finish",b.labels.finish)),b.enableCancelButton&&(f+=e.format("cancel",b.labels.cancel)),a.append(d.format(b.actionContainerTag,b.clearFixCssClass,b.labels.pagination,f)),D(a,b,c),A(a,b,c)}}function M(a,c){for(var d=a.match(/#([a-z]*)#/gi),e=0;e<d.length;e++){var f=d[e],g=f.substring(1,f.length-1);c[g]===b&&R("The key '{0}' does not exist in the substitute collection!",g),a=a.replace(f,c[g])}return a}function N(b,c,d,e,f){var g=q(b),h=g+V+f,j=g+W+f,k=g+X+f,l=b.find(".steps > ul"),m=M(c.titleTemplate,{index:f+1,title:e.html()}),n=a('<li role="tab"><a id="'+h+'" href="#'+k+'" aria-controls="'+j+'">'+m+"</a></li>");n._enableAria(c.enableAllSteps||d.currentIndex>f),d.currentIndex>f&&n.addClass("done"),e._id(k).attr("tabindex","-1").addClass("title"),0===f?l.prepend(n):l.find("li").eq(f-1).after(n),0===f&&l.find("li").removeClass("first").eq(f).addClass("first"),f===d.stepCount-1&&l.find("li").removeClass("last").eq(f).addClass("last"),n.children("a").bind("click"+i(b),Q)}function O(b,c,d){c.saveState&&a.cookie&&a.cookie(U+q(b),d.currentIndex)}function P(b,c,d,e,f){var g=b.find(".content > .body"),h=r(ab,c.transitionEffect),i=c.transitionEffectSpeed,j=g.eq(e),k=g.eq(f);switch(h){case ab.fade:case ab.slide:var l=h===ab.fade?"fadeOut":"slideUp",m=h===ab.fade?"fadeIn":"slideDown";d.transitionElement=j,k[l](i,function(){var b=a(this)._showAria(!1).parent().parent(),c=n(b);c.transitionElement&&(c.transitionElement[m](i,function(){a(this)._showAria()}),c.transitionElement=null)}).promise();break;case ab.slideLeft:var o=k.outerWidth(!0),p=e>f?-o:o,q=e>f?o:-o;k.animate({left:p},i,function(){a(this)._showAria(!1)}).promise(),j.css("left",q+"px")._showAria().animate({left:0},i).promise();break;default:k._showAria(!1),j._showAria()}}function Q(b){b.preventDefault();var c=a(this),d=c.parent().parent().parent().parent(),e=m(d),f=n(d),g=f.currentIndex;if(c.parent().is(":not(.disabled):not(.current)")){var h=c.attr("href"),i=parseInt(h.substring(h.lastIndexOf("-")+1),0);u(d,e,f,i)}return g===f.currentIndex?(j(d,g).focus(),!1):void 0}function R(a){throw arguments.length>1&&(a=a.format(Array.prototype.slice.call(arguments,1))),new Error(a)}function S(a,b){null==b&&R("The argument '{0}' is null or undefined.",a)}a.fn.extend({_aria:function(a,b){return this.attr("aria-"+a,b)},_removeAria:function(a){return this.removeAttr("aria-"+a)},_enableAria:function(a){return null==a||a?this.removeClass("disabled")._aria("disabled","false"):this.addClass("disabled")._aria("disabled","true")},_showAria:function(a){return null==a||a?this.show()._aria("hidden","false"):this.hide()._aria("hidden","true")},_selectAria:function(a){return null==a||a?this.addClass("current")._aria("selected","true"):this.removeClass("current")._aria("selected","false")},_id:function(a){return a?this.attr("id",a):this.attr("id")}}),String.prototype.format||(String.prototype.format=function(){for(var b=1===arguments.length&&a.isArray(arguments[0])?arguments[0]:arguments,c=this,d=0;d<b.length;d++){var e=new RegExp("\\{"+d+"\\}","gm");c=c.replace(e,b[d])}return c});var T=0,U="jQu3ry_5teps_St@te_",V="-t-",W="-p-",X="-h-",Y="Index out of range.",Z="One or more corresponding step {0} are missing.";a.fn.steps=function(b){return a.fn.steps[b]?a.fn.steps[b].apply(this,Array.prototype.slice.call(arguments,1)):"object"!=typeof b&&b?void a.error("Method "+b+" does not exist on jQuery.steps"):w.apply(this,arguments)},a.fn.steps.add=function(a){var b=n(this);return x(this,m(this),b,b.stepCount,a)},a.fn.steps.destroy=function(){return g(this,m(this))},a.fn.steps.finish=function(){h(this,n(this))},a.fn.steps.getCurrentIndex=function(){return n(this).currentIndex},a.fn.steps.getCurrentStep=function(){return p(this,n(this).currentIndex)},a.fn.steps.getStep=function(a){return p(this,a)},a.fn.steps.insert=function(a,b){return x(this,m(this),n(this),a,b)},a.fn.steps.next=function(){return s(this,m(this),n(this))},a.fn.steps.previous=function(){return t(this,m(this),n(this))},a.fn.steps.remove=function(a){return H(this,m(this),n(this),a)},a.fn.steps.setStep=function(){throw new Error("Not yet implemented!")},a.fn.steps.skip=function(){throw new Error("Not yet implemented!")};var $=a.fn.steps.contentMode={html:0,iframe:1,async:2},_=a.fn.steps.stepsOrientation={horizontal:0,vertical:1},ab=a.fn.steps.transitionEffect={none:0,fade:1,slide:2,slideLeft:3},bb=a.fn.steps.stepModel={title:"",content:"",contentUrl:"",contentMode:$.html,contentLoaded:!1},cb=a.fn.steps.defaults={headerTag:"h1",bodyTag:"div",contentContainerTag:"div",actionContainerTag:"div",stepsContainerTag:"div",cssClass:"wizard",clearFixCssClass:"clearfix",stepsOrientation:_.horizontal,titleTemplate:'<span class="number">#index#.</span> #title#',loadingTemplate:'<span class="spinner"></span> #text#',autoFocus:!1,enableAllSteps:!1,enableKeyNavigation:!0,enablePagination:!0,suppressPaginationOnFocus:!0,enableContentCache:!0,enableCancelButton:!0,enableFinishButton:!0,preloadContent:!1,showFinishButtonAlways:!1,forceMoveForward:!1,saveState:!1,startIndex:0,transitionEffect:ab.none,transitionEffectSpeed:200,onStepChanging:function(){return!0},onStepChanged:function(){},onCanceled:function(){},onFinishing:function(){return!0},onFinished:function(){},labels:{cancel:"Cancel",current:"current step:",pagination:"Pagination",finish:"Finish",next:"Next",previous:"Previous",loading:"Loading ..."}}}(jQuery);
/*! jQuery Validation Plugin - v1.13.0 - 7/1/2014
 * http://jqueryvalidation.org/
 * Copyright (c) 2014 Jörn Zaefferer; Licensed MIT */

!function(a){"function"==typeof define&&define.amd?define(["jquery"],a):a(jQuery)}(function(a){a.extend(a.fn,{validate:function(b){if(!this.length)return void(b&&b.debug&&window.console&&console.warn("Nothing selected, can't validate, returning nothing."));var c=a.data(this[0],"validator");return c?c:(this.attr("novalidate","novalidate"),c=new a.validator(b,this[0]),a.data(this[0],"validator",c),c.settings.onsubmit&&(this.validateDelegate(":submit","click",function(b){c.settings.submitHandler&&(c.submitButton=b.target),a(b.target).hasClass("cancel")&&(c.cancelSubmit=!0),void 0!==a(b.target).attr("formnovalidate")&&(c.cancelSubmit=!0)}),this.submit(function(b){function d(){var d;return c.settings.submitHandler?(c.submitButton&&(d=a("<input type='hidden'/>").attr("name",c.submitButton.name).val(a(c.submitButton).val()).appendTo(c.currentForm)),c.settings.submitHandler.call(c,c.currentForm,b),c.submitButton&&d.remove(),!1):!0}return c.settings.debug&&b.preventDefault(),c.cancelSubmit?(c.cancelSubmit=!1,d()):c.form()?c.pendingRequest?(c.formSubmitted=!0,!1):d():(c.focusInvalid(),!1)})),c)},valid:function(){var b,c;return a(this[0]).is("form")?b=this.validate().form():(b=!0,c=a(this[0].form).validate(),this.each(function(){b=c.element(this)&&b})),b},removeAttrs:function(b){var c={},d=this;return a.each(b.split(/\s/),function(a,b){c[b]=d.attr(b),d.removeAttr(b)}),c},rules:function(b,c){var d,e,f,g,h,i,j=this[0];if(b)switch(d=a.data(j.form,"validator").settings,e=d.rules,f=a.validator.staticRules(j),b){case"add":a.extend(f,a.validator.normalizeRule(c)),delete f.messages,e[j.name]=f,c.messages&&(d.messages[j.name]=a.extend(d.messages[j.name],c.messages));break;case"remove":return c?(i={},a.each(c.split(/\s/),function(b,c){i[c]=f[c],delete f[c],"required"===c&&a(j).removeAttr("aria-required")}),i):(delete e[j.name],f)}return g=a.validator.normalizeRules(a.extend({},a.validator.classRules(j),a.validator.attributeRules(j),a.validator.dataRules(j),a.validator.staticRules(j)),j),g.required&&(h=g.required,delete g.required,g=a.extend({required:h},g),a(j).attr("aria-required","true")),g.remote&&(h=g.remote,delete g.remote,g=a.extend(g,{remote:h})),g}}),a.extend(a.expr[":"],{blank:function(b){return!a.trim(""+a(b).val())},filled:function(b){return!!a.trim(""+a(b).val())},unchecked:function(b){return!a(b).prop("checked")}}),a.validator=function(b,c){this.settings=a.extend(!0,{},a.validator.defaults,b),this.currentForm=c,this.init()},a.validator.format=function(b,c){return 1===arguments.length?function(){var c=a.makeArray(arguments);return c.unshift(b),a.validator.format.apply(this,c)}:(arguments.length>2&&c.constructor!==Array&&(c=a.makeArray(arguments).slice(1)),c.constructor!==Array&&(c=[c]),a.each(c,function(a,c){b=b.replace(new RegExp("\\{"+a+"\\}","g"),function(){return c})}),b)},a.extend(a.validator,{defaults:{messages:{},groups:{},rules:{},errorClass:"error",validClass:"valid",errorElement:"label",focusInvalid:!0,errorContainer:a([]),errorLabelContainer:a([]),onsubmit:!0,ignore:":hidden",ignoreTitle:!1,onfocusin:function(a){this.lastActive=a,this.settings.focusCleanup&&!this.blockFocusCleanup&&(this.settings.unhighlight&&this.settings.unhighlight.call(this,a,this.settings.errorClass,this.settings.validClass),this.hideThese(this.errorsFor(a)))},onfocusout:function(a){this.checkable(a)||!(a.name in this.submitted)&&this.optional(a)||this.element(a)},onkeyup:function(a,b){(9!==b.which||""!==this.elementValue(a))&&(a.name in this.submitted||a===this.lastElement)&&this.element(a)},onclick:function(a){a.name in this.submitted?this.element(a):a.parentNode.name in this.submitted&&this.element(a.parentNode)},highlight:function(b,c,d){"radio"===b.type?this.findByName(b.name).addClass(c).removeClass(d):a(b).addClass(c).removeClass(d)},unhighlight:function(b,c,d){"radio"===b.type?this.findByName(b.name).removeClass(c).addClass(d):a(b).removeClass(c).addClass(d)}},setDefaults:function(b){a.extend(a.validator.defaults,b)},messages:{required:"This field is required.",remote:"Please fix this field.",email:"Please enter a valid email address.",url:"Please enter a valid URL.",date:"Please enter a valid date.",dateISO:"Please enter a valid date ( ISO ).",number:"Please enter a valid number.",digits:"Please enter only digits.",creditcard:"Please enter a valid credit card number.",equalTo:"Please enter the same value again.",maxlength:a.validator.format("Please enter no more than {0} characters."),minlength:a.validator.format("Please enter at least {0} characters."),rangelength:a.validator.format("Please enter a value between {0} and {1} characters long."),range:a.validator.format("Please enter a value between {0} and {1}."),max:a.validator.format("Please enter a value less than or equal to {0}."),min:a.validator.format("Please enter a value greater than or equal to {0}.")},autoCreateRanges:!1,prototype:{init:function(){function b(b){var c=a.data(this[0].form,"validator"),d="on"+b.type.replace(/^validate/,""),e=c.settings;e[d]&&!this.is(e.ignore)&&e[d].call(c,this[0],b)}this.labelContainer=a(this.settings.errorLabelContainer),this.errorContext=this.labelContainer.length&&this.labelContainer||a(this.currentForm),this.containers=a(this.settings.errorContainer).add(this.settings.errorLabelContainer),this.submitted={},this.valueCache={},this.pendingRequest=0,this.pending={},this.invalid={},this.reset();var c,d=this.groups={};a.each(this.settings.groups,function(b,c){"string"==typeof c&&(c=c.split(/\s/)),a.each(c,function(a,c){d[c]=b})}),c=this.settings.rules,a.each(c,function(b,d){c[b]=a.validator.normalizeRule(d)}),a(this.currentForm).validateDelegate(":text, [type='password'], [type='file'], select, textarea, [type='number'], [type='search'] ,[type='tel'], [type='url'], [type='email'], [type='datetime'], [type='date'], [type='month'], [type='week'], [type='time'], [type='datetime-local'], [type='range'], [type='color'], [type='radio'], [type='checkbox']","focusin focusout keyup",b).validateDelegate("select, option, [type='radio'], [type='checkbox']","click",b),this.settings.invalidHandler&&a(this.currentForm).bind("invalid-form.validate",this.settings.invalidHandler),a(this.currentForm).find("[required], [data-rule-required], .required").attr("aria-required","true")},form:function(){return this.checkForm(),a.extend(this.submitted,this.errorMap),this.invalid=a.extend({},this.errorMap),this.valid()||a(this.currentForm).triggerHandler("invalid-form",[this]),this.showErrors(),this.valid()},checkForm:function(){this.prepareForm();for(var a=0,b=this.currentElements=this.elements();b[a];a++)this.check(b[a]);return this.valid()},element:function(b){var c=this.clean(b),d=this.validationTargetFor(c),e=!0;return this.lastElement=d,void 0===d?delete this.invalid[c.name]:(this.prepareElement(d),this.currentElements=a(d),e=this.check(d)!==!1,e?delete this.invalid[d.name]:this.invalid[d.name]=!0),a(b).attr("aria-invalid",!e),this.numberOfInvalids()||(this.toHide=this.toHide.add(this.containers)),this.showErrors(),e},showErrors:function(b){if(b){a.extend(this.errorMap,b),this.errorList=[];for(var c in b)this.errorList.push({message:b[c],element:this.findByName(c)[0]});this.successList=a.grep(this.successList,function(a){return!(a.name in b)})}this.settings.showErrors?this.settings.showErrors.call(this,this.errorMap,this.errorList):this.defaultShowErrors()},resetForm:function(){a.fn.resetForm&&a(this.currentForm).resetForm(),this.submitted={},this.lastElement=null,this.prepareForm(),this.hideErrors(),this.elements().removeClass(this.settings.errorClass).removeData("previousValue").removeAttr("aria-invalid")},numberOfInvalids:function(){return this.objectLength(this.invalid)},objectLength:function(a){var b,c=0;for(b in a)c++;return c},hideErrors:function(){this.hideThese(this.toHide)},hideThese:function(a){a.not(this.containers).text(""),this.addWrapper(a).hide()},valid:function(){return 0===this.size()},size:function(){return this.errorList.length},focusInvalid:function(){if(this.settings.focusInvalid)try{a(this.findLastActive()||this.errorList.length&&this.errorList[0].element||[]).filter(":visible").focus().trigger("focusin")}catch(b){}},findLastActive:function(){var b=this.lastActive;return b&&1===a.grep(this.errorList,function(a){return a.element.name===b.name}).length&&b},elements:function(){var b=this,c={};return a(this.currentForm).find("input, select, textarea").not(":submit, :reset, :image, [disabled]").not(this.settings.ignore).filter(function(){return!this.name&&b.settings.debug&&window.console&&console.error("%o has no name assigned",this),this.name in c||!b.objectLength(a(this).rules())?!1:(c[this.name]=!0,!0)})},clean:function(b){return a(b)[0]},errors:function(){var b=this.settings.errorClass.split(" ").join(".");return a(this.settings.errorElement+"."+b,this.errorContext)},reset:function(){this.successList=[],this.errorList=[],this.errorMap={},this.toShow=a([]),this.toHide=a([]),this.currentElements=a([])},prepareForm:function(){this.reset(),this.toHide=this.errors().add(this.containers)},prepareElement:function(a){this.reset(),this.toHide=this.errorsFor(a)},elementValue:function(b){var c,d=a(b),e=b.type;return"radio"===e||"checkbox"===e?a("input[name='"+b.name+"']:checked").val():"number"===e&&"undefined"!=typeof b.validity?b.validity.badInput?!1:d.val():(c=d.val(),"string"==typeof c?c.replace(/\r/g,""):c)},check:function(b){b=this.validationTargetFor(this.clean(b));var c,d,e,f=a(b).rules(),g=a.map(f,function(a,b){return b}).length,h=!1,i=this.elementValue(b);for(d in f){e={method:d,parameters:f[d]};try{if(c=a.validator.methods[d].call(this,i,b,e.parameters),"dependency-mismatch"===c&&1===g){h=!0;continue}if(h=!1,"pending"===c)return void(this.toHide=this.toHide.not(this.errorsFor(b)));if(!c)return this.formatAndAdd(b,e),!1}catch(j){throw this.settings.debug&&window.console&&console.log("Exception occurred when checking element "+b.id+", check the '"+e.method+"' method.",j),j}}if(!h)return this.objectLength(f)&&this.successList.push(b),!0},customDataMessage:function(b,c){return a(b).data("msg"+c.charAt(0).toUpperCase()+c.substring(1).toLowerCase())||a(b).data("msg")},customMessage:function(a,b){var c=this.settings.messages[a];return c&&(c.constructor===String?c:c[b])},findDefined:function(){for(var a=0;a<arguments.length;a++)if(void 0!==arguments[a])return arguments[a];return void 0},defaultMessage:function(b,c){return this.findDefined(this.customMessage(b.name,c),this.customDataMessage(b,c),!this.settings.ignoreTitle&&b.title||void 0,a.validator.messages[c],"<strong>Warning: No message defined for "+b.name+"</strong>")},formatAndAdd:function(b,c){var d=this.defaultMessage(b,c.method),e=/\$?\{(\d+)\}/g;"function"==typeof d?d=d.call(this,c.parameters,b):e.test(d)&&(d=a.validator.format(d.replace(e,"{$1}"),c.parameters)),this.errorList.push({message:d,element:b,method:c.method}),this.errorMap[b.name]=d,this.submitted[b.name]=d},addWrapper:function(a){return this.settings.wrapper&&(a=a.add(a.parent(this.settings.wrapper))),a},defaultShowErrors:function(){var a,b,c;for(a=0;this.errorList[a];a++)c=this.errorList[a],this.settings.highlight&&this.settings.highlight.call(this,c.element,this.settings.errorClass,this.settings.validClass),this.showLabel(c.element,c.message);if(this.errorList.length&&(this.toShow=this.toShow.add(this.containers)),this.settings.success)for(a=0;this.successList[a];a++)this.showLabel(this.successList[a]);if(this.settings.unhighlight)for(a=0,b=this.validElements();b[a];a++)this.settings.unhighlight.call(this,b[a],this.settings.errorClass,this.settings.validClass);this.toHide=this.toHide.not(this.toShow),this.hideErrors(),this.addWrapper(this.toShow).show()},validElements:function(){return this.currentElements.not(this.invalidElements())},invalidElements:function(){return a(this.errorList).map(function(){return this.element})},showLabel:function(b,c){var d,e,f,g=this.errorsFor(b),h=this.idOrName(b),i=a(b).attr("aria-describedby");g.length?(g.removeClass(this.settings.validClass).addClass(this.settings.errorClass),g.html(c)):(g=a("<"+this.settings.errorElement+">").attr("id",h+"-error").addClass(this.settings.errorClass).html(c||""),d=g,this.settings.wrapper&&(d=g.hide().show().wrap("<"+this.settings.wrapper+"/>").parent()),this.labelContainer.length?this.labelContainer.append(d):this.settings.errorPlacement?this.settings.errorPlacement(d,a(b)):d.insertAfter(b),g.is("label")?g.attr("for",h):0===g.parents("label[for='"+h+"']").length&&(f=g.attr("id"),i?i.match(new RegExp("\b"+f+"\b"))||(i+=" "+f):i=f,a(b).attr("aria-describedby",i),e=this.groups[b.name],e&&a.each(this.groups,function(b,c){c===e&&a("[name='"+b+"']",this.currentForm).attr("aria-describedby",g.attr("id"))}))),!c&&this.settings.success&&(g.text(""),"string"==typeof this.settings.success?g.addClass(this.settings.success):this.settings.success(g,b)),this.toShow=this.toShow.add(g)},errorsFor:function(b){var c=this.idOrName(b),d=a(b).attr("aria-describedby"),e="label[for='"+c+"'], label[for='"+c+"'] *";return d&&(e=e+", #"+d.replace(/\s+/g,", #")),this.errors().filter(e)},idOrName:function(a){return this.groups[a.name]||(this.checkable(a)?a.name:a.id||a.name)},validationTargetFor:function(a){return this.checkable(a)&&(a=this.findByName(a.name).not(this.settings.ignore)[0]),a},checkable:function(a){return/radio|checkbox/i.test(a.type)},findByName:function(b){return a(this.currentForm).find("[name='"+b+"']")},getLength:function(b,c){switch(c.nodeName.toLowerCase()){case"select":return a("option:selected",c).length;case"input":if(this.checkable(c))return this.findByName(c.name).filter(":checked").length}return b.length},depend:function(a,b){return this.dependTypes[typeof a]?this.dependTypes[typeof a](a,b):!0},dependTypes:{"boolean":function(a){return a},string:function(b,c){return!!a(b,c.form).length},"function":function(a,b){return a(b)}},optional:function(b){var c=this.elementValue(b);return!a.validator.methods.required.call(this,c,b)&&"dependency-mismatch"},startRequest:function(a){this.pending[a.name]||(this.pendingRequest++,this.pending[a.name]=!0)},stopRequest:function(b,c){this.pendingRequest--,this.pendingRequest<0&&(this.pendingRequest=0),delete this.pending[b.name],c&&0===this.pendingRequest&&this.formSubmitted&&this.form()?(a(this.currentForm).submit(),this.formSubmitted=!1):!c&&0===this.pendingRequest&&this.formSubmitted&&(a(this.currentForm).triggerHandler("invalid-form",[this]),this.formSubmitted=!1)},previousValue:function(b){return a.data(b,"previousValue")||a.data(b,"previousValue",{old:null,valid:!0,message:this.defaultMessage(b,"remote")})}},classRuleSettings:{required:{required:!0},email:{email:!0},url:{url:!0},date:{date:!0},dateISO:{dateISO:!0},number:{number:!0},digits:{digits:!0},creditcard:{creditcard:!0}},addClassRules:function(b,c){b.constructor===String?this.classRuleSettings[b]=c:a.extend(this.classRuleSettings,b)},classRules:function(b){var c={},d=a(b).attr("class");return d&&a.each(d.split(" "),function(){this in a.validator.classRuleSettings&&a.extend(c,a.validator.classRuleSettings[this])}),c},attributeRules:function(b){var c,d,e={},f=a(b),g=b.getAttribute("type");for(c in a.validator.methods)"required"===c?(d=b.getAttribute(c),""===d&&(d=!0),d=!!d):d=f.attr(c),/min|max/.test(c)&&(null===g||/number|range|text/.test(g))&&(d=Number(d)),d||0===d?e[c]=d:g===c&&"range"!==g&&(e[c]=!0);return e.maxlength&&/-1|2147483647|524288/.test(e.maxlength)&&delete e.maxlength,e},dataRules:function(b){var c,d,e={},f=a(b);for(c in a.validator.methods)d=f.data("rule"+c.charAt(0).toUpperCase()+c.substring(1).toLowerCase()),void 0!==d&&(e[c]=d);return e},staticRules:function(b){var c={},d=a.data(b.form,"validator");return d.settings.rules&&(c=a.validator.normalizeRule(d.settings.rules[b.name])||{}),c},normalizeRules:function(b,c){return a.each(b,function(d,e){if(e===!1)return void delete b[d];if(e.param||e.depends){var f=!0;switch(typeof e.depends){case"string":f=!!a(e.depends,c.form).length;break;case"function":f=e.depends.call(c,c)}f?b[d]=void 0!==e.param?e.param:!0:delete b[d]}}),a.each(b,function(d,e){b[d]=a.isFunction(e)?e(c):e}),a.each(["minlength","maxlength"],function(){b[this]&&(b[this]=Number(b[this]))}),a.each(["rangelength","range"],function(){var c;b[this]&&(a.isArray(b[this])?b[this]=[Number(b[this][0]),Number(b[this][1])]:"string"==typeof b[this]&&(c=b[this].replace(/[\[\]]/g,"").split(/[\s,]+/),b[this]=[Number(c[0]),Number(c[1])]))}),a.validator.autoCreateRanges&&(b.min&&b.max&&(b.range=[b.min,b.max],delete b.min,delete b.max),b.minlength&&b.maxlength&&(b.rangelength=[b.minlength,b.maxlength],delete b.minlength,delete b.maxlength)),b},normalizeRule:function(b){if("string"==typeof b){var c={};a.each(b.split(/\s/),function(){c[this]=!0}),b=c}return b},addMethod:function(b,c,d){a.validator.methods[b]=c,a.validator.messages[b]=void 0!==d?d:a.validator.messages[b],c.length<3&&a.validator.addClassRules(b,a.validator.normalizeRule(b))},methods:{required:function(b,c,d){if(!this.depend(d,c))return"dependency-mismatch";if("select"===c.nodeName.toLowerCase()){var e=a(c).val();return e&&e.length>0}return this.checkable(c)?this.getLength(b,c)>0:a.trim(b).length>0},email:function(a,b){return this.optional(b)||/^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/.test(a)},url:function(a,b){return this.optional(b)||/^(https?|s?ftp):\/\/(((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:)*@)?(((\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]))|((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?)(:\d*)?)(\/((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)+(\/(([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)*)*)?)?(\?((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|[\uE000-\uF8FF]|\/|\?)*)?(#((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|\/|\?)*)?$/i.test(a)},date:function(a,b){return this.optional(b)||!/Invalid|NaN/.test(new Date(a).toString())},dateISO:function(a,b){return this.optional(b)||/^\d{4}[\/\-](0?[1-9]|1[012])[\/\-](0?[1-9]|[12][0-9]|3[01])$/.test(a)},number:function(a,b){return this.optional(b)||/^-?(?:\d+|\d{1,3}(?:,\d{3})+)?(?:\.\d+)?$/.test(a)},digits:function(a,b){return this.optional(b)||/^\d+$/.test(a)},creditcard:function(a,b){if(this.optional(b))return"dependency-mismatch";if(/[^0-9 \-]+/.test(a))return!1;var c,d,e=0,f=0,g=!1;if(a=a.replace(/\D/g,""),a.length<13||a.length>19)return!1;for(c=a.length-1;c>=0;c--)d=a.charAt(c),f=parseInt(d,10),g&&(f*=2)>9&&(f-=9),e+=f,g=!g;return e%10===0},minlength:function(b,c,d){var e=a.isArray(b)?b.length:this.getLength(a.trim(b),c);return this.optional(c)||e>=d},maxlength:function(b,c,d){var e=a.isArray(b)?b.length:this.getLength(a.trim(b),c);return this.optional(c)||d>=e},rangelength:function(b,c,d){var e=a.isArray(b)?b.length:this.getLength(a.trim(b),c);return this.optional(c)||e>=d[0]&&e<=d[1]},min:function(a,b,c){return this.optional(b)||a>=c},max:function(a,b,c){return this.optional(b)||c>=a},range:function(a,b,c){return this.optional(b)||a>=c[0]&&a<=c[1]},equalTo:function(b,c,d){var e=a(d);return this.settings.onfocusout&&e.unbind(".validate-equalTo").bind("blur.validate-equalTo",function(){a(c).valid()}),b===e.val()},remote:function(b,c,d){if(this.optional(c))return"dependency-mismatch";var e,f,g=this.previousValue(c);return this.settings.messages[c.name]||(this.settings.messages[c.name]={}),g.originalMessage=this.settings.messages[c.name].remote,this.settings.messages[c.name].remote=g.message,d="string"==typeof d&&{url:d}||d,g.old===b?g.valid:(g.old=b,e=this,this.startRequest(c),f={},f[c.name]=b,a.ajax(a.extend(!0,{url:d,mode:"abort",port:"validate"+c.name,dataType:"json",data:f,context:e.currentForm,success:function(d){var f,h,i,j=d===!0||"true"===d;e.settings.messages[c.name].remote=g.originalMessage,j?(i=e.formSubmitted,e.prepareElement(c),e.formSubmitted=i,e.successList.push(c),delete e.invalid[c.name],e.showErrors()):(f={},h=d||e.defaultMessage(c,"remote"),f[c.name]=g.message=a.isFunction(h)?h(b):h,e.invalid[c.name]=!0,e.showErrors(f)),g.valid=j,e.stopRequest(c,j)}},d)),"pending")}}}),a.format=function(){throw"$.format has been deprecated. Please use $.validator.format instead."};var b,c={};a.ajaxPrefilter?a.ajaxPrefilter(function(a,b,d){var e=a.port;"abort"===a.mode&&(c[e]&&c[e].abort(),c[e]=d)}):(b=a.ajax,a.ajax=function(d){var e=("mode"in d?d:a.ajaxSettings).mode,f=("port"in d?d:a.ajaxSettings).port;return"abort"===e?(c[f]&&c[f].abort(),c[f]=b.apply(this,arguments),c[f]):b.apply(this,arguments)}),a.extend(a.fn,{validateDelegate:function(b,c,d){return this.bind(c,function(c){var e=a(c.target);return e.is(b)?d.apply(e,arguments):void 0})}})});

;(function(){

    /**
     * Require the module at `name`.
     *
     * @param {String} name
     * @return {Object} exports
     * @api public
     */

    function require(name) {
        var module = require.modules[name];
        if (!module) throw new Error('failed to require "' + name + '"');

        if (!('exports' in module) && typeof module.definition === 'function') {
            module.client = module.component = true;
            module.definition.call(this, module.exports = {}, module);
            delete module.definition;
        }

        return module.exports;
    }

    /**
     * Registered modules.
     */

    require.modules = {};

    /**
     * Register module at `name` with callback `definition`.
     *
     * @param {String} name
     * @param {Function} definition
     * @api private
     */

    require.register = function (name, definition) {
        require.modules[name] = {
            definition: definition
        };
    };

    /**
     * Define a module's exports immediately with `exports`.
     *
     * @param {String} name
     * @param {Generic} exports
     * @api private
     */

    require.define = function (name, exports) {
        require.modules[name] = {
            exports: exports
        };
    };
    require.register("component~emitter@1.1.2", function (exports, module) {

        /**
         * Expose `Emitter`.
         */

        module.exports = Emitter;

        /**
         * Initialize a new `Emitter`.
         *
         * @api public
         */

        function Emitter(obj) {
            if (obj) return mixin(obj);
        };

        /**
         * Mixin the emitter properties.
         *
         * @param {Object} obj
         * @return {Object}
         * @api private
         */

        function mixin(obj) {
            for (var key in Emitter.prototype) {
                obj[key] = Emitter.prototype[key];
            }
            return obj;
        }

        /**
         * Listen on the given `event` with `fn`.
         *
         * @param {String} event
         * @param {Function} fn
         * @return {Emitter}
         * @api public
         */

        Emitter.prototype.on =
            Emitter.prototype.addEventListener = function(event, fn){
                this._callbacks = this._callbacks || {};
                (this._callbacks[event] = this._callbacks[event] || [])
                    .push(fn);
                return this;
            };

        /**
         * Adds an `event` listener that will be invoked a single
         * time then automatically removed.
         *
         * @param {String} event
         * @param {Function} fn
         * @return {Emitter}
         * @api public
         */

        Emitter.prototype.once = function(event, fn){
            var self = this;
            this._callbacks = this._callbacks || {};

            function on() {
                self.off(event, on);
                fn.apply(this, arguments);
            }

            on.fn = fn;
            this.on(event, on);
            return this;
        };

        /**
         * Remove the given callback for `event` or all
         * registered callbacks.
         *
         * @param {String} event
         * @param {Function} fn
         * @return {Emitter}
         * @api public
         */

        Emitter.prototype.off =
            Emitter.prototype.removeListener =
                Emitter.prototype.removeAllListeners =
                    Emitter.prototype.removeEventListener = function(event, fn){
                        this._callbacks = this._callbacks || {};

                        // all
                        if (0 == arguments.length) {
                            this._callbacks = {};
                            return this;
                        }

                        // specific event
                        var callbacks = this._callbacks[event];
                        if (!callbacks) return this;

                        // remove all handlers
                        if (1 == arguments.length) {
                            delete this._callbacks[event];
                            return this;
                        }

                        // remove specific handler
                        var cb;
                        for (var i = 0; i < callbacks.length; i++) {
                            cb = callbacks[i];
                            if (cb === fn || cb.fn === fn) {
                                callbacks.splice(i, 1);
                                break;
                            }
                        }
                        return this;
                    };

        /**
         * Emit `event` with the given args.
         *
         * @param {String} event
         * @param {Mixed} ...
         * @return {Emitter}
         */

        Emitter.prototype.emit = function(event){
            this._callbacks = this._callbacks || {};
            var args = [].slice.call(arguments, 1)
                , callbacks = this._callbacks[event];

            if (callbacks) {
                callbacks = callbacks.slice(0);
                for (var i = 0, len = callbacks.length; i < len; ++i) {
                    callbacks[i].apply(this, args);
                }
            }

            return this;
        };

        /**
         * Return array of callbacks for `event`.
         *
         * @param {String} event
         * @return {Array}
         * @api public
         */

        Emitter.prototype.listeners = function(event){
            this._callbacks = this._callbacks || {};
            return this._callbacks[event] || [];
        };

        /**
         * Check if this emitter has `event` handlers.
         *
         * @param {String} event
         * @return {Boolean}
         * @api public
         */

        Emitter.prototype.hasListeners = function(event){
            return !! this.listeners(event).length;
        };

    });

    require.register("dropzone", function (exports, module) {


        /**
         * Exposing dropzone
         */
        module.exports = require("dropzone/lib/dropzone.js");

    });

    require.register("dropzone/lib/dropzone.js", function (exports, module) {

        /*
         *
         * More info at [www.dropzonejs.com](http://www.dropzonejs.com)
         *
         * Copyright (c) 2012, Matias Meno
         *
         * Permission is hereby granted, free of charge, to any person obtaining a copy
         * of this software and associated documentation files (the "Software"), to deal
         * in the Software without restriction, including without limitation the rights
         * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
         * copies of the Software, and to permit persons to whom the Software is
         * furnished to do so, subject to the following conditions:
         *
         * The above copyright notice and this permission notice shall be included in
         * all copies or substantial portions of the Software.
         *
         * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
         * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
         * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
         * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
         * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
         * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
         * THE SOFTWARE.
         *
         */

        (function() {
            var Dropzone, Em, camelize, contentLoaded, detectVerticalSquash, drawImageIOSFix, noop, without,
                __hasProp = {}.hasOwnProperty,
                __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
                __slice = [].slice;

            Em = typeof Emitter !== "undefined" && Emitter !== null ? Emitter : require("component~emitter@1.1.2");

            noop = function() {};

            Dropzone = (function(_super) {
                var extend;

                __extends(Dropzone, _super);


                /*
                 This is a list of all available events you can register on a dropzone object.

                 You can register an event handler like this:

                 dropzone.on("dragEnter", function() { });
                 */

                Dropzone.prototype.events = ["drop", "dragstart", "dragend", "dragenter", "dragover", "dragleave", "addedfile", "removedfile", "thumbnail", "error", "errormultiple", "processing", "processingmultiple", "uploadprogress", "totaluploadprogress", "sending", "sendingmultiple", "success", "successmultiple", "canceled", "canceledmultiple", "complete", "completemultiple", "reset", "maxfilesexceeded", "maxfilesreached"];

                Dropzone.prototype.defaultOptions = {
                    url: null,
                    method: "post",
                    withCredentials: false,
                    parallelUploads: 2,
                    uploadMultiple: false,
                    maxFilesize: 256,
                    paramName: "file",
                    createImageThumbnails: true,
                    maxThumbnailFilesize: 10,
                    thumbnailWidth: 100,
                    thumbnailHeight: 100,
                    maxFiles: null,
                    params: {},
                    clickable: true,
                    ignoreHiddenFiles: true,
                    acceptedFiles: null,
                    acceptedMimeTypes: null,
                    autoProcessQueue: true,
                    autoQueue: true,
                    addRemoveLinks: false,
                    previewsContainer: null,
                    dictDefaultMessage: "Drop files here to upload",
                    dictFallbackMessage: "Your browser does not support drag'n'drop file uploads.",
                    dictFallbackText: "Please use the fallback form below to upload your files like in the olden days.",
                    dictFileTooBig: "File is too big ({{filesize}}MiB). Max filesize: {{maxFilesize}}MiB.",
                    dictInvalidFileType: "You can't upload files of this type.",
                    dictResponseError: "Server responded with {{statusCode}} code.",
                    dictCancelUpload: "Cancel upload",
                    dictCancelUploadConfirmation: "Are you sure you want to cancel this upload?",
                    dictRemoveFile: "Remove file",
                    dictRemoveFileConfirmation: null,
                    dictMaxFilesExceeded: "You can not upload any more files.",
                    accept: function(file, done) {
                        return done();
                    },
                    init: function() {
                        return noop;
                    },
                    forceFallback: false,
                    fallback: function() {
                        var child, messageElement, span, _i, _len, _ref;
                        this.element.className = "" + this.element.className + " dz-browser-not-supported";
                        _ref = this.element.getElementsByTagName("div");
                        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
                            child = _ref[_i];
                            if (/(^| )dz-message($| )/.test(child.className)) {
                                messageElement = child;
                                child.className = "dz-message";
                                continue;
                            }
                        }
                        if (!messageElement) {
                            messageElement = Dropzone.createElement("<div class=\"dz-message\"><span></span></div>");
                            this.element.appendChild(messageElement);
                        }
                        span = messageElement.getElementsByTagName("span")[0];
                        if (span) {
                            span.textContent = this.options.dictFallbackMessage;
                        }
                        return this.element.appendChild(this.getFallbackForm());
                    },
                    resize: function(file) {
                        var info, srcRatio, trgRatio;
                        info = {
                            srcX: 0,
                            srcY: 0,
                            srcWidth: file.width,
                            srcHeight: file.height
                        };
                        srcRatio = file.width / file.height;
                        trgRatio = this.options.thumbnailWidth / this.options.thumbnailHeight;
                        if (file.height < this.options.thumbnailHeight || file.width < this.options.thumbnailWidth) {
                            info.trgHeight = info.srcHeight;
                            info.trgWidth = info.srcWidth;
                        } else {
                            if (srcRatio > trgRatio) {
                                info.srcHeight = file.height;
                                info.srcWidth = info.srcHeight * trgRatio;
                            } else {
                                info.srcWidth = file.width;
                                info.srcHeight = info.srcWidth / trgRatio;
                            }
                        }
                        info.srcX = (file.width - info.srcWidth) / 2;
                        info.srcY = (file.height - info.srcHeight) / 2;
                        return info;
                    },

                    /*
                     Those functions register themselves to the events on init and handle all
                     the user interface specific stuff. Overwriting them won't break the upload
                     but can break the way it's displayed.
                     You can overwrite them if you don't like the default behavior. If you just
                     want to add an additional event handler, register it on the dropzone object
                     and don't overwrite those options.
                     */
                    drop: function(e) {
                        return this.element.classList.remove("dz-drag-hover");
                    },
                    dragstart: noop,
                    dragend: function(e) {
                        return this.element.classList.remove("dz-drag-hover");
                    },
                    dragenter: function(e) {
                        return this.element.classList.add("dz-drag-hover");
                    },
                    dragover: function(e) {
                        return this.element.classList.add("dz-drag-hover");
                    },
                    dragleave: function(e) {
                        return this.element.classList.remove("dz-drag-hover");
                    },
                    paste: noop,
                    reset: function() {
                        return this.element.classList.remove("dz-started");
                    },
                    addedfile: function(file) {
                        var node, removeFileEvent, removeLink, _i, _j, _k, _len, _len1, _len2, _ref, _ref1, _ref2, _results;
                        if (this.element === this.previewsContainer) {
                            this.element.classList.add("dz-started");
                        }
                        file.previewElement = Dropzone.createElement(this.options.previewTemplate.trim());
                        file.previewTemplate = file.previewElement;
                        this.previewsContainer.appendChild(file.previewElement);
                        _ref = file.previewElement.querySelectorAll("[data-dz-name]");
                        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
                            node = _ref[_i];
                            node.textContent = file.name;
                        }
                        _ref1 = file.previewElement.querySelectorAll("[data-dz-size]");
                        for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
                            node = _ref1[_j];
                            node.innerHTML = this.filesize(file.size);
                        }
                        if (this.options.addRemoveLinks) {
                            file._removeLink = Dropzone.createElement("<a class=\"dz-remove\" href=\"javascript:undefined;\" data-dz-remove>" + this.options.dictRemoveFile + "</a>");
                            file.previewElement.appendChild(file._removeLink);
                        }
                        removeFileEvent = (function(_this) {
                            return function(e) {
                                e.preventDefault();
                                e.stopPropagation();
                                if (file.status === Dropzone.UPLOADING) {
                                    return Dropzone.confirm(_this.options.dictCancelUploadConfirmation, function() {
                                        return _this.removeFile(file);
                                    });
                                } else {
                                    if (_this.options.dictRemoveFileConfirmation) {
                                        return Dropzone.confirm(_this.options.dictRemoveFileConfirmation, function() {
                                            return _this.removeFile(file);
                                        });
                                    } else {
                                        return _this.removeFile(file);
                                    }
                                }
                            };
                        })(this);
                        _ref2 = file.previewElement.querySelectorAll("[data-dz-remove]");
                        _results = [];
                        for (_k = 0, _len2 = _ref2.length; _k < _len2; _k++) {
                            removeLink = _ref2[_k];
                            _results.push(removeLink.addEventListener("click", removeFileEvent));
                        }
                        return _results;
                    },
                    removedfile: function(file) {
                        var _ref;
                        if ((_ref = file.previewElement) != null) {
                            _ref.parentNode.removeChild(file.previewElement);
                        }
                        return this._updateMaxFilesReachedClass();
                    },
                    thumbnail: function(file, dataUrl) {
                        var thumbnailElement, _i, _len, _ref, _results;
                        file.previewElement.classList.remove("dz-file-preview");
                        file.previewElement.classList.add("dz-image-preview");
                        _ref = file.previewElement.querySelectorAll("[data-dz-thumbnail]");
                        _results = [];
                        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
                            thumbnailElement = _ref[_i];
                            thumbnailElement.alt = file.name;
                            _results.push(thumbnailElement.src = dataUrl);
                        }
                        return _results;
                    },
                    error: function(file, message) {
                        var node, _i, _len, _ref, _results;
                        file.previewElement.classList.add("dz-error");
                        if (typeof message !== "String" && message.error) {
                            message = message.error;
                        }
                        _ref = file.previewElement.querySelectorAll("[data-dz-errormessage]");
                        _results = [];
                        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
                            node = _ref[_i];
                            _results.push(node.textContent = message);
                        }
                        return _results;
                    },
                    errormultiple: noop,
                    processing: function(file) {
                        file.previewElement.classList.add("dz-processing");
                        if (file._removeLink) {
                            return file._removeLink.textContent = this.options.dictCancelUpload;
                        }
                    },
                    processingmultiple: noop,
                    uploadprogress: function(file, progress, bytesSent) {
                        var node, _i, _len, _ref, _results;
                        _ref = file.previewElement.querySelectorAll("[data-dz-uploadprogress]");
                        _results = [];
                        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
                            node = _ref[_i];
                            _results.push(node.style.width = "" + progress + "%");
                        }
                        return _results;
                    },
                    totaluploadprogress: noop,
                    sending: noop,
                    sendingmultiple: noop,
                    success: function(file) {
                        return file.previewElement.classList.add("dz-success");
                    },
                    successmultiple: noop,
                    canceled: function(file) {
                        return this.emit("error", file, "Upload canceled.");
                    },
                    canceledmultiple: noop,
                    complete: function(file) {
                        if (file._removeLink) {
                            return file._removeLink.textContent = this.options.dictRemoveFile;
                        }
                    },
                    completemultiple: noop,
                    maxfilesexceeded: noop,
                    maxfilesreached: noop,
                    previewTemplate: "<div class=\"dz-preview dz-file-preview\">\n  <div class=\"dz-details\">\n    <div class=\"dz-filename\"><span data-dz-name></span></div>\n    <div class=\"dz-size\" data-dz-size></div>\n    <img data-dz-thumbnail />\n  </div>\n  <div class=\"dz-progress\"><span class=\"dz-upload\" data-dz-uploadprogress></span></div>\n  <div class=\"dz-success-mark\"><span>✔</span></div>\n  <div class=\"dz-error-mark\"><span>✘</span></div>\n  <div class=\"dz-error-message\"><span data-dz-errormessage></span></div>\n</div>"
                };

                extend = function() {
                    var key, object, objects, target, val, _i, _len;
                    target = arguments[0], objects = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
                    for (_i = 0, _len = objects.length; _i < _len; _i++) {
                        object = objects[_i];
                        for (key in object) {
                            val = object[key];
                            target[key] = val;
                        }
                    }
                    return target;
                };

                function Dropzone(element, options) {
                    var elementOptions, fallback, _ref;
                    this.element = element;
                    this.version = Dropzone.version;
                    this.defaultOptions.previewTemplate = this.defaultOptions.previewTemplate.replace(/\n*/g, "");
                    this.clickableElements = [];
                    this.listeners = [];
                    this.files = [];
                    if (typeof this.element === "string") {
                        this.element = document.querySelector(this.element);
                    }
                    if (!(this.element && (this.element.nodeType != null))) {
                        throw new Error("Invalid dropzone element.");
                    }
                    if (this.element.dropzone) {
                        throw new Error("Dropzone already attached.");
                    }
                    Dropzone.instances.push(this);
                    this.element.dropzone = this;
                    elementOptions = (_ref = Dropzone.optionsForElement(this.element)) != null ? _ref : {};
                    this.options = extend({}, this.defaultOptions, elementOptions, options != null ? options : {});
                    if (this.options.forceFallback || !Dropzone.isBrowserSupported()) {
                        return this.options.fallback.call(this);
                    }
                    if (this.options.url == null) {
                        this.options.url = this.element.getAttribute("action");
                    }
                    if (!this.options.url) {
                        throw new Error("No URL provided.");
                    }
                    if (this.options.acceptedFiles && this.options.acceptedMimeTypes) {
                        throw new Error("You can't provide both 'acceptedFiles' and 'acceptedMimeTypes'. 'acceptedMimeTypes' is deprecated.");
                    }
                    if (this.options.acceptedMimeTypes) {
                        this.options.acceptedFiles = this.options.acceptedMimeTypes;
                        delete this.options.acceptedMimeTypes;
                    }
                    this.options.method = this.options.method.toUpperCase();
                    if ((fallback = this.getExistingFallback()) && fallback.parentNode) {
                        fallback.parentNode.removeChild(fallback);
                    }
                    if (this.options.previewsContainer) {
                        this.previewsContainer = Dropzone.getElement(this.options.previewsContainer, "previewsContainer");
                    } else {
                        this.previewsContainer = this.element;
                    }
                    if (this.options.clickable) {
                        if (this.options.clickable === true) {
                            this.clickableElements = [this.element];
                        } else {
                            this.clickableElements = Dropzone.getElements(this.options.clickable, "clickable");
                        }
                    }
                    this.init();
                }

                Dropzone.prototype.getAcceptedFiles = function() {
                    var file, _i, _len, _ref, _results;
                    _ref = this.files;
                    _results = [];
                    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
                        file = _ref[_i];
                        if (file.accepted) {
                            _results.push(file);
                        }
                    }
                    return _results;
                };

                Dropzone.prototype.getRejectedFiles = function() {
                    var file, _i, _len, _ref, _results;
                    _ref = this.files;
                    _results = [];
                    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
                        file = _ref[_i];
                        if (!file.accepted) {
                            _results.push(file);
                        }
                    }
                    return _results;
                };

                Dropzone.prototype.getFilesWithStatus = function(status) {
                    var file, _i, _len, _ref, _results;
                    _ref = this.files;
                    _results = [];
                    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
                        file = _ref[_i];
                        if (file.status === status) {
                            _results.push(file);
                        }
                    }
                    return _results;
                };

                Dropzone.prototype.getQueuedFiles = function() {
                    return this.getFilesWithStatus(Dropzone.QUEUED);
                };

                Dropzone.prototype.getUploadingFiles = function() {
                    return this.getFilesWithStatus(Dropzone.UPLOADING);
                };

                Dropzone.prototype.getActiveFiles = function() {
                    var file, _i, _len, _ref, _results;
                    _ref = this.files;
                    _results = [];
                    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
                        file = _ref[_i];
                        if (file.status === Dropzone.UPLOADING || file.status === Dropzone.QUEUED) {
                            _results.push(file);
                        }
                    }
                    return _results;
                };

                Dropzone.prototype.init = function() {
                    var eventName, noPropagation, setupHiddenFileInput, _i, _len, _ref, _ref1;
                    if (this.element.tagName === "form") {
                        this.element.setAttribute("enctype", "multipart/form-data");
                    }
                    if (this.element.classList.contains("dropzone") && !this.element.querySelector(".dz-message")) {
                        this.element.appendChild(Dropzone.createElement("<div class=\"dz-default dz-message\"><span>" + this.options.dictDefaultMessage + "</span></div>"));
                    }
                    if (this.clickableElements.length) {
                        setupHiddenFileInput = (function(_this) {
                            return function() {
                                if (_this.hiddenFileInput) {
                                    document.body.removeChild(_this.hiddenFileInput);
                                }
                                _this.hiddenFileInput = document.createElement("input");
                                _this.hiddenFileInput.setAttribute("type", "file");
                                if ((_this.options.maxFiles == null) || _this.options.maxFiles > 1) {
                                    _this.hiddenFileInput.setAttribute("multiple", "multiple");
                                }
                                _this.hiddenFileInput.className = "dz-hidden-input";
                                if (_this.options.acceptedFiles != null) {
                                    _this.hiddenFileInput.setAttribute("accept", _this.options.acceptedFiles);
                                }
                                _this.hiddenFileInput.style.visibility = "hidden";
                                _this.hiddenFileInput.style.position = "absolute";
                                _this.hiddenFileInput.style.top = "0";
                                _this.hiddenFileInput.style.left = "0";
                                _this.hiddenFileInput.style.height = "0";
                                _this.hiddenFileInput.style.width = "0";
                                document.body.appendChild(_this.hiddenFileInput);
                                return _this.hiddenFileInput.addEventListener("change", function() {
                                    var file, files, _i, _len;
                                    files = _this.hiddenFileInput.files;
                                    if (files.length) {
                                        for (_i = 0, _len = files.length; _i < _len; _i++) {
                                            file = files[_i];
                                            _this.addFile(file);
                                        }
                                    }
                                    return setupHiddenFileInput();
                                });
                            };
                        })(this);
                        setupHiddenFileInput();
                    }
                    this.URL = (_ref = window.URL) != null ? _ref : window.webkitURL;
                    _ref1 = this.events;
                    for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
                        eventName = _ref1[_i];
                        this.on(eventName, this.options[eventName]);
                    }
                    this.on("uploadprogress", (function(_this) {
                        return function() {
                            return _this.updateTotalUploadProgress();
                        };
                    })(this));
                    this.on("removedfile", (function(_this) {
                        return function() {
                            return _this.updateTotalUploadProgress();
                        };
                    })(this));
                    this.on("canceled", (function(_this) {
                        return function(file) {
                            return _this.emit("complete", file);
                        };
                    })(this));
                    this.on("complete", (function(_this) {
                        return function(file) {
                            if (_this.getUploadingFiles().length === 0 && _this.getQueuedFiles().length === 0) {
                                return setTimeout((function() {
                                    return _this.emit("queuecomplete");
                                }), 0);
                            }
                        };
                    })(this));
                    noPropagation = function(e) {
                        e.stopPropagation();
                        if (e.preventDefault) {
                            return e.preventDefault();
                        } else {
                            return e.returnValue = false;
                        }
                    };
                    this.listeners = [
                        {
                            element: this.element,
                            events: {
                                "dragstart": (function(_this) {
                                    return function(e) {
                                        return _this.emit("dragstart", e);
                                    };
                                })(this),
                                "dragenter": (function(_this) {
                                    return function(e) {
                                        noPropagation(e);
                                        return _this.emit("dragenter", e);
                                    };
                                })(this),
                                "dragover": (function(_this) {
                                    return function(e) {
                                        var efct;
                                        try {
                                            efct = e.dataTransfer.effectAllowed;
                                        } catch (_error) {}
                                        e.dataTransfer.dropEffect = 'move' === efct || 'linkMove' === efct ? 'move' : 'copy';
                                        noPropagation(e);
                                        return _this.emit("dragover", e);
                                    };
                                })(this),
                                "dragleave": (function(_this) {
                                    return function(e) {
                                        return _this.emit("dragleave", e);
                                    };
                                })(this),
                                "drop": (function(_this) {
                                    return function(e) {
                                        noPropagation(e);
                                        return _this.drop(e);
                                    };
                                })(this),
                                "dragend": (function(_this) {
                                    return function(e) {
                                        return _this.emit("dragend", e);
                                    };
                                })(this)
                            }
                        }
                    ];
                    this.clickableElements.forEach((function(_this) {
                        return function(clickableElement) {
                            return _this.listeners.push({
                                element: clickableElement,
                                events: {
                                    "click": function(evt) {
                                        if ((clickableElement !== _this.element) || (evt.target === _this.element || Dropzone.elementInside(evt.target, _this.element.querySelector(".dz-message")))) {
                                            return _this.hiddenFileInput.click();
                                        }
                                    }
                                }
                            });
                        };
                    })(this));
                    this.enable();
                    return this.options.init.call(this);
                };

                Dropzone.prototype.destroy = function() {
                    var _ref;
                    this.disable();
                    this.removeAllFiles(true);
                    if ((_ref = this.hiddenFileInput) != null ? _ref.parentNode : void 0) {
                        this.hiddenFileInput.parentNode.removeChild(this.hiddenFileInput);
                        this.hiddenFileInput = null;
                    }
                    delete this.element.dropzone;
                    return Dropzone.instances.splice(Dropzone.instances.indexOf(this), 1);
                };

                Dropzone.prototype.updateTotalUploadProgress = function() {
                    var activeFiles, file, totalBytes, totalBytesSent, totalUploadProgress, _i, _len, _ref;
                    totalBytesSent = 0;
                    totalBytes = 0;
                    activeFiles = this.getActiveFiles();
                    if (activeFiles.length) {
                        _ref = this.getActiveFiles();
                        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
                            file = _ref[_i];
                            totalBytesSent += file.upload.bytesSent;
                            totalBytes += file.upload.total;
                        }
                        totalUploadProgress = 100 * totalBytesSent / totalBytes;
                    } else {
                        totalUploadProgress = 100;
                    }
                    return this.emit("totaluploadprogress", totalUploadProgress, totalBytes, totalBytesSent);
                };

                Dropzone.prototype.getFallbackForm = function() {
                    var existingFallback, fields, fieldsString, form;
                    if (existingFallback = this.getExistingFallback()) {
                        return existingFallback;
                    }
                    fieldsString = "<div class=\"dz-fallback\">";
                    if (this.options.dictFallbackText) {
                        fieldsString += "<p>" + this.options.dictFallbackText + "</p>";
                    }
                    fieldsString += "<input type=\"file\" name=\"" + this.options.paramName + (this.options.uploadMultiple ? "[]" : "") + "\" " + (this.options.uploadMultiple ? 'multiple="multiple"' : void 0) + " /><input type=\"submit\" value=\"Upload!\"></div>";
                    fields = Dropzone.createElement(fieldsString);
                    if (this.element.tagName !== "FORM") {
                        form = Dropzone.createElement("<form action=\"" + this.options.url + "\" enctype=\"multipart/form-data\" method=\"" + this.options.method + "\"></form>");
                        form.appendChild(fields);
                    } else {
                        this.element.setAttribute("enctype", "multipart/form-data");
                        this.element.setAttribute("method", this.options.method);
                    }
                    return form != null ? form : fields;
                };

                Dropzone.prototype.getExistingFallback = function() {
                    var fallback, getFallback, tagName, _i, _len, _ref;
                    getFallback = function(elements) {
                        var el, _i, _len;
                        for (_i = 0, _len = elements.length; _i < _len; _i++) {
                            el = elements[_i];
                            if (/(^| )fallback($| )/.test(el.className)) {
                                return el;
                            }
                        }
                    };
                    _ref = ["div", "form"];
                    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
                        tagName = _ref[_i];
                        if (fallback = getFallback(this.element.getElementsByTagName(tagName))) {
                            return fallback;
                        }
                    }
                };

                Dropzone.prototype.setupEventListeners = function() {
                    var elementListeners, event, listener, _i, _len, _ref, _results;
                    _ref = this.listeners;
                    _results = [];
                    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
                        elementListeners = _ref[_i];
                        _results.push((function() {
                            var _ref1, _results1;
                            _ref1 = elementListeners.events;
                            _results1 = [];
                            for (event in _ref1) {
                                listener = _ref1[event];
                                _results1.push(elementListeners.element.addEventListener(event, listener, false));
                            }
                            return _results1;
                        })());
                    }
                    return _results;
                };

                Dropzone.prototype.removeEventListeners = function() {
                    var elementListeners, event, listener, _i, _len, _ref, _results;
                    _ref = this.listeners;
                    _results = [];
                    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
                        elementListeners = _ref[_i];
                        _results.push((function() {
                            var _ref1, _results1;
                            _ref1 = elementListeners.events;
                            _results1 = [];
                            for (event in _ref1) {
                                listener = _ref1[event];
                                _results1.push(elementListeners.element.removeEventListener(event, listener, false));
                            }
                            return _results1;
                        })());
                    }
                    return _results;
                };

                Dropzone.prototype.disable = function() {
                    var file, _i, _len, _ref, _results;
                    this.clickableElements.forEach(function(element) {
                        return element.classList.remove("dz-clickable");
                    });
                    this.removeEventListeners();
                    _ref = this.files;
                    _results = [];
                    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
                        file = _ref[_i];
                        _results.push(this.cancelUpload(file));
                    }
                    return _results;
                };

                Dropzone.prototype.enable = function() {
                    this.clickableElements.forEach(function(element) {
                        return element.classList.add("dz-clickable");
                    });
                    return this.setupEventListeners();
                };

                Dropzone.prototype.filesize = function(size) {
                    var string;
                    if (size >= 1024 * 1024 * 1024 * 1024 / 10) {
                        size = size / (1024 * 1024 * 1024 * 1024 / 10);
                        string = "TiB";
                    } else if (size >= 1024 * 1024 * 1024 / 10) {
                        size = size / (1024 * 1024 * 1024 / 10);
                        string = "GiB";
                    } else if (size >= 1024 * 1024 / 10) {
                        size = size / (1024 * 1024 / 10);
                        string = "MiB";
                    } else if (size >= 1024 / 10) {
                        size = size / (1024 / 10);
                        string = "KiB";
                    } else {
                        size = size * 10;
                        string = "b";
                    }
                    return "<strong>" + (Math.round(size) / 10) + "</strong> " + string;
                };

                Dropzone.prototype._updateMaxFilesReachedClass = function() {
                    if ((this.options.maxFiles != null) && this.getAcceptedFiles().length >= this.options.maxFiles) {
                        if (this.getAcceptedFiles().length === this.options.maxFiles) {
                            this.emit('maxfilesreached', this.files);
                        }
                        return this.element.classList.add("dz-max-files-reached");
                    } else {
                        return this.element.classList.remove("dz-max-files-reached");
                    }
                };

                Dropzone.prototype.drop = function(e) {
                    var files, items;
                    if (!e.dataTransfer) {
                        return;
                    }
                    this.emit("drop", e);
                    files = e.dataTransfer.files;
                    if (files.length) {
                        items = e.dataTransfer.items;
                        if (items && items.length && (items[0].webkitGetAsEntry != null)) {
                            this._addFilesFromItems(items);
                        } else {
                            this.handleFiles(files);
                        }
                    }
                };

                Dropzone.prototype.paste = function(e) {
                    var items, _ref;
                    if ((e != null ? (_ref = e.clipboardData) != null ? _ref.items : void 0 : void 0) == null) {
                        return;
                    }
                    this.emit("paste", e);
                    items = e.clipboardData.items;
                    if (items.length) {
                        return this._addFilesFromItems(items);
                    }
                };

                Dropzone.prototype.handleFiles = function(files) {
                    var file, _i, _len, _results;
                    _results = [];
                    for (_i = 0, _len = files.length; _i < _len; _i++) {
                        file = files[_i];
                        _results.push(this.addFile(file));
                    }
                    return _results;
                };

                Dropzone.prototype._addFilesFromItems = function(items) {
                    var entry, item, _i, _len, _results;
                    _results = [];
                    for (_i = 0, _len = items.length; _i < _len; _i++) {
                        item = items[_i];
                        if ((item.webkitGetAsEntry != null) && (entry = item.webkitGetAsEntry())) {
                            if (entry.isFile) {
                                _results.push(this.addFile(item.getAsFile()));
                            } else if (entry.isDirectory) {
                                _results.push(this._addFilesFromDirectory(entry, entry.name));
                            } else {
                                _results.push(void 0);
                            }
                        } else if (item.getAsFile != null) {
                            if ((item.kind == null) || item.kind === "file") {
                                _results.push(this.addFile(item.getAsFile()));
                            } else {
                                _results.push(void 0);
                            }
                        } else {
                            _results.push(void 0);
                        }
                    }
                    return _results;
                };

                Dropzone.prototype._addFilesFromDirectory = function(directory, path) {
                    var dirReader, entriesReader;
                    dirReader = directory.createReader();
                    entriesReader = (function(_this) {
                        return function(entries) {
                            var entry, _i, _len;
                            for (_i = 0, _len = entries.length; _i < _len; _i++) {
                                entry = entries[_i];
                                if (entry.isFile) {
                                    entry.file(function(file) {
                                        if (_this.options.ignoreHiddenFiles && file.name.substring(0, 1) === '.') {
                                            return;
                                        }
                                        file.fullPath = "" + path + "/" + file.name;
                                        return _this.addFile(file);
                                    });
                                } else if (entry.isDirectory) {
                                    _this._addFilesFromDirectory(entry, "" + path + "/" + entry.name);
                                }
                            }
                        };
                    })(this);
                    return dirReader.readEntries(entriesReader, function(error) {
                        return typeof console !== "undefined" && console !== null ? typeof console.log === "function" ? console.log(error) : void 0 : void 0;
                    });
                };

                Dropzone.prototype.accept = function(file, done) {
                    if (file.size > this.options.maxFilesize * 1024 * 1024) {
                        return done(this.options.dictFileTooBig.replace("{{filesize}}", Math.round(file.size / 1024 / 10.24) / 100).replace("{{maxFilesize}}", this.options.maxFilesize));
                    } else if (!Dropzone.isValidFile(file, this.options.acceptedFiles)) {
                        return done(this.options.dictInvalidFileType);
                    } else if ((this.options.maxFiles != null) && this.getAcceptedFiles().length >= this.options.maxFiles) {
                        done(this.options.dictMaxFilesExceeded.replace("{{maxFiles}}", this.options.maxFiles));
                        return this.emit("maxfilesexceeded", file);
                    } else {
                        return this.options.accept.call(this, file, done);
                    }
                };

                Dropzone.prototype.addFile = function(file) {
                    file.upload = {
                        progress: 0,
                        total: file.size,
                        bytesSent: 0
                    };
                    this.files.push(file);
                    file.status = Dropzone.ADDED;
                    this.emit("addedfile", file);
                    this._enqueueThumbnail(file);
                    return this.accept(file, (function(_this) {
                        return function(error) {
                            if (error) {
                                file.accepted = false;
                                _this._errorProcessing([file], error);
                            } else {
                                file.accepted = true;
                                if (_this.options.autoQueue) {
                                    _this.enqueueFile(file);
                                }
                            }
                            return _this._updateMaxFilesReachedClass();
                        };
                    })(this));
                };

                Dropzone.prototype.enqueueFiles = function(files) {
                    var file, _i, _len;
                    for (_i = 0, _len = files.length; _i < _len; _i++) {
                        file = files[_i];
                        this.enqueueFile(file);
                    }
                    return null;
                };

                Dropzone.prototype.enqueueFile = function(file) {
                    if (file.status === Dropzone.ADDED && file.accepted === true) {
                        file.status = Dropzone.QUEUED;
                        if (this.options.autoProcessQueue) {
                            return setTimeout(((function(_this) {
                                return function() {
                                    return _this.processQueue();
                                };
                            })(this)), 0);
                        }
                    } else {
                        throw new Error("This file can't be queued because it has already been processed or was rejected.");
                    }
                };

                Dropzone.prototype._thumbnailQueue = [];

                Dropzone.prototype._processingThumbnail = false;

                Dropzone.prototype._enqueueThumbnail = function(file) {
                    if (this.options.createImageThumbnails && file.type.match(/image.*/) && file.size <= this.options.maxThumbnailFilesize * 1024 * 1024) {
                        this._thumbnailQueue.push(file);
                        return setTimeout(((function(_this) {
                            return function() {
                                return _this._processThumbnailQueue();
                            };
                        })(this)), 0);
                    }
                };

                Dropzone.prototype._processThumbnailQueue = function() {
                    if (this._processingThumbnail || this._thumbnailQueue.length === 0) {
                        return;
                    }
                    this._processingThumbnail = true;
                    return this.createThumbnail(this._thumbnailQueue.shift(), (function(_this) {
                        return function() {
                            _this._processingThumbnail = false;
                            return _this._processThumbnailQueue();
                        };
                    })(this));
                };

                Dropzone.prototype.removeFile = function(file) {
                    if (file.status === Dropzone.UPLOADING) {
                        this.cancelUpload(file);
                    }
                    this.files = without(this.files, file);
                    this.emit("removedfile", file);
                    if (this.files.length === 0) {
                        return this.emit("reset");
                    }
                };

                Dropzone.prototype.removeAllFiles = function(cancelIfNecessary) {
                    var file, _i, _len, _ref;
                    if (cancelIfNecessary == null) {
                        cancelIfNecessary = false;
                    }
                    _ref = this.files.slice();
                    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
                        file = _ref[_i];
                        if (file.status !== Dropzone.UPLOADING || cancelIfNecessary) {
                            this.removeFile(file);
                        }
                    }
                    return null;
                };

                Dropzone.prototype.createThumbnail = function(file, callback) {
                    var fileReader;
                    fileReader = new FileReader;
                    fileReader.onload = (function(_this) {
                        return function() {
                            var img;
                            img = document.createElement("img");
                            img.onload = function() {
                                var canvas, ctx, resizeInfo, thumbnail, _ref, _ref1, _ref2, _ref3;
                                file.width = img.width;
                                file.height = img.height;
                                resizeInfo = _this.options.resize.call(_this, file);
                                if (resizeInfo.trgWidth == null) {
                                    resizeInfo.trgWidth = _this.options.thumbnailWidth;
                                }
                                if (resizeInfo.trgHeight == null) {
                                    resizeInfo.trgHeight = _this.options.thumbnailHeight;
                                }
                                canvas = document.createElement("canvas");
                                ctx = canvas.getContext("2d");
                                canvas.width = resizeInfo.trgWidth;
                                canvas.height = resizeInfo.trgHeight;
                                drawImageIOSFix(ctx, img, (_ref = resizeInfo.srcX) != null ? _ref : 0, (_ref1 = resizeInfo.srcY) != null ? _ref1 : 0, resizeInfo.srcWidth, resizeInfo.srcHeight, (_ref2 = resizeInfo.trgX) != null ? _ref2 : 0, (_ref3 = resizeInfo.trgY) != null ? _ref3 : 0, resizeInfo.trgWidth, resizeInfo.trgHeight);
                                thumbnail = canvas.toDataURL("image/png");
                                _this.emit("thumbnail", file, thumbnail);
                                if (callback != null) {
                                    return callback();
                                }
                            };
                            return img.src = fileReader.result;
                        };
                    })(this);
                    return fileReader.readAsDataURL(file);
                };

                Dropzone.prototype.processQueue = function() {
                    var i, parallelUploads, processingLength, queuedFiles;
                    parallelUploads = this.options.parallelUploads;
                    processingLength = this.getUploadingFiles().length;
                    i = processingLength;
                    if (processingLength >= parallelUploads) {
                        return;
                    }
                    queuedFiles = this.getQueuedFiles();
                    if (!(queuedFiles.length > 0)) {
                        return;
                    }
                    if (this.options.uploadMultiple) {
                        return this.processFiles(queuedFiles.slice(0, parallelUploads - processingLength));
                    } else {
                        while (i < parallelUploads) {
                            if (!queuedFiles.length) {
                                return;
                            }
                            this.processFile(queuedFiles.shift());
                            i++;
                        }
                    }
                };

                Dropzone.prototype.processFile = function(file) {
                    return this.processFiles([file]);
                };

                Dropzone.prototype.processFiles = function(files) {
                    var file, _i, _len;
                    for (_i = 0, _len = files.length; _i < _len; _i++) {
                        file = files[_i];
                        file.processing = true;
                        file.status = Dropzone.UPLOADING;
                        this.emit("processing", file);
                    }
                    if (this.options.uploadMultiple) {
                        this.emit("processingmultiple", files);
                    }
                    return this.uploadFiles(files);
                };

                Dropzone.prototype._getFilesWithXhr = function(xhr) {
                    var file, files;
                    return files = (function() {
                        var _i, _len, _ref, _results;
                        _ref = this.files;
                        _results = [];
                        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
                            file = _ref[_i];
                            if (file.xhr === xhr) {
                                _results.push(file);
                            }
                        }
                        return _results;
                    }).call(this);
                };

                Dropzone.prototype.cancelUpload = function(file) {
                    var groupedFile, groupedFiles, _i, _j, _len, _len1, _ref;
                    if (file.status === Dropzone.UPLOADING) {
                        groupedFiles = this._getFilesWithXhr(file.xhr);
                        for (_i = 0, _len = groupedFiles.length; _i < _len; _i++) {
                            groupedFile = groupedFiles[_i];
                            groupedFile.status = Dropzone.CANCELED;
                        }
                        file.xhr.abort();
                        for (_j = 0, _len1 = groupedFiles.length; _j < _len1; _j++) {
                            groupedFile = groupedFiles[_j];
                            this.emit("canceled", groupedFile);
                        }
                        if (this.options.uploadMultiple) {
                            this.emit("canceledmultiple", groupedFiles);
                        }
                    } else if ((_ref = file.status) === Dropzone.ADDED || _ref === Dropzone.QUEUED) {
                        file.status = Dropzone.CANCELED;
                        this.emit("canceled", file);
                        if (this.options.uploadMultiple) {
                            this.emit("canceledmultiple", [file]);
                        }
                    }
                    if (this.options.autoProcessQueue) {
                        return this.processQueue();
                    }
                };

                Dropzone.prototype.uploadFile = function(file) {
                    return this.uploadFiles([file]);
                };

                Dropzone.prototype.uploadFiles = function(files) {
                    var file, formData, handleError, headerName, headerValue, headers, input, inputName, inputType, key, option, progressObj, response, updateProgress, value, xhr, _i, _j, _k, _l, _len, _len1, _len2, _len3, _len4, _m, _ref, _ref1, _ref2, _ref3, _ref4;
                    xhr = new XMLHttpRequest();
                    for (_i = 0, _len = files.length; _i < _len; _i++) {
                        file = files[_i];
                        file.xhr = xhr;
                    }
                    xhr.open(this.options.method, this.options.url, true);
                    xhr.withCredentials = !!this.options.withCredentials;
                    response = null;
                    handleError = (function(_this) {
                        return function() {
                            var _j, _len1, _results;
                            _results = [];
                            for (_j = 0, _len1 = files.length; _j < _len1; _j++) {
                                file = files[_j];
                                _results.push(_this._errorProcessing(files, response || _this.options.dictResponseError.replace("{{statusCode}}", xhr.status), xhr));
                            }
                            return _results;
                        };
                    })(this);
                    updateProgress = (function(_this) {
                        return function(e) {
                            var allFilesFinished, progress, _j, _k, _l, _len1, _len2, _len3, _results;
                            if (e != null) {
                                progress = 100 * e.loaded / e.total;
                                for (_j = 0, _len1 = files.length; _j < _len1; _j++) {
                                    file = files[_j];
                                    file.upload = {
                                        progress: progress,
                                        total: e.total,
                                        bytesSent: e.loaded
                                    };
                                }
                            } else {
                                allFilesFinished = true;
                                progress = 100;
                                for (_k = 0, _len2 = files.length; _k < _len2; _k++) {
                                    file = files[_k];
                                    if (!(file.upload.progress === 100 && file.upload.bytesSent === file.upload.total)) {
                                        allFilesFinished = false;
                                    }
                                    file.upload.progress = progress;
                                    file.upload.bytesSent = file.upload.total;
                                }
                                if (allFilesFinished) {
                                    return;
                                }
                            }
                            _results = [];
                            for (_l = 0, _len3 = files.length; _l < _len3; _l++) {
                                file = files[_l];
                                _results.push(_this.emit("uploadprogress", file, progress, file.upload.bytesSent));
                            }
                            return _results;
                        };
                    })(this);
                    xhr.onload = (function(_this) {
                        return function(e) {
                            var _ref;
                            if (files[0].status === Dropzone.CANCELED) {
                                return;
                            }
                            if (xhr.readyState !== 4) {
                                return;
                            }
                            response = xhr.responseText;
                            if (xhr.getResponseHeader("content-type") && ~xhr.getResponseHeader("content-type").indexOf("application/json")) {
                                try {
                                    response = JSON.parse(response);
                                } catch (_error) {
                                    e = _error;
                                    response = "Invalid JSON response from server.";
                                }
                            }
                            updateProgress();
                            if (!((200 <= (_ref = xhr.status) && _ref < 300))) {
                                return handleError();
                            } else {
                                return _this._finished(files, response, e);
                            }
                        };
                    })(this);
                    xhr.onerror = (function(_this) {
                        return function() {
                            if (files[0].status === Dropzone.CANCELED) {
                                return;
                            }
                            return handleError();
                        };
                    })(this);
                    progressObj = (_ref = xhr.upload) != null ? _ref : xhr;
                    progressObj.onprogress = updateProgress;
                    headers = {
                        "Accept": "application/json",
                        "Cache-Control": "no-cache",
                        "X-Requested-With": "XMLHttpRequest"
                    };
                    if (this.options.headers) {
                        extend(headers, this.options.headers);
                    }
                    for (headerName in headers) {
                        headerValue = headers[headerName];
                        xhr.setRequestHeader(headerName, headerValue);
                    }
                    formData = new FormData();
                    if (this.options.params) {
                        _ref1 = this.options.params;
                        for (key in _ref1) {
                            value = _ref1[key];
                            formData.append(key, value);
                        }
                    }
                    for (_j = 0, _len1 = files.length; _j < _len1; _j++) {
                        file = files[_j];
                        this.emit("sending", file, xhr, formData);
                    }
                    if (this.options.uploadMultiple) {
                        this.emit("sendingmultiple", files, xhr, formData);
                    }
                    if (this.element.tagName === "FORM") {
                        _ref2 = this.element.querySelectorAll("input, textarea, select, button");
                        for (_k = 0, _len2 = _ref2.length; _k < _len2; _k++) {
                            input = _ref2[_k];
                            inputName = input.getAttribute("name");
                            inputType = input.getAttribute("type");
                            if (input.tagName === "SELECT" && input.hasAttribute("multiple")) {
                                _ref3 = input.options;
                                for (_l = 0, _len3 = _ref3.length; _l < _len3; _l++) {
                                    option = _ref3[_l];
                                    if (option.selected) {
                                        formData.append(inputName, option.value);
                                    }
                                }
                            } else if (!inputType || ((_ref4 = inputType.toLowerCase()) !== "checkbox" && _ref4 !== "radio") || input.checked) {
                                formData.append(inputName, input.value);
                            }
                        }
                    }
                    for (_m = 0, _len4 = files.length; _m < _len4; _m++) {
                        file = files[_m];
                        formData.append("" + this.options.paramName + (this.options.uploadMultiple ? "[]" : ""), file, file.name);
                    }
                    return xhr.send(formData);
                };

                Dropzone.prototype._finished = function(files, responseText, e) {
                    var file, _i, _len;
                    for (_i = 0, _len = files.length; _i < _len; _i++) {
                        file = files[_i];
                        file.status = Dropzone.SUCCESS;
                        this.emit("success", file, responseText, e);
                        this.emit("complete", file);
                    }
                    if (this.options.uploadMultiple) {
                        this.emit("successmultiple", files, responseText, e);
                        this.emit("completemultiple", files);
                    }
                    if (this.options.autoProcessQueue) {
                        return this.processQueue();
                    }
                };

                Dropzone.prototype._errorProcessing = function(files, message, xhr) {
                    var file, _i, _len;
                    for (_i = 0, _len = files.length; _i < _len; _i++) {
                        file = files[_i];
                        file.status = Dropzone.ERROR;
                        this.emit("error", file, message, xhr);
                        this.emit("complete", file);
                    }
                    if (this.options.uploadMultiple) {
                        this.emit("errormultiple", files, message, xhr);
                        this.emit("completemultiple", files);
                    }
                    if (this.options.autoProcessQueue) {
                        return this.processQueue();
                    }
                };

                return Dropzone;

            })(Em);

            Dropzone.version = "3.8.7";

            Dropzone.options = {};

            Dropzone.optionsForElement = function(element) {
                if (element.getAttribute("id")) {
                    return Dropzone.options[camelize(element.getAttribute("id"))];
                } else {
                    return void 0;
                }
            };

            Dropzone.instances = [];

            Dropzone.forElement = function(element) {
                if (typeof element === "string") {
                    element = document.querySelector(element);
                }
                if ((element != null ? element.dropzone : void 0) == null) {
                    throw new Error("No Dropzone found for given element. This is probably because you're trying to access it before Dropzone had the time to initialize. Use the `init` option to setup any additional observers on your Dropzone.");
                }
                return element.dropzone;
            };

            Dropzone.autoDiscover = true;

            Dropzone.discover = function() {
                var checkElements, dropzone, dropzones, _i, _len, _results;
                if (document.querySelectorAll) {
                    dropzones = document.querySelectorAll(".dropzone");
                } else {
                    dropzones = [];
                    checkElements = function(elements) {
                        var el, _i, _len, _results;
                        _results = [];
                        for (_i = 0, _len = elements.length; _i < _len; _i++) {
                            el = elements[_i];
                            if (/(^| )dropzone($| )/.test(el.className)) {
                                _results.push(dropzones.push(el));
                            } else {
                                _results.push(void 0);
                            }
                        }
                        return _results;
                    };
                    checkElements(document.getElementsByTagName("div"));
                    checkElements(document.getElementsByTagName("form"));
                }
                _results = [];
                for (_i = 0, _len = dropzones.length; _i < _len; _i++) {
                    dropzone = dropzones[_i];
                    if (Dropzone.optionsForElement(dropzone) !== false) {
                        _results.push(new Dropzone(dropzone));
                    } else {
                        _results.push(void 0);
                    }
                }
                return _results;
            };

            Dropzone.blacklistedBrowsers = [/opera.*Macintosh.*version\/12/i];

            Dropzone.isBrowserSupported = function() {
                var capableBrowser, regex, _i, _len, _ref;
                capableBrowser = true;
                if (window.File && window.FileReader && window.FileList && window.Blob && window.FormData && document.querySelector) {
                    if (!("classList" in document.createElement("a"))) {
                        capableBrowser = false;
                    } else {
                        _ref = Dropzone.blacklistedBrowsers;
                        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
                            regex = _ref[_i];
                            if (regex.test(navigator.userAgent)) {
                                capableBrowser = false;
                                continue;
                            }
                        }
                    }
                } else {
                    capableBrowser = false;
                }
                return capableBrowser;
            };

            without = function(list, rejectedItem) {
                var item, _i, _len, _results;
                _results = [];
                for (_i = 0, _len = list.length; _i < _len; _i++) {
                    item = list[_i];
                    if (item !== rejectedItem) {
                        _results.push(item);
                    }
                }
                return _results;
            };

            camelize = function(str) {
                return str.replace(/[\-_](\w)/g, function(match) {
                    return match.charAt(1).toUpperCase();
                });
            };

            Dropzone.createElement = function(string) {
                var div;
                div = document.createElement("div");
                div.innerHTML = string;
                return div.childNodes[0];
            };

            Dropzone.elementInside = function(element, container) {
                if (element === container) {
                    return true;
                }
                while (element = element.parentNode) {
                    if (element === container) {
                        return true;
                    }
                }
                return false;
            };

            Dropzone.getElement = function(el, name) {
                var element;
                if (typeof el === "string") {
                    element = document.querySelector(el);
                } else if (el.nodeType != null) {
                    element = el;
                }
                if (element == null) {
                    throw new Error("Invalid `" + name + "` option provided. Please provide a CSS selector or a plain HTML element.");
                }
                return element;
            };

            Dropzone.getElements = function(els, name) {
                var e, el, elements, _i, _j, _len, _len1, _ref;
                if (els instanceof Array) {
                    elements = [];
                    try {
                        for (_i = 0, _len = els.length; _i < _len; _i++) {
                            el = els[_i];
                            elements.push(this.getElement(el, name));
                        }
                    } catch (_error) {
                        e = _error;
                        elements = null;
                    }
                } else if (typeof els === "string") {
                    elements = [];
                    _ref = document.querySelectorAll(els);
                    for (_j = 0, _len1 = _ref.length; _j < _len1; _j++) {
                        el = _ref[_j];
                        elements.push(el);
                    }
                } else if (els.nodeType != null) {
                    elements = [els];
                }
                if (!((elements != null) && elements.length)) {
                    throw new Error("Invalid `" + name + "` option provided. Please provide a CSS selector, a plain HTML element or a list of those.");
                }
                return elements;
            };

            Dropzone.confirm = function(question, accepted, rejected) {
                if (window.confirm(question)) {
                    return accepted();
                } else if (rejected != null) {
                    return rejected();
                }
            };

            Dropzone.isValidFile = function(file, acceptedFiles) {
                var baseMimeType, mimeType, validType, _i, _len;
                if (!acceptedFiles) {
                    return true;
                }
                acceptedFiles = acceptedFiles.split(",");
                mimeType = file.type;
                baseMimeType = mimeType.replace(/\/.*$/, "");
                for (_i = 0, _len = acceptedFiles.length; _i < _len; _i++) {
                    validType = acceptedFiles[_i];
                    validType = validType.trim();
                    if (validType.charAt(0) === ".") {
                        if (file.name.toLowerCase().indexOf(validType.toLowerCase(), file.name.length - validType.length) !== -1) {
                            return true;
                        }
                    } else if (/\/\*$/.test(validType)) {
                        if (baseMimeType === validType.replace(/\/.*$/, "")) {
                            return true;
                        }
                    } else {
                        if (mimeType === validType) {
                            return true;
                        }
                    }
                }
                return false;
            };

            if (typeof jQuery !== "undefined" && jQuery !== null) {
                jQuery.fn.dropzone = function(options) {
                    return this.each(function() {
                        return new Dropzone(this, options);
                    });
                };
            }

            if (typeof module !== "undefined" && module !== null) {
                module.exports = Dropzone;
            } else {
                window.Dropzone = Dropzone;
            }

            Dropzone.ADDED = "added";

            Dropzone.QUEUED = "queued";

            Dropzone.ACCEPTED = Dropzone.QUEUED;

            Dropzone.UPLOADING = "uploading";

            Dropzone.PROCESSING = Dropzone.UPLOADING;

            Dropzone.CANCELED = "canceled";

            Dropzone.ERROR = "error";

            Dropzone.SUCCESS = "success";


            /*

             Bugfix for iOS 6 and 7
             Source: http://stackoverflow.com/questions/11929099/html5-canvas-drawimage-ratio-bug-ios
             based on the work of https://github.com/stomita/ios-imagefile-megapixel
             */

            detectVerticalSquash = function(img) {
                var alpha, canvas, ctx, data, ey, ih, iw, py, ratio, sy;
                iw = img.naturalWidth;
                ih = img.naturalHeight;
                canvas = document.createElement("canvas");
                canvas.width = 1;
                canvas.height = ih;
                ctx = canvas.getContext("2d");
                ctx.drawImage(img, 0, 0);
                data = ctx.getImageData(0, 0, 1, ih).data;
                sy = 0;
                ey = ih;
                py = ih;
                while (py > sy) {
                    alpha = data[(py - 1) * 4 + 3];
                    if (alpha === 0) {
                        ey = py;
                    } else {
                        sy = py;
                    }
                    py = (ey + sy) >> 1;
                }
                ratio = py / ih;
                if (ratio === 0) {
                    return 1;
                } else {
                    return ratio;
                }
            };

            drawImageIOSFix = function(ctx, img, sx, sy, sw, sh, dx, dy, dw, dh) {
                var vertSquashRatio;
                vertSquashRatio = detectVerticalSquash(img);
                return ctx.drawImage(img, sx, sy, sw, sh, dx, dy, dw, dh / vertSquashRatio);
            };


            /*
             * contentloaded.js
             *
             * Author: Diego Perini (diego.perini at gmail.com)
             * Summary: cross-browser wrapper for DOMContentLoaded
             * Updated: 20101020
             * License: MIT
             * Version: 1.2
             *
             * URL:
             * http://javascript.nwbox.com/ContentLoaded/
             * http://javascript.nwbox.com/ContentLoaded/MIT-LICENSE
             */

            contentLoaded = function(win, fn) {
                var add, doc, done, init, poll, pre, rem, root, top;
                done = false;
                top = true;
                doc = win.document;
                root = doc.documentElement;
                add = (doc.addEventListener ? "addEventListener" : "attachEvent");
                rem = (doc.addEventListener ? "removeEventListener" : "detachEvent");
                pre = (doc.addEventListener ? "" : "on");
                init = function(e) {
                    if (e.type === "readystatechange" && doc.readyState !== "complete") {
                        return;
                    }
                    (e.type === "load" ? win : doc)[rem](pre + e.type, init, false);
                    if (!done && (done = true)) {
                        return fn.call(win, e.type || e);
                    }
                };
                poll = function() {
                    var e;
                    try {
                        root.doScroll("left");
                    } catch (_error) {
                        e = _error;
                        setTimeout(poll, 50);
                        return;
                    }
                    return init("poll");
                };
                if (doc.readyState !== "complete") {
                    if (doc.createEventObject && root.doScroll) {
                        try {
                            top = !win.frameElement;
                        } catch (_error) {}
                        if (top) {
                            poll();
                        }
                    }
                    doc[add](pre + "DOMContentLoaded", init, false);
                    doc[add](pre + "readystatechange", init, false);
                    return win[add](pre + "load", init, false);
                }
            };

            Dropzone._autoDiscoverFunction = function() {
                if (Dropzone.autoDiscover) {
                    return Dropzone.discover();
                }
            };

            contentLoaded(window, Dropzone._autoDiscoverFunction);

        }).call(this);

    });

    if (typeof exports == "object") {
        module.exports = require("dropzone");
    } else if (typeof define == "function" && define.amd) {
        define([], function(){ return require("dropzone"); });
    } else {
        this["Dropzone"] = require("dropzone");
    }
})()
;
!function(a){"function"==typeof define&&define.amd?define(["jquery","codemirror"],a):a(window.jQuery,window.CodeMirror)}(function(a,b){"function"!=typeof Array.prototype.reduce&&(Array.prototype.reduce=function(a,b){var c,d,e=this.length>>>0,f=!1;for(1<arguments.length&&(d=b,f=!0),c=0;e>c;++c)this.hasOwnProperty(c)&&(f?d=a(d,this[c],c,this):(d=this[c],f=!0));if(!f)throw new TypeError("Reduce of empty array with no initial value");return d});var c={bMac:navigator.appVersion.indexOf("Mac")>-1,bMSIE:navigator.userAgent.indexOf("MSIE")>-1||navigator.userAgent.indexOf("Trident")>-1,bFF:navigator.userAgent.indexOf("Firefox")>-1,jqueryVersion:parseFloat(a.fn.jquery),bCodeMirror:!!b},d=function(){var a=function(a){return function(b){return a===b}},b=function(a,b){return a===b},c=function(){return!0},d=function(){return!1},e=function(a){return function(){return!a.apply(a,arguments)}},f=function(a){return a};return{eq:a,eq2:b,ok:c,fail:d,not:e,self:f}}(),e=function(){var a=function(a){return a[0]},b=function(a){return a[a.length-1]},c=function(a){return a.slice(0,a.length-1)},e=function(a){return a.slice(1)},f=function(a,b){var c=a.indexOf(b);return-1===c?null:a[c+1]},g=function(a,b){var c=a.indexOf(b);return-1===c?null:a[c-1]},h=function(a,b){return b=b||d.self,a.reduce(function(a,c){return a+b(c)},0)},i=function(a){for(var b=[],c=-1,d=a.length;++c<d;)b[c]=a[c];return b},j=function(c,d){if(0===c.length)return[];var f=e(c);return f.reduce(function(a,c){var e=b(a);return d(b(e),c)?e[e.length]=c:a[a.length]=[c],a},[[a(c)]])},k=function(a){for(var b=[],c=0,d=a.length;d>c;c++)a[c]&&b.push(a[c]);return b};return{head:a,last:b,initial:c,tail:e,prev:g,next:f,sum:h,from:i,compact:k,clusterBy:j}}(),f=function(){var b=function(b){return b&&a(b).hasClass("note-editable")},g=function(b){return b&&a(b).hasClass("note-control-sizing")},h=function(a){var b=function(b){return function(){return a.find(b)}};return{editor:function(){return a},dropzone:b(".note-dropzone"),toolbar:b(".note-toolbar"),editable:b(".note-editable"),codable:b(".note-codable"),statusbar:b(".note-statusbar"),popover:b(".note-popover"),handle:b(".note-handle"),dialog:b(".note-dialog")}},i=function(a){return function(b){return b&&b.nodeName===a}},j=function(a){return a&&/^DIV|^P|^LI|^H[1-7]/.test(a.nodeName)},k=function(a){return a&&/^UL|^OL/.test(a.nodeName)},l=function(a){return a&&/^TD|^TH/.test(a.nodeName)},m=function(a,c){for(;a;){if(c(a))return a;if(b(a))break;a=a.parentNode}return null},n=function(a,b){b=b||d.fail;var c=[];return m(a,function(a){return c.push(a),b(a)}),c},o=function(b,c){for(var d=n(b),e=c;e;e=e.parentNode)if(a.inArray(e,d)>-1)return e;return null},p=function(a,b){var c=[],d=!1,e=!1;return function f(g){if(g){if(g===a&&(d=!0),d&&!e&&c.push(g),g===b)return void(e=!0);for(var h=0,i=g.childNodes.length;i>h;h++)f(g.childNodes[h])}}(o(a,b)),c},q=function(a,b){b=b||d.fail;for(var c=[];a&&(c.push(a),!b(a));)a=a.previousSibling;return c},r=function(a,b){b=b||d.fail;for(var c=[];a&&(c.push(a),!b(a));)a=a.nextSibling;return c},s=function(a,b){var c=[];return b=b||d.ok,function e(d){a!==d&&b(d)&&c.push(d);for(var f=0,g=d.childNodes.length;g>f;f++)e(d.childNodes[f])}(a),c},t=function(a,b){var c=b.nextSibling,d=b.parentNode;return c?d.insertBefore(a,c):d.appendChild(a),a},u=function(b,c){return a.each(c,function(a,c){b.appendChild(c)}),b},v=i("#text"),w=function(a){return v(a)?a.nodeValue.length:a.childNodes.length},x=function(a){for(var b=0;a=a.previousSibling;)b+=1;return b},y=function(b,c){var f=e.initial(n(c,d.eq(b)));return a.map(f,x).reverse()},z=function(a,b){for(var c=a,d=0,e=b.length;e>d;d++)c=c.childNodes[b[d]];return c},A=function(a,b){if(0===b)return a;if(b>=w(a))return a.nextSibling;if(v(a))return a.splitText(b);var c=a.childNodes[b];return a=t(a.cloneNode(!1),a),u(a,r(c))},B=function(a,b,c){var e=n(b,d.eq(a));return 1===e.length?A(b,c):e.reduce(function(a,d){var e=d.cloneNode(!1);return t(e,d),a===b&&(a=A(a,c)),u(e,r(a)),e})},C=function(a,b){if(a&&a.parentNode){if(a.removeNode)return a.removeNode(b);var c=a.parentNode;if(!b){var d,e,f=[];for(d=0,e=a.childNodes.length;e>d;d++)f.push(a.childNodes[d]);for(d=0,e=f.length;e>d;d++)c.insertBefore(f[d],a)}c.removeChild(a)}},D=function(a){return f.isTextarea(a[0])?a.val():a.html()};return{blank:c.bMSIE?"&nbsp;":"<br/>",emptyPara:"<p><br/></p>",isEditable:b,isControlSizing:g,buildLayoutInfo:h,isText:v,isPara:j,isList:k,isTable:i("TABLE"),isCell:l,isAnchor:i("A"),isDiv:i("DIV"),isLi:i("LI"),isSpan:i("SPAN"),isB:i("B"),isU:i("U"),isS:i("S"),isI:i("I"),isImg:i("IMG"),isTextarea:i("TEXTAREA"),ancestor:m,listAncestor:n,listNext:r,listPrev:q,listDescendant:s,commonAncestor:o,listBetween:p,insertAfter:t,position:x,makeOffsetPath:y,fromOffsetPath:z,split:B,remove:C,html:D}}(),g={version:"0.5.2",options:{width:null,height:null,focus:!1,tabsize:4,styleWithSpan:!0,disableLinkTarget:!1,disableDragAndDrop:!1,codemirror:null,lang:"en-US",direction:null,toolbar:[["style",["style"]],["font",["bold","italic","underline","clear"]],["fontname",["fontname"]],["color",["color"]],["para",["ul","ol","paragraph"]],["height",["height"]],["table",["table"]],["insert",["link","picture","video"]],["view",["fullscreen","codeview"]],["help",["help"]]],oninit:null,onfocus:null,onblur:null,onenter:null,onkeyup:null,onkeydown:null,onImageUpload:null,onImageUploadError:null,onToolbarClick:null,keyMap:{pc:{"CTRL+Z":"undo","CTRL+Y":"redo",TAB:"tab","SHIFT+TAB":"untab","CTRL+B":"bold","CTRL+I":"italic","CTRL+U":"underline","CTRL+SHIFT+S":"strikethrough","CTRL+BACKSLASH":"removeFormat","CTRL+SHIFT+L":"justifyLeft","CTRL+SHIFT+E":"justifyCenter","CTRL+SHIFT+R":"justifyRight","CTRL+SHIFT+J":"justifyFull","CTRL+SHIFT+NUM7":"insertUnorderedList","CTRL+SHIFT+NUM8":"insertOrderedList","CTRL+LEFTBRACKET":"outdent","CTRL+RIGHTBRACKET":"indent","CTRL+NUM0":"formatPara","CTRL+NUM1":"formatH1","CTRL+NUM2":"formatH2","CTRL+NUM3":"formatH3","CTRL+NUM4":"formatH4","CTRL+NUM5":"formatH5","CTRL+NUM6":"formatH6","CTRL+ENTER":"insertHorizontalRule"},mac:{"CMD+Z":"undo","CMD+SHIFT+Z":"redo",TAB:"tab","SHIFT+TAB":"untab","CMD+B":"bold","CMD+I":"italic","CMD+U":"underline","CMD+SHIFT+S":"strikethrough","CMD+BACKSLASH":"removeFormat","CMD+SHIFT+L":"justifyLeft","CMD+SHIFT+E":"justifyCenter","CMD+SHIFT+R":"justifyRight","CMD+SHIFT+J":"justifyFull","CMD+SHIFT+NUM7":"insertUnorderedList","CMD+SHIFT+NUM8":"insertOrderedList","CMD+LEFTBRACKET":"outdent","CMD+RIGHTBRACKET":"indent","CMD+NUM0":"formatPara","CMD+NUM1":"formatH1","CMD+NUM2":"formatH2","CMD+NUM3":"formatH3","CMD+NUM4":"formatH4","CMD+NUM5":"formatH5","CMD+NUM6":"formatH6","CMD+ENTER":"insertHorizontalRule"}}},lang:{"en-US":{font:{bold:"Bold",italic:"Italic",underline:"Underline",strike:"Strike",clear:"Remove Font Style",height:"Line Height",name:"Font Family",size:"Font Size"},image:{image:"Picture",insert:"Insert Image",resizeFull:"Resize Full",resizeHalf:"Resize Half",resizeQuarter:"Resize Quarter",floatLeft:"Float Left",floatRight:"Float Right",floatNone:"Float None",dragImageHere:"Drag an image here",selectFromFiles:"Select from files",url:"Image URL",remove:"Remove Image"},link:{link:"Link",insert:"Insert Link",unlink:"Unlink",edit:"Edit",textToDisplay:"Text to display",url:"To what URL should this link go?",openInNewWindow:"Open in new window"},video:{video:"Video",videoLink:"Video Link",insert:"Insert Video",url:"Video URL?",providers:"(YouTube, Vimeo, Vine, Instagram, or DailyMotion)"},table:{table:"Table"},hr:{insert:"Insert Horizontal Rule"},style:{style:"Style",normal:"Normal",blockquote:"Quote",pre:"Code",h1:"Header 1",h2:"Header 2",h3:"Header 3",h4:"Header 4",h5:"Header 5",h6:"Header 6"},lists:{unordered:"Unordered list",ordered:"Ordered list"},options:{help:"Help",fullscreen:"Full Screen",codeview:"Code View"},paragraph:{paragraph:"Paragraph",outdent:"Outdent",indent:"Indent",left:"Align left",center:"Align center",right:"Align right",justify:"Justify full"},color:{recent:"Recent Color",more:"More Color",background:"BackColor",foreground:"FontColor",transparent:"Transparent",setTransparent:"Set transparent",reset:"Reset",resetToDefault:"Reset to default"},shortcut:{shortcuts:"Keyboard shortcuts",close:"Close",textFormatting:"Text formatting",action:"Action",paragraphFormatting:"Paragraph formatting",documentStyle:"Document Style"},history:{undo:"Undo",redo:"Redo"}}}},h=function(){var b=function(b){return a.Deferred(function(c){a.extend(new FileReader,{onload:function(a){var b=a.target.result;c.resolve(b)},onerror:function(){c.reject(this)}}).readAsDataURL(b)}).promise()},c=function(b){return a.Deferred(function(c){a("<img>").one("load",function(){c.resolve(a(this))}).one("error abort",function(){c.reject(a(this))}).css({display:"none"}).appendTo(document.body).attr("src",b)}).promise()};return{readFileAsDataURL:b,createImage:c}}(),i={isEdit:function(a){return-1!==[8,9,13,32].indexOf(a)},nameFromCode:{8:"BACKSPACE",9:"TAB",13:"ENTER",32:"SPACE",48:"NUM0",49:"NUM1",50:"NUM2",51:"NUM3",52:"NUM4",53:"NUM5",54:"NUM6",55:"NUM7",56:"NUM8",66:"B",69:"E",73:"I",74:"J",75:"K",76:"L",82:"R",83:"S",85:"U",89:"Y",90:"Z",191:"SLASH",219:"LEFTBRACKET",220:"BACKSLASH",221:"RIGHTBRACKET"}},j=function(){var b=function(b,d){if(c.jqueryVersion<1.9){var e={};return a.each(d,function(a,c){e[c]=b.css(c)}),e}return b.css.call(b,d)};this.stylePara=function(b,c){a.each(b.nodes(f.isPara),function(b,d){a(d).css(c)})},this.current=function(c,d){var e=a(f.isText(c.sc)?c.sc.parentNode:c.sc),g=["font-family","font-size","text-align","list-style-type","line-height"],h=b(e,g)||{};if(h["font-size"]=parseInt(h["font-size"],10),h["font-bold"]=document.queryCommandState("bold")?"bold":"normal",h["font-italic"]=document.queryCommandState("italic")?"italic":"normal",h["font-underline"]=document.queryCommandState("underline")?"underline":"normal",h["font-strikethrough"]=document.queryCommandState("strikeThrough")?"strikethrough":"normal",c.isOnList()){var i=["circle","disc","disc-leading-zero","square"],j=a.inArray(h["list-style-type"],i)>-1;h["list-style"]=j?"unordered":"ordered"}else h["list-style"]="none";var k=f.ancestor(c.sc,f.isPara);if(k&&k.style["line-height"])h["line-height"]=k.style.lineHeight;else{var l=parseInt(h["line-height"],10)/parseInt(h["font-size"],10);h["line-height"]=l.toFixed(1)}return h.image=f.isImg(d)&&d,h.anchor=c.isOnAnchor()&&f.ancestor(c.sc,f.isAnchor),h.aAncestor=f.listAncestor(c.sc,f.isEditable),h}},k=function(){var b=!!document.createRange,c=function(a,b){var c,d,g=a.parentElement(),h=document.body.createTextRange(),i=e.from(g.childNodes);for(c=0;c<i.length;c++)if(!f.isText(i[c])){if(h.moveToElementText(i[c]),h.compareEndPoints("StartToStart",a)>=0)break;d=i[c]}if(0!==c&&f.isText(i[c-1])){var j=document.body.createTextRange(),k=null;j.moveToElementText(d||g),j.collapse(!d),k=d?d.nextSibling:g.firstChild;var l=a.duplicate();l.setEndPoint("StartToStart",j);for(var m=l.text.replace(/[\r\n]/g,"").length;m>k.nodeValue.length&&k.nextSibling;)m-=k.nodeValue.length,k=k.nextSibling;{k.nodeValue}b&&k.nextSibling&&f.isText(k.nextSibling)&&m===k.nodeValue.length&&(m-=k.nodeValue.length,k=k.nextSibling),g=k,c=m}return{cont:g,offset:c}},g=function(a){var b=function(a,c){var g,h;if(f.isText(a)){var i=f.listPrev(a,d.not(f.isText)),j=e.last(i).previousSibling;g=j||a.parentNode,c+=e.sum(e.tail(i),f.length),h=!j}else{if(g=a.childNodes[c]||a,f.isText(g))return b(g,c);c=0,h=!1}return{cont:g,collapseToStart:h,offset:c}},c=document.body.createTextRange(),g=b(a.cont,a.offset);return c.moveToElementText(g.cont),c.collapse(g.collapseToStart),c.moveStart("character",g.offset),c},h=function(c,h,i,j){this.sc=c,this.so=h,this.ec=i,this.eo=j;var k=function(){if(b){var a=document.createRange();return a.setStart(c,h),a.setEnd(i,j),a}var d=g({cont:c,offset:h});return d.setEndPoint("EndToEnd",g({cont:i,offset:j})),d};this.select=function(){var a=k();if(b){var c=document.getSelection();c.rangeCount>0&&c.removeAllRanges(),c.addRange(a)}else a.select()},this.nodes=function(b){var g=f.listBetween(c,i),h=e.compact(a.map(g,function(a){return f.ancestor(a,b)}));return a.map(e.clusterBy(h,d.eq2),e.head)},this.commonAncestor=function(){return f.commonAncestor(c,i)};var l=function(a){return function(){var b=f.ancestor(c,a);return!!b&&b===f.ancestor(i,a)}};this.isOnEditable=l(f.isEditable),this.isOnList=l(f.isList),this.isOnAnchor=l(f.isAnchor),this.isOnCell=l(f.isCell),this.isCollapsed=function(){return c===i&&h===j},this.insertNode=function(a){var c=k();b?c.insertNode(a):c.pasteHTML(a.outerHTML)},this.toString=function(){var a=k();return b?a.toString():a.text},this.bookmark=function(a){return{s:{path:f.makeOffsetPath(a,c),offset:h},e:{path:f.makeOffsetPath(a,i),offset:j}}}};return{create:function(a,d,e,f){if(0===arguments.length)if(b){var g=document.getSelection();if(0===g.rangeCount)return null;var i=g.getRangeAt(0);a=i.startContainer,d=i.startOffset,e=i.endContainer,f=i.endOffset}else{var j=document.selection.createRange(),k=j.duplicate();k.collapse(!1);var l=j;l.collapse(!0);var m=c(l,!0),n=c(k,!1);a=m.cont,d=m.offset,e=n.cont,f=n.offset}else 2===arguments.length&&(e=a,f=d);return new h(a,d,e,f)},createFromNode:function(a){return this.create(a,0,a,1)},createFromBookmark:function(a,b){var c=f.fromOffsetPath(a,b.s.path),d=b.s.offset,e=f.fromOffsetPath(a,b.e.path),g=b.e.offset;return new h(c,d,e,g)}}}(),l=function(){this.tab=function(a,b){var c=f.ancestor(a.commonAncestor(),f.isCell),d=f.ancestor(c,f.isTable),g=f.listDescendant(d,f.isCell),h=e[b?"prev":"next"](g,c);h&&k.create(h,0).select()},this.createTable=function(b,c){for(var d,e=[],g=0;b>g;g++)e.push("<td>"+f.blank+"</td>");d=e.join("");for(var h,i=[],j=0;c>j;j++)i.push("<tr>"+d+"</tr>");h=i.join("");var k='<table class="table table-bordered">'+h+"</table>";return a(k)[0]}},m=function(){var b=new j,d=new l;this.saveRange=function(a){a.data("range",k.create())},this.restoreRange=function(a){var b=a.data("range");b&&b.select()},this.currentStyle=function(a){var c=k.create();return c.isOnEditable()&&b.current(c,a)},this.undo=function(a){a.data("NoteHistory").undo(a)},this.redo=function(a){a.data("NoteHistory").redo(a)};for(var e=this.recordUndo=function(a){a.data("NoteHistory").recordUndo(a)},g=["bold","italic","underline","strikethrough","justifyLeft","justifyCenter","justifyRight","justifyFull","insertOrderedList","insertUnorderedList","indent","outdent","formatBlock","removeFormat","backColor","foreColor","insertHorizontalRule","fontName"],i=0,m=g.length;m>i;i++)this[g[i]]=function(a){return function(b,c){e(b),document.execCommand(a,!1,c)}}(g[i]);var n=function(b,c,d){e(b);var g=new Array(d+1).join("&nbsp;");c.insertNode(a('<span id="noteTab">'+g+"</span>")[0]);var h=a("#noteTab").removeAttr("id");c=k.create(h[0],1),c.select(),f.remove(h[0])};this.tab=function(a,b){var c=k.create();c.isCollapsed()&&c.isOnCell()?d.tab(c):n(a,c,b.tabsize)},this.untab=function(){var a=k.create();a.isCollapsed()&&a.isOnCell()&&d.tab(a,!0)},this.insertImage=function(a,b){h.createImage(b).then(function(b){e(a),b.css({display:"",width:Math.min(a.width(),b.width())}),k.create().insertNode(b[0])}).fail(function(){var b=a.data("callbacks");b.onImageUploadError&&b.onImageUploadError()})},this.insertVideo=function(b,c){e(b);var d,f=/^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/,g=c.match(f),h=/\/\/instagram.com\/p\/(.[a-zA-Z0-9]*)/,i=c.match(h),j=/\/\/vine.co\/v\/(.[a-zA-Z0-9]*)/,l=c.match(j),m=/\/\/(player.)?vimeo.com\/([a-z]*\/)*([0-9]{6,11})[?]?.*/,n=c.match(m),o=/.+dailymotion.com\/(video|hub)\/([^_]+)[^#]*(#video=([^_&]+))?/,p=c.match(o);if(g&&11===g[2].length){var q=g[2];d=a("<iframe>").attr("src","//www.youtube.com/embed/"+q).attr("width","640").attr("height","360")}else i&&i[0].length>0?d=a("<iframe>").attr("src",i[0]+"/embed/").attr("width","612").attr("height","710").attr("scrolling","no").attr("allowtransparency","true"):l&&l[0].length>0?d=a("<iframe>").attr("src",l[0]+"/embed/simple").attr("width","600").attr("height","600").attr("class","vine-embed"):n&&n[3].length>0?d=a("<iframe webkitallowfullscreen mozallowfullscreen allowfullscreen>").attr("src","//player.vimeo.com/video/"+n[3]).attr("width","640").attr("height","360"):p&&p[2].length>0&&(d=a("<iframe>").attr("src","//www.dailymotion.com/embed/video/"+p[2]).attr("width","640").attr("height","360"));d&&(d.attr("frameborder",0),k.create().insertNode(d[0]))},this.formatBlock=function(a,b){e(a),b=c.bMSIE?"<"+b+">":b,document.execCommand("FormatBlock",!1,b)},this.formatPara=function(a){this.formatBlock(a,"P")};for(var i=1;6>=i;i++)this["formatH"+i]=function(a){return function(b){this.formatBlock(b,"H"+a)}}(i);this.fontSize=function(a,b){e(a),document.execCommand("fontSize",!1,3),c.bFF?a.find("font[size=3]").removeAttr("size").css("font-size",b+"px"):a.find("span").filter(function(){return"medium"===this.style.fontSize}).css("font-size",b+"px")},this.lineHeight=function(a,c){e(a),b.stylePara(k.create(),{lineHeight:c})},this.unlink=function(a){var b=k.create();if(b.isOnAnchor()){e(a);var c=f.ancestor(b.sc,f.isAnchor);b=k.createFromNode(c),b.select(),document.execCommand("unlink")}},this.createLink=function(b,d,g){var h=k.create();e(b);var i=d;if(-1!==d.indexOf("@")&&-1===d.indexOf(":")?i="mailto:"+d:-1===d.indexOf("://")&&(i="http://"+d),(c.bMSIE||c.bFF)&&h.isCollapsed()){h.insertNode(a('<A id="linkAnchor">'+d+"</A>")[0]);var j=a("#linkAnchor").attr("href",i).removeAttr("id");h=k.createFromNode(j[0]),h.select()}else document.execCommand("createlink",!1,i),h=k.create();a.each(h.nodes(f.isAnchor),function(b,c){g?a(c).attr("target","_blank"):a(c).removeAttr("target")})},this.getLinkInfo=function(){var b=k.create(),c=!0,d="";if(b.isOnAnchor()){var e=f.ancestor(b.sc,f.isAnchor);b=k.createFromNode(e),c="_blank"===a(e).attr("target"),d=e.href}return{text:b.toString(),url:d,newWindow:c}},this.getVideoInfo=function(){var a=k.create();if(a.isOnAnchor()){var b=f.ancestor(a.sc,f.isAnchor);a=k.createFromNode(b)}return{text:a.toString()}},this.color=function(a,b){var c=JSON.parse(b),d=c.foreColor,f=c.backColor;e(a),d&&document.execCommand("foreColor",!1,d),f&&document.execCommand("backColor",!1,f)},this.insertTable=function(a,b){e(a);var c=b.split("x");k.create().insertNode(d.createTable(c[0],c[1]))},this.floatMe=function(a,b,c){e(a),c.css("float",b)},this.resize=function(a,b,c){e(a),c.css({width:a.width()*b+"px",height:""})},this.resizeTo=function(a,b,c){var d;if(c){var e=a.y/a.x,f=b.data("ratio");d={width:f>e?a.x:a.y/f,height:f>e?a.x*f:a.y}}else d={width:a.x,height:a.y};b.css(d)},this.removeMedia=function(a,b,c){e(a),c.detach()}},n=function(){var a=[],b=[],c=function(a){var b=a[0],c=k.create();return{contents:a.html(),bookmark:c.bookmark(b),scrollTop:a.scrollTop()}},d=function(a,b){a.html(b.contents).scrollTop(b.scrollTop),k.createFromBookmark(a[0],b.bookmark).select()};this.undo=function(e){var f=c(e);0!==a.length&&(d(e,a.pop()),b.push(f))},this.redo=function(e){var f=c(e);0!==b.length&&(d(e,b.pop()),a.push(f))},this.recordUndo=function(d){b=[],a.push(c(d))}},o=function(){this.update=function(b,c){var d=function(b,c){b.find(".dropdown-menu li a").each(function(){var b=a(this).data("value")+""==c+"";this.className=b?"checked":""})},f=function(a,c){var d=b.find(a);d.toggleClass("active",c())},g=b.find(".note-fontname");if(g.length>0){var h=c["font-family"];h&&(h=e.head(h.split(",")),h=h.replace(/\'/g,""),g.find(".note-current-fontname").text(h),d(g,h))}var i=b.find(".note-fontsize");i.find(".note-current-fontsize").text(c["font-size"]),d(i,parseFloat(c["font-size"]));var j=b.find(".note-height");d(j,parseFloat(c["line-height"])),f('button[data-event="bold"]',function(){return"bold"===c["font-bold"]}),f('button[data-event="italic"]',function(){return"italic"===c["font-italic"]}),f('button[data-event="underline"]',function(){return"underline"===c["font-underline"]}),f('button[data-event="strikethrough"]',function(){return"strikethrough"===c["font-strikethrough"]}),f('button[data-event="justifyLeft"]',function(){return"left"===c["text-align"]||"start"===c["text-align"]}),f('button[data-event="justifyCenter"]',function(){return"center"===c["text-align"]}),f('button[data-event="justifyRight"]',function(){return"right"===c["text-align"]}),f('button[data-event="justifyFull"]',function(){return"justify"===c["text-align"]}),f('button[data-event="insertUnorderedList"]',function(){return"unordered"===c["list-style"]}),f('button[data-event="insertOrderedList"]',function(){return"ordered"===c["list-style"]})},this.updateRecentColor=function(b,c,d){var e=a(b).closest(".note-color"),f=e.find(".note-recent-color"),g=JSON.parse(f.attr("data-value"));g[c]=d,f.attr("data-value",JSON.stringify(g));var h="backColor"===c?"background-color":"color";f.find("i").css(h,d)},this.updateFullscreen=function(a,b){var c=a.find('button[data-event="fullscreen"]');c.toggleClass("active",b)},this.updateCodeview=function(a,b){var c=a.find('button[data-event="codeview"]');c.toggleClass("active",b)},this.activate=function(a){a.find("button").not('button[data-event="codeview"]').removeClass("disabled")},this.deactivate=function(a){a.find("button").not('button[data-event="codeview"]').addClass("disabled")}},p=function(){var b=function(b,c){var d=a(c),e=d.position(),f=d.height();b.css({display:"block",left:e.left,top:e.top+f})};this.update=function(a,c){var d=a.find(".note-link-popover");if(c.anchor){var e=d.find("a");e.attr("href",c.anchor.href).html(c.anchor.href),b(d,c.anchor)}else d.hide();var f=a.find(".note-image-popover");c.image?b(f,c.image):f.hide()},this.hide=function(a){a.children().hide()}},q=function(){this.update=function(b,c){var d=b.find(".note-control-selection");if(c.image){var e=a(c.image),f=e.position(),g={w:e.width(),h:e.height()};d.css({display:"block",left:f.left,top:f.top,width:g.w,height:g.h}).data("target",c.image);var h=g.w+"x"+g.h;d.find(".note-control-selection-info").text(h)}else d.hide()},this.hide=function(a){a.children().hide()}},r=function(){var b=function(a,b){a.toggleClass("disabled",!b),a.attr("disabled",!b)};this.showImageDialog=function(c,d){return a.Deferred(function(a){var e=d.find(".note-image-dialog"),f=d.find(".note-image-input"),g=d.find(".note-image-url"),h=d.find(".note-image-btn");e.one("shown.bs.modal",function(){f.replaceWith(f.clone().on("change",function(){e.modal("hide"),a.resolve(this.files)})),h.click(function(b){b.preventDefault(),e.modal("hide"),a.resolve(g.val())}),g.keyup(function(){b(h,g.val())}).val("").focus()}).one("hidden.bs.modal",function(){c.focus(),f.off("change"),g.off("keyup"),h.off("click")}).modal("show")})},this.showVideoDialog=function(c,d,e){return a.Deferred(function(a){var f=d.find(".note-video-dialog"),g=f.find(".note-video-url"),h=f.find(".note-video-btn");f.one("shown.bs.modal",function(){g.val(e.text).keyup(function(){b(h,g.val())}).trigger("keyup").trigger("focus"),h.click(function(b){b.preventDefault(),f.modal("hide"),a.resolve(g.val())})}).one("hidden.bs.modal",function(){c.focus(),g.off("keyup"),h.off("click")}).modal("show")})},this.showLinkDialog=function(c,d,e){return a.Deferred(function(a){var f=d.find(".note-link-dialog"),g=f.find(".note-link-text"),h=f.find(".note-link-url"),i=f.find(".note-link-btn"),j=f.find("input[type=checkbox]");f.one("shown.bs.modal",function(){g.val(e.text),h.keyup(function(){b(i,h.val()),e.text||g.val(h.val())}).val(e.url).trigger("focus"),j.prop("checked",e.newWindow),i.one("click",function(b){b.preventDefault(),f.modal("hide"),a.resolve(h.val(),j.is(":checked"))})}).one("hidden.bs.modal",function(){c.focus(),h.off("keyup")}).modal("show")}).promise()},this.showHelpDialog=function(a,b){var c=b.find(".note-help-dialog");c.one("hidden.bs.modal",function(){a.focus()}).modal("show")}},s=function(){var d=new m,g=new o,j=new p,k=new q,l=new r,s=function(b){var c=a(b).closest(".note-editor");return c.length>0&&f.buildLayoutInfo(c)},t=function(b,c){d.restoreRange(b);var e=b.data("callbacks");e.onImageUpload?e.onImageUpload(c,d,b):a.each(c,function(a,c){h.readFileAsDataURL(c).then(function(a){d.insertImage(b,a)}).fail(function(){e.onImageUploadError&&e.onImageUploadError()})})},u=function(a){f.isImg(a.target)&&a.preventDefault()},v=function(a){var b=s(a.currentTarget||a.target),c=d.currentStyle(a.target);c&&(g.update(b.toolbar(),c),j.update(b.popover(),c),k.update(b.handle(),c))},w=function(a){var b=s(a.currentTarget||a.target);j.hide(b.popover()),k.hide(b.handle())},x=function(a){var b=a.originalEvent;if(b.clipboardData&&b.clipboardData.items&&b.clipboardData.items.length){var c=s(a.currentTarget||a.target),d=e.head(b.clipboardData.items),f="file"===d.kind&&-1!==d.type.indexOf("image/");f&&t(c.editable(),[d.getAsFile()])}},y=function(b){if(f.isControlSizing(b.target)){var c=s(b.target),e=c.handle(),g=c.popover(),h=c.editable(),i=c.editor(),l=e.find(".note-control-selection").data("target"),m=a(l),n=m.offset(),o=a(document).scrollTop();i.on("mousemove",function(a){d.resizeTo({x:a.clientX-n.left,y:a.clientY-(n.top-o)},m,!a.shiftKey),k.update(e,{image:l}),j.update(g,{image:l})}).one("mouseup",function(){i.off("mousemove")}),m.data("ratio")||m.data("ratio",m.height()/m.width()),d.recordUndo(h),b.stopPropagation(),b.preventDefault()}},z=function(b){var c=a(b.target).closest("[data-event]");c.length>0&&b.preventDefault()},A=function(e){var h=a(e.target).closest("[data-event]");if(h.length>0){var i,j,k,m=h.attr("data-event"),n=h.attr("data-value"),o=s(e.target),p=o.editor(),q=o.toolbar(),r=o.dialog(),u=o.editable(),w=o.codable(),x=p.data("options");if(-1!==a.inArray(m,["resize","floatMe","removeMedia"])){var y=o.handle(),z=y.find(".note-control-selection");k=a(z.data("target"))}if(d[m]&&(u.trigger("focus"),d[m](u,n,k)),-1!==a.inArray(m,["backColor","foreColor"]))g.updateRecentColor(h[0],m,n);else if("showLinkDialog"===m){u.focus();var A=d.getLinkInfo();d.saveRange(u),l.showLinkDialog(u,r,A).then(function(a,b){d.restoreRange(u),d.createLink(u,a,b)})}else if("showImageDialog"===m)u.focus(),l.showImageDialog(u,r).then(function(a){"string"==typeof a?(d.restoreRange(u),d.insertImage(u,a)):t(u,a)});else if("showVideoDialog"===m){u.focus();var B=d.getVideoInfo();d.saveRange(u),l.showVideoDialog(u,r,B).then(function(a){d.restoreRange(u),d.insertVideo(u,a)})}else if("showHelpDialog"===m)l.showHelpDialog(u,r);else if("fullscreen"===m){var C=a("html, body"),D=function(a){p.css("width",a.w),u.css("height",a.h),w.css("height",a.h),w.data("cmEditor")&&w.data("cmEditor").setSize(null,a.h)};p.toggleClass("fullscreen");var E=p.hasClass("fullscreen");E?(u.data("orgHeight",u.css("height")),a(window).on("resize",function(){D({w:a(window).width(),h:a(window).height()-q.outerHeight()})}).trigger("resize"),C.css("overflow","hidden")):(a(window).off("resize"),D({w:x.width||"",h:u.data("orgHeight")}),C.css("overflow","auto")),g.updateFullscreen(q,E)}else if("codeview"===m){p.toggleClass("codeview");var F=p.hasClass("codeview");if(F){if(w.val(u.html()),w.height(u.height()),g.deactivate(q),w.focus(),c.bCodeMirror){j=b.fromTextArea(w[0],a.extend({mode:"text/html",lineNumbers:!0},x.codemirror));var G=p.data("options").codemirror.tern||!1;G&&(i=new b.TernServer(G),j.ternServer=i,j.on("cursorActivity",function(a){i.updateArgHints(a)})),j.setSize(null,u.outerHeight()),j.autoFormatRange&&j.autoFormatRange({line:0,ch:0},{line:j.lineCount(),ch:j.getTextArea().value.length}),w.data("cmEditor",j)}}else c.bCodeMirror&&(j=w.data("cmEditor"),w.val(j.getValue()),j.toTextArea()),u.html(w.val()||f.emptyPara),u.height(x.height?w.height():"auto"),g.activate(q),u.focus();g.updateCodeview(o.toolbar(),F)}v(e)}},B=24,C=function(b){var c=a(document),d=s(b.target).editable(),e=d.offset().top-c.scrollTop();c.on("mousemove",function(a){var b=a.clientY-(e+B);d.height(b)}).one("mouseup",function(){c.off("mousemove")}),b.stopPropagation(),b.preventDefault()},D=18,E=function(b){var c,d=a(b.target.parentNode),e=d.next(),f=d.find(".note-dimension-picker-mousecatcher"),g=d.find(".note-dimension-picker-highlighted"),h=d.find(".note-dimension-picker-unhighlighted");if(void 0===b.offsetX){var i=a(b.target).offset();c={x:b.pageX-i.left,y:b.pageY-i.top}}else c={x:b.offsetX,y:b.offsetY};var j={c:Math.ceil(c.x/D)||1,r:Math.ceil(c.y/D)||1};g.css({width:j.c+"em",height:j.r+"em"}),f.attr("data-value",j.c+"x"+j.r),3<j.c&&j.c<10&&h.css({width:j.c+1+"em"}),3<j.r&&j.r<10&&h.css({height:j.r+1+"em"}),e.html(j.c+" x "+j.r)},F=function(b){var c=a(),d=b.dropzone,e=b.dropzone.find(".note-dropzone-message");a(document).on("dragenter",function(a){var f=b.editor.hasClass("codeview");f||0!==c.length||(b.editor.addClass("dragover"),d.width(b.editor.width()),d.height(b.editor.height()),e.text("Drag Image Here")),c=c.add(a.target)}).on("dragleave",function(a){c=c.not(a.target),0===c.length&&b.editor.removeClass("dragover")}).on("drop",function(){c=a(),b.editor.removeClass("dragover")}),d.on("dragenter",function(){d.addClass("hover"),e.text("Drop Image")}).on("dragleave",function(){d.removeClass("hover"),e.text("Drag Image Here")}),d.on("drop",function(a){var b=a.originalEvent.dataTransfer;if(b&&b.files){var c=s(a.currentTarget||a.target);c.editable().focus(),t(c.editable(),b.files)}a.preventDefault()}).on("dragover",!1)};this.bindKeyMap=function(a,b){var c=a.editor,e=a.editable;e.on("keydown",function(a){var f=[];a.metaKey&&f.push("CMD"),a.ctrlKey&&f.push("CTRL"),a.shiftKey&&f.push("SHIFT");var g=i.nameFromCode[a.keyCode];g&&f.push(g);var h=b[f.join("+")];h?(a.preventDefault(),d[h](e,c.data("options"))):i.isEdit(a.keyCode)&&d.recordUndo(e)})},this.attach=function(a,b){this.bindKeyMap(a,b.keyMap[c.bMac?"mac":"pc"]),a.editable.on("mousedown",u),a.editable.on("keyup mouseup",v),a.editable.on("scroll",w),a.editable.on("paste",x),b.disableDragAndDrop||F(a),a.handle.on("mousedown",y),a.toolbar.on("click",A),a.popover.on("click",A),a.toolbar.on("mousedown",z),a.popover.on("mousedown",z),a.statusbar.on("mousedown",C);var e=a.toolbar,f=e.find(".note-dimension-picker-mousecatcher");if(f.on("mousemove",E),a.editable.on("blur",function(){d.saveRange(a.editable)}),a.editor.data("options",b),b.styleWithSpan&&!c.bMSIE&&setTimeout(function(){document.execCommand("styleWithCSS",0,!0)}),a.editable.data("NoteHistory",new n),b.onenter&&a.editable.keypress(function(a){a.keyCode===i.ENTER&&b.onenter(a)}),b.onfocus&&a.editable.focus(b.onfocus),b.onblur&&a.editable.blur(b.onblur),b.onkeyup&&a.editable.keyup(b.onkeyup),b.onkeydown&&a.editable.keydown(b.onkeydown),b.onpaste&&a.editable.on("paste",b.onpaste),b.onToolbarClick&&a.toolbar.click(b.onToolbarClick),b.onChange){var g=function(){b.onChange(a.editable,a.editable.html())};c.bMSIE?a.editable.on("DOMCharacterDataModified, DOMSubtreeModified, DOMNodeInserted",g):a.editable.on("input",g)}a.editable.data("callbacks",{onAutoSave:b.onAutoSave,onImageUpload:b.onImageUpload,onImageUploadError:b.onImageUploadError,onFileUpload:b.onFileUpload,onFileUploadError:b.onFileUpload})},this.dettach=function(a){a.editable.off(),a.toolbar.off(),a.handle.off(),a.popover.off()}},t=function(){var b,d,e,g,h;b={picture:function(a){return'<button type="button" class="btn btn-default btn-sm btn-small" title="'+a.image.image+'" data-event="showImageDialog" tabindex="-1"><i class="fa fa-picture-o icon-picture"></i></button>'},link:function(a){return'<button type="button" class="btn btn-default btn-sm btn-small" title="'+a.link.link+'" data-event="showLinkDialog" tabindex="-1"><i class="fa fa-link icon-link"></i></button>'},video:function(a){return'<button type="button" class="btn btn-default btn-sm btn-small" title="'+a.video.video+'" data-event="showVideoDialog" tabindex="-1"><i class="fa fa-youtube-play icon-play"></i></button>'},table:function(a){return'<button type="button" class="btn btn-default btn-sm btn-small dropdown-toggle" title="'+a.table.table+'" data-toggle="dropdown" tabindex="-1"><i class="fa fa-table icon-table"></i> <span class="caret"></span></button><ul class="dropdown-menu"><div class="note-dimension-picker"><div class="note-dimension-picker-mousecatcher" data-event="insertTable" data-value="1x1"></div><div class="note-dimension-picker-highlighted"></div><div class="note-dimension-picker-unhighlighted"></div></div><div class="note-dimension-display"> 1 x 1 </div></ul>'
},style:function(a){return'<button type="button" class="btn btn-default btn-sm btn-small dropdown-toggle" title="'+a.style.style+'" data-toggle="dropdown" tabindex="-1"><i class="fa fa-magic icon-magic"></i> <span class="caret"></span></button><ul class="dropdown-menu"><li><a data-event="formatBlock" data-value="p">'+a.style.normal+'</a></li><li><a data-event="formatBlock" data-value="blockquote"><blockquote>'+a.style.blockquote+'</blockquote></a></li><li><a data-event="formatBlock" data-value="pre">'+a.style.pre+'</a></li><li><a data-event="formatBlock" data-value="h1"><h1>'+a.style.h1+'</h1></a></li><li><a data-event="formatBlock" data-value="h2"><h2>'+a.style.h2+'</h2></a></li><li><a data-event="formatBlock" data-value="h3"><h3>'+a.style.h3+'</h3></a></li><li><a data-event="formatBlock" data-value="h4"><h4>'+a.style.h4+'</h4></a></li><li><a data-event="formatBlock" data-value="h5"><h5>'+a.style.h5+'</h5></a></li><li><a data-event="formatBlock" data-value="h6"><h6>'+a.style.h6+"</h6></a></li></ul>"},fontname:function(a){var b=["Serif","Sans","Arial","Arial Black","Courier","Courier New","Comic Sans MS","Helvetica","Impact","Lucida Grande","Lucida Sans","Tahoma","Times","Times New Roman","Verdana"],c='<button type="button" class="btn btn-default btn-sm btn-small dropdown-toggle" data-toggle="dropdown" title="'+a.font.name+'" tabindex="-1"><span class="note-current-fontname">Arial</span> <b class="caret"></b></button>';c+='<ul class="dropdown-menu">';for(var d=0;d<b.length;d++)c+='<li><a data-event="fontName" data-value="'+b[d]+'"><i class="fa fa-check icon-ok"></i> '+b[d]+"</a></li>";return c+="</ul>"},fontsize:function(a){return'<button type="button" class="btn btn-default btn-sm btn-small dropdown-toggle" data-toggle="dropdown" title="'+a.font.size+'" tabindex="-1"><span class="note-current-fontsize">11</span> <b class="caret"></b></button><ul class="dropdown-menu"><li><a data-event="fontSize" data-value="8"><i class="fa fa-check icon-ok"></i> 8</a></li><li><a data-event="fontSize" data-value="9"><i class="fa fa-check icon-ok"></i> 9</a></li><li><a data-event="fontSize" data-value="10"><i class="fa fa-check icon-ok"></i> 10</a></li><li><a data-event="fontSize" data-value="11"><i class="fa fa-check icon-ok"></i> 11</a></li><li><a data-event="fontSize" data-value="12"><i class="fa fa-check icon-ok"></i> 12</a></li><li><a data-event="fontSize" data-value="14"><i class="fa fa-check icon-ok"></i> 14</a></li><li><a data-event="fontSize" data-value="18"><i class="fa fa-check icon-ok"></i> 18</a></li><li><a data-event="fontSize" data-value="24"><i class="fa fa-check icon-ok"></i> 24</a></li><li><a data-event="fontSize" data-value="36"><i class="fa fa-check icon-ok"></i> 36</a></li></ul>'},color:function(a){return'<button type="button" class="btn btn-default btn-sm btn-small note-recent-color" title="'+a.color.recent+'" data-event="color" data-value=\'{"backColor":"yellow"}\' tabindex="-1"><i class="fa fa-font icon-font" style="color:black;background-color:yellow;"></i></button><button type="button" class="btn btn-default btn-sm btn-small dropdown-toggle" title="'+a.color.more+'" data-toggle="dropdown" tabindex="-1"><span class="caret"></span></button><ul class="dropdown-menu"><li><div class="btn-group"><div class="note-palette-title">'+a.color.background+'</div><div class="note-color-reset" data-event="backColor" data-value="inherit" title="'+a.color.transparent+'">'+a.color.setTransparent+'</div><div class="note-color-palette" data-target-event="backColor"></div></div><div class="btn-group"><div class="note-palette-title">'+a.color.foreground+'</div><div class="note-color-reset" data-event="foreColor" data-value="inherit" title="'+a.color.reset+'">'+a.color.resetToDefault+'</div><div class="note-color-palette" data-target-event="foreColor"></div></div></li></ul>'},bold:function(a){return'<button type="button" class="btn btn-default btn-sm btn-small" title="'+a.font.bold+'" data-shortcut="Ctrl+B" data-mac-shortcut="⌘+B" data-event="bold" tabindex="-1"><i class="fa fa-bold icon-bold"></i></button>'},italic:function(a){return'<button type="button" class="btn btn-default btn-sm btn-small" title="'+a.font.italic+'" data-shortcut="Ctrl+I" data-mac-shortcut="⌘+I" data-event="italic" tabindex="-1"><i class="fa fa-italic icon-italic"></i></button>'},underline:function(a){return'<button type="button" class="btn btn-default btn-sm btn-small" title="'+a.font.underline+'" data-shortcut="Ctrl+U" data-mac-shortcut="⌘+U" data-event="underline" tabindex="-1"><i class="fa fa-underline icon-underline"></i></button>'},strike:function(a){return'<button type="button" class="btn btn-default btn-sm btn-small" title="'+a.font.strike+'" data-event="strikethrough" tabindex="-1"><i class="fa fa-strikethrough icon-strikethrough"></i></button>'},clear:function(a){return'<button type="button" class="btn btn-default btn-sm btn-small" title="'+a.font.clear+'" data-shortcut="Ctrl+\\" data-mac-shortcut="⌘+\\" data-event="removeFormat" tabindex="-1"><i class="fa fa-eraser icon-eraser"></i></button>'},ul:function(a){return'<button type="button" class="btn btn-default btn-sm btn-small" title="'+a.lists.unordered+'" data-shortcut="Ctrl+Shift+8" data-mac-shortcut="⌘+⇧+7" data-event="insertUnorderedList" tabindex="-1"><i class="fa fa-list-ul icon-list-ul"></i></button>'},ol:function(a){return'<button type="button" class="btn btn-default btn-sm btn-small" title="'+a.lists.ordered+'" data-shortcut="Ctrl+Shift+7" data-mac-shortcut="⌘+⇧+8" data-event="insertOrderedList" tabindex="-1"><i class="fa fa-list-ol icon-list-ol"></i></button>'},paragraph:function(a){return'<button type="button" class="btn btn-default btn-sm btn-small dropdown-toggle" title="'+a.paragraph.paragraph+'" data-toggle="dropdown" tabindex="-1"><i class="fa fa-align-left icon-align-left"></i>  <span class="caret"></span></button><div class="dropdown-menu"><div class="note-align btn-group"><button type="button" class="btn btn-default btn-sm btn-small" title="'+a.paragraph.left+'" data-shortcut="Ctrl+Shift+L" data-mac-shortcut="⌘+⇧+L" data-event="justifyLeft" tabindex="-1"><i class="fa fa-align-left icon-align-left"></i></button><button type="button" class="btn btn-default btn-sm btn-small" title="'+a.paragraph.center+'" data-shortcut="Ctrl+Shift+E" data-mac-shortcut="⌘+⇧+E" data-event="justifyCenter" tabindex="-1"><i class="fa fa-align-center icon-align-center"></i></button><button type="button" class="btn btn-default btn-sm btn-small" title="'+a.paragraph.right+'" data-shortcut="Ctrl+Shift+R" data-mac-shortcut="⌘+⇧+R" data-event="justifyRight" tabindex="-1"><i class="fa fa-align-right icon-align-right"></i></button><button type="button" class="btn btn-default btn-sm btn-small" title="'+a.paragraph.justify+'" data-shortcut="Ctrl+Shift+J" data-mac-shortcut="⌘+⇧+J" data-event="justifyFull" tabindex="-1"><i class="fa fa-align-justify icon-align-justify"></i></button></div><div class="note-list btn-group"><button type="button" class="btn btn-default btn-sm btn-small" title="'+a.paragraph.outdent+'" data-shortcut="Ctrl+[" data-mac-shortcut="⌘+[" data-event="outdent" tabindex="-1"><i class="fa fa-outdent icon-indent-left"></i></button><button type="button" class="btn btn-default btn-sm btn-small" title="'+a.paragraph.indent+'" data-shortcut="Ctrl+]" data-mac-shortcut="⌘+]" data-event="indent" tabindex="-1"><i class="fa fa-indent icon-indent-right"></i></button></div></div>'},height:function(a){return'<button type="button" class="btn btn-default btn-sm btn-small dropdown-toggle" data-toggle="dropdown" title="'+a.font.height+'" tabindex="-1"><i class="fa fa-text-height icon-text-height"></i>&nbsp; <b class="caret"></b></button><ul class="dropdown-menu"><li><a data-event="lineHeight" data-value="1.0"><i class="fa fa-check icon-ok"></i> 1.0</a></li><li><a data-event="lineHeight" data-value="1.2"><i class="fa fa-check icon-ok"></i> 1.2</a></li><li><a data-event="lineHeight" data-value="1.4"><i class="fa fa-check icon-ok"></i> 1.4</a></li><li><a data-event="lineHeight" data-value="1.5"><i class="fa fa-check icon-ok"></i> 1.5</a></li><li><a data-event="lineHeight" data-value="1.6"><i class="fa fa-check icon-ok"></i> 1.6</a></li><li><a data-event="lineHeight" data-value="1.8"><i class="fa fa-check icon-ok"></i> 1.8</a></li><li><a data-event="lineHeight" data-value="2.0"><i class="fa fa-check icon-ok"></i> 2.0</a></li><li><a data-event="lineHeight" data-value="3.0"><i class="fa fa-check icon-ok"></i> 3.0</a></li></ul>'},help:function(a){return'<button type="button" class="btn btn-default btn-sm btn-small" title="'+a.options.help+'" data-event="showHelpDialog" tabindex="-1"><i class="fa fa-question icon-question"></i></button>'},fullscreen:function(a){return'<button type="button" class="btn btn-default btn-sm btn-small" title="'+a.options.fullscreen+'" data-event="fullscreen" tabindex="-1"><i class="fa fa-arrows-alt icon-fullscreen"></i></button>'},codeview:function(a){return'<button type="button" class="btn btn-default btn-sm btn-small" title="'+a.options.codeview+'" data-event="codeview" tabindex="-1"><i class="fa fa-code icon-code"></i></button>'},undo:function(a){return'<button type="button" class="btn btn-default btn-sm btn-small" title="'+a.history.undo+'" data-event="undo" tabindex="-1"><i class="fa fa-undo icon-undo"></i></button>'},redo:function(a){return'<button type="button" class="btn btn-default btn-sm btn-small" title="'+a.history.redo+'" data-event="redo" tabindex="-1"><i class="fa fa-repeat icon-repeat"></i></button>'}},d=function(a){return'<div class="note-popover"><div class="note-link-popover popover bottom in" style="display: none;"><div class="arrow"></div><div class="popover-content note-link-content"><a href="http://www.google.com" target="_blank">www.google.com</a>&nbsp;&nbsp;<div class="note-insert btn-group"><button type="button" class="btn btn-default btn-sm btn-small" title="'+a.link.edit+'" data-event="showLinkDialog" tabindex="-1"><i class="fa fa-edit icon-edit"></i></button><button type="button" class="btn btn-default btn-sm btn-small" title="'+a.link.unlink+'" data-event="unlink" tabindex="-1"><i class="fa fa-unlink icon-unlink"></i></button></div></div></div><div class="note-image-popover popover bottom in" style="display: none;"><div class="arrow"></div><div class="popover-content note-image-content"><div class="btn-group"><button type="button" class="btn btn-default btn-sm btn-small" title="'+a.image.resizeFull+'" data-event="resize" data-value="1" tabindex="-1"><span class="note-fontsize-10">100%</span> </button><button type="button" class="btn btn-default btn-sm btn-small" title="'+a.image.resizeHalf+'" data-event="resize" data-value="0.5" tabindex="-1"><span class="note-fontsize-10">50%</span> </button><button type="button" class="btn btn-default btn-sm btn-small" title="'+a.image.resizeQuarter+'" data-event="resize" data-value="0.25" tabindex="-1"><span class="note-fontsize-10">25%</span> </button></div><div class="btn-group"><button type="button" class="btn btn-default btn-sm btn-small" title="'+a.image.floatLeft+'" data-event="floatMe" data-value="left" tabindex="-1"><i class="fa fa-align-left icon-align-left"></i></button><button type="button" class="btn btn-default btn-sm btn-small" title="'+a.image.floatRight+'" data-event="floatMe" data-value="right" tabindex="-1"><i class="fa fa-align-right icon-align-right"></i></button><button type="button" class="btn btn-default btn-sm btn-small" title="'+a.image.floatNone+'" data-event="floatMe" data-value="none" tabindex="-1"><i class="fa fa-align-justify icon-align-justify"></i></button></div><div class="btn-group"><button type="button" class="btn btn-default btn-sm btn-small" title="'+a.image.remove+'" data-event="removeMedia" data-value="none" tabindex="-1"><i class="fa fa-trash-o icon-trash"></i></button></div></div></div></div>'};var e=function(){return'<div class="note-handle"><div class="note-control-selection"><div class="note-control-selection-bg"></div><div class="note-control-holder note-control-nw"></div><div class="note-control-holder note-control-ne"></div><div class="note-control-holder note-control-sw"></div><div class="note-control-sizing note-control-se"></div><div class="note-control-selection-info"></div></div></div>'},i=function(a){return'<table class="note-shortcut"><thead><tr><th></th><th>'+a.shortcut.textFormatting+"</th></tr></thead><tbody><tr><td>⌘ + B</td><td>"+a.font.bold+"</td></tr><tr><td>⌘ + I</td><td>"+a.font.italic+"</td></tr><tr><td>⌘ + U</td><td>"+a.font.underline+"</td></tr><tr><td>⌘ + ⇧ + S</td><td>"+a.font.strike+"</td></tr><tr><td>⌘ + \\</td><td>"+a.font.clear+"</td></tr></tr></tbody></table>"},j=function(a){return'<table class="note-shortcut"><thead><tr><th></th><th>'+a.shortcut.action+"</th></tr></thead><tbody><tr><td>⌘ + Z</td><td>"+a.history.undo+"</td></tr><tr><td>⌘ + ⇧ + Z</td><td>"+a.history.redo+"</td></tr><tr><td>⌘ + ]</td><td>"+a.paragraph.indent+"</td></tr><tr><td>⌘ + [</td><td>"+a.paragraph.outdent+"</td></tr><tr><td>⌘ + ENTER</td><td>"+a.hr.insert+"</td></tr></tbody></table>"},k=function(a,b){var c='<table class="note-shortcut"><thead><tr><th></th><th>'+a.shortcut.extraKeys+"</th></tr></thead><tbody>";for(var d in b.extraKeys)b.extraKeys.hasOwnProperty(d)&&(c+="<tr><td>"+d+"</td><td>"+b.extraKeys[d]+"</td></tr>");return c+="</tbody></table>"},l=function(a){return'<table class="note-shortcut"><thead><tr><th></th><th>'+a.shortcut.paragraphFormatting+"</th></tr></thead><tbody><tr><td>⌘ + ⇧ + L</td><td>"+a.paragraph.left+"</td></tr><tr><td>⌘ + ⇧ + E</td><td>"+a.paragraph.center+"</td></tr><tr><td>⌘ + ⇧ + R</td><td>"+a.paragraph.right+"</td></tr><tr><td>⌘ + ⇧ + J</td><td>"+a.paragraph.justify+"</td></tr><tr><td>⌘ + ⇧ + NUM7</td><td>"+a.lists.ordered+"</td></tr><tr><td>⌘ + ⇧ + NUM8</td><td>"+a.lists.unordered+"</td></tr></tbody></table>"},m=function(a){return'<table class="note-shortcut"><thead><tr><th></th><th>'+a.shortcut.documentStyle+"</th></tr></thead><tbody><tr><td>⌘ + NUM0</td><td>"+a.style.normal+"</td></tr><tr><td>⌘ + NUM1</td><td>"+a.style.h1+"</td></tr><tr><td>⌘ + NUM2</td><td>"+a.style.h2+"</td></tr><tr><td>⌘ + NUM3</td><td>"+a.style.h3+"</td></tr><tr><td>⌘ + NUM4</td><td>"+a.style.h4+"</td></tr><tr><td>⌘ + NUM5</td><td>"+a.style.h5+"</td></tr><tr><td>⌘ + NUM6</td><td>"+a.style.h6+"</td></tr></tbody></table>"},n=function(a,b){var c='<table class="note-shortcut-layout"><tbody><tr><td>'+j(a,b)+"</td><td>"+i(a,b)+"</td></tr><tr><td>"+m(a,b)+"</td><td>"+l(a,b)+"</td></tr>";return b.extraKeys&&(c+='<tr><td colspan="2">'+k(a,b)+"</td></tr>"),c+="</tbody</table>"},o=function(a){return a.replace(/⌘/g,"Ctrl").replace(/⇧/g,"Shift")};g=function(a,b){var d=function(){return'<div class="note-image-dialog modal" aria-hidden="false"><div class="modal-dialog"><div class="modal-content"><div class="modal-header"><button type="button" class="close" aria-hidden="true" tabindex="-1">&times;</button><h4>'+a.image.insert+'</h4></div><div class="modal-body"><div class="row-fluid"><h5>'+a.image.selectFromFiles+'</h5><input class="note-image-input" type="file" name="files" accept="image/*" /><h5>'+a.image.url+'</h5><input class="note-image-url form-control span12" type="text" /></div></div><div class="modal-footer"><button href="#" class="btn btn-primary note-image-btn disabled" disabled="disabled">'+a.image.insert+"</button></div></div></div></div>"},e=function(){return'<div class="note-link-dialog modal" aria-hidden="false"><div class="modal-dialog"><div class="modal-content"><div class="modal-header"><button type="button" class="close" aria-hidden="true" tabindex="-1">&times;</button><h4>'+a.link.insert+'</h4></div><div class="modal-body"><div class="row-fluid"><div class="form-group"><label>'+a.link.textToDisplay+'</label><input class="note-link-text form-control span12" disabled type="text" /></div><div class="form-group"><label>'+a.link.url+'</label><input class="note-link-url form-control span12" type="text" /></div>'+(b.disableLinkTarget?"":'<div class="checkbox"><label><input type="checkbox" checked> '+a.link.openInNewWindow+"</label></div>")+'</div></div><div class="modal-footer"><button href="#" class="btn btn-primary note-link-btn disabled" disabled="disabled">'+a.link.insert+"</button></div></div></div></div>"},f=function(){return'<div class="note-video-dialog modal" aria-hidden="false"><div class="modal-dialog"><div class="modal-content"><div class="modal-header"><button type="button" class="close" aria-hidden="true" tabindex="-1">&times;</button><h4>'+a.video.insert+'</h4></div><div class="modal-body"><div class="row-fluid"><div class="form-group"><label>'+a.video.url+'</label>&nbsp;<small class="text-muted">'+a.video.providers+'</small><input class="note-video-url form-control span12" type="text" /></div></div></div><div class="modal-footer"><button href="#" class="btn btn-primary note-video-btn disabled" disabled="disabled">'+a.video.insert+"</button></div></div></div></div>"},g=function(){return'<div class="note-help-dialog modal" aria-hidden="false"><div class="modal-dialog"><div class="modal-content"><div class="modal-body"><a class="modal-close pull-right" aria-hidden="true" tabindex="-1">'+a.shortcut.close+'</a><div class="title">'+a.shortcut.shortcuts+"</div>"+(c.bMac?n(a,b):o(n(a,b)))+'<p class="text-center"><a href="//hackerwins.github.io/summernote/" target="_blank">Summernote 0.5.2</a> · <a href="//github.com/HackerWins/summernote" target="_blank">Project</a> · <a href="//github.com/HackerWins/summernote/issues" target="_blank">Issues</a></p></div></div></div></div>'};return'<div class="note-dialog">'+d()+e()+f()+g()+"</div>"},h=function(){return'<div class="note-resizebar"><div class="note-icon-bar"></div><div class="note-icon-bar"></div><div class="note-icon-bar"></div></div>'};var p=function(b,d){b.find("button").each(function(b,d){var e=a(d),f=e.attr(c.bMac?"data-mac-shortcut":"data-shortcut");f&&e.attr("title",function(a,b){return b+" ("+f+")"})}).tooltip({container:"body",trigger:"hover",placement:d||"top"}).on("click",function(){a(this).tooltip("hide")})},q=[["#000000","#424242","#636363","#9C9C94","#CEC6CE","#EFEFEF","#F7F7F7","#FFFFFF"],["#FF0000","#FF9C00","#FFFF00","#00FF00","#00FFFF","#0000FF","#9C00FF","#FF00FF"],["#F7C6CE","#FFE7CE","#FFEFC6","#D6EFD6","#CEDEE7","#CEE7F7","#D6D6E7","#E7D6DE"],["#E79C9C","#FFC69C","#FFE79C","#B5D6A5","#A5C6CE","#9CC6EF","#B5A5D6","#D6A5BD"],["#E76363","#F7AD6B","#FFD663","#94BD7B","#73A5AD","#6BADDE","#8C7BC6","#C67BA5"],["#CE0000","#E79439","#EFC631","#6BA54A","#4A7B8C","#3984C6","#634AA5","#A54A7B"],["#9C0000","#B56308","#BD9400","#397B21","#104A5A","#085294","#311873","#731842"],["#630000","#7B3900","#846300","#295218","#083139","#003163","#21104A","#4A1031"]],r=function(b){b.find(".note-color-palette").each(function(){for(var b=a(this),c=b.attr("data-target-event"),d=[],e=0,f=q.length;f>e;e++){for(var g=q[e],h=[],i=0,j=g.length;j>i;i++){var k=g[i];h.push(['<button type="button" class="note-color-btn" style="background-color:',k,';" data-event="',c,'" data-value="',k,'" title="',k,'" data-toggle="button" tabindex="-1"></button>'].join(""))}d.push("<div>"+h.join("")+"</div>")}b.html(d.join(""))})};this.createLayout=function(c,i){var j=c.next();if(!j||!j.hasClass("note-editor")){var k=a('<div class="note-editor"></div>');i.width&&k.width(i.width),i.height>0&&a('<div class="note-statusbar">'+h()+"</div>").prependTo(k);var l=!c.is(":disabled"),m=a('<div class="note-editable" contentEditable="'+l+'"></div>').prependTo(k);i.height&&m.height(i.height),i.direction&&m.attr("dir",i.direction),m.html(f.html(c)||f.emptyPara),a('<textarea class="note-codable"></textarea>').prependTo(k);for(var n=a.summernote.lang[i.lang],o="",q=0,s=i.toolbar.length;s>q;q++){var t=i.toolbar[q];o+='<div class="note-'+t[0]+' btn-group">';for(var u=0,v=t[1].length;v>u;u++)o+=b[t[1][u]](n);o+="</div>"}o='<div class="note-toolbar btn-toolbar">'+o+"</div>";var w=a(o).prependTo(k);r(w),p(w,"bottom");var x=a(d(n)).prependTo(k);p(x),a(e()).prependTo(k);var y=a(g(n,i)).prependTo(k);y.find("button.close, a.modal-close").click(function(){a(this).closest(".modal").modal("hide")}),a('<div class="note-dropzone"><div class="note-dropzone-message"></div></div>').prependTo(k),k.insertAfter(c),c.hide()}},this.layoutInfoFromHolder=function(a){var b=a.next();if(b.hasClass("note-editor")){var c=f.buildLayoutInfo(b);for(var d in c)c.hasOwnProperty(d)&&(c[d]=c[d].call());return c}},this.removeLayout=function(a){var b=this.layoutInfoFromHolder(a);b&&(a.html(b.editable.html()),b.editor.remove(),a.show())}};a.summernote=a.summernote||{},a.extend(a.summernote,g);var u=new t,v=new s;a.fn.extend({summernote:function(b){if(b=a.extend({},a.summernote.options,b),this.each(function(c,d){var e=a(d);u.createLayout(e,b);var g=u.layoutInfoFromHolder(e);v.attach(g,b),f.isTextarea(e[0])&&e.closest("form").submit(function(){e.html(e.code())})}),this.first()&&b.focus){var c=u.layoutInfoFromHolder(this.first());c.editable.focus()}return this.length>0&&b.oninit&&b.oninit(),this},code:function(b){if(void 0===b){var d=this.first();if(0===d.length)return;var e=u.layoutInfoFromHolder(d);if(e&&e.editable){var f=e.editor.hasClass("codeview");return f&&c.bCodeMirror&&e.codable.data("cmEditor").save(),f?e.codable.val():e.editable.html()}return d.html()}return this.each(function(c,d){var e=u.layoutInfoFromHolder(a(d));e&&e.editable&&e.editable.html(b)}),this},destroy:function(){return this.each(function(b,c){var d=a(c),e=u.layoutInfoFromHolder(d);e&&e.editable&&(v.dettach(e),u.removeLayout(d))}),this}})});
!function(a){"use strict";"function"==typeof define&&define.amd?define(["jquery"],a):window.jQuery&&!window.jQuery.fn.colorpicker&&a(window.jQuery)}(function(a){"use strict";var b=function(a){this.value={h:0,s:0,b:0,a:1},this.origFormat=null,a&&(void 0!==a.toLowerCase?(a+="","#"===a.charAt(0)||3!==a.length&&6!==a.length||(a="#"+a),this.setColor(a)):void 0!==a.h&&(this.value=a))};b.prototype={constructor:b,colors:{aliceblue:"#f0f8ff",antiquewhite:"#faebd7",aqua:"#00ffff",aquamarine:"#7fffd4",azure:"#f0ffff",beige:"#f5f5dc",bisque:"#ffe4c4",black:"#000000",blanchedalmond:"#ffebcd",blue:"#0000ff",blueviolet:"#8a2be2",brown:"#a52a2a",burlywood:"#deb887",cadetblue:"#5f9ea0",chartreuse:"#7fff00",chocolate:"#d2691e",coral:"#ff7f50",cornflowerblue:"#6495ed",cornsilk:"#fff8dc",crimson:"#dc143c",cyan:"#00ffff",darkblue:"#00008b",darkcyan:"#008b8b",darkgoldenrod:"#b8860b",darkgray:"#a9a9a9",darkgreen:"#006400",darkkhaki:"#bdb76b",darkmagenta:"#8b008b",darkolivegreen:"#556b2f",darkorange:"#ff8c00",darkorchid:"#9932cc",darkred:"#8b0000",darksalmon:"#e9967a",darkseagreen:"#8fbc8f",darkslateblue:"#483d8b",darkslategray:"#2f4f4f",darkturquoise:"#00ced1",darkviolet:"#9400d3",deeppink:"#ff1493",deepskyblue:"#00bfff",dimgray:"#696969",dodgerblue:"#1e90ff",firebrick:"#b22222",floralwhite:"#fffaf0",forestgreen:"#228b22",fuchsia:"#ff00ff",gainsboro:"#dcdcdc",ghostwhite:"#f8f8ff",gold:"#ffd700",goldenrod:"#daa520",gray:"#808080",green:"#008000",greenyellow:"#adff2f",honeydew:"#f0fff0",hotpink:"#ff69b4","indianred ":"#cd5c5c","indigo ":"#4b0082",ivory:"#fffff0",khaki:"#f0e68c",lavender:"#e6e6fa",lavenderblush:"#fff0f5",lawngreen:"#7cfc00",lemonchiffon:"#fffacd",lightblue:"#add8e6",lightcoral:"#f08080",lightcyan:"#e0ffff",lightgoldenrodyellow:"#fafad2",lightgrey:"#d3d3d3",lightgreen:"#90ee90",lightpink:"#ffb6c1",lightsalmon:"#ffa07a",lightseagreen:"#20b2aa",lightskyblue:"#87cefa",lightslategray:"#778899",lightsteelblue:"#b0c4de",lightyellow:"#ffffe0",lime:"#00ff00",limegreen:"#32cd32",linen:"#faf0e6",magenta:"#ff00ff",maroon:"#800000",mediumaquamarine:"#66cdaa",mediumblue:"#0000cd",mediumorchid:"#ba55d3",mediumpurple:"#9370d8",mediumseagreen:"#3cb371",mediumslateblue:"#7b68ee",mediumspringgreen:"#00fa9a",mediumturquoise:"#48d1cc",mediumvioletred:"#c71585",midnightblue:"#191970",mintcream:"#f5fffa",mistyrose:"#ffe4e1",moccasin:"#ffe4b5",navajowhite:"#ffdead",navy:"#000080",oldlace:"#fdf5e6",olive:"#808000",olivedrab:"#6b8e23",orange:"#ffa500",orangered:"#ff4500",orchid:"#da70d6",palegoldenrod:"#eee8aa",palegreen:"#98fb98",paleturquoise:"#afeeee",palevioletred:"#d87093",papayawhip:"#ffefd5",peachpuff:"#ffdab9",peru:"#cd853f",pink:"#ffc0cb",plum:"#dda0dd",powderblue:"#b0e0e6",purple:"#800080",red:"#ff0000",rosybrown:"#bc8f8f",royalblue:"#4169e1",saddlebrown:"#8b4513",salmon:"#fa8072",sandybrown:"#f4a460",seagreen:"#2e8b57",seashell:"#fff5ee",sienna:"#a0522d",silver:"#c0c0c0",skyblue:"#87ceeb",slateblue:"#6a5acd",slategray:"#708090",snow:"#fffafa",springgreen:"#00ff7f",steelblue:"#4682b4",tan:"#d2b48c",teal:"#008080",thistle:"#d8bfd8",tomato:"#ff6347",turquoise:"#40e0d0",violet:"#ee82ee",wheat:"#f5deb3",white:"#ffffff",whitesmoke:"#f5f5f5",yellow:"#ffff00",yellowgreen:"#9acd32"},_sanitizeNumber:function(a){return"number"==typeof a?a:isNaN(a)||null===a||""===a||void 0===a?1:void 0!==a.toLowerCase?parseFloat(a):1},setColor:function(a){a=a.toLowerCase(),this.value=this.stringToHSB(a)||{h:0,s:0,b:0,a:1}},stringToHSB:function(b){b=b.toLowerCase();var c=this,d=!1;return a.each(this.stringParsers,function(a,e){var f=e.re.exec(b),g=f&&e.parse.apply(c,[f]),h=e.format||"rgba";return g?(d=h.match(/hsla?/)?c.RGBtoHSB.apply(c,c.HSLtoRGB.apply(c,g)):c.RGBtoHSB.apply(c,g),c.origFormat=h,!1):!0}),d},setHue:function(a){this.value.h=1-a},setSaturation:function(a){this.value.s=a},setBrightness:function(a){this.value.b=1-a},setAlpha:function(a){this.value.a=parseInt(100*(1-a),10)/100},toRGB:function(a,b,c,d){a||(a=this.value.h,b=this.value.s,c=this.value.b),a*=360;var e,f,g,h,i;return a=a%360/60,i=c*b,h=i*(1-Math.abs(a%2-1)),e=f=g=c-i,a=~~a,e+=[i,h,0,0,h,i][a],f+=[h,i,i,h,0,0][a],g+=[0,0,h,i,i,h][a],{r:Math.round(255*e),g:Math.round(255*f),b:Math.round(255*g),a:d||this.value.a}},toHex:function(a,b,c,d){var e=this.toRGB(a,b,c,d);return"#"+(1<<24|parseInt(e.r)<<16|parseInt(e.g)<<8|parseInt(e.b)).toString(16).substr(1)},toHSL:function(a,b,c,d){a=a||this.value.h,b=b||this.value.s,c=c||this.value.b,d=d||this.value.a;var e=a,f=(2-b)*c,g=b*c;return g/=f>0&&1>=f?f:2-f,f/=2,g>1&&(g=1),{h:isNaN(e)?0:e,s:isNaN(g)?0:g,l:isNaN(f)?0:f,a:isNaN(d)?0:d}},toAlias:function(a,b,c,d){var e=this.toHex(a,b,c,d);for(var f in this.colors)if(this.colors[f]==e)return f;return!1},RGBtoHSB:function(a,b,c,d){a/=255,b/=255,c/=255;var e,f,g,h;return g=Math.max(a,b,c),h=g-Math.min(a,b,c),e=0===h?null:g===a?(b-c)/h:g===b?(c-a)/h+2:(a-b)/h+4,e=(e+360)%6*60/360,f=0===h?0:h/g,{h:this._sanitizeNumber(e),s:f,b:g,a:this._sanitizeNumber(d)}},HueToRGB:function(a,b,c){return 0>c?c+=1:c>1&&(c-=1),1>6*c?a+(b-a)*c*6:1>2*c?b:2>3*c?a+(b-a)*(2/3-c)*6:a},HSLtoRGB:function(a,b,c,d){0>b&&(b=0);var e;e=.5>=c?c*(1+b):c+b-c*b;var f=2*c-e,g=a+1/3,h=a,i=a-1/3,j=Math.round(255*this.HueToRGB(f,e,g)),k=Math.round(255*this.HueToRGB(f,e,h)),l=Math.round(255*this.HueToRGB(f,e,i));return[j,k,l,this._sanitizeNumber(d)]},toString:function(a){switch(a=a||"rgba"){case"rgb":var b=this.toRGB();return"rgb("+b.r+","+b.g+","+b.b+")";case"rgba":var b=this.toRGB();return"rgba("+b.r+","+b.g+","+b.b+","+b.a+")";case"hsl":var c=this.toHSL();return"hsl("+Math.round(360*c.h)+","+Math.round(100*c.s)+"%,"+Math.round(100*c.l)+"%)";case"hsla":var c=this.toHSL();return"hsla("+Math.round(360*c.h)+","+Math.round(100*c.s)+"%,"+Math.round(100*c.l)+"%,"+c.a+")";case"hex":return this.toHex();case"alias":return this.toAlias()||this.toHex();default:return!1}},stringParsers:[{re:/#?([a-fA-F0-9]{2})([a-fA-F0-9]{2})([a-fA-F0-9]{2})/,format:"hex",parse:function(a){return[parseInt(a[1],16),parseInt(a[2],16),parseInt(a[3],16),1]}},{re:/#?([a-fA-F0-9])([a-fA-F0-9])([a-fA-F0-9])/,format:"hex",parse:function(a){return[parseInt(a[1]+a[1],16),parseInt(a[2]+a[2],16),parseInt(a[3]+a[3],16),1]}},{re:/rgb\(\s*(\d{1,3})\s*,\s*(\d{1,3})\s*,\s*(\d{1,3})\s*?\)/,format:"rgb",parse:function(a){return[a[1],a[2],a[3],1]}},{re:/rgb\(\s*(\d+(?:\.\d+)?)\%\s*,\s*(\d+(?:\.\d+)?)\%\s*,\s*(\d+(?:\.\d+)?)\%\s*?\)/,format:"rgb",parse:function(a){return[2.55*a[1],2.55*a[2],2.55*a[3],1]}},{re:/rgba\(\s*(\d{1,3})\s*,\s*(\d{1,3})\s*,\s*(\d{1,3})\s*(?:,\s*(\d+(?:\.\d+)?)\s*)?\)/,format:"rgba",parse:function(a){return[a[1],a[2],a[3],a[4]]}},{re:/rgba\(\s*(\d+(?:\.\d+)?)\%\s*,\s*(\d+(?:\.\d+)?)\%\s*,\s*(\d+(?:\.\d+)?)\%\s*(?:,\s*(\d+(?:\.\d+)?)\s*)?\)/,format:"rgba",parse:function(a){return[2.55*a[1],2.55*a[2],2.55*a[3],a[4]]}},{re:/hsl\(\s*(\d+(?:\.\d+)?)\s*,\s*(\d+(?:\.\d+)?)\%\s*,\s*(\d+(?:\.\d+)?)\%\s*?\)/,format:"hsl",parse:function(a){return[a[1]/360,a[2]/100,a[3]/100,a[4]]}},{re:/hsla\(\s*(\d+(?:\.\d+)?)\s*,\s*(\d+(?:\.\d+)?)\%\s*,\s*(\d+(?:\.\d+)?)\%\s*(?:,\s*(\d+(?:\.\d+)?)\s*)?\)/,format:"hsla",parse:function(a){return[a[1]/360,a[2]/100,a[3]/100,a[4]]}},{re:/^([a-z]{3,})$/,format:"alias",parse:function(a){var b=this.colorNameToHex(a[0])||"#000000",c=this.stringParsers[0].re.exec(b),d=c&&this.stringParsers[0].parse.apply(this,[c]);return d}}],colorNameToHex:function(a){return"undefined"!=typeof this.colors[a.toLowerCase()]?this.colors[a.toLowerCase()]:!1}};var c={horizontal:!1,inline:!1,color:!1,format:!1,input:"input",container:!1,component:".add-on, .input-group-addon",sliders:{saturation:{maxLeft:100,maxTop:100,callLeft:"setSaturation",callTop:"setBrightness"},hue:{maxLeft:0,maxTop:100,callLeft:!1,callTop:"setHue"},alpha:{maxLeft:0,maxTop:100,callLeft:!1,callTop:"setAlpha"}},slidersHorz:{saturation:{maxLeft:100,maxTop:100,callLeft:"setSaturation",callTop:"setBrightness"},hue:{maxLeft:100,maxTop:0,callLeft:"setHue",callTop:!1},alpha:{maxLeft:100,maxTop:0,callLeft:"setAlpha",callTop:!1}},template:'<div class="colorpicker dropdown-menu"><div class="colorpicker-saturation"><i><b></b></i></div><div class="colorpicker-hue"><i></i></div><div class="colorpicker-alpha"><i></i></div><div class="colorpicker-color"><div /></div></div>'},d=function(d,e){this.element=a(d).addClass("colorpicker-element"),this.options=a.extend({},c,this.element.data(),e),this.component=this.options.component,this.component=this.component!==!1?this.element.find(this.component):!1,this.component&&0===this.component.length&&(this.component=!1),this.container=this.options.container===!0?this.element:this.options.container,this.container=this.container!==!1?a(this.container):!1,this.input=this.element.is("input")?this.element:this.options.input?this.element.find(this.options.input):!1,this.input&&0===this.input.length&&(this.input=!1),this.color=new b(this.options.color!==!1?this.options.color:this.getValue()),this.format=this.options.format!==!1?this.options.format:this.color.origFormat,this.picker=a(this.options.template),this.picker.addClass(this.options.inline?"colorpicker-inline colorpicker-visible":"colorpicker-hidden"),this.options.horizontal&&this.picker.addClass("colorpicker-horizontal"),("rgba"===this.format||"hsla"===this.format)&&this.picker.addClass("colorpicker-with-alpha"),this.picker.on("mousedown.colorpicker touchstart.colorpicker",a.proxy(this.mousedown,this)),this.picker.appendTo(this.container?this.container:a("body")),this.input!==!1&&(this.input.on({"keyup.colorpicker":a.proxy(this.keyup,this)}),this.component===!1&&this.element.on({"focus.colorpicker":a.proxy(this.show,this)}),this.options.inline===!1&&this.element.on({"focusout.colorpicker":a.proxy(this.hide,this)})),this.component!==!1&&this.component.on({"click.colorpicker":a.proxy(this.show,this)}),this.input===!1&&this.component===!1&&this.element.on({"click.colorpicker":a.proxy(this.show,this)}),this.input!==!1&&this.component!==!1&&"color"===this.input.attr("type")&&this.input.on({"click.colorpicker":a.proxy(this.show,this),"focus.colorpicker":a.proxy(this.show,this)}),this.update(),a(a.proxy(function(){this.element.trigger("create")},this))};d.version="2.0.0-beta",d.Color=b,d.prototype={constructor:d,destroy:function(){this.picker.remove(),this.element.removeData("colorpicker").off(".colorpicker"),this.input!==!1&&this.input.off(".colorpicker"),this.component!==!1&&this.component.off(".colorpicker"),this.element.removeClass("colorpicker-element"),this.element.trigger({type:"destroy"})},reposition:function(){if(this.options.inline!==!1||this.options.container)return!1;var a=this.container&&this.container[0]!==document.body?"position":"offset",b=this.component?this.component[a]():this.element[a]();this.picker.css({top:b.top+(this.component?this.component.outerHeight():this.element.outerHeight()),left:b.left})},show:function(b){return this.isDisabled()?!1:(this.picker.addClass("colorpicker-visible").removeClass("colorpicker-hidden"),this.reposition(),a(window).on("resize.colorpicker",a.proxy(this.reposition,this)),!b||this.hasInput()&&"color"!==this.input.attr("type")||b.stopPropagation&&b.preventDefault&&(b.stopPropagation(),b.preventDefault()),this.options.inline===!1&&a(window.document).on({"mousedown.colorpicker":a.proxy(this.hide,this)}),void this.element.trigger({type:"showPicker",color:this.color}))},hide:function(){this.picker.addClass("colorpicker-hidden").removeClass("colorpicker-visible"),a(window).off("resize.colorpicker",this.reposition),a(document).off({"mousedown.colorpicker":this.hide}),this.update(),this.element.trigger({type:"hidePicker",color:this.color})},updateData:function(a){return a=a||this.color.toString(this.format),this.element.data("color",a),a},updateInput:function(a){return a=a||this.color.toString(this.format),this.input!==!1&&this.input.prop("value",a),a},updatePicker:function(a){void 0!==a&&(this.color=new b(a));var c=this.options.horizontal===!1?this.options.sliders:this.options.slidersHorz,d=this.picker.find("i");return 0!==d.length?(this.options.horizontal===!1?(c=this.options.sliders,d.eq(1).css("top",c.hue.maxTop*(1-this.color.value.h)).end().eq(2).css("top",c.alpha.maxTop*(1-this.color.value.a))):(c=this.options.slidersHorz,d.eq(1).css("left",c.hue.maxLeft*(1-this.color.value.h)).end().eq(2).css("left",c.alpha.maxLeft*(1-this.color.value.a))),d.eq(0).css({top:c.saturation.maxTop-this.color.value.b*c.saturation.maxTop,left:this.color.value.s*c.saturation.maxLeft}),this.picker.find(".colorpicker-saturation").css("backgroundColor",this.color.toHex(this.color.value.h,1,1,1)),this.picker.find(".colorpicker-alpha").css("backgroundColor",this.color.toHex()),this.picker.find(".colorpicker-color, .colorpicker-color div").css("backgroundColor",this.color.toString(this.format)),a):void 0},updateComponent:function(a){if(a=a||this.color.toString(this.format),this.component!==!1){var b=this.component.find("i").eq(0);b.length>0?b.css({backgroundColor:a}):this.component.css({backgroundColor:a})}return a},update:function(a){var b=this.updateComponent();return(this.getValue(!1)!==!1||a===!0)&&(this.updateInput(b),this.updateData(b)),this.updatePicker(),b},setValue:function(a){this.color=new b(a),this.update(),this.element.trigger({type:"changeColor",color:this.color,value:a})},getValue:function(a){a=void 0===a?"#000000":a;var b;return b=this.hasInput()?this.input.val():this.element.data("color"),(void 0===b||""===b||null===b)&&(b=a),b},hasInput:function(){return this.input!==!1},isDisabled:function(){return this.hasInput()?this.input.prop("disabled")===!0:!1},disable:function(){return this.hasInput()?(this.input.prop("disabled",!0),!0):!1},enable:function(){return this.hasInput()?(this.input.prop("disabled",!1),!0):!1},currentSlider:null,mousePointer:{left:0,top:0},mousedown:function(b){b.pageX||b.pageY||!b.originalEvent||(b.pageX=b.originalEvent.touches[0].pageX,b.pageY=b.originalEvent.touches[0].pageY),b.stopPropagation(),b.preventDefault();var c=a(b.target),d=c.closest("div"),e=this.options.horizontal?this.options.slidersHorz:this.options.sliders;if(!d.is(".colorpicker")){if(d.is(".colorpicker-saturation"))this.currentSlider=a.extend({},e.saturation);else if(d.is(".colorpicker-hue"))this.currentSlider=a.extend({},e.hue);else{if(!d.is(".colorpicker-alpha"))return!1;this.currentSlider=a.extend({},e.alpha)}var f=d.offset();this.currentSlider.guide=d.find("i")[0].style,this.currentSlider.left=b.pageX-f.left,this.currentSlider.top=b.pageY-f.top,this.mousePointer={left:b.pageX,top:b.pageY},a(document).on({"mousemove.colorpicker":a.proxy(this.mousemove,this),"touchmove.colorpicker":a.proxy(this.mousemove,this),"mouseup.colorpicker":a.proxy(this.mouseup,this),"touchend.colorpicker":a.proxy(this.mouseup,this)}).trigger("mousemove")}return!1},mousemove:function(a){a.pageX||a.pageY||!a.originalEvent||(a.pageX=a.originalEvent.touches[0].pageX,a.pageY=a.originalEvent.touches[0].pageY),a.stopPropagation(),a.preventDefault();var b=Math.max(0,Math.min(this.currentSlider.maxLeft,this.currentSlider.left+((a.pageX||this.mousePointer.left)-this.mousePointer.left))),c=Math.max(0,Math.min(this.currentSlider.maxTop,this.currentSlider.top+((a.pageY||this.mousePointer.top)-this.mousePointer.top)));return this.currentSlider.guide.left=b+"px",this.currentSlider.guide.top=c+"px",this.currentSlider.callLeft&&this.color[this.currentSlider.callLeft].call(this.color,b/this.currentSlider.maxLeft),this.currentSlider.callTop&&this.color[this.currentSlider.callTop].call(this.color,c/this.currentSlider.maxTop),this.update(!0),this.element.trigger({type:"changeColor",color:this.color}),!1},mouseup:function(b){return b.stopPropagation(),b.preventDefault(),a(document).off({"mousemove.colorpicker":this.mousemove,"touchmove.colorpicker":this.mousemove,"mouseup.colorpicker":this.mouseup,"touchend.colorpicker":this.mouseup}),!1},keyup:function(a){if(38===a.keyCode)this.color.value.a<1&&(this.color.value.a=Math.round(100*(this.color.value.a+.01))/100),this.update(!0);else if(40===a.keyCode)this.color.value.a>0&&(this.color.value.a=Math.round(100*(this.color.value.a-.01))/100),this.update(!0);else{var c=this.input.val();this.color=new b(c),this.getValue(!1)!==!1&&(this.updateData(),this.updateComponent(),this.updatePicker())}this.element.trigger({type:"changeColor",color:this.color,value:c})}},a.colorpicker=d,a.fn.colorpicker=function(b){var c=arguments;return this.each(function(){var e=a(this),f=e.data("colorpicker"),g="object"==typeof b?b:{};f||"string"==typeof b?"string"==typeof b&&f[b].apply(f,Array.prototype.slice.call(c,1)):e.data("colorpicker",new d(this,g))})},a.fn.colorpicker.constructor=d});
/*!
 * Cropper v0.7.6-beta
 * https://github.com/fengyuanchen/cropper
 *
 * Copyright 2014 Fengyuan Chen
 * Released under the MIT license
 */


!function(a){"function"==typeof define&&define.amd?define(["jquery"],a):a("object"==typeof exports?require("jquery"):jQuery)}(function(a){"use strict";var b=a(window),c=a(document),d=window.location,e=!0,f=!1,g=null,h=0/0,i=1/0,j="undefined",k="directive",l=".cropper",m=/^(e|n|w|s|ne|nw|sw|se|all|crop|move|zoom)$/,n=/^(x|y|width|height)$/,o=/^(naturalWidth|naturalHeight|width|height|aspectRatio|ratio|rotate)$/,p="cropper-modal",q="cropper-hidden",r="cropper-invisible",s="cropper-move",t="cropper-crop",u="cropper-disabled",v="mousedown touchstart",w="mousemove touchmove",x="mouseup mouseleave touchend touchleave touchcancel",y="wheel mousewheel DOMMouseScroll",z="resize"+l,A="dblclick",B="build"+l,C="built"+l,D="dragstart"+l,E="dragmove"+l,F="dragend"+l,G=function(a){return"number"==typeof a},H=function(b,c){this.element=b,this.$element=a(b),this.defaults=a.extend({},H.DEFAULTS,a.isPlainObject(c)?c:{}),this.$original=g,this.ready=f,this.built=f,this.cropped=f,this.rotated=f,this.disabled=f,this.replaced=f,this.init()},I=Math.round,J=Math.sqrt,K=Math.min,L=Math.max,M=Math.abs,N=Math.sin,O=Math.cos,P=parseFloat;H.prototype={constructor:H,support:{canvas:a.isFunction(a("<canvas>")[0].getContext)},init:function(){var b=this.defaults;a.each(b,function(a,c){switch(a){case"aspectRatio":b[a]=M(P(c))||h;break;case"autoCropArea":b[a]=M(P(c))||.8;break;case"minWidth":case"minHeight":b[a]=M(P(c))||0;break;case"maxWidth":case"maxHeight":b[a]=M(P(c))||i}}),this.image={rotate:0},this.load()},load:function(){var b,c,d=this,f=this.$element,g=this.element,h=this.image,i="";f.is("img")?c=f.prop("src"):f.is("canvas")&&this.support.canvas&&(c=g.toDataURL()),c&&(this.replaced&&(h.rotate=0),this.defaults.checkImageOrigin&&(f.prop("crossOrigin")||this.isCrossOriginURL(c))&&(i=" crossOrigin"),this.$clone=b=a("<img"+i+' src="'+c+'">'),b.one("load",function(){h.naturalWidth=this.naturalWidth||b.width(),h.naturalHeight=this.naturalHeight||b.height(),h.aspectRatio=h.naturalWidth/h.naturalHeight,d.url=c,d.ready=e,d.build()}),b.addClass(r).prependTo("body"))},isCrossOriginURL:function(a){var b=a.match(/^(https?:)\/\/([^\:\/\?#]+):?(\d*)/i);return!b||b[1]===d.protocol&&b[2]===d.hostname&&b[3]===d.port?f:e},build:function(){var b,d,f=this.$element,g=this.defaults;this.ready&&(this.built&&this.unbuild(),f.one(B,g.build),b=a.Event(B),f.trigger(b),b.isDefaultPrevented()||(this.$cropper=d=a(H.TEMPLATE),f.addClass(q),this.$clone.removeClass(r).prependTo(d),this.rotated||(this.$original=this.$clone.clone(),this.$original.addClass(q).prependTo(this.$cropper),this.originalImage=a.extend({},this.image)),this.$container=f.parent(),this.$container.append(d),this.$canvas=d.find(".cropper-canvas"),this.$dragger=d.find(".cropper-dragger"),this.$viewer=d.find(".cropper-viewer"),g.autoCrop?this.cropped=e:this.$dragger.addClass(q),g.dragCrop&&this.setDragMode("crop"),g.modal&&this.$canvas.addClass(p),!g.dashed&&this.$dragger.find(".cropper-dashed").addClass(q),!g.movable&&this.$dragger.find(".cropper-face").data(k,"move"),!g.resizable&&this.$dragger.find(".cropper-line, .cropper-point").addClass(q),this.$scope=g.multiple?this.$cropper:c,this.addListeners(),this.initPreview(),this.built=e,this.update(),f.one(C,g.built),f.trigger(C)))},unbuild:function(){this.built&&(this.built=f,this.removeListeners(),this.$preview.empty(),this.$preview=g,this.$dragger=g,this.$canvas=g,this.$container=g,this.$cropper.remove(),this.$cropper=g)},update:function(a){this.initContainer(),this.initCropper(),this.initImage(),this.initDragger(),a?(this.setData(a,e),this.setDragMode("crop")):this.setData(this.defaults.data)},resize:function(){clearTimeout(this.resizing),this.resizing=setTimeout(a.proxy(this.update,this,this.getData()),200)},preview:function(){var b=this.image,c=this.dragger,d=b.width,e=b.height,f=c.left-b.left,g=c.top-b.top;this.$viewer.find("img").css({width:I(d),height:I(e),marginLeft:-I(f),marginTop:-I(g)}),this.$preview.each(function(){var b=a(this),h=b.width()/c.width;b.find("img").css({width:I(d*h),height:I(e*h),marginLeft:-I(f*h),marginTop:-I(g*h)})})},addListeners:function(){var c=this.defaults;this.$element.on(D,c.dragstart).on(E,c.dragmove).on(F,c.dragend),this.$cropper.on(v,this._dragstart=a.proxy(this.dragstart,this)).on(A,this._dblclick=a.proxy(this.dblclick,this)),c.zoomable&&this.$cropper.on(y,this._wheel=a.proxy(this.wheel,this)),this.$scope.on(w,this._dragmove=a.proxy(this.dragmove,this)).on(x,this._dragend=a.proxy(this.dragend,this)),b.on(z,this._resize=a.proxy(this.resize,this))},removeListeners:function(){var a=this.defaults;this.$element.off(D,a.dragstart).off(E,a.dragmove).off(F,a.dragend),this.$cropper.off(v,this._dragstart).off(A,this._dblclick),a.zoomable&&this.$cropper.off(y,this._wheel),this.$scope.off(w,this._dragmove).off(x,this._dragend),b.off(z,this._resize)},initPreview:function(){var b='<img src="'+this.url+'">';this.$preview=a(this.defaults.preview),this.$viewer.html(b),this.$preview.html(b).find("img").css("cssText","min-width:0!important;min-height:0!important;max-width:none!important;max-height:none!important;")},initContainer:function(){var a=this.$container;this.container={width:L(a.width(),300),height:L(a.height(),150)}},initCropper:function(){var a,b=this.container,c=this.image;c.naturalWidth*b.height/c.naturalHeight-b.width>=0?(a={width:b.width,height:b.width/c.aspectRatio,left:0},a.top=(b.height-a.height)/2):(a={width:b.height*c.aspectRatio,height:b.height,top:0},a.left=(b.width-a.width)/2),this.$cropper.css({width:I(a.width),height:I(a.height),left:I(a.left),top:I(a.top)}),this.cropper=a},initImage:function(){var b=this.image,c=this.cropper,d={_width:c.width,_height:c.height,width:c.width,height:c.height,left:0,top:0,ratio:c.width/b.naturalWidth};this.defaultImage=a.extend({},b,d),b._width!==c.width||b._height!==c.height?a.extend(b,d):(b=a.extend({},d,b),this.replaced&&(this.replaced=f,b.ratio=d.ratio)),this.image=b,this.renderImage()},renderImage:function(a){var b=this.image;"zoom"===a&&(b.left-=(b.width-b.oldWidth)/2,b.top-=(b.height-b.oldHeight)/2),b.left=K(L(b.left,b._width-b.width),0),b.top=K(L(b.top,b._height-b.height),0),this.$clone.css({width:I(b.width),height:I(b.height),marginLeft:I(b.left),marginTop:I(b.top)}),a&&(this.defaults.done(this.getData()),this.preview())},initDragger:function(){var b,c=this.defaults,d=this.cropper,e=c.aspectRatio||this.image.aspectRatio,f=this.image.ratio;b=d.height*e-d.width>=0?{height:d.width/e,width:d.width,left:0,top:(d.height-d.width/e)/2,maxWidth:d.width,maxHeight:d.width/e}:{height:d.height,width:d.height*e,left:(d.width-d.height*e)/2,top:0,maxWidth:d.height*e,maxHeight:d.height},b.minWidth=0,b.minHeight=0,c.aspectRatio?(isFinite(c.maxWidth)?(b.maxWidth=K(b.maxWidth,c.maxWidth*f),b.maxHeight=b.maxWidth/e):isFinite(c.maxHeight)&&(b.maxHeight=K(b.maxHeight,c.maxHeight*f),b.maxWidth=b.maxHeight*e),c.minWidth>0?(b.minWidth=L(0,c.minWidth*f),b.minHeight=b.minWidth/e):c.minHeight>0&&(b.minHeight=L(0,c.minHeight*f),b.minWidth=b.minHeight*e)):(b.maxWidth=K(b.maxWidth,c.maxWidth*f),b.maxHeight=K(b.maxHeight,c.maxHeight*f),b.minWidth=L(0,c.minWidth*f),b.minHeight=L(0,c.minHeight*f)),b.minWidth=K(b.maxWidth,b.minWidth),b.minHeight=K(b.maxHeight,b.minHeight),b.height*=c.autoCropArea,b.width*=c.autoCropArea,b.left=(d.width-b.width)/2,b.top=(d.height-b.height)/2,b.oldLeft=b.left,b.oldTop=b.top,this.defaultDragger=b,this.dragger=a.extend({},b)},renderDragger:function(){var a=this.dragger,b=this.cropper;a.width>a.maxWidth?(a.width=a.maxWidth,a.left=a.oldLeft):a.width<a.minWidth&&(a.width=a.minWidth,a.left=a.oldLeft),a.height>a.maxHeight?(a.height=a.maxHeight,a.top=a.oldTop):a.height<a.minHeight&&(a.height=a.minHeight,a.top=a.oldTop),a.left=K(L(a.left,0),b.width-a.width),a.top=K(L(a.top,0),b.height-a.height),a.oldLeft=a.left,a.oldTop=a.top,this.dragger=a,this.disabled||this.defaults.done(this.getData()),this.$dragger.css({width:I(a.width),height:I(a.height),left:I(a.left),top:I(a.top)}),this.preview()},reset:function(b){this.cropped&&(b&&(this.defaults.data={}),this.image=a.extend({},this.defaultImage),this.renderImage(),this.dragger=a.extend({},this.defaultDragger),this.setData(this.defaults.data))},clear:function(){this.cropped&&(this.cropped=f,this.setData({x:0,y:0,width:0,height:0}),this.$canvas.removeClass(p),this.$dragger.addClass(q))},destroy:function(){var a=this.$element;this.ready&&(this.unbuild(),a.removeClass(q).removeData("cropper"),this.rotated&&a.attr("src",this.$original.attr("src")))},replace:function(b,c){var d,g=this,h=this.$element,i=this.element;b&&b!==this.url&&b!==h.attr("src")&&(c||(this.rotated=f,this.replaced=e),h.is("img")?(h.attr("src",b),this.load()):h.is("canvas")&&this.support.canvas&&(d=i.getContext("2d"),a('<img src="'+b+'">').one("load",function(){i.width=this.width,i.height=this.height,d.clearRect(0,0,i.width,i.height),d.drawImage(this,0,0),g.load()})))},setData:function(b,c){var d=this.cropper,e=this.dragger,f=this.image,h=this.defaults.aspectRatio;this.built&&typeof b!==j&&((b===g||a.isEmptyObject(b))&&(e=a.extend({},this.defaultDragger)),a.isPlainObject(b)&&!a.isEmptyObject(b)&&(c||(this.defaults.data=b),b=this.transformData(b),G(b.x)&&b.x<=d.width-f.left&&(e.left=b.x+f.left),G(b.y)&&b.y<=d.height-f.top&&(e.top=b.y+f.top),h?G(b.width)&&b.width<=e.maxWidth&&b.width>=e.minWidth?(e.width=b.width,e.height=e.width/h):G(b.height)&&b.height<=e.maxHeight&&b.height>=e.minHeight&&(e.height=b.height,e.width=e.height*h):(G(b.width)&&b.width<=e.maxWidth&&b.width>=e.minWidth&&(e.width=b.width),G(b.height)&&b.height<=e.maxHeight&&b.height>=e.minHeight&&(e.height=b.height))),this.dragger=e,this.renderDragger())},getData:function(a){var b=this.dragger,c=this.image,d={};return this.built&&(d={x:b.left-c.left,y:b.top-c.top,width:b.width,height:b.height},d=this.transformData(d,e,a)),d},transformData:function(b,c,d){var e=this.image.ratio,f={};return a.each(b,function(a,b){b=P(b),n.test(a)&&!isNaN(b)&&(f[a]=c?d?I(b/e):b/e:b*e)}),f},setAspectRatio:function(a){var b="auto"===a;a=P(a),(b||!isNaN(a)&&a>0)&&(this.defaults.aspectRatio=b?h:a,this.built&&(this.initDragger(),this.renderDragger()))},getImageData:function(){var b={};return this.ready&&a.each(this.image,function(a,c){o.test(a)&&(b[a]=c)}),b},getDataURL:function(b,c,d){var e,f=a("<canvas>")[0],g=this.getData(),h="";return a.isPlainObject(b)||(d=c,c=b,b={}),b=a.extend({width:g.width,height:g.height},b),this.cropped&&this.support.canvas&&(f.width=b.width,f.height=b.height,e=f.getContext("2d"),"image/jpeg"===c&&(e.fillStyle="#fff",e.fillRect(0,0,b.width,b.height)),e.drawImage(this.$clone[0],g.x,g.y,g.width,g.height,0,0,b.width,b.height),h=f.toDataURL(c,d)),h},setDragMode:function(a){var b=this.$canvas,c=this.defaults,d=f,g=f;if(this.built&&!this.disabled){switch(a){case"crop":c.dragCrop&&(d=e,b.data(k,a));break;case"move":g=e,b.data(k,a);break;default:b.removeData(k)}b.toggleClass(t,d).toggleClass(s,g)}},enable:function(){this.built&&(this.disabled=f,this.$cropper.removeClass(u))},disable:function(){this.built&&(this.disabled=e,this.$cropper.addClass(u))},rotate:function(a){var b=this.image;a=P(a)||0,this.built&&0!==a&&!this.disabled&&this.defaults.rotatable&&this.support.canvas&&(this.rotated=e,a=b.rotate=(b.rotate+a)%360,this.replace(this.getRotatedDataURL(a),!0))},getRotatedDataURL:function(b){var c=a("<canvas>")[0],d=c.getContext("2d"),e=b*Math.PI/180,f=M(b)%180,g=f>90?180-f:f,h=g*Math.PI/180,i=this.originalImage,j=i.naturalWidth,k=i.naturalHeight,l=M(j*O(h)+k*N(h)),m=M(j*N(h)+k*O(h));return c.width=l,c.height=m,d.save(),d.translate(l/2,m/2),d.rotate(e),d.drawImage(this.$original[0],-j/2,-k/2,j,k),d.restore(),c.toDataURL()},zoom:function(a){var b,c,d,e=this.image;a=P(a),this.built&&a&&!this.disabled&&this.defaults.zoomable&&(b=e.width*(1+a),c=e.height*(1+a),d=b/e._width,d>10||(1>d&&(b=e._width,c=e._height),this.setDragMode(1>=d?"crop":"move"),e.oldWidth=e.width,e.oldHeight=e.height,e.width=b,e.height=c,e.ratio=e.width/e.naturalWidth,this.renderImage("zoom")))},dblclick:function(){this.disabled||this.setDragMode(this.$canvas.hasClass(t)?"move":"crop")},wheel:function(a){var b,c=a.originalEvent,d=117.25,e=5,f=166.66665649414062,g=.1;this.disabled||(a.preventDefault(),c.deltaY?(b=c.deltaY,b=b%e===0?b/e:b%d===0?b/d:b/f):b=c.wheelDelta?-c.wheelDelta/120:c.detail?c.detail/3:0,this.zoom(b*g))},dragstart:function(b){var c,d,g,h=b.originalEvent.touches,i=b;if(!this.disabled){if(h){if(g=h.length,g>1){if(!this.defaults.zoomable||2!==g)return;i=h[1],this.startX2=i.pageX,this.startY2=i.pageY,c="zoom"}i=h[0]}if(c=c||a(i.target).data(k),m.test(c)){if(b.preventDefault(),d=a.Event(D),this.$element.trigger(d),d.isDefaultPrevented())return;this.directive=c,this.cropping=f,this.startX=i.pageX,this.startY=i.pageY,"crop"===c&&(this.cropping=e,this.$canvas.addClass(p))}}},dragmove:function(b){var c,d,e=b.originalEvent.touches,f=b;if(!this.disabled){if(e){if(d=e.length,d>1){if(!this.defaults.zoomable||2!==d)return;f=e[1],this.endX2=f.pageX,this.endY2=f.pageY}f=e[0]}if(this.directive){if(b.preventDefault(),c=a.Event(E),this.$element.trigger(c),c.isDefaultPrevented())return;this.endX=f.pageX,this.endY=f.pageY,this.dragging()}}},dragend:function(b){var c;if(!this.disabled&&this.directive){if(b.preventDefault(),c=a.Event(F),this.$element.trigger(c),c.isDefaultPrevented())return;this.cropping&&(this.cropping=f,this.$canvas.toggleClass(p,this.cropped&&this.defaults.modal)),this.directive=""}},dragging:function(){var a,b=this.directive,c=this.image,d=this.cropper,g=d.width,h=d.height,i=this.dragger,j=i.width,k=i.height,l=i.left,m=i.top,n=l+j,o=m+k,p=e,r=this.defaults,s=r.aspectRatio,t={x:this.endX-this.startX,y:this.endY-this.startY};switch(s&&(t.X=t.y*s,t.Y=t.x/s),b){case"all":l+=t.x,m+=t.y;break;case"e":if(t.x>=0&&(n>=g||s&&(0>=m||o>=h))){p=f;break}j+=t.x,s&&(k=j/s,m-=t.Y/2),0>j&&(b="w",j=0);break;case"n":if(t.y<=0&&(0>=m||s&&(0>=l||n>=g))){p=f;break}k-=t.y,m+=t.y,s&&(j=k*s,l+=t.X/2),0>k&&(b="s",k=0);break;case"w":if(t.x<=0&&(0>=l||s&&(0>=m||o>=h))){p=f;break}j-=t.x,l+=t.x,s&&(k=j/s,m+=t.Y/2),0>j&&(b="e",j=0);break;case"s":if(t.y>=0&&(o>=h||s&&(0>=l||n>=g))){p=f;break}k+=t.y,s&&(j=k*s,l-=t.X/2),0>k&&(b="n",k=0);break;case"ne":if(s){if(t.y<=0&&(0>=m||n>=g)){p=f;break}k-=t.y,m+=t.y,j=k*s}else t.x>=0?g>n?j+=t.x:t.y<=0&&0>=m&&(p=f):j+=t.x,t.y<=0?m>0&&(k-=t.y,m+=t.y):(k-=t.y,m+=t.y);0>k&&(b="sw",k=0,j=0);break;case"nw":if(s){if(t.y<=0&&(0>=m||0>=l)){p=f;break}k-=t.y,m+=t.y,j=k*s,l+=t.X}else t.x<=0?l>0?(j-=t.x,l+=t.x):t.y<=0&&0>=m&&(p=f):(j-=t.x,l+=t.x),t.y<=0?m>0&&(k-=t.y,m+=t.y):(k-=t.y,m+=t.y);0>k&&(b="se",k=0,j=0);break;case"sw":if(s){if(t.x<=0&&(0>=l||o>=h)){p=f;break}j-=t.x,l+=t.x,k=j/s}else t.x<=0?l>0?(j-=t.x,l+=t.x):t.y>=0&&o>=h&&(p=f):(j-=t.x,l+=t.x),t.y>=0?h>o&&(k+=t.y):k+=t.y;0>j&&(b="ne",k=0,j=0);break;case"se":if(s){if(t.x>=0&&(n>=g||o>=h)){p=f;break}j+=t.x,k=j/s}else t.x>=0?g>n?j+=t.x:t.y>=0&&o>=h&&(p=f):j+=t.x,t.y>=0?h>o&&(k+=t.y):k+=t.y;0>j&&(b="nw",k=0,j=0);break;case"move":c.left+=t.x,c.top+=t.y,this.renderImage("move"),p=f;break;case"zoom":r.zoomable&&(this.zoom(function(a,b,c,d,e,f){return(J(e*e+f*f)-J(c*c+d*d))/J(a*a+b*b)}(c.width,c.height,M(this.startX-this.startX2),M(this.startY-this.startY2),M(this.endX-this.endX2),M(this.endY-this.endY2))),this.endX2=this.startX2,this.endY2=this.startY2);break;case"crop":t.x&&t.y&&(a=this.$cropper.offset(),l=this.startX-a.left,m=this.startY-a.top,j=i.minWidth,k=i.minHeight,t.x>0?t.y>0?b="se":(b="ne",m-=k):t.y>0?(b="sw",l-=j):(b="nw",l-=j,m-=k),this.cropped||(this.cropped=e,this.$dragger.removeClass(q)))}p&&(i.width=j,i.height=k,i.left=l,i.top=m,this.directive=b,this.renderDragger()),this.startX=this.endX,this.startY=this.endY}},H.TEMPLATE=function(a,b){return b=b.split(","),a.replace(/\d+/g,function(a){return b[a]})}('<0 6="5-container"><0 6="5-canvas"></0><0 6="5-dragger"><1 6="5-viewer"></1><1 6="5-8 8-h"></1><1 6="5-8 8-v"></1><1 6="5-face" 3-2="all"></1><1 6="5-7 7-e" 3-2="e"></1><1 6="5-7 7-n" 3-2="n"></1><1 6="5-7 7-w" 3-2="w"></1><1 6="5-7 7-s" 3-2="s"></1><1 6="5-4 4-e" 3-2="e"></1><1 6="5-4 4-n" 3-2="n"></1><1 6="5-4 4-w" 3-2="w"></1><1 6="5-4 4-s" 3-2="s"></1><1 6="5-4 4-ne" 3-2="ne"></1><1 6="5-4 4-nw" 3-2="nw"></1><1 6="5-4 4-sw" 3-2="sw"></1><1 6="5-4 4-se" 3-2="se"></1></0></0>',"div,span,directive,data,point,cropper,class,line,dashed"),H.DEFAULTS={aspectRatio:"auto",autoCropArea:.8,data:{},done:a.noop,preview:"",multiple:f,autoCrop:e,dragCrop:e,dashed:e,modal:e,movable:e,resizable:e,zoomable:e,rotatable:e,checkImageOrigin:e,minWidth:0,minHeight:0,maxWidth:i,maxHeight:i,build:g,built:g,dragstart:g,dragmove:g,dragend:g},H.setDefaults=function(b){a.extend(H.DEFAULTS,b)},H.other=a.fn.cropper,a.fn.cropper=function(b){var c,d=[].slice.call(arguments,1);return this.each(function(){var e,f=a(this),g=f.data("cropper");g||f.data("cropper",g=new H(this,b)),"string"==typeof b&&a.isFunction(e=g[b])&&(c=e.apply(g,d))}),typeof c!==j?c:this},a.fn.cropper.Constructor=H,a.fn.cropper.setDefaults=H.setDefaults,a.fn.cropper.noConflict=function(){return a.fn.cropper=H.other,this}});
/* =========================================================
 * bootstrap-datepicker.js
 * Repo: https://github.com/eternicode/bootstrap-datepicker/
 * Demo: http://eternicode.github.io/bootstrap-datepicker/
 * Docs: http://bootstrap-datepicker.readthedocs.org/
 * Forked from http://www.eyecon.ro/bootstrap-datepicker
 * =========================================================
 * Started by Stefan Petre; improvements by Andrew Rowls + contributors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * ========================================================= */


(function($, undefined){

	var $window = $(window);

	function UTCDate(){
		return new Date(Date.UTC.apply(Date, arguments));
	}
	function UTCToday(){
		var today = new Date();
		return UTCDate(today.getFullYear(), today.getMonth(), today.getDate());
	}
	function alias(method){
		return function(){
			return this[method].apply(this, arguments);
		};
	}

	var DateArray = (function(){
		var extras = {
			get: function(i){
				return this.slice(i)[0];
			},
			contains: function(d){
				// Array.indexOf is not cross-browser;
				// $.inArray doesn't work with Dates
				var val = d && d.valueOf();
				for (var i=0, l=this.length; i < l; i++)
					if (this[i].valueOf() === val)
						return i;
				return -1;
			},
			remove: function(i){
				this.splice(i,1);
			},
			replace: function(new_array){
				if (!new_array)
					return;
				if (!$.isArray(new_array))
					new_array = [new_array];
				this.clear();
				this.push.apply(this, new_array);
			},
			clear: function(){
				this.splice(0);
			},
			copy: function(){
				var a = new DateArray();
				a.replace(this);
				return a;
			}
		};

		return function(){
			var a = [];
			a.push.apply(a, arguments);
			$.extend(a, extras);
			return a;
		};
	})();


	// Picker object

	var Datepicker = function(element, options){
		this.dates = new DateArray();
		this.viewDate = UTCToday();
		this.focusDate = null;

		this._process_options(options);

		this.element = $(element);
		this.isInline = false;
		this.isInput = this.element.is('input');
		this.component = this.element.is('.date') ? this.element.find('.add-on, .input-group-addon, .btn') : false;
		this.hasInput = this.component && this.element.find('input').length;
		if (this.component && this.component.length === 0)
			this.component = false;

		this.picker = $(DPGlobal.template);
		this._buildEvents();
		this._attachEvents();

		if (this.isInline){
			this.picker.addClass('datepicker-inline').appendTo(this.element);
		}
		else {
			this.picker.addClass('datepicker-dropdown dropdown-menu');
		}

		if (this.o.rtl){
			this.picker.addClass('datepicker-rtl');
		}

		this.viewMode = this.o.startView;

		if (this.o.calendarWeeks)
			this.picker.find('tfoot th.today')
						.attr('colspan', function(i, val){
							return parseInt(val) + 1;
						});

		this._allow_update = false;

		this.setStartDate(this._o.startDate);
		this.setEndDate(this._o.endDate);
		this.setDaysOfWeekDisabled(this.o.daysOfWeekDisabled);

		this.fillDow();
		this.fillMonths();

		this._allow_update = true;

		this.update();
		this.showMode();

		if (this.isInline){
			this.show();
		}
	};

	Datepicker.prototype = {
		constructor: Datepicker,

		_process_options: function(opts){
			// Store raw options for reference
			this._o = $.extend({}, this._o, opts);
			// Processed options
			var o = this.o = $.extend({}, this._o);

			// Check if "de-DE" style date is available, if not language should
			// fallback to 2 letter code eg "de"
			var lang = o.language;
			if (!dates[lang]){
				lang = lang.split('-')[0];
				if (!dates[lang])
					lang = defaults.language;
			}
			o.language = lang;

			switch (o.startView){
				case 2:
				case 'decade':
					o.startView = 2;
					break;
				case 1:
				case 'year':
					o.startView = 1;
					break;
				default:
					o.startView = 0;
			}

			switch (o.minViewMode){
				case 1:
				case 'months':
					o.minViewMode = 1;
					break;
				case 2:
				case 'years':
					o.minViewMode = 2;
					break;
				default:
					o.minViewMode = 0;
			}

			o.startView = Math.max(o.startView, o.minViewMode);

			// true, false, or Number > 0
			if (o.multidate !== true){
				o.multidate = Number(o.multidate) || false;
				if (o.multidate !== false)
					o.multidate = Math.max(0, o.multidate);
				else
					o.multidate = 1;
			}
			o.multidateSeparator = String(o.multidateSeparator);

			o.weekStart %= 7;
			o.weekEnd = ((o.weekStart + 6) % 7);

			var format = DPGlobal.parseFormat(o.format);
			if (o.startDate !== -Infinity){
				if (!!o.startDate){
					if (o.startDate instanceof Date)
						o.startDate = this._local_to_utc(this._zero_time(o.startDate));
					else
						o.startDate = DPGlobal.parseDate(o.startDate, format, o.language);
				}
				else {
					o.startDate = -Infinity;
				}
			}
			if (o.endDate !== Infinity){
				if (!!o.endDate){
					if (o.endDate instanceof Date)
						o.endDate = this._local_to_utc(this._zero_time(o.endDate));
					else
						o.endDate = DPGlobal.parseDate(o.endDate, format, o.language);
				}
				else {
					o.endDate = Infinity;
				}
			}

			o.daysOfWeekDisabled = o.daysOfWeekDisabled||[];
			if (!$.isArray(o.daysOfWeekDisabled))
				o.daysOfWeekDisabled = o.daysOfWeekDisabled.split(/[,\s]*/);
			o.daysOfWeekDisabled = $.map(o.daysOfWeekDisabled, function(d){
				return parseInt(d, 10);
			});

			var plc = String(o.orientation).toLowerCase().split(/\s+/g),
				_plc = o.orientation.toLowerCase();
			plc = $.grep(plc, function(word){
				return (/^auto|left|right|top|bottom$/).test(word);
			});
			o.orientation = {x: 'auto', y: 'auto'};
			if (!_plc || _plc === 'auto')
				; // no action
			else if (plc.length === 1){
				switch (plc[0]){
					case 'top':
					case 'bottom':
						o.orientation.y = plc[0];
						break;
					case 'left':
					case 'right':
						o.orientation.x = plc[0];
						break;
				}
			}
			else {
				_plc = $.grep(plc, function(word){
					return (/^left|right$/).test(word);
				});
				o.orientation.x = _plc[0] || 'auto';

				_plc = $.grep(plc, function(word){
					return (/^top|bottom$/).test(word);
				});
				o.orientation.y = _plc[0] || 'auto';
			}
		},
		_events: [],
		_secondaryEvents: [],
		_applyEvents: function(evs){
			for (var i=0, el, ch, ev; i < evs.length; i++){
				el = evs[i][0];
				if (evs[i].length === 2){
					ch = undefined;
					ev = evs[i][1];
				}
				else if (evs[i].length === 3){
					ch = evs[i][1];
					ev = evs[i][2];
				}
				el.on(ev, ch);
			}
		},
		_unapplyEvents: function(evs){
			for (var i=0, el, ev, ch; i < evs.length; i++){
				el = evs[i][0];
				if (evs[i].length === 2){
					ch = undefined;
					ev = evs[i][1];
				}
				else if (evs[i].length === 3){
					ch = evs[i][1];
					ev = evs[i][2];
				}
				el.off(ev, ch);
			}
		},
		_buildEvents: function(){
			if (this.isInput){ // single input
				this._events = [
					[this.element, {
						focus: $.proxy(this.show, this),
						keyup: $.proxy(function(e){
							if ($.inArray(e.keyCode, [27,37,39,38,40,32,13,9]) === -1)
								this.update();
						}, this),
						keydown: $.proxy(this.keydown, this)
					}]
				];
			}
			else if (this.component && this.hasInput){ // component: input + button
				this._events = [
					// For components that are not readonly, allow keyboard nav
					[this.element.find('input'), {
						focus: $.proxy(this.show, this),
						keyup: $.proxy(function(e){
							if ($.inArray(e.keyCode, [27,37,39,38,40,32,13,9]) === -1)
								this.update();
						}, this),
						keydown: $.proxy(this.keydown, this)
					}],
					[this.component, {
						click: $.proxy(this.show, this)
					}]
				];
			}
			else if (this.element.is('div')){  // inline datepicker
				this.isInline = true;
			}
			else {
				this._events = [
					[this.element, {
						click: $.proxy(this.show, this)
					}]
				];
			}
			this._events.push(
				// Component: listen for blur on element descendants
				[this.element, '*', {
					blur: $.proxy(function(e){
						this._focused_from = e.target;
					}, this)
				}],
				// Input: listen for blur on element
				[this.element, {
					blur: $.proxy(function(e){
						this._focused_from = e.target;
					}, this)
				}]
			);

			this._secondaryEvents = [
				[this.picker, {
					click: $.proxy(this.click, this)
				}],
				[$(window), {
					resize: $.proxy(this.place, this)
				}],
				[$(document), {
					'mousedown touchstart': $.proxy(function(e){
						// Clicked outside the datepicker, hide it
						if (!(
							this.element.is(e.target) ||
							this.element.find(e.target).length ||
							this.picker.is(e.target) ||
							this.picker.find(e.target).length
						)){
							this.hide();
						}
					}, this)
				}]
			];
		},
		_attachEvents: function(){
			this._detachEvents();
			this._applyEvents(this._events);
		},
		_detachEvents: function(){
			this._unapplyEvents(this._events);
		},
		_attachSecondaryEvents: function(){
			this._detachSecondaryEvents();
			this._applyEvents(this._secondaryEvents);
		},
		_detachSecondaryEvents: function(){
			this._unapplyEvents(this._secondaryEvents);
		},
		_trigger: function(event, altdate){
			var date = altdate || this.dates.get(-1),
				local_date = this._utc_to_local(date);

			this.element.trigger({
				type: event,
				date: local_date,
				dates: $.map(this.dates, this._utc_to_local),
				format: $.proxy(function(ix, format){
					if (arguments.length === 0){
						ix = this.dates.length - 1;
						format = this.o.format;
					}
					else if (typeof ix === 'string'){
						format = ix;
						ix = this.dates.length - 1;
					}
					format = format || this.o.format;
					var date = this.dates.get(ix);
					return DPGlobal.formatDate(date, format, this.o.language);
				}, this)
			});
		},

		show: function(){
			if (!this.isInline)
				this.picker.appendTo('body');
			this.picker.show();
			this.place();
			this._attachSecondaryEvents();
			this._trigger('show');
		},

		hide: function(){
			if (this.isInline)
				return;
			if (!this.picker.is(':visible'))
				return;
			this.focusDate = null;
			this.picker.hide().detach();
			this._detachSecondaryEvents();
			this.viewMode = this.o.startView;
			this.showMode();

			if (
				this.o.forceParse &&
				(
					this.isInput && this.element.val() ||
					this.hasInput && this.element.find('input').val()
				)
			)
				this.setValue();
			this._trigger('hide');
		},

		remove: function(){
			this.hide();
			this._detachEvents();
			this._detachSecondaryEvents();
			this.picker.remove();
			delete this.element.data().datepicker;
			if (!this.isInput){
				delete this.element.data().date;
			}
		},

		_utc_to_local: function(utc){
			return utc && new Date(utc.getTime() + (utc.getTimezoneOffset()*60000));
		},
		_local_to_utc: function(local){
			return local && new Date(local.getTime() - (local.getTimezoneOffset()*60000));
		},
		_zero_time: function(local){
			return local && new Date(local.getFullYear(), local.getMonth(), local.getDate());
		},
		_zero_utc_time: function(utc){
			return utc && new Date(Date.UTC(utc.getUTCFullYear(), utc.getUTCMonth(), utc.getUTCDate()));
		},

		getDates: function(){
			return $.map(this.dates, this._utc_to_local);
		},

		getUTCDates: function(){
			return $.map(this.dates, function(d){
				return new Date(d);
			});
		},

		getDate: function(){
			return this._utc_to_local(this.getUTCDate());
		},

		getUTCDate: function(){
			return new Date(this.dates.get(-1));
		},

		setDates: function(){
			var args = $.isArray(arguments[0]) ? arguments[0] : arguments;
			this.update.apply(this, args);
			this._trigger('changeDate');
			this.setValue();
		},

		setUTCDates: function(){
			var args = $.isArray(arguments[0]) ? arguments[0] : arguments;
			this.update.apply(this, $.map(args, this._utc_to_local));
			this._trigger('changeDate');
			this.setValue();
		},

		setDate: alias('setDates'),
		setUTCDate: alias('setUTCDates'),

		setValue: function(){
			var formatted = this.getFormattedDate();
			if (!this.isInput){
				if (this.component){
					this.element.find('input').val(formatted).change();
				}
			}
			else {
				this.element.val(formatted).change();
			}
		},

		getFormattedDate: function(format){
			if (format === undefined)
				format = this.o.format;

			var lang = this.o.language;
			return $.map(this.dates, function(d){
				return DPGlobal.formatDate(d, format, lang);
			}).join(this.o.multidateSeparator);
		},

		setStartDate: function(startDate){
			this._process_options({startDate: startDate});
			this.update();
			this.updateNavArrows();
		},

		setEndDate: function(endDate){
			this._process_options({endDate: endDate});
			this.update();
			this.updateNavArrows();
		},

		setDaysOfWeekDisabled: function(daysOfWeekDisabled){
			this._process_options({daysOfWeekDisabled: daysOfWeekDisabled});
			this.update();
			this.updateNavArrows();
		},

		place: function(){
			if (this.isInline)
				return;
			var calendarWidth = this.picker.outerWidth(),
				calendarHeight = this.picker.outerHeight(),
				visualPadding = 10,
				windowWidth = $window.width(),
				windowHeight = $window.height(),
				scrollTop = $window.scrollTop();

			var zIndex = parseInt(this.element.parents().filter(function(){
					return $(this).css('z-index') !== 'auto';
				}).first().css('z-index'))+10;
			var offset = this.component ? this.component.parent().offset() : this.element.offset();
			var height = this.component ? this.component.outerHeight(true) : this.element.outerHeight(false);
			var width = this.component ? this.component.outerWidth(true) : this.element.outerWidth(false);
			var left = offset.left,
				top = offset.top;

			this.picker.removeClass(
				'datepicker-orient-top datepicker-orient-bottom '+
				'datepicker-orient-right datepicker-orient-left'
			);

			if (this.o.orientation.x !== 'auto'){
				this.picker.addClass('datepicker-orient-' + this.o.orientation.x);
				if (this.o.orientation.x === 'right')
					left -= calendarWidth - width;
			}
			// auto x orientation is best-placement: if it crosses a window
			// edge, fudge it sideways
			else {
				// Default to left
				this.picker.addClass('datepicker-orient-left');
				if (offset.left < 0)
					left -= offset.left - visualPadding;
				else if (offset.left + calendarWidth > windowWidth)
					left = windowWidth - calendarWidth - visualPadding;
			}

			// auto y orientation is best-situation: top or bottom, no fudging,
			// decision based on which shows more of the calendar
			var yorient = this.o.orientation.y,
				top_overflow, bottom_overflow;
			if (yorient === 'auto'){
				top_overflow = -scrollTop + offset.top - calendarHeight;
				bottom_overflow = scrollTop + windowHeight - (offset.top + height + calendarHeight);
				if (Math.max(top_overflow, bottom_overflow) === bottom_overflow)
					yorient = 'top';
				else
					yorient = 'bottom';
			}
			this.picker.addClass('datepicker-orient-' + yorient);
			if (yorient === 'top')
				top += height;
			else
				top -= calendarHeight + parseInt(this.picker.css('padding-top'));

			this.picker.css({
				top: top,
				left: left,
				zIndex: zIndex
			});
		},

		_allow_update: true,
		update: function(){
			if (!this._allow_update)
				return;

			var oldDates = this.dates.copy(),
				dates = [],
				fromArgs = false;
			if (arguments.length){
				$.each(arguments, $.proxy(function(i, date){
					if (date instanceof Date)
						date = this._local_to_utc(date);
					dates.push(date);
				}, this));
				fromArgs = true;
			}
			else {
				dates = this.isInput
						? this.element.val()
						: this.element.data('date') || this.element.find('input').val();
				if (dates && this.o.multidate)
					dates = dates.split(this.o.multidateSeparator);
				else
					dates = [dates];
				delete this.element.data().date;
			}

			dates = $.map(dates, $.proxy(function(date){
				return DPGlobal.parseDate(date, this.o.format, this.o.language);
			}, this));
			dates = $.grep(dates, $.proxy(function(date){
				return (
					date < this.o.startDate ||
					date > this.o.endDate ||
					!date
				);
			}, this), true);
			this.dates.replace(dates);

			if (this.dates.length)
				this.viewDate = new Date(this.dates.get(-1));
			else if (this.viewDate < this.o.startDate)
				this.viewDate = new Date(this.o.startDate);
			else if (this.viewDate > this.o.endDate)
				this.viewDate = new Date(this.o.endDate);

			if (fromArgs){
				// setting date by clicking
				this.setValue();
			}
			else if (dates.length){
				// setting date by typing
				if (String(oldDates) !== String(this.dates))
					this._trigger('changeDate');
			}
			if (!this.dates.length && oldDates.length)
				this._trigger('clearDate');

			this.fill();
		},

		fillDow: function(){
			var dowCnt = this.o.weekStart,
				html = '<tr>';
			if (this.o.calendarWeeks){
				var cell = '<th class="cw">&nbsp;</th>';
				html += cell;
				this.picker.find('.datepicker-days thead tr:first-child').prepend(cell);
			}
			while (dowCnt < this.o.weekStart + 7){
				html += '<th class="dow">'+dates[this.o.language].daysMin[(dowCnt++)%7]+'</th>';
			}
			html += '</tr>';
			this.picker.find('.datepicker-days thead').append(html);
		},

		fillMonths: function(){
			var html = '',
			i = 0;
			while (i < 12){
				html += '<span class="month">'+dates[this.o.language].monthsShort[i++]+'</span>';
			}
			this.picker.find('.datepicker-months td').html(html);
		},

		setRange: function(range){
			if (!range || !range.length)
				delete this.range;
			else
				this.range = $.map(range, function(d){
					return d.valueOf();
				});
			this.fill();
		},

		getClassNames: function(date){
			var cls = [],
				year = this.viewDate.getUTCFullYear(),
				month = this.viewDate.getUTCMonth(),
				today = new Date();
			if (date.getUTCFullYear() < year || (date.getUTCFullYear() === year && date.getUTCMonth() < month)){
				cls.push('old');
			}
			else if (date.getUTCFullYear() > year || (date.getUTCFullYear() === year && date.getUTCMonth() > month)){
				cls.push('new');
			}
			if (this.focusDate && date.valueOf() === this.focusDate.valueOf())
				cls.push('focused');
			// Compare internal UTC date with local today, not UTC today
			if (this.o.todayHighlight &&
				date.getUTCFullYear() === today.getFullYear() &&
				date.getUTCMonth() === today.getMonth() &&
				date.getUTCDate() === today.getDate()){
				cls.push('today');
			}
			if (this.dates.contains(date) !== -1)
				cls.push('active');
			if (date.valueOf() < this.o.startDate || date.valueOf() > this.o.endDate ||
				$.inArray(date.getUTCDay(), this.o.daysOfWeekDisabled) !== -1){
				cls.push('disabled');
			}
			if (this.range){
				if (date > this.range[0] && date < this.range[this.range.length-1]){
					cls.push('range');
				}
				if ($.inArray(date.valueOf(), this.range) !== -1){
					cls.push('selected');
				}
			}
			return cls;
		},

		fill: function(){
			var d = new Date(this.viewDate),
				year = d.getUTCFullYear(),
				month = d.getUTCMonth(),
				startYear = this.o.startDate !== -Infinity ? this.o.startDate.getUTCFullYear() : -Infinity,
				startMonth = this.o.startDate !== -Infinity ? this.o.startDate.getUTCMonth() : -Infinity,
				endYear = this.o.endDate !== Infinity ? this.o.endDate.getUTCFullYear() : Infinity,
				endMonth = this.o.endDate !== Infinity ? this.o.endDate.getUTCMonth() : Infinity,
				todaytxt = dates[this.o.language].today || dates['en'].today || '',
				cleartxt = dates[this.o.language].clear || dates['en'].clear || '',
				tooltip;
			this.picker.find('.datepicker-days thead th.datepicker-switch')
						.text(dates[this.o.language].months[month]+' '+year);
			this.picker.find('tfoot th.today')
						.text(todaytxt)
						.toggle(this.o.todayBtn !== false);
			this.picker.find('tfoot th.clear')
						.text(cleartxt)
						.toggle(this.o.clearBtn !== false);
			this.updateNavArrows();
			this.fillMonths();
			var prevMonth = UTCDate(year, month-1, 28),
				day = DPGlobal.getDaysInMonth(prevMonth.getUTCFullYear(), prevMonth.getUTCMonth());
			prevMonth.setUTCDate(day);
			prevMonth.setUTCDate(day - (prevMonth.getUTCDay() - this.o.weekStart + 7)%7);
			var nextMonth = new Date(prevMonth);
			nextMonth.setUTCDate(nextMonth.getUTCDate() + 42);
			nextMonth = nextMonth.valueOf();
			var html = [];
			var clsName;
			while (prevMonth.valueOf() < nextMonth){
				if (prevMonth.getUTCDay() === this.o.weekStart){
					html.push('<tr>');
					if (this.o.calendarWeeks){
						// ISO 8601: First week contains first thursday.
						// ISO also states week starts on Monday, but we can be more abstract here.
						var
							// Start of current week: based on weekstart/current date
							ws = new Date(+prevMonth + (this.o.weekStart - prevMonth.getUTCDay() - 7) % 7 * 864e5),
							// Thursday of this week
							th = new Date(Number(ws) + (7 + 4 - ws.getUTCDay()) % 7 * 864e5),
							// First Thursday of year, year from thursday
							yth = new Date(Number(yth = UTCDate(th.getUTCFullYear(), 0, 1)) + (7 + 4 - yth.getUTCDay())%7*864e5),
							// Calendar week: ms between thursdays, div ms per day, div 7 days
							calWeek =  (th - yth) / 864e5 / 7 + 1;
						html.push('<td class="cw">'+ calWeek +'</td>');

					}
				}
				clsName = this.getClassNames(prevMonth);
				clsName.push('day');

				if (this.o.beforeShowDay !== $.noop){
					var before = this.o.beforeShowDay(this._utc_to_local(prevMonth));
					if (before === undefined)
						before = {};
					else if (typeof(before) === 'boolean')
						before = {enabled: before};
					else if (typeof(before) === 'string')
						before = {classes: before};
					if (before.enabled === false)
						clsName.push('disabled');
					if (before.classes)
						clsName = clsName.concat(before.classes.split(/\s+/));
					if (before.tooltip)
						tooltip = before.tooltip;
				}

				clsName = $.unique(clsName);
				html.push('<td class="'+clsName.join(' ')+'"' + (tooltip ? ' title="'+tooltip+'"' : '') + '>'+prevMonth.getUTCDate() + '</td>');
				if (prevMonth.getUTCDay() === this.o.weekEnd){
					html.push('</tr>');
				}
				prevMonth.setUTCDate(prevMonth.getUTCDate()+1);
			}
			this.picker.find('.datepicker-days tbody').empty().append(html.join(''));

			var months = this.picker.find('.datepicker-months')
						.find('th:eq(1)')
							.text(year)
							.end()
						.find('span').removeClass('active');

			$.each(this.dates, function(i, d){
				if (d.getUTCFullYear() === year)
					months.eq(d.getUTCMonth()).addClass('active');
			});

			if (year < startYear || year > endYear){
				months.addClass('disabled');
			}
			if (year === startYear){
				months.slice(0, startMonth).addClass('disabled');
			}
			if (year === endYear){
				months.slice(endMonth+1).addClass('disabled');
			}

			html = '';
			year = parseInt(year/10, 10) * 10;
			var yearCont = this.picker.find('.datepicker-years')
								.find('th:eq(1)')
									.text(year + '-' + (year + 9))
									.end()
								.find('td');
			year -= 1;
			var years = $.map(this.dates, function(d){
					return d.getUTCFullYear();
				}),
				classes;
			for (var i = -1; i < 11; i++){
				classes = ['year'];
				if (i === -1)
					classes.push('old');
				else if (i === 10)
					classes.push('new');
				if ($.inArray(year, years) !== -1)
					classes.push('active');
				if (year < startYear || year > endYear)
					classes.push('disabled');
				html += '<span class="' + classes.join(' ') + '">'+year+'</span>';
				year += 1;
			}
			yearCont.html(html);
		},

		updateNavArrows: function(){
			if (!this._allow_update)
				return;

			var d = new Date(this.viewDate),
				year = d.getUTCFullYear(),
				month = d.getUTCMonth();
			switch (this.viewMode){
				case 0:
					if (this.o.startDate !== -Infinity && year <= this.o.startDate.getUTCFullYear() && month <= this.o.startDate.getUTCMonth()){
						this.picker.find('.prev').css({visibility: 'hidden'});
					}
					else {
						this.picker.find('.prev').css({visibility: 'visible'});
					}
					if (this.o.endDate !== Infinity && year >= this.o.endDate.getUTCFullYear() && month >= this.o.endDate.getUTCMonth()){
						this.picker.find('.next').css({visibility: 'hidden'});
					}
					else {
						this.picker.find('.next').css({visibility: 'visible'});
					}
					break;
				case 1:
				case 2:
					if (this.o.startDate !== -Infinity && year <= this.o.startDate.getUTCFullYear()){
						this.picker.find('.prev').css({visibility: 'hidden'});
					}
					else {
						this.picker.find('.prev').css({visibility: 'visible'});
					}
					if (this.o.endDate !== Infinity && year >= this.o.endDate.getUTCFullYear()){
						this.picker.find('.next').css({visibility: 'hidden'});
					}
					else {
						this.picker.find('.next').css({visibility: 'visible'});
					}
					break;
			}
		},

		click: function(e){
			e.preventDefault();
			var target = $(e.target).closest('span, td, th'),
				year, month, day;
			if (target.length === 1){
				switch (target[0].nodeName.toLowerCase()){
					case 'th':
						switch (target[0].className){
							case 'datepicker-switch':
								this.showMode(1);
								break;
							case 'prev':
							case 'next':
								var dir = DPGlobal.modes[this.viewMode].navStep * (target[0].className === 'prev' ? -1 : 1);
								switch (this.viewMode){
									case 0:
										this.viewDate = this.moveMonth(this.viewDate, dir);
										this._trigger('changeMonth', this.viewDate);
										break;
									case 1:
									case 2:
										this.viewDate = this.moveYear(this.viewDate, dir);
										if (this.viewMode === 1)
											this._trigger('changeYear', this.viewDate);
										break;
								}
								this.fill();
								break;
							case 'today':
								var date = new Date();
								date = UTCDate(date.getFullYear(), date.getMonth(), date.getDate(), 0, 0, 0);

								this.showMode(-2);
								var which = this.o.todayBtn === 'linked' ? null : 'view';
								this._setDate(date, which);
								break;
							case 'clear':
								var element;
								if (this.isInput)
									element = this.element;
								else if (this.component)
									element = this.element.find('input');
								if (element)
									element.val("").change();
								this.update();
								this._trigger('changeDate');
								if (this.o.autoclose)
									this.hide();
								break;
						}
						break;
					case 'span':
						if (!target.is('.disabled')){
							this.viewDate.setUTCDate(1);
							if (target.is('.month')){
								day = 1;
								month = target.parent().find('span').index(target);
								year = this.viewDate.getUTCFullYear();
								this.viewDate.setUTCMonth(month);
								this._trigger('changeMonth', this.viewDate);
								if (this.o.minViewMode === 1){
									this._setDate(UTCDate(year, month, day));
								}
							}
							else {
								day = 1;
								month = 0;
								year = parseInt(target.text(), 10)||0;
								this.viewDate.setUTCFullYear(year);
								this._trigger('changeYear', this.viewDate);
								if (this.o.minViewMode === 2){
									this._setDate(UTCDate(year, month, day));
								}
							}
							this.showMode(-1);
							this.fill();
						}
						break;
					case 'td':
						if (target.is('.day') && !target.is('.disabled')){
							day = parseInt(target.text(), 10)||1;
							year = this.viewDate.getUTCFullYear();
							month = this.viewDate.getUTCMonth();
							if (target.is('.old')){
								if (month === 0){
									month = 11;
									year -= 1;
								}
								else {
									month -= 1;
								}
							}
							else if (target.is('.new')){
								if (month === 11){
									month = 0;
									year += 1;
								}
								else {
									month += 1;
								}
							}
							this._setDate(UTCDate(year, month, day));
						}
						break;
				}
			}
			if (this.picker.is(':visible') && this._focused_from){
				$(this._focused_from).focus();
			}
			delete this._focused_from;
		},

		_toggle_multidate: function(date){
			var ix = this.dates.contains(date);
			if (!date){
				this.dates.clear();
			}
			else if (ix !== -1){
				this.dates.remove(ix);
			}
			else {
				this.dates.push(date);
			}
			if (typeof this.o.multidate === 'number')
				while (this.dates.length > this.o.multidate)
					this.dates.remove(0);
		},

		_setDate: function(date, which){
			if (!which || which === 'date')
				this._toggle_multidate(date && new Date(date));
			if (!which || which  === 'view')
				this.viewDate = date && new Date(date);

			this.fill();
			this.setValue();
			this._trigger('changeDate');
			var element;
			if (this.isInput){
				element = this.element;
			}
			else if (this.component){
				element = this.element.find('input');
			}
			if (element){
				element.change();
			}
			if (this.o.autoclose && (!which || which === 'date')){
				this.hide();
			}
		},

		moveMonth: function(date, dir){
			if (!date)
				return undefined;
			if (!dir)
				return date;
			var new_date = new Date(date.valueOf()),
				day = new_date.getUTCDate(),
				month = new_date.getUTCMonth(),
				mag = Math.abs(dir),
				new_month, test;
			dir = dir > 0 ? 1 : -1;
			if (mag === 1){
				test = dir === -1
					// If going back one month, make sure month is not current month
					// (eg, Mar 31 -> Feb 31 == Feb 28, not Mar 02)
					? function(){
						return new_date.getUTCMonth() === month;
					}
					// If going forward one month, make sure month is as expected
					// (eg, Jan 31 -> Feb 31 == Feb 28, not Mar 02)
					: function(){
						return new_date.getUTCMonth() !== new_month;
					};
				new_month = month + dir;
				new_date.setUTCMonth(new_month);
				// Dec -> Jan (12) or Jan -> Dec (-1) -- limit expected date to 0-11
				if (new_month < 0 || new_month > 11)
					new_month = (new_month + 12) % 12;
			}
			else {
				// For magnitudes >1, move one month at a time...
				for (var i=0; i < mag; i++)
					// ...which might decrease the day (eg, Jan 31 to Feb 28, etc)...
					new_date = this.moveMonth(new_date, dir);
				// ...then reset the day, keeping it in the new month
				new_month = new_date.getUTCMonth();
				new_date.setUTCDate(day);
				test = function(){
					return new_month !== new_date.getUTCMonth();
				};
			}
			// Common date-resetting loop -- if date is beyond end of month, make it
			// end of month
			while (test()){
				new_date.setUTCDate(--day);
				new_date.setUTCMonth(new_month);
			}
			return new_date;
		},

		moveYear: function(date, dir){
			return this.moveMonth(date, dir*12);
		},

		dateWithinRange: function(date){
			return date >= this.o.startDate && date <= this.o.endDate;
		},

		keydown: function(e){
			if (this.picker.is(':not(:visible)')){
				if (e.keyCode === 27) // allow escape to hide and re-show picker
					this.show();
				return;
			}
			var dateChanged = false,
				dir, newDate, newViewDate,
				focusDate = this.focusDate || this.viewDate;
			switch (e.keyCode){
				case 27: // escape
					if (this.focusDate){
						this.focusDate = null;
						this.viewDate = this.dates.get(-1) || this.viewDate;
						this.fill();
					}
					else
						this.hide();
					e.preventDefault();
					break;
				case 37: // left
				case 39: // right
					if (!this.o.keyboardNavigation)
						break;
					dir = e.keyCode === 37 ? -1 : 1;
					if (e.ctrlKey){
						newDate = this.moveYear(this.dates.get(-1) || UTCToday(), dir);
						newViewDate = this.moveYear(focusDate, dir);
						this._trigger('changeYear', this.viewDate);
					}
					else if (e.shiftKey){
						newDate = this.moveMonth(this.dates.get(-1) || UTCToday(), dir);
						newViewDate = this.moveMonth(focusDate, dir);
						this._trigger('changeMonth', this.viewDate);
					}
					else {
						newDate = new Date(this.dates.get(-1) || UTCToday());
						newDate.setUTCDate(newDate.getUTCDate() + dir);
						newViewDate = new Date(focusDate);
						newViewDate.setUTCDate(focusDate.getUTCDate() + dir);
					}
					if (this.dateWithinRange(newDate)){
						this.focusDate = this.viewDate = newViewDate;
						this.setValue();
						this.fill();
						e.preventDefault();
					}
					break;
				case 38: // up
				case 40: // down
					if (!this.o.keyboardNavigation)
						break;
					dir = e.keyCode === 38 ? -1 : 1;
					if (e.ctrlKey){
						newDate = this.moveYear(this.dates.get(-1) || UTCToday(), dir);
						newViewDate = this.moveYear(focusDate, dir);
						this._trigger('changeYear', this.viewDate);
					}
					else if (e.shiftKey){
						newDate = this.moveMonth(this.dates.get(-1) || UTCToday(), dir);
						newViewDate = this.moveMonth(focusDate, dir);
						this._trigger('changeMonth', this.viewDate);
					}
					else {
						newDate = new Date(this.dates.get(-1) || UTCToday());
						newDate.setUTCDate(newDate.getUTCDate() + dir * 7);
						newViewDate = new Date(focusDate);
						newViewDate.setUTCDate(focusDate.getUTCDate() + dir * 7);
					}
					if (this.dateWithinRange(newDate)){
						this.focusDate = this.viewDate = newViewDate;
						this.setValue();
						this.fill();
						e.preventDefault();
					}
					break;
				case 32: // spacebar
					// Spacebar is used in manually typing dates in some formats.
					// As such, its behavior should not be hijacked.
					break;
				case 13: // enter
					focusDate = this.focusDate || this.dates.get(-1) || this.viewDate;
					this._toggle_multidate(focusDate);
					dateChanged = true;
					this.focusDate = null;
					this.viewDate = this.dates.get(-1) || this.viewDate;
					this.setValue();
					this.fill();
					if (this.picker.is(':visible')){
						e.preventDefault();
						if (this.o.autoclose)
							this.hide();
					}
					break;
				case 9: // tab
					this.focusDate = null;
					this.viewDate = this.dates.get(-1) || this.viewDate;
					this.fill();
					this.hide();
					break;
			}
			if (dateChanged){
				if (this.dates.length)
					this._trigger('changeDate');
				else
					this._trigger('clearDate');
				var element;
				if (this.isInput){
					element = this.element;
				}
				else if (this.component){
					element = this.element.find('input');
				}
				if (element){
					element.change();
				}
			}
		},

		showMode: function(dir){
			if (dir){
				this.viewMode = Math.max(this.o.minViewMode, Math.min(2, this.viewMode + dir));
			}
			this.picker
				.find('>div')
				.hide()
				.filter('.datepicker-'+DPGlobal.modes[this.viewMode].clsName)
					.css('display', 'block');
			this.updateNavArrows();
		}
	};

	var DateRangePicker = function(element, options){
		this.element = $(element);
		this.inputs = $.map(options.inputs, function(i){
			return i.jquery ? i[0] : i;
		});
		delete options.inputs;

		$(this.inputs)
			.datepicker(options)
			.bind('changeDate', $.proxy(this.dateUpdated, this));

		this.pickers = $.map(this.inputs, function(i){
			return $(i).data('datepicker');
		});
		this.updateDates();
	};
	DateRangePicker.prototype = {
		updateDates: function(){
			this.dates = $.map(this.pickers, function(i){
				return i.getUTCDate();
			});
			this.updateRanges();
		},
		updateRanges: function(){
			var range = $.map(this.dates, function(d){
				return d.valueOf();
			});
			$.each(this.pickers, function(i, p){
				p.setRange(range);
			});
		},
		dateUpdated: function(e){
			// `this.updating` is a workaround for preventing infinite recursion
			// between `changeDate` triggering and `setUTCDate` calling.  Until
			// there is a better mechanism.
			if (this.updating)
				return;
			this.updating = true;

			var dp = $(e.target).data('datepicker'),
				new_date = dp.getUTCDate(),
				i = $.inArray(e.target, this.inputs),
				l = this.inputs.length;
			if (i === -1)
				return;

			$.each(this.pickers, function(i, p){
				if (!p.getUTCDate())
					p.setUTCDate(new_date);
			});

			if (new_date < this.dates[i]){
				// Date being moved earlier/left
				while (i >= 0 && new_date < this.dates[i]){
					this.pickers[i--].setUTCDate(new_date);
				}
			}
			else if (new_date > this.dates[i]){
				// Date being moved later/right
				while (i < l && new_date > this.dates[i]){
					this.pickers[i++].setUTCDate(new_date);
				}
			}
			this.updateDates();

			delete this.updating;
		},
		remove: function(){
			$.map(this.pickers, function(p){ p.remove(); });
			delete this.element.data().datepicker;
		}
	};

	function opts_from_el(el, prefix){
		// Derive options from element data-attrs
		var data = $(el).data(),
			out = {}, inkey,
			replace = new RegExp('^' + prefix.toLowerCase() + '([A-Z])');
		prefix = new RegExp('^' + prefix.toLowerCase());
		function re_lower(_,a){
			return a.toLowerCase();
		}
		for (var key in data)
			if (prefix.test(key)){
				inkey = key.replace(replace, re_lower);
				out[inkey] = data[key];
			}
		return out;
	}

	function opts_from_locale(lang){
		// Derive options from locale plugins
		var out = {};
		// Check if "de-DE" style date is available, if not language should
		// fallback to 2 letter code eg "de"
		if (!dates[lang]){
			lang = lang.split('-')[0];
			if (!dates[lang])
				return;
		}
		var d = dates[lang];
		$.each(locale_opts, function(i,k){
			if (k in d)
				out[k] = d[k];
		});
		return out;
	}

	var old = $.fn.datepicker;
	$.fn.datepicker = function(option){
		var args = Array.apply(null, arguments);
		args.shift();
		var internal_return;
		this.each(function(){
			var $this = $(this),
				data = $this.data('datepicker'),
				options = typeof option === 'object' && option;
			if (!data){
				var elopts = opts_from_el(this, 'date'),
					// Preliminary otions
					xopts = $.extend({}, defaults, elopts, options),
					locopts = opts_from_locale(xopts.language),
					// Options priority: js args, data-attrs, locales, defaults
					opts = $.extend({}, defaults, locopts, elopts, options);
				if ($this.is('.input-daterange') || opts.inputs){
					var ropts = {
						inputs: opts.inputs || $this.find('input').toArray()
					};
					$this.data('datepicker', (data = new DateRangePicker(this, $.extend(opts, ropts))));
				}
				else {
					$this.data('datepicker', (data = new Datepicker(this, opts)));
				}
			}
			if (typeof option === 'string' && typeof data[option] === 'function'){
				internal_return = data[option].apply(data, args);
				if (internal_return !== undefined)
					return false;
			}
		});
		if (internal_return !== undefined)
			return internal_return;
		else
			return this;
	};

	var defaults = $.fn.datepicker.defaults = {
		autoclose: false,
		beforeShowDay: $.noop,
		calendarWeeks: false,
		clearBtn: false,
		daysOfWeekDisabled: [],
		endDate: Infinity,
		forceParse: true,
		format: 'mm/dd/yyyy',
		keyboardNavigation: true,
		language: 'en',
		minViewMode: 0,
		multidate: false,
		multidateSeparator: ',',
		orientation: "auto",
		rtl: false,
		startDate: -Infinity,
		startView: 0,
		todayBtn: false,
		todayHighlight: false,
		weekStart: 0
	};
	var locale_opts = $.fn.datepicker.locale_opts = [
		'format',
		'rtl',
		'weekStart'
	];
	$.fn.datepicker.Constructor = Datepicker;
	var dates = $.fn.datepicker.dates = {
		en: {
			days: ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"],
			daysShort: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
			daysMin: ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"],
			months: ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"],
			monthsShort: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
			today: "Today",
			clear: "Clear"
		}
	};

	var DPGlobal = {
		modes: [
			{
				clsName: 'days',
				navFnc: 'Month',
				navStep: 1
			},
			{
				clsName: 'months',
				navFnc: 'FullYear',
				navStep: 1
			},
			{
				clsName: 'years',
				navFnc: 'FullYear',
				navStep: 10
		}],
		isLeapYear: function(year){
			return (((year % 4 === 0) && (year % 100 !== 0)) || (year % 400 === 0));
		},
		getDaysInMonth: function(year, month){
			return [31, (DPGlobal.isLeapYear(year) ? 29 : 28), 31, 30, 31, 30, 31, 31, 30, 31, 30, 31][month];
		},
		validParts: /dd?|DD?|mm?|MM?|yy(?:yy)?/g,
		nonpunctuation: /[^ -\/:-@\[\u3400-\u9fff-`{-~\t\n\r]+/g,
		parseFormat: function(format){
			// IE treats \0 as a string end in inputs (truncating the value),
			// so it's a bad format delimiter, anyway
			var separators = format.replace(this.validParts, '\0').split('\0'),
				parts = format.match(this.validParts);
			if (!separators || !separators.length || !parts || parts.length === 0){
				throw new Error("Invalid date format.");
			}
			return {separators: separators, parts: parts};
		},
		parseDate: function(date, format, language){
			if (!date)
				return undefined;
			if (date instanceof Date)
				return date;
			if (typeof format === 'string')
				format = DPGlobal.parseFormat(format);
			var part_re = /([\-+]\d+)([dmwy])/,
				parts = date.match(/([\-+]\d+)([dmwy])/g),
				part, dir, i;
			if (/^[\-+]\d+[dmwy]([\s,]+[\-+]\d+[dmwy])*$/.test(date)){
				date = new Date();
				for (i=0; i < parts.length; i++){
					part = part_re.exec(parts[i]);
					dir = parseInt(part[1]);
					switch (part[2]){
						case 'd':
							date.setUTCDate(date.getUTCDate() + dir);
							break;
						case 'm':
							date = Datepicker.prototype.moveMonth.call(Datepicker.prototype, date, dir);
							break;
						case 'w':
							date.setUTCDate(date.getUTCDate() + dir * 7);
							break;
						case 'y':
							date = Datepicker.prototype.moveYear.call(Datepicker.prototype, date, dir);
							break;
					}
				}
				return UTCDate(date.getUTCFullYear(), date.getUTCMonth(), date.getUTCDate(), 0, 0, 0);
			}
			parts = date && date.match(this.nonpunctuation) || [];
			date = new Date();
			var parsed = {},
				setters_order = ['yyyy', 'yy', 'M', 'MM', 'm', 'mm', 'd', 'dd'],
				setters_map = {
					yyyy: function(d,v){
						return d.setUTCFullYear(v);
					},
					yy: function(d,v){
						return d.setUTCFullYear(2000+v);
					},
					m: function(d,v){
						if (isNaN(d))
							return d;
						v -= 1;
						while (v < 0) v += 12;
						v %= 12;
						d.setUTCMonth(v);
						while (d.getUTCMonth() !== v)
							d.setUTCDate(d.getUTCDate()-1);
						return d;
					},
					d: function(d,v){
						return d.setUTCDate(v);
					}
				},
				val, filtered;
			setters_map['M'] = setters_map['MM'] = setters_map['mm'] = setters_map['m'];
			setters_map['dd'] = setters_map['d'];
			date = UTCDate(date.getFullYear(), date.getMonth(), date.getDate(), 0, 0, 0);
			var fparts = format.parts.slice();
			// Remove noop parts
			if (parts.length !== fparts.length){
				fparts = $(fparts).filter(function(i,p){
					return $.inArray(p, setters_order) !== -1;
				}).toArray();
			}
			// Process remainder
			function match_part(){
				var m = this.slice(0, parts[i].length),
					p = parts[i].slice(0, m.length);
				return m === p;
			}
			if (parts.length === fparts.length){
				var cnt;
				for (i=0, cnt = fparts.length; i < cnt; i++){
					val = parseInt(parts[i], 10);
					part = fparts[i];
					if (isNaN(val)){
						switch (part){
							case 'MM':
								filtered = $(dates[language].months).filter(match_part);
								val = $.inArray(filtered[0], dates[language].months) + 1;
								break;
							case 'M':
								filtered = $(dates[language].monthsShort).filter(match_part);
								val = $.inArray(filtered[0], dates[language].monthsShort) + 1;
								break;
						}
					}
					parsed[part] = val;
				}
				var _date, s;
				for (i=0; i < setters_order.length; i++){
					s = setters_order[i];
					if (s in parsed && !isNaN(parsed[s])){
						_date = new Date(date);
						setters_map[s](_date, parsed[s]);
						if (!isNaN(_date))
							date = _date;
					}
				}
			}
			return date;
		},
		formatDate: function(date, format, language){
			if (!date)
				return '';
			if (typeof format === 'string')
				format = DPGlobal.parseFormat(format);
			var val = {
				d: date.getUTCDate(),
				D: dates[language].daysShort[date.getUTCDay()],
				DD: dates[language].days[date.getUTCDay()],
				m: date.getUTCMonth() + 1,
				M: dates[language].monthsShort[date.getUTCMonth()],
				MM: dates[language].months[date.getUTCMonth()],
				yy: date.getUTCFullYear().toString().substring(2),
				yyyy: date.getUTCFullYear()
			};
			val.dd = (val.d < 10 ? '0' : '') + val.d;
			val.mm = (val.m < 10 ? '0' : '') + val.m;
			date = [];
			var seps = $.extend([], format.separators);
			for (var i=0, cnt = format.parts.length; i <= cnt; i++){
				if (seps.length)
					date.push(seps.shift());
				date.push(val[format.parts[i]]);
			}
			return date.join('');
		},
		headTemplate: '<thead>'+
							'<tr>'+
								'<th class="prev">&laquo;</th>'+
								'<th colspan="5" class="datepicker-switch"></th>'+
								'<th class="next">&raquo;</th>'+
							'</tr>'+
						'</thead>',
		contTemplate: '<tbody><tr><td colspan="7"></td></tr></tbody>',
		footTemplate: '<tfoot>'+
							'<tr>'+
								'<th colspan="7" class="today"></th>'+
							'</tr>'+
							'<tr>'+
								'<th colspan="7" class="clear"></th>'+
							'</tr>'+
						'</tfoot>'
	};
	DPGlobal.template = '<div class="datepicker">'+
							'<div class="datepicker-days">'+
								'<table class=" table-condensed">'+
									DPGlobal.headTemplate+
									'<tbody></tbody>'+
									DPGlobal.footTemplate+
								'</table>'+
							'</div>'+
							'<div class="datepicker-months">'+
								'<table class="table-condensed">'+
									DPGlobal.headTemplate+
									DPGlobal.contTemplate+
									DPGlobal.footTemplate+
								'</table>'+
							'</div>'+
							'<div class="datepicker-years">'+
								'<table class="table-condensed">'+
									DPGlobal.headTemplate+
									DPGlobal.contTemplate+
									DPGlobal.footTemplate+
								'</table>'+
							'</div>'+
						'</div>';

	$.fn.datepicker.DPGlobal = DPGlobal;


	/* DATEPICKER NO CONFLICT
	* =================== */

	$.fn.datepicker.noConflict = function(){
		$.fn.datepicker = old;
		return this;
	};


	/* DATEPICKER DATA-API
	* ================== */

	$(document).on(
		'focus.datepicker.data-api click.datepicker.data-api',
		'[data-provide="datepicker"]',
		function(e){
			var $this = $(this);
			if ($this.data('datepicker'))
				return;
			e.preventDefault();
			// component click requires us to explicitly show it
			$this.datepicker('show');
		}
	);
	$(function(){
		$('[data-provide="datepicker-inline"]').datepicker();
	});

}(window.jQuery));
// Ion.RangeSlider | version 1.9.1 | https://github.com/IonDen/ion.rangeSlider
(function(c,ea,$,M){var aa=0,s,S=function(){var c=M.userAgent,a=/msie\s\d+/i;return 0<c.search(a)&&(c=a.exec(c).toString(),c=c.split(" ")[1],9>c)?!0:!1}(),X="ontouchstart"in $||0<M.msMaxTouchPoints,N=function(c){"Number"!==typeof c&&(c=parseFloat(c));return isNaN(c)?null:c},H={init:function(fa){return this.each(function(){var a=c.extend({min:null,max:null,from:null,to:null,type:"single",step:null,prefix:"",postfix:"",maxPostfix:"",hasGrid:!1,hideMinMax:!1,hideFromTo:!1,prettify:!0,disable:!1,values:null,
onChange:null,onLoad:null,onFinish:null},fa),e=c(this),n=this,I=!1,g=null;if(!e.data("isActive")){e.data("isActive",!0);this.pluginCount=aa+=1;e.prop("value")&&(g=e.prop("value").split(";"));"single"===a.type?g&&1<g.length?("number"!==typeof a.min?a.min=parseFloat(g[0]):"number"!==typeof a.from&&(a.from=parseFloat(g[0])),"number"!==typeof a.max&&(a.max=parseFloat(g[1]))):g&&1===g.length&&"number"!==typeof a.from&&(a.from=parseFloat(g[0])):"double"===a.type&&(g&&1<g.length?("number"!==typeof a.min?
a.min=parseFloat(g[0]):"number"!==typeof a.from&&(a.from=parseFloat(g[0])),"number"!==typeof a.max?a.max=parseFloat(g[1]):"number"!==typeof a.to&&(a.to=parseFloat(g[1]))):g&&1===g.length&&("number"!==typeof a.min?a.min=parseFloat(g[0]):"number"!==typeof a.from&&(a.from=parseFloat(g[0]))));"number"===typeof e.data("min")&&(a.min=parseFloat(e.data("min")));"number"===typeof e.data("max")&&(a.max=parseFloat(e.data("max")));"number"===typeof e.data("from")&&(a.from=parseFloat(e.data("from")));"number"===
typeof e.data("to")&&(a.to=parseFloat(e.data("to")));e.data("step")&&(a.step=parseFloat(e.data("step")));e.data("type")&&(a.type=e.data("type"));e.data("prefix")&&(a.prefix=e.data("prefix"));e.data("postfix")&&(a.postfix=e.data("postfix"));e.data("maxpostfix")&&(a.maxPostfix=e.data("maxpostfix"));e.data("hasgrid")&&(a.hasGrid=e.data("hasgrid"));e.data("hideminmax")&&(a.hideMinMax=e.data("hideminmax"));e.data("hidefromto")&&(a.hideFromTo=e.data("hidefromto"));e.data("prettify")&&(a.prettify=e.data("prettify"));
e.data("disable")&&(a.disable=e.data("disable"));e.data("values")&&(a.values=e.data("values").split(","));a.min=N(a.min);a.min||0===a.min||(a.min=10);a.max=N(a.max);a.max||0===a.max||(a.max=100);"[object Array]"!==Object.prototype.toString.call(a.values)&&(a.values=null);a.values&&0<a.values.length&&(a.min=0,a.max=a.values.length-1,a.step=1,I=!0);a.from=N(a.from);a.from||0===a.from||(a.from=a.min);a.to=N(a.to);a.to||0===a.to||(a.to=a.max);a.step=N(a.step);a.step||(a.step=1);a.from<a.min&&(a.from=
a.min);a.from>a.max&&(a.from=a.min);a.to<a.min&&(a.to=a.max);a.to>a.max&&(a.to=a.max);"double"===a.type&&(a.from>a.to&&(a.from=a.to),a.to<a.from&&(a.to=a.from));var z=function(b){b=b.toString();a.prettify&&(b=b.replace(/(\d{1,3}(?=(?:\d\d\d)+(?!\d)))/g,"$1 "));return b},g='<span class="irs" id="irs-'+this.pluginCount+'"></span>';e[0].style.display="none";e.before(g);var p=e.prev(),J=c(ea.body),T=c($),q,C,D,A,B,w,x,m,t,r,H,M,v=!1,y=!1,E=!0,f={},U=0,O=0,P=0,l=0,F=0,G=0,V=0,Q=0,R=0,Y=0,u=0;parseInt(a.step,
10)!==parseFloat(a.step)&&(u=a.step.toString().split(".")[1],u=Math.pow(10,u.length));this.updateData=function(b){E=!0;a=c.extend(a,b);p.find("*").off();T.off("mouseup.irs"+n.pluginCount);J.off("mouseup.irs"+n.pluginCount);J.off("mousemove.irs"+n.pluginCount);p.html("");ba()};this.removeSlider=function(){p.find("*").off();T.off("mouseup.irs"+n.pluginCount);J.off("mouseup.irs"+n.pluginCount);J.off("mousemove.irs"+n.pluginCount);p.html("").remove();e.data("isActive",!1);e.show()};var ba=function(){p.html('<span class="irs"><span class="irs-line"><span class="irs-line-left"></span><span class="irs-line-mid"></span><span class="irs-line-right"></span></span><span class="irs-min">0</span><span class="irs-max">1</span><span class="irs-from">0</span><span class="irs-to">0</span><span class="irs-single">0</span></span><span class="irs-grid"></span>');
q=p.find(".irs");C=q.find(".irs-min");D=q.find(".irs-max");A=q.find(".irs-from");B=q.find(".irs-to");w=q.find(".irs-single");M=p.find(".irs-grid");a.hideFromTo&&(A[0].style.visibility="hidden",B[0].style.visibility="hidden",w[0].style.visibility="hidden");a.hideFromTo||(A[0].style.visibility="visible",B[0].style.visibility="visible",w[0].style.visibility="visible");a.hideMinMax&&(C[0].style.visibility="hidden",D[0].style.visibility="hidden",P=O=0);a.hideMinMax||(C[0].style.visibility="visible",D[0].style.visibility=
"visible",a.values?(C.html(a.prefix+a.values[0]+a.postfix),D.html(a.prefix+a.values[a.values.length-1]+a.maxPostfix+a.postfix)):(C.html(a.prefix+z(a.min)+a.postfix),D.html(a.prefix+z(a.max)+a.maxPostfix+a.postfix)),O=C.outerWidth(),P=D.outerWidth());ga()},ga=function(){if("single"===a.type){if(q.append('<span class="irs-slider single"></span>'),x=q.find(".single"),x.on("mousedown",function(a){a.preventDefault();a.stopPropagation();K(a,c(this),null);y=v=!0;s=n.pluginCount;S&&c("*").prop("unselectable",
!0)}),X)x.on("touchstart",function(a){a.preventDefault();a.stopPropagation();K(a.originalEvent.touches[0],c(this),null);y=v=!0;s=n.pluginCount})}else"double"===a.type&&(q.append('<span class="irs-diapason"></span><span class="irs-slider from"></span><span class="irs-slider to"></span>'),m=q.find(".from"),t=q.find(".to"),H=q.find(".irs-diapason"),L(),m.on("mousedown",function(a){a.preventDefault();a.stopPropagation();c(this).addClass("last");t.removeClass("last");K(a,c(this),"from");y=v=!0;s=n.pluginCount;
S&&c("*").prop("unselectable",!0)}),t.on("mousedown",function(a){a.preventDefault();a.stopPropagation();c(this).addClass("last");m.removeClass("last");K(a,c(this),"to");y=v=!0;s=n.pluginCount;S&&c("*").prop("unselectable",!0)}),X&&(m.on("touchstart",function(a){a.preventDefault();a.stopPropagation();c(this).addClass("last");t.removeClass("last");K(a.originalEvent.touches[0],c(this),"from");y=v=!0;s=n.pluginCount}),t.on("touchstart",function(a){a.preventDefault();a.stopPropagation();c(this).addClass("last");
m.removeClass("last");K(a.originalEvent.touches[0],c(this),"to");y=v=!0;s=n.pluginCount})),a.to===a.max&&m.addClass("last"));J.on("mouseup.irs"+n.pluginCount,function(){s===n.pluginCount&&v&&(v=y=!1,r.removeAttr("id"),r=null,"double"===a.type&&L(),Z(),S&&c("*").prop("unselectable",!1))});J.on("mousemove.irs"+n.pluginCount,function(a){v&&(U=a.pageX,W())});p.on("mousedown",function(){s=n.pluginCount});p.on("mouseup",function(b){if(s===n.pluginCount&&!v&&!a.disable){b=b.pageX;E=!1;b-=p.offset().left;
var d=f.fromX+(f.toX-f.fromX)/2;Q=0;V=q.width()-G;R=q.width()-G;"single"===a.type?(r=x,r.attr("id","irs-active-slider"),W(b)):"double"===a.type&&(r=b<=d?m:t,r.attr("id","irs-active-slider"),W(b),L());r.removeAttr("id");r=null}});X&&(T.on("touchend",function(){v&&(v=y=!1,r.removeAttr("id"),r=null,"double"===a.type&&L(),Z())}),T.on("touchmove",function(a){v&&(U=a.originalEvent.touches[0].pageX,W())}));ca();ha();a.hasGrid&&ia();a.disable?(p.addClass("irs-disabled"),p.append('<span class="irs-disable-mask"></span>')):
(p.removeClass("irs-disabled"),p.find(".irs-disable-mask").remove())},ca=function(){l=q.width();G=x?x.width():m.width();F=l-G},K=function(b,d,h){ca();E=!1;r=d;r.attr("id","irs-active-slider");d=r.offset().left;Y=d+(b.pageX-d)-r.position().left;"single"===a.type?V=q.width()-G:"double"===a.type&&("from"===h?(Q=0,R=parseInt(t.css("left"),10)):(Q=parseInt(m.css("left"),10),R=q.width()-G))},L=function(){var a=m.width(),d=c.data(m[0],"x")||parseInt(m[0].style.left,10)||m.position().left,h=(c.data(t[0],
"x")||parseInt(t[0].style.left,10)||t.position().left)-d;H[0].style.left=d+a/2+"px";H[0].style.width=h+"px"},W=function(b){var d=U-Y,d=b?b:U-Y;"single"===a.type?(0>d&&(d=0),d>V&&(d=V)):"double"===a.type&&(d<Q&&(d=Q),d>R&&(d=R),L());c.data(r[0],"x",d);Z();b=Math.round(d);r[0].style.left=b+"px"},Z=function(){var b={input:e,slider:p,min:a.min,max:a.max,fromNumber:0,toNumber:0,fromPers:0,toPers:0,fromX:0,fromX_pure:0,toX:0,toX_pure:0},d=a.max-a.min,h;"single"===a.type?(b.fromX=c.data(x[0],"x")||parseInt(x[0].style.left,
10)||x.position().left,b.fromPers=b.fromX/F*100,h=d/100*b.fromPers+a.min,b.fromNumber=Math.round(h/a.step)*a.step,b.fromNumber<a.min&&(b.fromNumber=a.min),b.fromNumber>a.max&&(b.fromNumber=a.max),u&&(b.fromNumber=parseInt(b.fromNumber*u,10)/u),I&&(b.fromValue=a.values[b.fromNumber])):"double"===a.type&&(b.fromX=c.data(m[0],"x")||parseInt(m[0].style.left,10)||m.position().left,b.fromPers=b.fromX/F*100,h=d/100*b.fromPers+a.min,b.fromNumber=Math.round(h/a.step)*a.step,b.fromNumber<a.min&&(b.fromNumber=
a.min),b.toX=c.data(t[0],"x")||parseInt(t[0].style.left,10)||t.position().left,b.toPers=b.toX/F*100,d=d/100*b.toPers+a.min,b.toNumber=Math.round(d/a.step)*a.step,b.toNumber>a.max&&(b.toNumber=a.max),u&&(b.fromNumber=parseInt(b.fromNumber*u,10)/u,b.toNumber=parseInt(b.toNumber*u,10)/u),I&&(b.fromValue=a.values[b.fromNumber],b.toValue=a.values[b.toNumber]));f=b;da()},ha=function(){var b={input:e,slider:p,min:a.min,max:a.max,fromNumber:a.from,toNumber:a.to,fromPers:0,toPers:0,fromX:0,fromX_pure:0,toX:0,
toX_pure:0},d=a.max-a.min;"single"===a.type?(b.fromPers=0!==d?(b.fromNumber-a.min)/d*100:0,b.fromX_pure=F/100*b.fromPers,b.fromX=Math.round(b.fromX_pure),x[0].style.left=b.fromX+"px",c.data(x[0],"x",b.fromX_pure)):"double"===a.type&&(b.fromPers=0!==d?(b.fromNumber-a.min)/d*100:0,b.fromX_pure=F/100*b.fromPers,b.fromX=Math.round(b.fromX_pure),m[0].style.left=b.fromX+"px",c.data(m[0],"x",b.fromX_pure),b.toPers=0!==d?(b.toNumber-a.min)/d*100:1,b.toX_pure=F/100*b.toPers,b.toX=Math.round(b.toX_pure),t[0].style.left=
b.toX+"px",c.data(t[0],"x",b.toX_pure),L());f=b;da()},da=function(){var b,d,h,c,g,k;k=G/2;h="";"single"===a.type?(h=f.fromNumber===a.max?a.maxPostfix:"",A[0].style.display="none",B[0].style.display="none",h=I?a.prefix+a.values[f.fromNumber]+h+a.postfix:a.prefix+z(f.fromNumber)+h+a.postfix,w.html(h),g=w.outerWidth(),k=f.fromX-g/2+k,0>k&&(k=0),k>l-g&&(k=l-g),w[0].style.left=k+"px",a.hideMinMax||a.hideFromTo||(C[0].style.display=k<O?"none":"block",D[0].style.display=k+g>l-P?"none":"block"),e.attr("value",
parseFloat(f.fromNumber))):"double"===a.type&&(h=f.toNumber===a.max?a.maxPostfix:"",I?(b=a.prefix+a.values[f.fromNumber]+a.postfix,d=a.prefix+a.values[f.toNumber]+h+a.postfix,h=f.fromNumber!==f.toNumber?a.prefix+a.values[f.fromNumber]+" \u2014 "+a.prefix+a.values[f.toNumber]+h+a.postfix:a.prefix+a.values[f.fromNumber]+h+a.postfix):(b=a.prefix+z(f.fromNumber)+a.postfix,d=a.prefix+z(f.toNumber)+h+a.postfix,h=f.fromNumber!==f.toNumber?a.prefix+z(f.fromNumber)+" \u2014 "+a.prefix+z(f.toNumber)+h+a.postfix:
a.prefix+z(f.fromNumber)+h+a.postfix),A.html(b),B.html(d),w.html(h),b=A.outerWidth(),d=f.fromX-b/2+k,0>d&&(d=0),d>l-b&&(d=l-b),A[0].style.left=d+"px",h=B.outerWidth(),c=f.toX-h/2+k,0>c&&(c=0),c>l-h&&(c=l-h),B[0].style.left=c+"px",g=w.outerWidth(),k=f.fromX+(f.toX-f.fromX)/2-g/2+k,0>k&&(k=0),k>l-g&&(k=l-g),w[0].style.left=k+"px",d+b<c?(w[0].style.display="none",A[0].style.display="block",B[0].style.display="block"):(w[0].style.display="block",A[0].style.display="none",B[0].style.display="none"),a.hideMinMax||
a.hideFromTo||(C[0].style.display=k<O||d<O?"none":"block",D[0].style.display=k+g>l-P||c+h>l-P?"none":"block"),e.attr("value",parseFloat(f.fromNumber)+";"+parseFloat(f.toNumber)));ja()},ja=function(){"function"!==typeof a.onFinish||y||E||a.onFinish.call(this,f);"function"!==typeof a.onChange||E||a.onChange.call(this,f);"function"===typeof a.onLoad&&!y&&E&&(a.onLoad.call(this,f),E=!1)},ia=function(){p.addClass("irs-with-grid");var b,d="",c=0,c=0,e="";for(b=0;20>=b;b+=1)c=Math.floor(l/20*b),c>=l&&(c=
l-1),e+='<span class="irs-grid-pol small" style="left: '+c+'px;"></span>';for(b=0;4>=b;b+=1)c=Math.floor(l/4*b),c>=l&&(c=l-1),e+='<span class="irs-grid-pol" style="left: '+c+'px;"></span>',u?(d=a.min+(a.max-a.min)/4*b,d=d/a.step*a.step,d=parseInt(d*u,10)/u):(d=Math.round(a.min+(a.max-a.min)/4*b),d=Math.round(d/a.step)*a.step,d=z(d)),I&&(a.hideMinMax?(d=Math.round(a.min+(a.max-a.min)/4*b),d=Math.round(d/a.step)*a.step,d=0===b||4===b?a.values[d]:""):d=""),0===b?e+='<span class="irs-grid-text" style="left: '+
c+'px; text-align: left;">'+d+"</span>":4===b?(c-=100,e+='<span class="irs-grid-text" style="left: '+c+'px; text-align: right;">'+d+"</span>"):(c-=50,e+='<span class="irs-grid-text" style="left: '+c+'px;">'+d+"</span>");M.html(e)};ba()}})},update:function(c){return this.each(function(){this.updateData(c)})},remove:function(){return this.each(function(){this.removeSlider()})}};c.fn.ionRangeSlider=function(s){if(H[s])return H[s].apply(this,Array.prototype.slice.call(arguments,1));if("object"!==typeof s&&
s)c.error("Method "+s+" does not exist for jQuery.ionRangeSlider");else return H.init.apply(this,arguments)}})(jQuery,document,window,navigator);
/*!
 * Jasny Bootstrap v3.1.2 (http://jasny.github.io/bootstrap)
 * Copyright 2012-2014 Arnold Daniels
 * Licensed under Apache-2.0 (https://github.com/jasny/bootstrap/blob/master/LICENSE)
 */

if("undefined"==typeof jQuery)throw new Error("Jasny Bootstrap's JavaScript requires jQuery");+function(a){"use strict";function b(){var a=document.createElement("bootstrap"),b={WebkitTransition:"webkitTransitionEnd",MozTransition:"transitionend",OTransition:"oTransitionEnd otransitionend",transition:"transitionend"};for(var c in b)if(void 0!==a.style[c])return{end:b[c]};return!1}void 0===a.support.transition&&(a.fn.emulateTransitionEnd=function(b){var c=!1,d=this;a(this).one(a.support.transition.end,function(){c=!0});var e=function(){c||a(d).trigger(a.support.transition.end)};return setTimeout(e,b),this},a(function(){a.support.transition=b()}))}(window.jQuery),+function(a){"use strict";var b=function(c,d){this.$element=a(c),this.options=a.extend({},b.DEFAULTS,d),this.state=null,this.placement=null,this.options.recalc&&(this.calcClone(),a(window).on("resize",a.proxy(this.recalc,this))),this.options.autohide&&a(document).on("click",a.proxy(this.autohide,this)),this.options.toggle&&this.toggle(),this.options.disablescrolling&&(this.options.disableScrolling=this.options.disablescrolling,delete this.options.disablescrolling)};b.DEFAULTS={toggle:!0,placement:"auto",autohide:!0,recalc:!0,disableScrolling:!0},b.prototype.offset=function(){switch(this.placement){case"left":case"right":return this.$element.outerWidth();case"top":case"bottom":return this.$element.outerHeight()}},b.prototype.calcPlacement=function(){function b(a,b){if("auto"===e.css(b))return a;if("auto"===e.css(a))return b;var c=parseInt(e.css(a),10),d=parseInt(e.css(b),10);return c>d?b:a}if("auto"!==this.options.placement)return void(this.placement=this.options.placement);this.$element.hasClass("in")||this.$element.css("visiblity","hidden !important").addClass("in");var c=a(window).width()/this.$element.width(),d=a(window).height()/this.$element.height(),e=this.$element;this.placement=c>=d?b("left","right"):b("top","bottom"),"hidden !important"===this.$element.css("visibility")&&this.$element.removeClass("in").css("visiblity","")},b.prototype.opposite=function(a){switch(a){case"top":return"bottom";case"left":return"right";case"bottom":return"top";case"right":return"left"}},b.prototype.getCanvasElements=function(){var b=this.options.canvas?a(this.options.canvas):this.$element,c=b.find("*").filter(function(){return"fixed"===a(this).css("position")}).not(this.options.exclude);return b.add(c)},b.prototype.slide=function(b,c,d){if(!a.support.transition){var e={};return e[this.placement]="+="+c,b.animate(e,350,d)}var f=this.placement,g=this.opposite(f);b.each(function(){"auto"!==a(this).css(f)&&a(this).css(f,(parseInt(a(this).css(f),10)||0)+c),"auto"!==a(this).css(g)&&a(this).css(g,(parseInt(a(this).css(g),10)||0)-c)}),this.$element.one(a.support.transition.end,d).emulateTransitionEnd(350)},b.prototype.disableScrolling=function(){var b=a("body").width(),c="padding-"+this.opposite(this.placement);if(void 0===a("body").data("offcanvas-style")&&a("body").data("offcanvas-style",a("body").attr("style")),a("body").css("overflow","hidden"),a("body").width()>b){var d=parseInt(a("body").css(c),10)+a("body").width()-b;setTimeout(function(){a("body").css(c,d)},1)}},b.prototype.show=function(){if(!this.state){var b=a.Event("show.bs.offcanvas");if(this.$element.trigger(b),!b.isDefaultPrevented()){this.state="slide-in",this.calcPlacement();var c=this.getCanvasElements(),d=this.placement,e=this.opposite(d),f=this.offset();-1!==c.index(this.$element)&&(a(this.$element).data("offcanvas-style",a(this.$element).attr("style")||""),this.$element.css(d,-1*f),this.$element.css(d)),c.addClass("canvas-sliding").each(function(){void 0===a(this).data("offcanvas-style")&&a(this).data("offcanvas-style",a(this).attr("style")||""),"static"===a(this).css("position")&&a(this).css("position","relative"),"auto"!==a(this).css(d)&&"0px"!==a(this).css(d)||"auto"!==a(this).css(e)&&"0px"!==a(this).css(e)||a(this).css(d,0)}),this.options.disableScrolling&&this.disableScrolling();var g=function(){"slide-in"==this.state&&(this.state="slid",c.removeClass("canvas-sliding").addClass("canvas-slid"),this.$element.trigger("shown.bs.offcanvas"))};setTimeout(a.proxy(function(){this.$element.addClass("in"),this.slide(c,f,a.proxy(g,this))},this),1)}}},b.prototype.hide=function(){if("slid"===this.state){var b=a.Event("hide.bs.offcanvas");if(this.$element.trigger(b),!b.isDefaultPrevented()){this.state="slide-out";var c=a(".canvas-slid"),d=(this.placement,-1*this.offset()),e=function(){"slide-out"==this.state&&(this.state=null,this.placement=null,this.$element.removeClass("in"),c.removeClass("canvas-sliding"),c.add(this.$element).add("body").each(function(){a(this).attr("style",a(this).data("offcanvas-style")).removeData("offcanvas-style")}),this.$element.trigger("hidden.bs.offcanvas"))};c.removeClass("canvas-slid").addClass("canvas-sliding"),setTimeout(a.proxy(function(){this.slide(c,d,a.proxy(e,this))},this),1)}}},b.prototype.toggle=function(){"slide-in"!==this.state&&"slide-out"!==this.state&&this["slid"===this.state?"hide":"show"]()},b.prototype.calcClone=function(){this.$calcClone=this.$element.clone().html("").addClass("offcanvas-clone").removeClass("in").appendTo(a("body"))},b.prototype.recalc=function(){if("none"!==this.$calcClone.css("display")&&("slid"===this.state||"slide-in"===this.state)){this.state=null,this.placement=null;var b=this.getCanvasElements();this.$element.removeClass("in"),b.removeClass("canvas-slid"),b.add(this.$element).add("body").each(function(){a(this).attr("style",a(this).data("offcanvas-style")).removeData("offcanvas-style")})}},b.prototype.autohide=function(b){0===a(b.target).closest(this.$element).length&&this.hide()};var c=a.fn.offcanvas;a.fn.offcanvas=function(c){return this.each(function(){var d=a(this),e=d.data("bs.offcanvas"),f=a.extend({},b.DEFAULTS,d.data(),"object"==typeof c&&c);e||d.data("bs.offcanvas",e=new b(this,f)),"string"==typeof c&&e[c]()})},a.fn.offcanvas.Constructor=b,a.fn.offcanvas.noConflict=function(){return a.fn.offcanvas=c,this},a(document).on("click.bs.offcanvas.data-api","[data-toggle=offcanvas]",function(b){var c,d=a(this),e=d.attr("data-target")||b.preventDefault()||(c=d.attr("href"))&&c.replace(/.*(?=#[^\s]+$)/,""),f=a(e),g=f.data("bs.offcanvas"),h=g?"toggle":d.data();b.stopPropagation(),g?g.toggle():f.offcanvas(h)})}(window.jQuery),+function(a){"use strict";var b=function(c,d){this.$element=a(c),this.options=a.extend({},b.DEFAULTS,d),this.$element.on("click.bs.rowlink","td:not(.rowlink-skip)",a.proxy(this.click,this))};b.DEFAULTS={target:"a"},b.prototype.click=function(b){var c=a(b.currentTarget).closest("tr").find(this.options.target)[0];if(a(b.target)[0]!==c)if(b.preventDefault(),c.click)c.click();else if(document.createEvent){var d=document.createEvent("MouseEvents");d.initMouseEvent("click",!0,!0,window,0,0,0,0,0,!1,!1,!1,!1,0,null),c.dispatchEvent(d)}};var c=a.fn.rowlink;a.fn.rowlink=function(c){return this.each(function(){var d=a(this),e=d.data("rowlink");e||d.data("rowlink",e=new b(this,c))})},a.fn.rowlink.Constructor=b,a.fn.rowlink.noConflict=function(){return a.fn.rowlink=c,this},a(document).on("click.bs.rowlink.data-api",'[data-link="row"]',function(b){if(0===a(b.target).closest(".rowlink-skip").length){var c=a(this);c.data("rowlink")||(c.rowlink(c.data()),a(b.target).trigger("click.bs.rowlink"))}})}(window.jQuery),+function(a){"use strict";var b=void 0!==window.orientation,c=navigator.userAgent.toLowerCase().indexOf("android")>-1,d="Microsoft Internet Explorer"==window.navigator.appName,e=function(b,d){c||(this.$element=a(b),this.options=a.extend({},e.DEFAULTS,d),this.mask=String(this.options.mask),this.init(),this.listen(),this.checkVal())};e.DEFAULTS={mask:"",placeholder:"_",definitions:{9:"[0-9]",a:"[A-Za-z]","?":"[A-Za-z0-9]","*":"."}},e.prototype.init=function(){var b=this.options.definitions,c=this.mask.length;this.tests=[],this.partialPosition=this.mask.length,this.firstNonMaskPos=null,a.each(this.mask.split(""),a.proxy(function(a,d){"?"==d?(c--,this.partialPosition=a):b[d]?(this.tests.push(new RegExp(b[d])),null===this.firstNonMaskPos&&(this.firstNonMaskPos=this.tests.length-1)):this.tests.push(null)},this)),this.buffer=a.map(this.mask.split(""),a.proxy(function(a){return"?"!=a?b[a]?this.options.placeholder:a:void 0},this)),this.focusText=this.$element.val(),this.$element.data("rawMaskFn",a.proxy(function(){return a.map(this.buffer,function(a,b){return this.tests[b]&&a!=this.options.placeholder?a:null}).join("")},this))},e.prototype.listen=function(){if(!this.$element.attr("readonly")){var b=(d?"paste":"input")+".mask";this.$element.on("unmask.bs.inputmask",a.proxy(this.unmask,this)).on("focus.bs.inputmask",a.proxy(this.focusEvent,this)).on("blur.bs.inputmask",a.proxy(this.blurEvent,this)).on("keydown.bs.inputmask",a.proxy(this.keydownEvent,this)).on("keypress.bs.inputmask",a.proxy(this.keypressEvent,this)).on(b,a.proxy(this.pasteEvent,this))}},e.prototype.caret=function(a,b){if(0!==this.$element.length){if("number"==typeof a)return b="number"==typeof b?b:a,this.$element.each(function(){if(this.setSelectionRange)this.setSelectionRange(a,b);else if(this.createTextRange){var c=this.createTextRange();c.collapse(!0),c.moveEnd("character",b),c.moveStart("character",a),c.select()}});if(this.$element[0].setSelectionRange)a=this.$element[0].selectionStart,b=this.$element[0].selectionEnd;else if(document.selection&&document.selection.createRange){var c=document.selection.createRange();a=0-c.duplicate().moveStart("character",-1e5),b=a+c.text.length}return{begin:a,end:b}}},e.prototype.seekNext=function(a){for(var b=this.mask.length;++a<=b&&!this.tests[a];);return a},e.prototype.seekPrev=function(a){for(;--a>=0&&!this.tests[a];);return a},e.prototype.shiftL=function(a,b){var c=this.mask.length;if(!(0>a)){for(var d=a,e=this.seekNext(b);c>d;d++)if(this.tests[d]){if(!(c>e&&this.tests[d].test(this.buffer[e])))break;this.buffer[d]=this.buffer[e],this.buffer[e]=this.options.placeholder,e=this.seekNext(e)}this.writeBuffer(),this.caret(Math.max(this.firstNonMaskPos,a))}},e.prototype.shiftR=function(a){for(var b=this.mask.length,c=a,d=this.options.placeholder;b>c;c++)if(this.tests[c]){var e=this.seekNext(c),f=this.buffer[c];if(this.buffer[c]=d,!(b>e&&this.tests[e].test(f)))break;d=f}},e.prototype.unmask=function(){this.$element.unbind(".mask").removeData("inputmask")},e.prototype.focusEvent=function(){this.focusText=this.$element.val();var a=this.mask.length,b=this.checkVal();this.writeBuffer();var c=this,d=function(){b==a?c.caret(0,b):c.caret(b)};d(),setTimeout(d,50)},e.prototype.blurEvent=function(){this.checkVal(),this.$element.val()!==this.focusText&&this.$element.trigger("change")},e.prototype.keydownEvent=function(a){var c=a.which;if(8==c||46==c||b&&127==c){var d=this.caret(),e=d.begin,f=d.end;return f-e===0&&(e=46!=c?this.seekPrev(e):f=this.seekNext(e-1),f=46==c?this.seekNext(f):f),this.clearBuffer(e,f),this.shiftL(e,f-1),!1}return 27==c?(this.$element.val(this.focusText),this.caret(0,this.checkVal()),!1):void 0},e.prototype.keypressEvent=function(a){var b=this.mask.length,c=a.which,d=this.caret();if(a.ctrlKey||a.altKey||a.metaKey||32>c)return!0;if(c){d.end-d.begin!==0&&(this.clearBuffer(d.begin,d.end),this.shiftL(d.begin,d.end-1));var e=this.seekNext(d.begin-1);if(b>e){var f=String.fromCharCode(c);if(this.tests[e].test(f)){this.shiftR(e),this.buffer[e]=f,this.writeBuffer();var g=this.seekNext(e);this.caret(g)}}return!1}},e.prototype.pasteEvent=function(){var a=this;setTimeout(function(){a.caret(a.checkVal(!0))},0)},e.prototype.clearBuffer=function(a,b){for(var c=this.mask.length,d=a;b>d&&c>d;d++)this.tests[d]&&(this.buffer[d]=this.options.placeholder)},e.prototype.writeBuffer=function(){return this.$element.val(this.buffer.join("")).val()},e.prototype.checkVal=function(a){for(var b=this.mask.length,c=this.$element.val(),d=-1,e=0,f=0;b>e;e++)if(this.tests[e]){for(this.buffer[e]=this.options.placeholder;f++<c.length;){var g=c.charAt(f-1);if(this.tests[e].test(g)){this.buffer[e]=g,d=e;break}}if(f>c.length)break}else this.buffer[e]==c.charAt(f)&&e!=this.partialPosition&&(f++,d=e);return!a&&d+1<this.partialPosition?(this.$element.val(""),this.clearBuffer(0,b)):(a||d+1>=this.partialPosition)&&(this.writeBuffer(),a||this.$element.val(this.$element.val().substring(0,d+1))),this.partialPosition?e:this.firstNonMaskPos};var f=a.fn.inputmask;a.fn.inputmask=function(b){return this.each(function(){var c=a(this),d=c.data("inputmask");d||c.data("inputmask",d=new e(this,b))})},a.fn.inputmask.Constructor=e,a.fn.inputmask.noConflict=function(){return a.fn.inputmask=f,this},a(document).on("focus.bs.inputmask.data-api","[data-mask]",function(){var b=a(this);b.data("inputmask")||b.inputmask(b.data())})}(window.jQuery),+function(a){"use strict";var b="Microsoft Internet Explorer"==window.navigator.appName,c=function(b,c){if(this.$element=a(b),this.$input=this.$element.find(":file"),0!==this.$input.length){this.name=this.$input.attr("name")||c.name,this.$hidden=this.$element.find('input[type=hidden][name="'+this.name+'"]'),0===this.$hidden.length&&(this.$hidden=a('<input type="hidden">').insertBefore(this.$input)),this.$preview=this.$element.find(".fileinput-preview");var d=this.$preview.css("height");"inline"!==this.$preview.css("display")&&"0px"!==d&&"none"!==d&&this.$preview.css("line-height",d),this.original={exists:this.$element.hasClass("fileinput-exists"),preview:this.$preview.html(),hiddenVal:this.$hidden.val()},this.listen()}};c.prototype.listen=function(){this.$input.on("change.bs.fileinput",a.proxy(this.change,this)),a(this.$input[0].form).on("reset.bs.fileinput",a.proxy(this.reset,this)),this.$element.find('[data-trigger="fileinput"]').on("click.bs.fileinput",a.proxy(this.trigger,this)),this.$element.find('[data-dismiss="fileinput"]').on("click.bs.fileinput",a.proxy(this.clear,this))},c.prototype.change=function(b){var c=void 0===b.target.files?b.target&&b.target.value?[{name:b.target.value.replace(/^.+\\/,"")}]:[]:b.target.files;if(b.stopPropagation(),0===c.length)return void this.clear();this.$hidden.val(""),this.$hidden.attr("name",""),this.$input.attr("name",this.name);var d=c[0];if(this.$preview.length>0&&("undefined"!=typeof d.type?d.type.match(/^image\/(gif|png|jpeg)$/):d.name.match(/\.(gif|png|jpe?g)$/i))&&"undefined"!=typeof FileReader){var e=new FileReader,f=this.$preview,g=this.$element;e.onload=function(b){var e=a("<img>");e[0].src=b.target.result,c[0].result=b.target.result,g.find(".fileinput-filename").text(d.name),"none"!=f.css("max-height")&&e.css("max-height",parseInt(f.css("max-height"),10)-parseInt(f.css("padding-top"),10)-parseInt(f.css("padding-bottom"),10)-parseInt(f.css("border-top"),10)-parseInt(f.css("border-bottom"),10)),f.html(e),g.addClass("fileinput-exists").removeClass("fileinput-new"),g.trigger("change.bs.fileinput",c)},e.readAsDataURL(d)}else this.$element.find(".fileinput-filename").text(d.name),this.$preview.text(d.name),this.$element.addClass("fileinput-exists").removeClass("fileinput-new"),this.$element.trigger("change.bs.fileinput")},c.prototype.clear=function(a){if(a&&a.preventDefault(),this.$hidden.val(""),this.$hidden.attr("name",this.name),this.$input.attr("name",""),b){var c=this.$input.clone(!0);this.$input.after(c),this.$input.remove(),this.$input=c}else this.$input.val("");this.$preview.html(""),this.$element.find(".fileinput-filename").text(""),this.$element.addClass("fileinput-new").removeClass("fileinput-exists"),void 0!==a&&(this.$input.trigger("change"),this.$element.trigger("clear.bs.fileinput"))},c.prototype.reset=function(){this.clear(),this.$hidden.val(this.original.hiddenVal),this.$preview.html(this.original.preview),this.$element.find(".fileinput-filename").text(""),this.original.exists?this.$element.addClass("fileinput-exists").removeClass("fileinput-new"):this.$element.addClass("fileinput-new").removeClass("fileinput-exists"),this.$element.trigger("reset.bs.fileinput")},c.prototype.trigger=function(a){this.$input.trigger("click"),a.preventDefault()};var d=a.fn.fileinput;a.fn.fileinput=function(b){return this.each(function(){var d=a(this),e=d.data("fileinput");e||d.data("fileinput",e=new c(this,b)),"string"==typeof b&&e[b]()})},a.fn.fileinput.Constructor=c,a.fn.fileinput.noConflict=function(){return a.fn.fileinput=d,this},a(document).on("click.fileinput.data-api",'[data-provides="fileinput"]',function(b){var c=a(this);if(!c.data("fileinput")){c.fileinput(c.data());var d=a(b.target).closest('[data-dismiss="fileinput"],[data-trigger="fileinput"]');d.length>0&&(b.preventDefault(),d.trigger("click.bs.fileinput"))}})}(window.jQuery);
/*!jQuery Knob*/
/**
 * Downward compatible, touchable dial
 *
 * Version: 1.2.8
 * Requires: jQuery v1.7+
 *
 * Copyright (c) 2012 Anthony Terrien
 * Under MIT License (http://www.opensource.org/licenses/mit-license.php)
 *
 * Thanks to vor, eskimoblood, spiffistan, FabrizioC
 */

(function($) {

    /**
     * Kontrol library
     */
    "use strict";

    /**
     * Definition of globals and core
     */
    var k = {}, // kontrol
        max = Math.max,
        min = Math.min;

    k.c = {};
    k.c.d = $(document);
    k.c.t = function (e) {
        return e.originalEvent.touches.length - 1;
    };

    /**
     * Kontrol Object
     *
     * Definition of an abstract UI control
     *
     * Each concrete component must call this one.
     * <code>
     * k.o.call(this);
     * </code>
     */
    k.o = function () {
        var s = this;

        this.o = null; // array of options
        this.$ = null; // jQuery wrapped element
        this.i = null; // mixed HTMLInputElement or array of HTMLInputElement
        this.g = null; // deprecated 2D graphics context for 'pre-rendering'
        this.v = null; // value ; mixed array or integer
        this.cv = null; // change value ; not commited value
        this.x = 0; // canvas x position
        this.y = 0; // canvas y position
        this.w = 0; // canvas width
        this.h = 0; // canvas height
        this.$c = null; // jQuery canvas element
        this.c = null; // rendered canvas context
        this.t = 0; // touches index
        this.isInit = false;
        this.fgColor = null; // main color
        this.pColor = null; // previous color
        this.dH = null; // draw hook
        this.cH = null; // change hook
        this.eH = null; // cancel hook
        this.rH = null; // release hook
        this.scale = 1; // scale factor
        this.relative = false;
        this.relativeWidth = false;
        this.relativeHeight = false;
        this.$div = null; // component div

        this.run = function () {
            var cf = function (e, conf) {
                var k;
                for (k in conf) {
                    s.o[k] = conf[k];
                }
                s._carve().init();
                s._configure()
                    ._draw();
            };

            if(this.$.data('kontroled')) return;
            this.$.data('kontroled', true);

            this.extend();
            this.o = $.extend(
                {
                    // Config
                    min : this.$.data('min') !== undefined ? this.$.data('min') : 0,
                    max : this.$.data('max') !== undefined ? this.$.data('max') : 100,
                    stopper : true,
                    readOnly : this.$.data('readonly') || (this.$.attr('readonly') === 'readonly'),

                    // UI
                    cursor : (this.$.data('cursor') === true && 30) ||
                        this.$.data('cursor') || 0,
                    thickness : (
                        this.$.data('thickness') &&
                            Math.max(Math.min(this.$.data('thickness'), 1), 0.01)
                        ) || 0.35,
                    lineCap : this.$.data('linecap') || 'butt',
                    width : this.$.data('width') || 200,
                    height : this.$.data('height') || 200,
                    displayInput : this.$.data('displayinput') == null || this.$.data('displayinput'),
                    displayPrevious : this.$.data('displayprevious'),
                    fgColor : this.$.data('fgcolor') || '#87CEEB',
                    inputColor: this.$.data('inputcolor'),
                    font: this.$.data('font') || 'Arial',
                    fontWeight: this.$.data('font-weight') || 'bold',
                    inline : false,
                    step : this.$.data('step') || 1,
                    rotation: this.$.data('rotation'),

                    // Hooks
                    draw : null, // function () {}
                    change : null, // function (value) {}
                    cancel : null, // function () {}
                    release : null, // function (value) {}

                    // Output formatting, allows to add unit: %, ms ...
                    format: function(v) {
                        return v;
                    },
                    parse: function (v) {
                        return parseFloat(v);
                    }
                }, this.o
            );

            // finalize options
            this.o.flip = this.o.rotation === 'anticlockwise' || this.o.rotation === 'acw';
            if(!this.o.inputColor) {
                this.o.inputColor = this.o.fgColor;
            }

            // routing value
            if(this.$.is('fieldset')) {

                // fieldset = array of integer
                this.v = {};
                this.i = this.$.find('input');
                this.i.each(function(k) {
                    var $this = $(this);
                    s.i[k] = $this;
                    s.v[k] = s.o.parse($this.val());

                    $this.bind(
                        'change blur'
                        , function () {
                            var val = {};
                            val[k] = $this.val();
                            s.val(val);
                        }
                    );
                });
                this.$.find('legend').remove();

            } else {

                // input = integer
                this.i = this.$;
                this.v = this.o.parse(this.$.val());
                (this.v === '') && (this.v = this.o.min);

                this.$.bind(
                    'change blur'
                    , function () {
                        s.val(s._validate(s.o.parse(s.$.val())));
                    }
                );

            }

            (!this.o.displayInput) && this.$.hide();

            // adds needed DOM elements (canvas, div)
            this.$c = $(document.createElement('canvas')).attr({
                width: this.o.width,
                height: this.o.height
            });

            // wraps all elements in a div
            // add to DOM before Canvas init is triggered
            this.$div = $('<div style="'
                + (this.o.inline ? 'display:inline;' : '')
                + 'width:' + this.o.width + 'px;height:' + this.o.height + 'px;'
                + '"></div>');

            this.$.wrap(this.$div).before(this.$c);
            this.$div = this.$.parent();

            if (typeof G_vmlCanvasManager !== 'undefined') {
                G_vmlCanvasManager.initElement(this.$c[0]);
            }

            this.c = this.$c[0].getContext ? this.$c[0].getContext('2d') : null;

            if (!this.c) {
                throw {
                    name:        "CanvasNotSupportedException",
                    message:     "Canvas not supported. Please use excanvas on IE8.0.",
                    toString:    function(){return this.name + ": " + this.message}
                }
            }

            // hdpi support
            this.scale = (window.devicePixelRatio || 1) /
                (
                    this.c.webkitBackingStorePixelRatio ||
                        this.c.mozBackingStorePixelRatio ||
                        this.c.msBackingStorePixelRatio ||
                        this.c.oBackingStorePixelRatio ||
                        this.c.backingStorePixelRatio || 1
                    );

            // detects relative width / height
            this.relativeWidth = ((this.o.width % 1 !== 0) &&
                this.o.width.indexOf('%'));
            this.relativeHeight = ((this.o.height % 1 !== 0) &&
                this.o.height.indexOf('%'));
            this.relative = (this.relativeWidth || this.relativeHeight);

            // computes size and carves the component
            this._carve();

            // prepares props for transaction
            if (this.v instanceof Object) {
                this.cv = {};
                this.copy(this.v, this.cv);
            } else {
                this.cv = this.v;
            }

            // binds configure event
            this.$
                .bind("configure", cf)
                .parent()
                .bind("configure", cf);

            // finalize init
            this._listen()
                ._configure()
                ._xy()
                .init();

            this.isInit = true;

            this.$.val(this.o.format(this.v));
            this._draw();

            return this;
        };

        this._carve = function() {
            if(this.relative) {
                var w = this.relativeWidth ?
                        this.$div.parent().width() *
                            parseInt(this.o.width) / 100 :
                        this.$div.parent().width(),
                    h = this.relativeHeight ?
                        this.$div.parent().height() *
                            parseInt(this.o.height) / 100 :
                        this.$div.parent().height();

                // apply relative
                this.w = this.h = Math.min(w, h);
            } else {
                this.w = this.o.width;
                this.h = this.o.height;
            }

            // finalize div
            this.$div.css({
                'width': this.w + 'px',
                'height': this.h + 'px'
            });

            // finalize canvas with computed width
            this.$c.attr({
                width: this.w,
                height: this.h
            });

            // scaling
            if (this.scale !== 1) {
                this.$c[0].width = this.$c[0].width * this.scale;
                this.$c[0].height = this.$c[0].height * this.scale;
                this.$c.width(this.w);
                this.$c.height(this.h);
            }

            return this;
        }

        this._draw = function () {

            // canvas pre-rendering
            var d = true;

            s.g = s.c;

            s.clear();

            s.dH
            && (d = s.dH());

            (d !== false) && s.draw();

        };

        this._touch = function (e) {

            var touchMove = function (e) {

                var v = s.xy2val(
                    e.originalEvent.touches[s.t].pageX,
                    e.originalEvent.touches[s.t].pageY
                );

                if (v == s.cv) return;

                if (s.cH && (s.cH(v) === false)) return;

                s.change(s._validate(v));
                s._draw();
            };

            // get touches index
            this.t = k.c.t(e);

            // First touch
            touchMove(e);

            // Touch events listeners
            k.c.d
                .bind("touchmove.k", touchMove)
                .bind(
                "touchend.k"
                , function () {
                    k.c.d.unbind('touchmove.k touchend.k');
                    s.val(s.cv);
                }
            );

            return this;
        };

        this._mouse = function (e) {

            var mouseMove = function (e) {
                var v = s.xy2val(e.pageX, e.pageY);

                if (v == s.cv) return;

                if (s.cH && (s.cH(v) === false)) return;

                s.change(s._validate(v));
                s._draw();
            };

            // First click
            mouseMove(e);

            // Mouse events listeners
            k.c.d
                .bind("mousemove.k", mouseMove)
                .bind(
                // Escape key cancel current change
                "keyup.k"
                , function (e) {
                    if (e.keyCode === 27) {
                        k.c.d.unbind("mouseup.k mousemove.k keyup.k");

                        if (
                            s.eH
                                && (s.eH() === false)
                            ) return;

                        s.cancel();
                    }
                }
            )
                .bind(
                "mouseup.k"
                , function (e) {
                    k.c.d.unbind('mousemove.k mouseup.k keyup.k');
                    s.val(s.cv);
                }
            );

            return this;
        };

        this._xy = function () {
            var o = this.$c.offset();
            this.x = o.left;
            this.y = o.top;
            return this;
        };

        this._listen = function () {

            if (!this.o.readOnly) {
                this.$c
                    .bind(
                    "mousedown"
                    , function (e) {
                        e.preventDefault();
                        s._xy()._mouse(e);
                    }
                )
                    .bind(
                    "touchstart"
                    , function (e) {
                        e.preventDefault();
                        s._xy()._touch(e);
                    }
                );

                this.listen();
            } else {
                this.$.attr('readonly', 'readonly');
            }

            if(this.relative) {
                $(window).resize(function() {
                    s._carve()
                        .init();
                    s._draw();
                });
            }

            return this;
        };

        this._configure = function () {

            // Hooks
            if (this.o.draw) this.dH = this.o.draw;
            if (this.o.change) this.cH = this.o.change;
            if (this.o.cancel) this.eH = this.o.cancel;
            if (this.o.release) this.rH = this.o.release;

            if (this.o.displayPrevious) {
                this.pColor = this.h2rgba(this.o.fgColor, "0.4");
                this.fgColor = this.h2rgba(this.o.fgColor, "0.6");
            } else {
                this.fgColor = this.o.fgColor;
            }

            return this;
        };

        this._clear = function () {
            this.$c[0].width = this.$c[0].width;
        };

        this._validate = function(v) {
            return (~~ (((v < 0) ? -0.5 : 0.5) + (v/this.o.step))) * this.o.step;
        };

        // Abstract methods
        this.listen = function () {}; // on start, one time
        this.extend = function () {}; // each time configure triggered
        this.init = function () {}; // each time configure triggered
        this.change = function (v) {}; // on change
        this.val = function (v) {}; // on release
        this.xy2val = function (x, y) {}; //
        this.draw = function () {}; // on change / on release
        this.clear = function () { this._clear(); };

        // Utils
        this.h2rgba = function (h, a) {
            var rgb;
            h = h.substring(1,7)
            rgb = [parseInt(h.substring(0,2),16)
                ,parseInt(h.substring(2,4),16)
                ,parseInt(h.substring(4,6),16)];
            return "rgba(" + rgb[0] + "," + rgb[1] + "," + rgb[2] + "," + a + ")";
        };

        this.copy = function (f, t) {
            for (var i in f) { t[i] = f[i]; }
        };
    };


    /**
     * k.Dial
     */
    k.Dial = function () {
        k.o.call(this);

        this.startAngle = null;
        this.xy = null;
        this.radius = null;
        this.lineWidth = null;
        this.cursorExt = null;
        this.w2 = null;
        this.PI2 = 2*Math.PI;

        this.extend = function () {
            this.o = $.extend(
                {
                    bgColor : this.$.data('bgcolor') || '#EEEEEE',
                    angleOffset : this.$.data('angleoffset') || 0,
                    angleArc : this.$.data('anglearc') || 360,
                    inline : true
                }, this.o
            );
        };

        this.val = function (v, triggerRelease) {
            if (null != v) {

                // reverse format
                v = this.o.parse(v);

                if (
                    triggerRelease !== false && (v != this.v) && this.rH &&
                        (this.rH(v) === false)
                    ) return;

                this.cv = this.o.stopper ? max(min(v, this.o.max), this.o.min) : v;
                this.v = this.cv;
                this.$.val(this.o.format(this.v));
                this._draw();
            } else {
                return this.v;
            }
        };

        this.xy2val = function (x, y) {
            var a, ret;

            a = Math.atan2(
                x - (this.x + this.w2)
                , - (y - this.y - this.w2)
            ) - this.angleOffset;

            if (this.o.flip) {
                a = this.angleArc - a - this.PI2;
            }

            if(this.angleArc != this.PI2 && (a < 0) && (a > -0.5)) {
                // if isset angleArc option, set to min if .5 under min
                a = 0;
            } else if (a < 0) {
                a += this.PI2;
            }

            ret = ~~ (0.5 + (a * (this.o.max - this.o.min) / this.angleArc))
                + this.o.min;

            this.o.stopper && (ret = max(min(ret, this.o.max), this.o.min));

            return ret;
        };

        this.listen = function () {
            // bind MouseWheel
            var s = this, mwTimerStop, mwTimerRelease,
                mw = function (e) {
                    e.preventDefault();

                    var ori = e.originalEvent
                        ,deltaX = ori.detail || ori.wheelDeltaX
                        ,deltaY = ori.detail || ori.wheelDeltaY
                        ,v = s._validate(s.o.parse(s.$.val()))
                            + (deltaX>0 || deltaY>0 ? s.o.step : deltaX<0 || deltaY<0 ? -s.o.step : 0);

                    v = max(min(v, s.o.max), s.o.min);

                    s.val(v, false);

                    if(s.rH) {
                        // Handle mousewheel stop
                        clearTimeout(mwTimerStop);
                        mwTimerStop = setTimeout(function() {
                            s.rH(v);
                            mwTimerStop = null;
                        }, 100);

                        // Handle mousewheel releases
                        if(!mwTimerRelease) {
                            mwTimerRelease = setTimeout(function() {
                                if(mwTimerStop) s.rH(v);
                                mwTimerRelease = null;
                            }, 200);
                        }
                    }
                }
                , kval, to, m = 1, kv = {37:-s.o.step, 38:s.o.step, 39:s.o.step, 40:-s.o.step};

            this.$
                .bind(
                "keydown"
                ,function (e) {
                    var kc = e.keyCode;

                    // numpad support
                    if(kc >= 96 && kc <= 105) {
                        kc = e.keyCode = kc - 48;
                    }

                    kval = parseInt(String.fromCharCode(kc));

                    if (isNaN(kval)) {

                        (kc !== 13)         // enter
                            && (kc !== 8)       // bs
                            && (kc !== 9)       // tab
                            && (kc !== 189)     // -
                            && (kc !== 190 || s.$.val().match(/\./))     // . only allowed once
                        && e.preventDefault();

                        // arrows
                        if ($.inArray(kc,[37,38,39,40]) > -1) {
                            e.preventDefault();

                            var v = s.o.parse(s.$.val()) + kv[kc] * m;
                            s.o.stopper && (v = max(min(v, s.o.max), s.o.min));

                            s.change(v);
                            s._draw();

                            // long time keydown speed-up
                            to = window.setTimeout(
                                function () { m *= 2; }, 30
                            );
                        }
                    }
                }
            )
                .bind(
                "keyup"
                ,function (e) {
                    if (isNaN(kval)) {
                        if (to) {
                            window.clearTimeout(to);
                            to = null;
                            m = 1;
                            s.val(s.$.val());
                        }
                    } else {
                        // kval postcond
                        (s.$.val() > s.o.max && s.$.val(s.o.max))
                        || (s.$.val() < s.o.min && s.$.val(s.o.min));
                    }

                }
            );

            this.$c.bind("mousewheel DOMMouseScroll", mw);
            this.$.bind("mousewheel DOMMouseScroll", mw)
        };

        this.init = function () {

            if (
                this.v < this.o.min
                    || this.v > this.o.max
                ) this.v = this.o.min;

            this.$.val(this.v);
            this.w2 = this.w / 2;
            this.cursorExt = this.o.cursor / 100;
            this.xy = this.w2 * this.scale;
            this.lineWidth = this.xy * this.o.thickness;
            this.lineCap = this.o.lineCap;
            this.radius = this.xy - this.lineWidth / 2;

            this.o.angleOffset
            && (this.o.angleOffset = isNaN(this.o.angleOffset) ? 0 : this.o.angleOffset);

            this.o.angleArc
            && (this.o.angleArc = isNaN(this.o.angleArc) ? this.PI2 : this.o.angleArc);

            // deg to rad
            this.angleOffset = this.o.angleOffset * Math.PI / 180;
            this.angleArc = this.o.angleArc * Math.PI / 180;

            // compute start and end angles
            this.startAngle = 1.5 * Math.PI + this.angleOffset;
            this.endAngle = 1.5 * Math.PI + this.angleOffset + this.angleArc;

            var s = max(
                String(Math.abs(this.o.max)).length
                , String(Math.abs(this.o.min)).length
                , 2
            ) + 2;

            this.o.displayInput
                && this.i.css({
                'width' : ((this.w / 2 + 4) >> 0) + 'px'
                ,'height' : ((this.w / 3) >> 0) + 'px'
                ,'position' : 'absolute'
                ,'vertical-align' : 'middle'
                ,'margin-top' : ((this.w / 3) >> 0) + 'px'
                ,'margin-left' : '-' + ((this.w * 3 / 4 + 2) >> 0) + 'px'
                ,'border' : 0
                ,'background' : 'none'
                ,'font' : this.o.fontWeight + ' ' + ((this.w / s) >> 0) + 'px ' + this.o.font
                ,'text-align' : 'center'
                ,'color' : this.o.inputColor || this.o.fgColor
                ,'padding' : '0px'
                ,'-webkit-appearance': 'none'
            })
            || this.i.css({
                'width' : '0px'
                ,'visibility' : 'hidden'
            });
        };

        this.change = function (v) {
            this.cv = v;
            this.$.val(this.o.format(v));
        };

        this.angle = function (v) {
            return (v - this.o.min) * this.angleArc / (this.o.max - this.o.min);
        };

        this.arc = function (v) {
            var sa, ea;
            v = this.angle(v);
            if (this.o.flip) {
                sa = this.endAngle + 0.00001;
                ea = sa - v - 0.00001;
            } else {
                sa = this.startAngle - 0.00001;
                ea = sa + v + 0.00001;
            }
            this.o.cursor
                && (sa = ea - this.cursorExt)
            && (ea = ea + this.cursorExt);
            return {
                s: sa,
                e: ea,
                d: this.o.flip && !this.o.cursor
            };
        };

        this.draw = function () {

            var c = this.g,                 // context
                a = this.arc(this.cv)       // Arc
                , pa                        // Previous arc
                , r = 1;

            c.lineWidth = this.lineWidth;
            c.lineCap = this.lineCap;

            c.beginPath();
            c.strokeStyle = this.o.bgColor;
            c.arc(this.xy, this.xy, this.radius, this.endAngle - 0.00001, this.startAngle + 0.00001, true);
            c.stroke();

            if (this.o.displayPrevious) {
                pa = this.arc(this.v);
                c.beginPath();
                c.strokeStyle = this.pColor;
                c.arc(this.xy, this.xy, this.radius, pa.s, pa.e, pa.d);
                c.stroke();
                r = (this.cv == this.v);
            }

            c.beginPath();
            c.strokeStyle = r ? this.o.fgColor : this.fgColor ;
            c.arc(this.xy, this.xy, this.radius, a.s, a.e, a.d);
            c.stroke();
        };

        this.cancel = function () {
            this.val(this.v);
        };
    };

    $.fn.dial = $.fn.knob = function (o) {
        return this.each(
            function () {
                var d = new k.Dial();
                d.o = o;
                d.$ = $(this);
                d.run();
            }
        ).parent();
    };

})(jQuery);
/*

$.classVal - WTFPL - refreshless.com/classval/ */

(function(b){function h(a,e){var d=!1;b.each(a?q:g,function(a){if(b(e).hasClass(a))return d=a,!1});return d}var n=b.fn.val,g={},q={},u={};b.classVal=function(a,b,d,l){"string"===typeof a&&"boolean"===typeof l&&(b&&(g[a]=b),d&&(q[a]=d),u[a]=l)};b.fn.val=function(){var a=Array.prototype.slice.call(arguments,0),e,d;return a.length?this.each(function(){(e=h(!0,this))?(d=u[e]?b(this):this,d[q[e]].apply(this,a)):n.apply(b(this),a)}):(e=h(!1,this))?(d=u[e]?this:this[0],d[g[e]].apply(d)):n.apply(this)}})(window.jQuery||
window.Zepto);/*

$.Link (part of noUiSlider) - WTFPL */
(function(b){function h(a,b,d){if((a[b]||a[d])&&a[b]===a[d])throw Error("(Link) '"+b+"' can't match '"+d+"'.'");}function n(a){void 0===a&&(a={});if("object"!==typeof a)throw Error("(Format) 'format' option must be an object.");var e={};b(q).each(function(b,l){if(void 0===a[l])e[l]=u[b];else if(typeof a[l]===typeof u[b]){if("decimals"===l&&(0>a[l]||7<a[l]))throw Error("(Format) 'format.decimals' option must be between 0 and 7.");e[l]=a[l]}else throw Error("(Format) 'format."+l+"' must be a "+typeof u[b]+
".");});h(e,"mark","thousand");h(e,"prefix","negative");h(e,"prefix","negativeBefore");this.r=e}function g(a,e){"object"!==typeof a&&b.error("(Link) Initialize with an object.");return new g.prototype.p(a.target||function(){},a.method,a.format||{},e)}var q="decimals mark thousand prefix postfix encoder decoder negative negativeBefore to from".split(" "),u=[2,".","","","",function(a){return a},function(a){return a},"-","",function(a){return a},function(a){return a}];n.prototype.a=function(a){return this.r[a]};
n.prototype.L=function(a){function b(a){return a.split("").reverse().join("")}a=this.a("encoder")(a);var d=this.a("decimals"),l="",g="",h="",n="";0===parseFloat(a.toFixed(d))&&(a="0");0>a&&(l=this.a("negative"),g=this.a("negativeBefore"));a=Math.abs(a).toFixed(d).toString();a=a.split(".");this.a("thousand")?(h=b(a[0]).match(/.{1,3}/g),h=b(h.join(b(this.a("thousand"))))):h=a[0];this.a("mark")&&1<a.length&&(n=this.a("mark")+a[1]);return this.a("to")(g+this.a("prefix")+l+h+n+this.a("postfix"))};n.prototype.w=
function(a){function b(a){return a.replace(/[\-\/\\\^$*+?.()|\[\]{}]/g,"\\$&")}var d;if(null===a||void 0===a)return!1;a=this.a("from")(a);a=a.toString();d=a.replace(RegExp("^"+b(this.a("negativeBefore"))),"");a!==d?(a=d,d="-"):d="";a=a.replace(RegExp("^"+b(this.a("prefix"))),"");this.a("negative")&&(d="",a=a.replace(RegExp("^"+b(this.a("negative"))),"-"));a=a.replace(RegExp(b(this.a("postfix"))+"$"),"").replace(RegExp(b(this.a("thousand")),"g"),"").replace(this.a("mark"),".");a=this.a("decoder")(parseFloat(d+
a));return isNaN(a)?!1:a};g.prototype.K=function(a,e){this.method=e||"html";this.j=b(a.replace("-tooltip-","")||"<div/>")[0]};g.prototype.H=function(a){this.method="val";this.j=document.createElement("input");this.j.name=a;this.j.type="hidden"};g.prototype.G=function(a){function e(a,b){return[b?null:a,b?a:null]}var d=this;this.method="val";this.target=a.on("change",function(a){d.B.val(e(b(a.target).val(),d.t),{link:d,set:!0})})};g.prototype.p=function(a,e,d,g){this.g=d;this.update=!g;if("string"===
typeof a&&0===a.indexOf("-tooltip-"))this.K(a,e);else if("string"===typeof a&&0!==a.indexOf("-"))this.H(a);else if("function"===typeof a)this.target=!1,this.method=a;else{if(a instanceof b||b.zepto&&b.zepto.isZ(a)){if(!e){if(a.is("input, select, textarea")){this.G(a);return}e="html"}if("function"===typeof e||"string"===typeof e&&a[e]){this.method=e;this.target=a;return}}throw new RangeError("(Link) Invalid Link.");}};g.prototype.write=function(a,b,d,g){if(!this.update||!1!==g)if(this.u=a,this.F=a=
this.format(a),"function"===typeof this.method)this.method.call(this.target[0]||d[0],a,b,d);else this.target[this.method](a,b,d)};g.prototype.q=function(a){this.g=new n(b.extend({},a,this.g instanceof n?this.g.r:this.g))};g.prototype.J=function(a){this.B=a};g.prototype.I=function(a){this.t=a};g.prototype.format=function(a){return this.g.L(a)};g.prototype.A=function(a){return this.g.w(a)};g.prototype.p.prototype=g.prototype;b.Link=g})(window.jQuery||window.Zepto);/*

$.fn.noUiSlider - WTFPL - refreshless.com/nouislider/ */
(function(b){function h(a){return"number"===typeof a&&!isNaN(a)&&isFinite(a)}function n(a){return b.isArray(a)?a:[a]}function g(a,c){a.addClass(c);setTimeout(function(){a.removeClass(c)},300)}function q(a,c){return 100*c/(a[1]-a[0])}function u(a,c){if(c>=a.d.slice(-1)[0])return 100;for(var b=1,f,d,e;c>=a.d[b];)b++;f=a.d[b-1];d=a.d[b];e=a.c[b-1];f=[f,d];return e+q(f,0>f[0]?c+Math.abs(f[0]):c-f[0])/(100/(a.c[b]-e))}function a(a,c){if(100<=c)return a.d.slice(-1)[0];for(var b=1,f,d,e;c>=a.c[b];)b++;f=
a.d[b-1];d=a.d[b];e=a.c[b-1];f=[f,d];return 100/(a.c[b]-e)*(c-e)*(f[1]-f[0])/100+f[0]}function e(a,c){for(var b=1,f;c>=a.c[b];)b++;if(a.m)return f=a.c[b-1],b=a.c[b],c-f>(b-f)/2?b:f;a.h[b-1]?(f=a.h[b-1],b=a.c[b-1]+Math.round((c-a.c[b-1])/f)*f):b=c;return b}function d(a,c){if(!h(c))throw Error("noUiSlider: 'step' is not numeric.");a.h[0]=c}function l(a,c){if("object"!==typeof c||b.isArray(c))throw Error("noUiSlider: 'range' is not an object.");b.each(c,function(c,f){var d;"number"===typeof f&&(f=[f]);
if(!b.isArray(f))throw Error("noUiSlider: 'range' contains invalid value.");d="min"===c?0:"max"===c?100:parseFloat(c);if(!h(d)||!h(f[0]))throw Error("noUiSlider: 'range' value isn't numeric.");a.c.push(d);a.d.push(f[0]);d?a.h.push(isNaN(f[1])?!1:f[1]):isNaN(f[1])||(a.h[0]=f[1])});b.each(a.h,function(c,b){if(!b)return!0;a.h[c]=q([a.d[c],a.d[c+1]],b)/(100/(a.c[c+1]-a.c[c]))})}function z(a,c){"number"===typeof c&&(c=[c]);if(!b.isArray(c)||!c.length||2<c.length)throw Error("noUiSlider: 'start' option is incorrect.");
a.b=c.length;a.start=c}function A(a,c){a.m=c;if("boolean"!==typeof c)throw Error("noUiSlider: 'snap' option must be a boolean.");}function B(a,c){if("lower"===c&&1===a.b)a.i=1;else if("upper"===c&&1===a.b)a.i=2;else if(!0===c&&2===a.b)a.i=3;else if(!1===c)a.i=0;else throw Error("noUiSlider: 'connect' option doesn't match handle count.");}function y(a,c){switch(c){case "horizontal":a.k=0;break;case "vertical":a.k=1;break;default:throw Error("noUiSlider: 'orientation' option is invalid.");}}function I(a,
c){if(2<a.c.length)throw Error("noUiSlider: 'margin' option is only supported on linear sliders.");a.margin=q(a.d,c);if(!h(c))throw Error("noUiSlider: 'margin' option must be numeric.");}function J(a,c){switch(c){case "ltr":a.dir=0;break;case "rtl":a.dir=1;a.i=[0,2,1,3][a.i];break;default:throw Error("noUiSlider: 'direction' option was not recognized.");}}function K(a,c){if("string"!==typeof c)throw Error("noUiSlider: 'behaviour' must be a string containing options.");var b=0<=c.indexOf("snap");a.n=
{s:0<=c.indexOf("tap")||b,extend:0<=c.indexOf("extend"),v:0<=c.indexOf("drag"),fixed:0<=c.indexOf("fixed"),m:b}}function L(a,c,d){a.o=[c.lower,c.upper];a.g=c.format;b.each(a.o,function(a,e){if(!b.isArray(e))throw Error("noUiSlider: 'serialization."+(a?"upper":"lower")+"' must be an array.");b.each(e,function(){if(!(this instanceof b.Link))throw Error("noUiSlider: 'serialization."+(a?"upper":"lower")+"' can only contain Link instances.");this.I(a);this.J(d);this.q(c.format)})});a.dir&&1<a.b&&a.o.reverse()}
function M(a,c){var e={c:[],d:[],h:[!1],margin:0},f;f={step:{e:!1,f:d},range:{e:!0,f:l},start:{e:!0,f:z},snap:{e:!1,f:A},connect:{e:!0,f:B},orientation:{e:!1,f:y},margin:{e:!1,f:I},direction:{e:!0,f:J},behaviour:{e:!0,f:K},serialization:{e:!0,f:L}};a=b.extend({connect:!1,direction:"ltr",behaviour:"tap",orientation:"horizontal"},a);a.serialization=b.extend({lower:[],upper:[],format:{}},a.serialization);b.each(f,function(b,d){if(void 0===a[b]){if(d.e)throw Error("noUiSlider: '"+b+"' is required.");
return!0}d.f(e,a[b],c)});e.style=e.k?"top":"left";return e}function N(a,c){var d=b("<div><div/></div>").addClass(k[2]),f=["-lower","-upper"];a.dir&&f.reverse();d.children().addClass(k[3]+" "+k[3]+f[c]);return d}function O(a,c){c.j&&(c=new b.Link({target:b(c.j).clone().appendTo(a),method:c.method,format:c.g},!0));return c}function P(a,c){var d,f=[];for(d=0;d<a.b;d++){var e=f,g=d,k=a.o[d],h=c[d].children(),l=a.g,n=void 0,q=[],n=new b.Link({},!0);n.q(l);q.push(n);for(n=0;n<k.length;n++)q.push(O(h,k[n]));
e[g]=q}return f}function Q(a,c,b){switch(a){case 1:c.addClass(k[7]);b[0].addClass(k[6]);break;case 3:b[1].addClass(k[6]);case 2:b[0].addClass(k[7]);case 0:c.addClass(k[6])}}function R(a,b){var d,f=[];for(d=0;d<a.b;d++)f.push(N(a,d).appendTo(b));return f}function S(a,c){c.addClass([k[0],k[8+a.dir],k[4+a.k]].join(" "));return b("<div/>").appendTo(c).addClass(k[1])}function T(d,c,h){function f(){return r[["width","height"][c.k]]()}function l(a){var b,c=[s.val()];for(b=0;b<a.length;b++)s.trigger(a[b],
c)}function q(d,p,f){var g=d[0]!==m[0][0]?1:0,H=v[0]+c.margin,l=v[1]-c.margin;f&&1<m.length&&(p=g?Math.max(p,H):Math.min(p,l));100>p&&(p=e(c,p));p=Math.max(Math.min(parseFloat(p.toFixed(7)),100),0);if(p===v[g])return 1===m.length?!1:p===H||p===l?0:!1;d.css(c.style,p+"%");d.is(":first-child")&&d.toggleClass(k[17],50<p);v[g]=p;c.dir&&(p=100-p);b(w[g]).each(function(){this.write(a(c,p),d.children(),s)});return!0}function G(a,b,c){c||g(s,k[14]);q(a,b,!1);l(["slide","set","change"])}function t(a,b,d,f){a=
a.replace(/\s/g,".nui ")+".nui";b.on(a,function(a){var b=s.attr("disabled");if(s.hasClass(k[14])||void 0!==b&&null!==b)return!1;a.preventDefault();var b=0===a.type.indexOf("touch"),p=0===a.type.indexOf("mouse"),e=0===a.type.indexOf("pointer"),D,g,l=a;0===a.type.indexOf("MSPointer")&&(e=!0);a.originalEvent&&(a=a.originalEvent);b&&(D=a.changedTouches[0].pageX,g=a.changedTouches[0].pageY);if(p||e)e||void 0!==window.pageXOffset||(window.pageXOffset=document.documentElement.scrollLeft,window.pageYOffset=
document.documentElement.scrollTop),D=a.clientX+window.pageXOffset,g=a.clientY+window.pageYOffset;l.C=[D,g];l.cursor=p;a=l;a.l=a.C[c.k];d(a,f)})}function y(a,b){var c=b.b||m,d,e=!1,e=100*(a.l-b.start)/f(),g=c[0][0]!==m[0][0]?1:0;var k=b.D;d=e+k[0];e+=k[1];1<c.length?(0>d&&(e+=Math.abs(d)),100<e&&(d-=e-100),d=[Math.max(Math.min(d,100),0),Math.max(Math.min(e,100),0)]):d=[d,e];e=q(c[0],d[g],1===c.length);1<c.length&&(e=q(c[1],d[g?0:1],!1)||e);e&&l(["slide"])}function z(a){b("."+k[15]).removeClass(k[15]);
a.cursor&&b("body").css("cursor","").off(".nui");E.off(".nui");s.removeClass(k[12]);l(["set","change"])}function C(a,c){1===c.b.length&&c.b[0].children().addClass(k[15]);a.stopPropagation();t(x.move,E,y,{start:a.l,b:c.b,D:[v[0],v[m.length-1]]});t(x.end,E,z,null);a.cursor&&(b("body").css("cursor",b(a.target).css("cursor")),1<m.length&&s.addClass(k[12]),b("body").on("selectstart.nui",!1))}function A(a){var d=a.l,e=0;a.stopPropagation();b.each(m,function(){e+=this.offset()[c.style]});e=d<e/2||1===m.length?
0:1;d-=r.offset()[c.style];d=100*d/f();G(m[e],d,c.n.m);c.n.m&&C(a,{b:[m[e]]})}function B(a){var b=(a=a.l<r.offset()[c.style])?0:100;a=a?0:m.length-1;G(m[a],b,!1)}var s=b(d),v=[-1,-1],r,w,m;if(s.hasClass(k[0]))throw Error("Slider was already initialized.");r=S(c,s);m=R(c,r);w=P(c,m);Q(c.i,s,m);(function(a){var b;if(!a.fixed)for(b=0;b<m.length;b++)t(x.start,m[b].children(),C,{b:[m[b]]});a.s&&t(x.start,r,A,{b:m});a.extend&&(s.addClass(k[16]),a.s&&t(x.start,s,B,{b:m}));a.v&&(b=r.find("."+k[7]).addClass(k[10]),
a.fixed&&(b=b.add(r.children().not(b).children())),t(x.start,b,C,{b:m}))})(c.n);d.vSet=function(){var a=Array.prototype.slice.call(arguments,0),d,e,f,h,r,F,t=n(a[0]);"object"===typeof a[1]?(d=a[1].set,e=a[1].link,f=a[1].update,h=a[1].animate):!0===a[1]&&(d=!0);c.dir&&1<c.b&&t.reverse();h&&g(s,k[14]);a=1<m.length?3:1;1===t.length&&(a=1);for(r=0;r<a;r++)h=e||w[r%2][0],h=h.A(t[r%2]),!1!==h&&(h=u(c,h),c.dir&&(h=100-h),!0!==q(m[r%2],h,!0)&&b(w[r%2]).each(function(a){if(!a)return F=this.u,!0;this.write(F,
m[r%2].children(),s,f)}));!0===d&&l(["set"]);return this};d.vGet=function(){var a,b=[];for(a=0;a<c.b;a++)b[a]=w[a][0].F;return 1===b.length?b[0]:c.dir?b.reverse():b};d.destroy=function(){b.each(w,function(){b.each(this,function(){this.target&&this.target.off(".nui")})});b(this).off(".nui").removeClass(k.join(" ")).empty();return h};s.val(c.start)}function U(a){if(!this.length)throw Error("noUiSlider: Can't initialize slider on empty selection.");var b=M(a,this);return this.each(function(){T(this,
b,a)})}function V(a){return this.each(function(){var c=b(this).val(),d=this.destroy(),e=b.extend({},d,a);b(this).noUiSlider(e);d.start===e.start&&b(this).val(c)})}var E=b(document),x=window.navigator.pointerEnabled?{start:"pointerdown",move:"pointermove",end:"pointerup"}:window.navigator.msPointerEnabled?{start:"MSPointerDown",move:"MSPointerMove",end:"MSPointerUp"}:{start:"mousedown touchstart",move:"mousemove touchmove",end:"mouseup touchend"},k="noUi-target noUi-base noUi-origin noUi-handle noUi-horizontal noUi-vertical noUi-background noUi-connect noUi-ltr noUi-rtl noUi-dragable  noUi-state-drag  noUi-state-tap noUi-active noUi-extended noUi-stacking".split(" ");
b.noUiSlider={Link:b.Link};b.fn.noUiSlider=function(a,b){return(b?V:U).call(this,a)};b.classVal(k[0],"vGet","vSet",!1)})(window.jQuery||window.Zepto);
(function(){function require(path,parent,orig){var resolved=require.resolve(path);if(null==resolved){orig=orig||path;parent=parent||"root";var err=new Error('Failed to require "'+orig+'" from "'+parent+'"');err.path=orig;err.parent=parent;err.require=true;throw err}var module=require.modules[resolved];if(!module._resolving&&!module.exports){var mod={};mod.exports={};mod.client=mod.component=true;module._resolving=true;module.call(this,mod.exports,require.relative(resolved),mod);delete module._resolving;module.exports=mod.exports}return module.exports}require.modules={};require.aliases={};require.resolve=function(path){if(path.charAt(0)==="/")path=path.slice(1);var paths=[path,path+".js",path+".json",path+"/index.js",path+"/index.json"];for(var i=0;i<paths.length;i++){var path=paths[i];if(require.modules.hasOwnProperty(path))return path;if(require.aliases.hasOwnProperty(path))return require.aliases[path]}};require.normalize=function(curr,path){var segs=[];if("."!=path.charAt(0))return path;curr=curr.split("/");path=path.split("/");for(var i=0;i<path.length;++i){if(".."==path[i]){curr.pop()}else if("."!=path[i]&&""!=path[i]){segs.push(path[i])}}return curr.concat(segs).join("/")};require.register=function(path,definition){require.modules[path]=definition};require.alias=function(from,to){if(!require.modules.hasOwnProperty(from)){throw new Error('Failed to alias "'+from+'", it does not exist')}require.aliases[to]=from};require.relative=function(parent){var p=require.normalize(parent,"..");function lastIndexOf(arr,obj){var i=arr.length;while(i--){if(arr[i]===obj)return i}return-1}function localRequire(path){var resolved=localRequire.resolve(path);return require(resolved,parent,path)}localRequire.resolve=function(path){var c=path.charAt(0);if("/"==c)return path.slice(1);if("."==c)return require.normalize(p,path);var segs=parent.split("/");var i=lastIndexOf(segs,"deps")+1;if(!i)i=0;path=segs.slice(0,i+1).join("/")+"/deps/"+path;return path};localRequire.exists=function(path){return require.modules.hasOwnProperty(localRequire.resolve(path))};return localRequire};require.register("abpetkov-transitionize/transitionize.js",function(exports,require,module){module.exports=Transitionize;function Transitionize(element,props){if(!(this instanceof Transitionize))return new Transitionize(element,props);this.element=element;this.props=props||{};this.init()}Transitionize.prototype.isSafari=function(){return/Safari/.test(navigator.userAgent)&&/Apple Computer/.test(navigator.vendor)};Transitionize.prototype.init=function(){var transitions=[];for(var key in this.props){transitions.push(key+" "+this.props[key])}this.element.style.transition=transitions.join(", ");if(this.isSafari())this.element.style.webkitTransition=transitions.join(", ")}});require.register("ftlabs-fastclick/lib/fastclick.js",function(exports,require,module){function FastClick(layer){"use strict";var oldOnClick,self=this;this.trackingClick=false;this.trackingClickStart=0;this.targetElement=null;this.touchStartX=0;this.touchStartY=0;this.lastTouchIdentifier=0;this.touchBoundary=10;this.layer=layer;if(!layer||!layer.nodeType){throw new TypeError("Layer must be a document node")}this.onClick=function(){return FastClick.prototype.onClick.apply(self,arguments)};this.onMouse=function(){return FastClick.prototype.onMouse.apply(self,arguments)};this.onTouchStart=function(){return FastClick.prototype.onTouchStart.apply(self,arguments)};this.onTouchMove=function(){return FastClick.prototype.onTouchMove.apply(self,arguments)};this.onTouchEnd=function(){return FastClick.prototype.onTouchEnd.apply(self,arguments)};this.onTouchCancel=function(){return FastClick.prototype.onTouchCancel.apply(self,arguments)};if(FastClick.notNeeded(layer)){return}if(this.deviceIsAndroid){layer.addEventListener("mouseover",this.onMouse,true);layer.addEventListener("mousedown",this.onMouse,true);layer.addEventListener("mouseup",this.onMouse,true)}layer.addEventListener("click",this.onClick,true);layer.addEventListener("touchstart",this.onTouchStart,false);layer.addEventListener("touchmove",this.onTouchMove,false);layer.addEventListener("touchend",this.onTouchEnd,false);layer.addEventListener("touchcancel",this.onTouchCancel,false);if(!Event.prototype.stopImmediatePropagation){layer.removeEventListener=function(type,callback,capture){var rmv=Node.prototype.removeEventListener;if(type==="click"){rmv.call(layer,type,callback.hijacked||callback,capture)}else{rmv.call(layer,type,callback,capture)}};layer.addEventListener=function(type,callback,capture){var adv=Node.prototype.addEventListener;if(type==="click"){adv.call(layer,type,callback.hijacked||(callback.hijacked=function(event){if(!event.propagationStopped){callback(event)}}),capture)}else{adv.call(layer,type,callback,capture)}}}if(typeof layer.onclick==="function"){oldOnClick=layer.onclick;layer.addEventListener("click",function(event){oldOnClick(event)},false);layer.onclick=null}}FastClick.prototype.deviceIsAndroid=navigator.userAgent.indexOf("Android")>0;FastClick.prototype.deviceIsIOS=/iP(ad|hone|od)/.test(navigator.userAgent);FastClick.prototype.deviceIsIOS4=FastClick.prototype.deviceIsIOS&&/OS 4_\d(_\d)?/.test(navigator.userAgent);FastClick.prototype.deviceIsIOSWithBadTarget=FastClick.prototype.deviceIsIOS&&/OS ([6-9]|\d{2})_\d/.test(navigator.userAgent);FastClick.prototype.needsClick=function(target){"use strict";switch(target.nodeName.toLowerCase()){case"button":case"select":case"textarea":if(target.disabled){return true}break;case"input":if(this.deviceIsIOS&&target.type==="file"||target.disabled){return true}break;case"label":case"video":return true}return/\bneedsclick\b/.test(target.className)};FastClick.prototype.needsFocus=function(target){"use strict";switch(target.nodeName.toLowerCase()){case"textarea":return true;case"select":return!this.deviceIsAndroid;case"input":switch(target.type){case"button":case"checkbox":case"file":case"image":case"radio":case"submit":return false}return!target.disabled&&!target.readOnly;default:return/\bneedsfocus\b/.test(target.className)}};FastClick.prototype.sendClick=function(targetElement,event){"use strict";var clickEvent,touch;if(document.activeElement&&document.activeElement!==targetElement){document.activeElement.blur()}touch=event.changedTouches[0];clickEvent=document.createEvent("MouseEvents");clickEvent.initMouseEvent(this.determineEventType(targetElement),true,true,window,1,touch.screenX,touch.screenY,touch.clientX,touch.clientY,false,false,false,false,0,null);clickEvent.forwardedTouchEvent=true;targetElement.dispatchEvent(clickEvent)};FastClick.prototype.determineEventType=function(targetElement){"use strict";if(this.deviceIsAndroid&&targetElement.tagName.toLowerCase()==="select"){return"mousedown"}return"click"};FastClick.prototype.focus=function(targetElement){"use strict";var length;if(this.deviceIsIOS&&targetElement.setSelectionRange&&targetElement.type.indexOf("date")!==0&&targetElement.type!=="time"){length=targetElement.value.length;targetElement.setSelectionRange(length,length)}else{targetElement.focus()}};FastClick.prototype.updateScrollParent=function(targetElement){"use strict";var scrollParent,parentElement;scrollParent=targetElement.fastClickScrollParent;if(!scrollParent||!scrollParent.contains(targetElement)){parentElement=targetElement;do{if(parentElement.scrollHeight>parentElement.offsetHeight){scrollParent=parentElement;targetElement.fastClickScrollParent=parentElement;break}parentElement=parentElement.parentElement}while(parentElement)}if(scrollParent){scrollParent.fastClickLastScrollTop=scrollParent.scrollTop}};FastClick.prototype.getTargetElementFromEventTarget=function(eventTarget){"use strict";if(eventTarget.nodeType===Node.TEXT_NODE){return eventTarget.parentNode}return eventTarget};FastClick.prototype.onTouchStart=function(event){"use strict";var targetElement,touch,selection;if(event.targetTouches.length>1){return true}targetElement=this.getTargetElementFromEventTarget(event.target);touch=event.targetTouches[0];if(this.deviceIsIOS){selection=window.getSelection();if(selection.rangeCount&&!selection.isCollapsed){return true}if(!this.deviceIsIOS4){if(touch.identifier===this.lastTouchIdentifier){event.preventDefault();return false}this.lastTouchIdentifier=touch.identifier;this.updateScrollParent(targetElement)}}this.trackingClick=true;this.trackingClickStart=event.timeStamp;this.targetElement=targetElement;this.touchStartX=touch.pageX;this.touchStartY=touch.pageY;if(event.timeStamp-this.lastClickTime<200){event.preventDefault()}return true};FastClick.prototype.touchHasMoved=function(event){"use strict";var touch=event.changedTouches[0],boundary=this.touchBoundary;if(Math.abs(touch.pageX-this.touchStartX)>boundary||Math.abs(touch.pageY-this.touchStartY)>boundary){return true}return false};FastClick.prototype.onTouchMove=function(event){"use strict";if(!this.trackingClick){return true}if(this.targetElement!==this.getTargetElementFromEventTarget(event.target)||this.touchHasMoved(event)){this.trackingClick=false;this.targetElement=null}return true};FastClick.prototype.findControl=function(labelElement){"use strict";if(labelElement.control!==undefined){return labelElement.control}if(labelElement.htmlFor){return document.getElementById(labelElement.htmlFor)}return labelElement.querySelector("button, input:not([type=hidden]), keygen, meter, output, progress, select, textarea")};FastClick.prototype.onTouchEnd=function(event){"use strict";var forElement,trackingClickStart,targetTagName,scrollParent,touch,targetElement=this.targetElement;if(!this.trackingClick){return true}if(event.timeStamp-this.lastClickTime<200){this.cancelNextClick=true;return true}this.cancelNextClick=false;this.lastClickTime=event.timeStamp;trackingClickStart=this.trackingClickStart;this.trackingClick=false;this.trackingClickStart=0;if(this.deviceIsIOSWithBadTarget){touch=event.changedTouches[0];targetElement=document.elementFromPoint(touch.pageX-window.pageXOffset,touch.pageY-window.pageYOffset)||targetElement;targetElement.fastClickScrollParent=this.targetElement.fastClickScrollParent}targetTagName=targetElement.tagName.toLowerCase();if(targetTagName==="label"){forElement=this.findControl(targetElement);if(forElement){this.focus(targetElement);if(this.deviceIsAndroid){return false}targetElement=forElement}}else if(this.needsFocus(targetElement)){if(event.timeStamp-trackingClickStart>100||this.deviceIsIOS&&window.top!==window&&targetTagName==="input"){this.targetElement=null;return false}this.focus(targetElement);if(!this.deviceIsIOS4||targetTagName!=="select"){this.targetElement=null;event.preventDefault()}return false}if(this.deviceIsIOS&&!this.deviceIsIOS4){scrollParent=targetElement.fastClickScrollParent;if(scrollParent&&scrollParent.fastClickLastScrollTop!==scrollParent.scrollTop){return true}}if(!this.needsClick(targetElement)){event.preventDefault();this.sendClick(targetElement,event)}return false};FastClick.prototype.onTouchCancel=function(){"use strict";this.trackingClick=false;this.targetElement=null};FastClick.prototype.onMouse=function(event){"use strict";if(!this.targetElement){return true}if(event.forwardedTouchEvent){return true}if(!event.cancelable){return true}if(!this.needsClick(this.targetElement)||this.cancelNextClick){if(event.stopImmediatePropagation){event.stopImmediatePropagation()}else{event.propagationStopped=true}event.stopPropagation();event.preventDefault();return false}return true};FastClick.prototype.onClick=function(event){"use strict";var permitted;if(this.trackingClick){this.targetElement=null;this.trackingClick=false;return true}if(event.target.type==="submit"&&event.detail===0){return true}permitted=this.onMouse(event);if(!permitted){this.targetElement=null}return permitted};FastClick.prototype.destroy=function(){"use strict";var layer=this.layer;if(this.deviceIsAndroid){layer.removeEventListener("mouseover",this.onMouse,true);layer.removeEventListener("mousedown",this.onMouse,true);layer.removeEventListener("mouseup",this.onMouse,true)}layer.removeEventListener("click",this.onClick,true);layer.removeEventListener("touchstart",this.onTouchStart,false);layer.removeEventListener("touchmove",this.onTouchMove,false);layer.removeEventListener("touchend",this.onTouchEnd,false);layer.removeEventListener("touchcancel",this.onTouchCancel,false)};FastClick.notNeeded=function(layer){"use strict";var metaViewport;var chromeVersion;if(typeof window.ontouchstart==="undefined"){return true}chromeVersion=+(/Chrome\/([0-9]+)/.exec(navigator.userAgent)||[,0])[1];if(chromeVersion){if(FastClick.prototype.deviceIsAndroid){metaViewport=document.querySelector("meta[name=viewport]");if(metaViewport){if(metaViewport.content.indexOf("user-scalable=no")!==-1){return true}if(chromeVersion>31&&window.innerWidth<=window.screen.width){return true}}}else{return true}}if(layer.style.msTouchAction==="none"){return true}return false};FastClick.attach=function(layer){"use strict";return new FastClick(layer)};if(typeof define!=="undefined"&&define.amd){define(function(){"use strict";return FastClick})}else if(typeof module!=="undefined"&&module.exports){module.exports=FastClick.attach;module.exports.FastClick=FastClick}else{window.FastClick=FastClick}});require.register("switchery/switchery.js",function(exports,require,module){var transitionize=require("transitionize"),fastclick=require("fastclick");module.exports=Switchery;var defaults={color:"#64bd63",secondaryColor:"#dfdfdf",className:"switchery",disabled:false,disabledOpacity:.5,speed:"0.4s"};function Switchery(element,options){if(!(this instanceof Switchery))return new Switchery(element,options);this.element=element;this.options=options||{};for(var i in defaults){if(this.options[i]==null){this.options[i]=defaults[i]}}if(this.element!=null&&this.element.type=="checkbox")this.init()}Switchery.prototype.hide=function(){this.element.style.display="none"};Switchery.prototype.show=function(){var switcher=this.create();this.insertAfter(this.element,switcher)};Switchery.prototype.create=function(){this.switcher=document.createElement("span");this.jack=document.createElement("small");this.switcher.appendChild(this.jack);this.switcher.className=this.options.className;return this.switcher};Switchery.prototype.insertAfter=function(reference,target){reference.parentNode.insertBefore(target,reference.nextSibling)};Switchery.prototype.isChecked=function(){return this.element.checked};Switchery.prototype.isDisabled=function(){return this.options.disabled||this.element.disabled};Switchery.prototype.setPosition=function(clicked){var checked=this.isChecked(),switcher=this.switcher,jack=this.jack;if(clicked&&checked)checked=false;else if(clicked&&!checked)checked=true;if(checked===true){this.element.checked=true;if(window.getComputedStyle)jack.style.left=parseInt(window.getComputedStyle(switcher).width)-parseInt(window.getComputedStyle(jack).width)+"px";else jack.style.left=parseInt(switcher.currentStyle["width"])-parseInt(jack.currentStyle["width"])+"px";if(this.options.color)this.colorize();this.setSpeed()}else{jack.style.left=0;this.element.checked=false;this.switcher.style.boxShadow="inset 0 0 0 0 "+this.options.secondaryColor;this.switcher.style.borderColor=this.options.secondaryColor;this.switcher.style.backgroundColor="";this.setSpeed()}};Switchery.prototype.setSpeed=function(){var switcherProp={},jackProp={left:this.options.speed.replace(/[a-z]/,"")/2+"s"};if(this.isChecked()){switcherProp={border:this.options.speed,"box-shadow":this.options.speed,"background-color":this.options.speed.replace(/[a-z]/,"")*3+"s"}}else{switcherProp={border:this.options.speed,"box-shadow":this.options.speed}}transitionize(this.switcher,switcherProp);transitionize(this.jack,jackProp)};Switchery.prototype.setAttributes=function(){var id=this.element.getAttribute("id"),name=this.element.getAttribute("name");if(id)this.switcher.setAttribute("id",id);if(name)this.switcher.setAttribute("name",name)};Switchery.prototype.colorize=function(){this.switcher.style.backgroundColor=this.options.color;this.switcher.style.borderColor=this.options.color;this.switcher.style.boxShadow="inset 0 0 0 16px "+this.options.color};Switchery.prototype.handleOnchange=function(state){if(typeof Event==="function"||!document.fireEvent){var event=document.createEvent("HTMLEvents");event.initEvent("change",true,true);this.element.dispatchEvent(event)}else{this.element.fireEvent("onchange")}};Switchery.prototype.handleChange=function(){var self=this,el=this.element;if(el.addEventListener){el.addEventListener("change",function(){self.setPosition()})}else{el.attachEvent("onchange",function(){self.setPosition()})}};Switchery.prototype.handleClick=function(){var self=this,switcher=this.switcher;if(this.isDisabled()===false){fastclick(switcher);if(switcher.addEventListener){switcher.addEventListener("click",function(){self.setPosition(true);self.handleOnchange(self.element.checked)})}else{switcher.attachEvent("onclick",function(){self.setPosition(true);self.handleOnchange(self.element.checked)})}}else{this.element.disabled=true;this.switcher.style.opacity=this.options.disabledOpacity}};Switchery.prototype.disableLabel=function(){var parent=this.element.parentNode,labels=document.getElementsByTagName("label"),attached=null;for(var i=0;i<labels.length;i++){if(labels[i].getAttribute("for")===this.element.id){attached=true}}if(attached===true||parent.tagName.toLowerCase()==="label"){if(parent.addEventListener){parent.addEventListener("click",function(e){e.preventDefault()})}else{parent.attachEvent("onclick",function(e){e.returnValue=false})}}};Switchery.prototype.markAsSwitched=function(){this.element.setAttribute("data-switchery",true)};Switchery.prototype.markedAsSwitched=function(){return this.element.getAttribute("data-switchery")};Switchery.prototype.init=function(){this.hide();this.show();this.setPosition();this.setAttributes();this.markAsSwitched();this.disableLabel();this.handleChange();this.handleClick()}});require.alias("abpetkov-transitionize/transitionize.js","switchery/deps/transitionize/transitionize.js");require.alias("abpetkov-transitionize/transitionize.js","switchery/deps/transitionize/index.js");require.alias("abpetkov-transitionize/transitionize.js","transitionize/index.js");require.alias("abpetkov-transitionize/transitionize.js","abpetkov-transitionize/index.js");require.alias("ftlabs-fastclick/lib/fastclick.js","switchery/deps/fastclick/lib/fastclick.js");require.alias("ftlabs-fastclick/lib/fastclick.js","switchery/deps/fastclick/index.js");require.alias("ftlabs-fastclick/lib/fastclick.js","fastclick/index.js");require.alias("ftlabs-fastclick/lib/fastclick.js","ftlabs-fastclick/index.js");require.alias("switchery/switchery.js","switchery/index.js");if(typeof exports=="object"){module.exports=require("switchery")}else if(typeof define=="function"&&define.amd){define(function(){return require("switchery")})}else{this["Switchery"]=require("switchery")}})();
/*!
 Chosen, a Select Box Enhancer for jQuery and Prototype
 by Patrick Filler for Harvest, http://getharvest.com

 Version 1.1.0
 Full source at https://github.com/harvesthq/chosen
 Copyright (c) 2011 Harvest http://getharvest.com

 MIT License, https://github.com/harvesthq/chosen/blob/master/LICENSE.md
 This file is generated by `grunt build`, do not edit it by hand.
 */


(function() {
    var $, AbstractChosen, Chosen, SelectParser, _ref,
        __hasProp = {}.hasOwnProperty,
        __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

    SelectParser = (function() {
        function SelectParser() {
            this.options_index = 0;
            this.parsed = [];
        }

        SelectParser.prototype.add_node = function(child) {
            if (child.nodeName.toUpperCase() === "OPTGROUP") {
                return this.add_group(child);
            } else {
                return this.add_option(child);
            }
        };

        SelectParser.prototype.add_group = function(group) {
            var group_position, option, _i, _len, _ref, _results;
            group_position = this.parsed.length;
            this.parsed.push({
                array_index: group_position,
                group: true,
                label: this.escapeExpression(group.label),
                children: 0,
                disabled: group.disabled
            });
            _ref = group.childNodes;
            _results = [];
            for (_i = 0, _len = _ref.length; _i < _len; _i++) {
                option = _ref[_i];
                _results.push(this.add_option(option, group_position, group.disabled));
            }
            return _results;
        };

        SelectParser.prototype.add_option = function(option, group_position, group_disabled) {
            if (option.nodeName.toUpperCase() === "OPTION") {
                if (option.text !== "") {
                    if (group_position != null) {
                        this.parsed[group_position].children += 1;
                    }
                    this.parsed.push({
                        array_index: this.parsed.length,
                        options_index: this.options_index,
                        value: option.value,
                        text: option.text,
                        html: option.innerHTML,
                        selected: option.selected,
                        disabled: group_disabled === true ? group_disabled : option.disabled,
                        group_array_index: group_position,
                        classes: option.className,
                        style: option.style.cssText
                    });
                } else {
                    this.parsed.push({
                        array_index: this.parsed.length,
                        options_index: this.options_index,
                        empty: true
                    });
                }
                return this.options_index += 1;
            }
        };

        SelectParser.prototype.escapeExpression = function(text) {
            var map, unsafe_chars;
            if ((text == null) || text === false) {
                return "";
            }
            if (!/[\&\<\>\"\'\`]/.test(text)) {
                return text;
            }
            map = {
                "<": "&lt;",
                ">": "&gt;",
                '"': "&quot;",
                "'": "&#x27;",
                "`": "&#x60;"
            };
            unsafe_chars = /&(?!\w+;)|[\<\>\"\'\`]/g;
            return text.replace(unsafe_chars, function(chr) {
                return map[chr] || "&amp;";
            });
        };

        return SelectParser;

    })();

    SelectParser.select_to_array = function(select) {
        var child, parser, _i, _len, _ref;
        parser = new SelectParser();
        _ref = select.childNodes;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            child = _ref[_i];
            parser.add_node(child);
        }
        return parser.parsed;
    };

    AbstractChosen = (function() {
        function AbstractChosen(form_field, options) {
            this.form_field = form_field;
            this.options = options != null ? options : {};
            if (!AbstractChosen.browser_is_supported()) {
                return;
            }
            this.is_multiple = this.form_field.multiple;
            this.set_default_text();
            this.set_default_values();
            this.setup();
            this.set_up_html();
            this.register_observers();
        }

        AbstractChosen.prototype.set_default_values = function() {
            var _this = this;
            this.click_test_action = function(evt) {
                return _this.test_active_click(evt);
            };
            this.activate_action = function(evt) {
                return _this.activate_field(evt);
            };
            this.active_field = false;
            this.mouse_on_container = false;
            this.results_showing = false;
            this.result_highlighted = null;
            this.allow_single_deselect = (this.options.allow_single_deselect != null) && (this.form_field.options[0] != null) && this.form_field.options[0].text === "" ? this.options.allow_single_deselect : false;
            this.disable_search_threshold = this.options.disable_search_threshold || 0;
            this.disable_search = this.options.disable_search || false;
            this.enable_split_word_search = this.options.enable_split_word_search != null ? this.options.enable_split_word_search : true;
            this.group_search = this.options.group_search != null ? this.options.group_search : true;
            this.search_contains = this.options.search_contains || false;
            this.single_backstroke_delete = this.options.single_backstroke_delete != null ? this.options.single_backstroke_delete : true;
            this.max_selected_options = this.options.max_selected_options || Infinity;
            this.inherit_select_classes = this.options.inherit_select_classes || false;
            this.display_selected_options = this.options.display_selected_options != null ? this.options.display_selected_options : true;
            return this.display_disabled_options = this.options.display_disabled_options != null ? this.options.display_disabled_options : true;
        };

        AbstractChosen.prototype.set_default_text = function() {
            if (this.form_field.getAttribute("data-placeholder")) {
                this.default_text = this.form_field.getAttribute("data-placeholder");
            } else if (this.is_multiple) {
                this.default_text = this.options.placeholder_text_multiple || this.options.placeholder_text || AbstractChosen.default_multiple_text;
            } else {
                this.default_text = this.options.placeholder_text_single || this.options.placeholder_text || AbstractChosen.default_single_text;
            }
            return this.results_none_found = this.form_field.getAttribute("data-no_results_text") || this.options.no_results_text || AbstractChosen.default_no_result_text;
        };

        AbstractChosen.prototype.mouse_enter = function() {
            return this.mouse_on_container = true;
        };

        AbstractChosen.prototype.mouse_leave = function() {
            return this.mouse_on_container = false;
        };

        AbstractChosen.prototype.input_focus = function(evt) {
            var _this = this;
            if (this.is_multiple) {
                if (!this.active_field) {
                    return setTimeout((function() {
                        return _this.container_mousedown();
                    }), 50);
                }
            } else {
                if (!this.active_field) {
                    return this.activate_field();
                }
            }
        };

        AbstractChosen.prototype.input_blur = function(evt) {
            var _this = this;
            if (!this.mouse_on_container) {
                this.active_field = false;
                return setTimeout((function() {
                    return _this.blur_test();
                }), 100);
            }
        };

        AbstractChosen.prototype.results_option_build = function(options) {
            var content, data, _i, _len, _ref;
            content = '';
            _ref = this.results_data;
            for (_i = 0, _len = _ref.length; _i < _len; _i++) {
                data = _ref[_i];
                if (data.group) {
                    content += this.result_add_group(data);
                } else {
                    content += this.result_add_option(data);
                }
                if (options != null ? options.first : void 0) {
                    if (data.selected && this.is_multiple) {
                        this.choice_build(data);
                    } else if (data.selected && !this.is_multiple) {
                        this.single_set_selected_text(data.text);
                    }
                }
            }
            return content;
        };

        AbstractChosen.prototype.result_add_option = function(option) {
            var classes, option_el;
            if (!option.search_match) {
                return '';
            }
            if (!this.include_option_in_results(option)) {
                return '';
            }
            classes = [];
            if (!option.disabled && !(option.selected && this.is_multiple)) {
                classes.push("active-result");
            }
            if (option.disabled && !(option.selected && this.is_multiple)) {
                classes.push("disabled-result");
            }
            if (option.selected) {
                classes.push("result-selected");
            }
            if (option.group_array_index != null) {
                classes.push("group-option");
            }
            if (option.classes !== "") {
                classes.push(option.classes);
            }
            option_el = document.createElement("li");
            option_el.className = classes.join(" ");
            option_el.style.cssText = option.style;
            option_el.setAttribute("data-option-array-index", option.array_index);
            option_el.innerHTML = option.search_text;
            return this.outerHTML(option_el);
        };

        AbstractChosen.prototype.result_add_group = function(group) {
            var group_el;
            if (!(group.search_match || group.group_match)) {
                return '';
            }
            if (!(group.active_options > 0)) {
                return '';
            }
            group_el = document.createElement("li");
            group_el.className = "group-result";
            group_el.innerHTML = group.search_text;
            return this.outerHTML(group_el);
        };

        AbstractChosen.prototype.results_update_field = function() {
            this.set_default_text();
            if (!this.is_multiple) {
                this.results_reset_cleanup();
            }
            this.result_clear_highlight();
            this.results_build();
            if (this.results_showing) {
                return this.winnow_results();
            }
        };

        AbstractChosen.prototype.reset_single_select_options = function() {
            var result, _i, _len, _ref, _results;
            _ref = this.results_data;
            _results = [];
            for (_i = 0, _len = _ref.length; _i < _len; _i++) {
                result = _ref[_i];
                if (result.selected) {
                    _results.push(result.selected = false);
                } else {
                    _results.push(void 0);
                }
            }
            return _results;
        };

        AbstractChosen.prototype.results_toggle = function() {
            if (this.results_showing) {
                return this.results_hide();
            } else {
                return this.results_show();
            }
        };

        AbstractChosen.prototype.results_search = function(evt) {
            if (this.results_showing) {
                return this.winnow_results();
            } else {
                return this.results_show();
            }
        };

        AbstractChosen.prototype.winnow_results = function() {
            var escapedSearchText, option, regex, regexAnchor, results, results_group, searchText, startpos, text, zregex, _i, _len, _ref;
            this.no_results_clear();
            results = 0;
            searchText = this.get_search_text();
            escapedSearchText = searchText.replace(/[-[\]{}()*+?.,\\^$|#\s]/g, "\\$&");
            regexAnchor = this.search_contains ? "" : "^";
            regex = new RegExp(regexAnchor + escapedSearchText, 'i');
            zregex = new RegExp(escapedSearchText, 'i');
            _ref = this.results_data;
            for (_i = 0, _len = _ref.length; _i < _len; _i++) {
                option = _ref[_i];
                option.search_match = false;
                results_group = null;
                if (this.include_option_in_results(option)) {
                    if (option.group) {
                        option.group_match = false;
                        option.active_options = 0;
                    }
                    if ((option.group_array_index != null) && this.results_data[option.group_array_index]) {
                        results_group = this.results_data[option.group_array_index];
                        if (results_group.active_options === 0 && results_group.search_match) {
                            results += 1;
                        }
                        results_group.active_options += 1;
                    }
                    if (!(option.group && !this.group_search)) {
                        option.search_text = option.group ? option.label : option.html;
                        option.search_match = this.search_string_match(option.search_text, regex);
                        if (option.search_match && !option.group) {
                            results += 1;
                        }
                        if (option.search_match) {
                            if (searchText.length) {
                                startpos = option.search_text.search(zregex);
                                text = option.search_text.substr(0, startpos + searchText.length) + '</em>' + option.search_text.substr(startpos + searchText.length);
                                option.search_text = text.substr(0, startpos) + '<em>' + text.substr(startpos);
                            }
                            if (results_group != null) {
                                results_group.group_match = true;
                            }
                        } else if ((option.group_array_index != null) && this.results_data[option.group_array_index].search_match) {
                            option.search_match = true;
                        }
                    }
                }
            }
            this.result_clear_highlight();
            if (results < 1 && searchText.length) {
                this.update_results_content("");
                return this.no_results(searchText);
            } else {
                this.update_results_content(this.results_option_build());
                return this.winnow_results_set_highlight();
            }
        };

        AbstractChosen.prototype.search_string_match = function(search_string, regex) {
            var part, parts, _i, _len;
            if (regex.test(search_string)) {
                return true;
            } else if (this.enable_split_word_search && (search_string.indexOf(" ") >= 0 || search_string.indexOf("[") === 0)) {
                parts = search_string.replace(/\[|\]/g, "").split(" ");
                if (parts.length) {
                    for (_i = 0, _len = parts.length; _i < _len; _i++) {
                        part = parts[_i];
                        if (regex.test(part)) {
                            return true;
                        }
                    }
                }
            }
        };

        AbstractChosen.prototype.choices_count = function() {
            var option, _i, _len, _ref;
            if (this.selected_option_count != null) {
                return this.selected_option_count;
            }
            this.selected_option_count = 0;
            _ref = this.form_field.options;
            for (_i = 0, _len = _ref.length; _i < _len; _i++) {
                option = _ref[_i];
                if (option.selected) {
                    this.selected_option_count += 1;
                }
            }
            return this.selected_option_count;
        };

        AbstractChosen.prototype.choices_click = function(evt) {
            evt.preventDefault();
            if (!(this.results_showing || this.is_disabled)) {
                return this.results_show();
            }
        };

        AbstractChosen.prototype.keyup_checker = function(evt) {
            var stroke, _ref;
            stroke = (_ref = evt.which) != null ? _ref : evt.keyCode;
            this.search_field_scale();
            switch (stroke) {
                case 8:
                    if (this.is_multiple && this.backstroke_length < 1 && this.choices_count() > 0) {
                        return this.keydown_backstroke();
                    } else if (!this.pending_backstroke) {
                        this.result_clear_highlight();
                        return this.results_search();
                    }
                    break;
                case 13:
                    evt.preventDefault();
                    if (this.results_showing) {
                        return this.result_select(evt);
                    }
                    break;
                case 27:
                    if (this.results_showing) {
                        this.results_hide();
                    }
                    return true;
                case 9:
                case 38:
                case 40:
                case 16:
                case 91:
                case 17:
                    break;
                default:
                    return this.results_search();
            }
        };

        AbstractChosen.prototype.clipboard_event_checker = function(evt) {
            var _this = this;
            return setTimeout((function() {
                return _this.results_search();
            }), 50);
        };

        AbstractChosen.prototype.container_width = function() {
            if (this.options.width != null) {
                return this.options.width;
            } else {
                return "" + this.form_field.offsetWidth + "px";
            }
        };

        AbstractChosen.prototype.include_option_in_results = function(option) {
            if (this.is_multiple && (!this.display_selected_options && option.selected)) {
                return false;
            }
            if (!this.display_disabled_options && option.disabled) {
                return false;
            }
            if (option.empty) {
                return false;
            }
            return true;
        };

        AbstractChosen.prototype.search_results_touchstart = function(evt) {
            this.touch_started = true;
            return this.search_results_mouseover(evt);
        };

        AbstractChosen.prototype.search_results_touchmove = function(evt) {
            this.touch_started = false;
            return this.search_results_mouseout(evt);
        };

        AbstractChosen.prototype.search_results_touchend = function(evt) {
            if (this.touch_started) {
                return this.search_results_mouseup(evt);
            }
        };

        AbstractChosen.prototype.outerHTML = function(element) {
            var tmp;
            if (element.outerHTML) {
                return element.outerHTML;
            }
            tmp = document.createElement("div");
            tmp.appendChild(element);
            return tmp.innerHTML;
        };

        AbstractChosen.browser_is_supported = function() {
            if (window.navigator.appName === "Microsoft Internet Explorer") {
                return document.documentMode >= 8;
            }
            if (/iP(od|hone)/i.test(window.navigator.userAgent)) {
                return false;
            }
            if (/Android/i.test(window.navigator.userAgent)) {
                if (/Mobile/i.test(window.navigator.userAgent)) {
                    return false;
                }
            }
            return true;
        };

        AbstractChosen.default_multiple_text = "Select Some Options";

        AbstractChosen.default_single_text = "Select an Option";

        AbstractChosen.default_no_result_text = "No results match";

        return AbstractChosen;

    })();

    $ = jQuery;

    $.fn.extend({
        chosen: function(options) {
            if (!AbstractChosen.browser_is_supported()) {
                return this;
            }
            return this.each(function(input_field) {
                var $this, chosen;
                $this = $(this);
                chosen = $this.data('chosen');
                if (options === 'destroy' && chosen) {
                    chosen.destroy();
                } else if (!chosen) {
                    $this.data('chosen', new Chosen(this, options));
                }
            });
        }
    });

    Chosen = (function(_super) {
        __extends(Chosen, _super);

        function Chosen() {
            _ref = Chosen.__super__.constructor.apply(this, arguments);
            return _ref;
        }

        Chosen.prototype.setup = function() {
            this.form_field_jq = $(this.form_field);
            this.current_selectedIndex = this.form_field.selectedIndex;
            return this.is_rtl = this.form_field_jq.hasClass("chosen-rtl");
        };

        Chosen.prototype.set_up_html = function() {
            var container_classes, container_props;
            container_classes = ["chosen-container"];
            container_classes.push("chosen-container-" + (this.is_multiple ? "multi" : "single"));
            if (this.inherit_select_classes && this.form_field.className) {
                container_classes.push(this.form_field.className);
            }
            if (this.is_rtl) {
                container_classes.push("chosen-rtl");
            }
            container_props = {
                'class': container_classes.join(' '),
                'style': "width: " + (this.container_width()) + ";",
                'title': this.form_field.title
            };
            if (this.form_field.id.length) {
                container_props.id = this.form_field.id.replace(/[^\w]/g, '_') + "_chosen";
            }
            this.container = $("<div />", container_props);
            if (this.is_multiple) {
                this.container.html('<ul class="chosen-choices"><li class="search-field"><input type="text" value="' + this.default_text + '" class="default" autocomplete="off" style="width:25px;" /></li></ul><div class="chosen-drop"><ul class="chosen-results"></ul></div>');
            } else {
                this.container.html('<a class="chosen-single chosen-default" tabindex="-1"><span>' + this.default_text + '</span><div><b></b></div></a><div class="chosen-drop"><div class="chosen-search"><input type="text" autocomplete="off" /></div><ul class="chosen-results"></ul></div>');
            }
            this.form_field_jq.hide().after(this.container);
            this.dropdown = this.container.find('div.chosen-drop').first();
            this.search_field = this.container.find('input').first();
            this.search_results = this.container.find('ul.chosen-results').first();
            this.search_field_scale();
            this.search_no_results = this.container.find('li.no-results').first();
            if (this.is_multiple) {
                this.search_choices = this.container.find('ul.chosen-choices').first();
                this.search_container = this.container.find('li.search-field').first();
            } else {
                this.search_container = this.container.find('div.chosen-search').first();
                this.selected_item = this.container.find('.chosen-single').first();
            }
            this.results_build();
            this.set_tab_index();
            this.set_label_behavior();
            return this.form_field_jq.trigger("chosen:ready", {
                chosen: this
            });
        };

        Chosen.prototype.register_observers = function() {
            var _this = this;
            this.container.bind('mousedown.chosen', function(evt) {
                _this.container_mousedown(evt);
            });
            this.container.bind('mouseup.chosen', function(evt) {
                _this.container_mouseup(evt);
            });
            this.container.bind('mouseenter.chosen', function(evt) {
                _this.mouse_enter(evt);
            });
            this.container.bind('mouseleave.chosen', function(evt) {
                _this.mouse_leave(evt);
            });
            this.search_results.bind('mouseup.chosen', function(evt) {
                _this.search_results_mouseup(evt);
            });
            this.search_results.bind('mouseover.chosen', function(evt) {
                _this.search_results_mouseover(evt);
            });
            this.search_results.bind('mouseout.chosen', function(evt) {
                _this.search_results_mouseout(evt);
            });
            this.search_results.bind('mousewheel.chosen DOMMouseScroll.chosen', function(evt) {
                _this.search_results_mousewheel(evt);
            });
            this.search_results.bind('touchstart.chosen', function(evt) {
                _this.search_results_touchstart(evt);
            });
            this.search_results.bind('touchmove.chosen', function(evt) {
                _this.search_results_touchmove(evt);
            });
            this.search_results.bind('touchend.chosen', function(evt) {
                _this.search_results_touchend(evt);
            });
            this.form_field_jq.bind("chosen:updated.chosen", function(evt) {
                _this.results_update_field(evt);
            });
            this.form_field_jq.bind("chosen:activate.chosen", function(evt) {
                _this.activate_field(evt);
            });
            this.form_field_jq.bind("chosen:open.chosen", function(evt) {
                _this.container_mousedown(evt);
            });
            this.form_field_jq.bind("chosen:close.chosen", function(evt) {
                _this.input_blur(evt);
            });
            this.search_field.bind('blur.chosen', function(evt) {
                _this.input_blur(evt);
            });
            this.search_field.bind('keyup.chosen', function(evt) {
                _this.keyup_checker(evt);
            });
            this.search_field.bind('keydown.chosen', function(evt) {
                _this.keydown_checker(evt);
            });
            this.search_field.bind('focus.chosen', function(evt) {
                _this.input_focus(evt);
            });
            this.search_field.bind('cut.chosen', function(evt) {
                _this.clipboard_event_checker(evt);
            });
            this.search_field.bind('paste.chosen', function(evt) {
                _this.clipboard_event_checker(evt);
            });
            if (this.is_multiple) {
                return this.search_choices.bind('click.chosen', function(evt) {
                    _this.choices_click(evt);
                });
            } else {
                return this.container.bind('click.chosen', function(evt) {
                    evt.preventDefault();
                });
            }
        };

        Chosen.prototype.destroy = function() {
            $(this.container[0].ownerDocument).unbind("click.chosen", this.click_test_action);
            if (this.search_field[0].tabIndex) {
                this.form_field_jq[0].tabIndex = this.search_field[0].tabIndex;
            }
            this.container.remove();
            this.form_field_jq.removeData('chosen');
            return this.form_field_jq.show();
        };

        Chosen.prototype.search_field_disabled = function() {
            this.is_disabled = this.form_field_jq[0].disabled;
            if (this.is_disabled) {
                this.container.addClass('chosen-disabled');
                this.search_field[0].disabled = true;
                if (!this.is_multiple) {
                    this.selected_item.unbind("focus.chosen", this.activate_action);
                }
                return this.close_field();
            } else {
                this.container.removeClass('chosen-disabled');
                this.search_field[0].disabled = false;
                if (!this.is_multiple) {
                    return this.selected_item.bind("focus.chosen", this.activate_action);
                }
            }
        };

        Chosen.prototype.container_mousedown = function(evt) {
            if (!this.is_disabled) {
                if (evt && evt.type === "mousedown" && !this.results_showing) {
                    evt.preventDefault();
                }
                if (!((evt != null) && ($(evt.target)).hasClass("search-choice-close"))) {
                    if (!this.active_field) {
                        if (this.is_multiple) {
                            this.search_field.val("");
                        }
                        $(this.container[0].ownerDocument).bind('click.chosen', this.click_test_action);
                        this.results_show();
                    } else if (!this.is_multiple && evt && (($(evt.target)[0] === this.selected_item[0]) || $(evt.target).parents("a.chosen-single").length)) {
                        evt.preventDefault();
                        this.results_toggle();
                    }
                    return this.activate_field();
                }
            }
        };

        Chosen.prototype.container_mouseup = function(evt) {
            if (evt.target.nodeName === "ABBR" && !this.is_disabled) {
                return this.results_reset(evt);
            }
        };

        Chosen.prototype.search_results_mousewheel = function(evt) {
            var delta;
            if (evt.originalEvent) {
                delta = -evt.originalEvent.wheelDelta || evt.originalEvent.detail;
            }
            if (delta != null) {
                evt.preventDefault();
                if (evt.type === 'DOMMouseScroll') {
                    delta = delta * 40;
                }
                return this.search_results.scrollTop(delta + this.search_results.scrollTop());
            }
        };

        Chosen.prototype.blur_test = function(evt) {
            if (!this.active_field && this.container.hasClass("chosen-container-active")) {
                return this.close_field();
            }
        };

        Chosen.prototype.close_field = function() {
            $(this.container[0].ownerDocument).unbind("click.chosen", this.click_test_action);
            this.active_field = false;
            this.results_hide();
            this.container.removeClass("chosen-container-active");
            this.clear_backstroke();
            this.show_search_field_default();
            return this.search_field_scale();
        };

        Chosen.prototype.activate_field = function() {
            this.container.addClass("chosen-container-active");
            this.active_field = true;
            this.search_field.val(this.search_field.val());
            return this.search_field.focus();
        };

        Chosen.prototype.test_active_click = function(evt) {
            var active_container;
            active_container = $(evt.target).closest('.chosen-container');
            if (active_container.length && this.container[0] === active_container[0]) {
                return this.active_field = true;
            } else {
                return this.close_field();
            }
        };

        Chosen.prototype.results_build = function() {
            this.parsing = true;
            this.selected_option_count = null;
            this.results_data = SelectParser.select_to_array(this.form_field);
            if (this.is_multiple) {
                this.search_choices.find("li.search-choice").remove();
            } else if (!this.is_multiple) {
                this.single_set_selected_text();
                if (this.disable_search || this.form_field.options.length <= this.disable_search_threshold) {
                    this.search_field[0].readOnly = true;
                    this.container.addClass("chosen-container-single-nosearch");
                } else {
                    this.search_field[0].readOnly = false;
                    this.container.removeClass("chosen-container-single-nosearch");
                }
            }
            this.update_results_content(this.results_option_build({
                first: true
            }));
            this.search_field_disabled();
            this.show_search_field_default();
            this.search_field_scale();
            return this.parsing = false;
        };

        Chosen.prototype.result_do_highlight = function(el) {
            var high_bottom, high_top, maxHeight, visible_bottom, visible_top;
            if (el.length) {
                this.result_clear_highlight();
                this.result_highlight = el;
                this.result_highlight.addClass("highlighted");
                maxHeight = parseInt(this.search_results.css("maxHeight"), 10);
                visible_top = this.search_results.scrollTop();
                visible_bottom = maxHeight + visible_top;
                high_top = this.result_highlight.position().top + this.search_results.scrollTop();
                high_bottom = high_top + this.result_highlight.outerHeight();
                if (high_bottom >= visible_bottom) {
                    return this.search_results.scrollTop((high_bottom - maxHeight) > 0 ? high_bottom - maxHeight : 0);
                } else if (high_top < visible_top) {
                    return this.search_results.scrollTop(high_top);
                }
            }
        };

        Chosen.prototype.result_clear_highlight = function() {
            if (this.result_highlight) {
                this.result_highlight.removeClass("highlighted");
            }
            return this.result_highlight = null;
        };

        Chosen.prototype.results_show = function() {
            if (this.is_multiple && this.max_selected_options <= this.choices_count()) {
                this.form_field_jq.trigger("chosen:maxselected", {
                    chosen: this
                });
                return false;
            }
            this.container.addClass("chosen-with-drop");
            this.results_showing = true;
            this.search_field.focus();
            this.search_field.val(this.search_field.val());
            this.winnow_results();
            return this.form_field_jq.trigger("chosen:showing_dropdown", {
                chosen: this
            });
        };

        Chosen.prototype.update_results_content = function(content) {
            return this.search_results.html(content);
        };

        Chosen.prototype.results_hide = function() {
            if (this.results_showing) {
                this.result_clear_highlight();
                this.container.removeClass("chosen-with-drop");
                this.form_field_jq.trigger("chosen:hiding_dropdown", {
                    chosen: this
                });
            }
            return this.results_showing = false;
        };

        Chosen.prototype.set_tab_index = function(el) {
            var ti;
            if (this.form_field.tabIndex) {
                ti = this.form_field.tabIndex;
                this.form_field.tabIndex = -1;
                return this.search_field[0].tabIndex = ti;
            }
        };

        Chosen.prototype.set_label_behavior = function() {
            var _this = this;
            this.form_field_label = this.form_field_jq.parents("label");
            if (!this.form_field_label.length && this.form_field.id.length) {
                this.form_field_label = $("label[for='" + this.form_field.id + "']");
            }
            if (this.form_field_label.length > 0) {
                return this.form_field_label.bind('click.chosen', function(evt) {
                    if (_this.is_multiple) {
                        return _this.container_mousedown(evt);
                    } else {
                        return _this.activate_field();
                    }
                });
            }
        };

        Chosen.prototype.show_search_field_default = function() {
            if (this.is_multiple && this.choices_count() < 1 && !this.active_field) {
                this.search_field.val(this.default_text);
                return this.search_field.addClass("default");
            } else {
                this.search_field.val("");
                return this.search_field.removeClass("default");
            }
        };

        Chosen.prototype.search_results_mouseup = function(evt) {
            var target;
            target = $(evt.target).hasClass("active-result") ? $(evt.target) : $(evt.target).parents(".active-result").first();
            if (target.length) {
                this.result_highlight = target;
                this.result_select(evt);
                return this.search_field.focus();
            }
        };

        Chosen.prototype.search_results_mouseover = function(evt) {
            var target;
            target = $(evt.target).hasClass("active-result") ? $(evt.target) : $(evt.target).parents(".active-result").first();
            if (target) {
                return this.result_do_highlight(target);
            }
        };

        Chosen.prototype.search_results_mouseout = function(evt) {
            if ($(evt.target).hasClass("active-result" || $(evt.target).parents('.active-result').first())) {
                return this.result_clear_highlight();
            }
        };

        Chosen.prototype.choice_build = function(item) {
            var choice, close_link,
                _this = this;
            choice = $('<li />', {
                "class": "search-choice"
            }).html("<span>" + item.html + "</span>");
            if (item.disabled) {
                choice.addClass('search-choice-disabled');
            } else {
                close_link = $('<a />', {
                    "class": 'search-choice-close',
                    'data-option-array-index': item.array_index
                });
                close_link.bind('click.chosen', function(evt) {
                    return _this.choice_destroy_link_click(evt);
                });
                choice.append(close_link);
            }
            return this.search_container.before(choice);
        };

        Chosen.prototype.choice_destroy_link_click = function(evt) {
            evt.preventDefault();
            evt.stopPropagation();
            if (!this.is_disabled) {
                return this.choice_destroy($(evt.target));
            }
        };

        Chosen.prototype.choice_destroy = function(link) {
            if (this.result_deselect(link[0].getAttribute("data-option-array-index"))) {
                this.show_search_field_default();
                if (this.is_multiple && this.choices_count() > 0 && this.search_field.val().length < 1) {
                    this.results_hide();
                }
                link.parents('li').first().remove();
                return this.search_field_scale();
            }
        };

        Chosen.prototype.results_reset = function() {
            this.reset_single_select_options();
            this.form_field.options[0].selected = true;
            this.single_set_selected_text();
            this.show_search_field_default();
            this.results_reset_cleanup();
            this.form_field_jq.trigger("change");
            if (this.active_field) {
                return this.results_hide();
            }
        };

        Chosen.prototype.results_reset_cleanup = function() {
            this.current_selectedIndex = this.form_field.selectedIndex;
            return this.selected_item.find("abbr").remove();
        };

        Chosen.prototype.result_select = function(evt) {
            var high, item;
            if (this.result_highlight) {
                high = this.result_highlight;
                this.result_clear_highlight();
                if (this.is_multiple && this.max_selected_options <= this.choices_count()) {
                    this.form_field_jq.trigger("chosen:maxselected", {
                        chosen: this
                    });
                    return false;
                }
                if (this.is_multiple) {
                    high.removeClass("active-result");
                } else {
                    this.reset_single_select_options();
                }
                item = this.results_data[high[0].getAttribute("data-option-array-index")];
                item.selected = true;
                this.form_field.options[item.options_index].selected = true;
                this.selected_option_count = null;
                if (this.is_multiple) {
                    this.choice_build(item);
                } else {
                    this.single_set_selected_text(item.text);
                }
                if (!((evt.metaKey || evt.ctrlKey) && this.is_multiple)) {
                    this.results_hide();
                }
                this.search_field.val("");
                if (this.is_multiple || this.form_field.selectedIndex !== this.current_selectedIndex) {
                    this.form_field_jq.trigger("change", {
                        'selected': this.form_field.options[item.options_index].value
                    });
                }
                this.current_selectedIndex = this.form_field.selectedIndex;
                return this.search_field_scale();
            }
        };

        Chosen.prototype.single_set_selected_text = function(text) {
            if (text == null) {
                text = this.default_text;
            }
            if (text === this.default_text) {
                this.selected_item.addClass("chosen-default");
            } else {
                this.single_deselect_control_build();
                this.selected_item.removeClass("chosen-default");
            }
            return this.selected_item.find("span").text(text);
        };

        Chosen.prototype.result_deselect = function(pos) {
            var result_data;
            result_data = this.results_data[pos];
            if (!this.form_field.options[result_data.options_index].disabled) {
                result_data.selected = false;
                this.form_field.options[result_data.options_index].selected = false;
                this.selected_option_count = null;
                this.result_clear_highlight();
                if (this.results_showing) {
                    this.winnow_results();
                }
                this.form_field_jq.trigger("change", {
                    deselected: this.form_field.options[result_data.options_index].value
                });
                this.search_field_scale();
                return true;
            } else {
                return false;
            }
        };

        Chosen.prototype.single_deselect_control_build = function() {
            if (!this.allow_single_deselect) {
                return;
            }
            if (!this.selected_item.find("abbr").length) {
                this.selected_item.find("span").first().after("<abbr class=\"search-choice-close\"></abbr>");
            }
            return this.selected_item.addClass("chosen-single-with-deselect");
        };

        Chosen.prototype.get_search_text = function() {
            if (this.search_field.val() === this.default_text) {
                return "";
            } else {
                return $('<div/>').text($.trim(this.search_field.val())).html();
            }
        };

        Chosen.prototype.winnow_results_set_highlight = function() {
            var do_high, selected_results;
            selected_results = !this.is_multiple ? this.search_results.find(".result-selected.active-result") : [];
            do_high = selected_results.length ? selected_results.first() : this.search_results.find(".active-result").first();
            if (do_high != null) {
                return this.result_do_highlight(do_high);
            }
        };

        Chosen.prototype.no_results = function(terms) {
            var no_results_html;
            no_results_html = $('<li class="no-results">' + this.results_none_found + ' "<span></span>"</li>');
            no_results_html.find("span").first().html(terms);
            this.search_results.append(no_results_html);
            return this.form_field_jq.trigger("chosen:no_results", {
                chosen: this
            });
        };

        Chosen.prototype.no_results_clear = function() {
            return this.search_results.find(".no-results").remove();
        };

        Chosen.prototype.keydown_arrow = function() {
            var next_sib;
            if (this.results_showing && this.result_highlight) {
                next_sib = this.result_highlight.nextAll("li.active-result").first();
                if (next_sib) {
                    return this.result_do_highlight(next_sib);
                }
            } else {
                return this.results_show();
            }
        };

        Chosen.prototype.keyup_arrow = function() {
            var prev_sibs;
            if (!this.results_showing && !this.is_multiple) {
                return this.results_show();
            } else if (this.result_highlight) {
                prev_sibs = this.result_highlight.prevAll("li.active-result");
                if (prev_sibs.length) {
                    return this.result_do_highlight(prev_sibs.first());
                } else {
                    if (this.choices_count() > 0) {
                        this.results_hide();
                    }
                    return this.result_clear_highlight();
                }
            }
        };

        Chosen.prototype.keydown_backstroke = function() {
            var next_available_destroy;
            if (this.pending_backstroke) {
                this.choice_destroy(this.pending_backstroke.find("a").first());
                return this.clear_backstroke();
            } else {
                next_available_destroy = this.search_container.siblings("li.search-choice").last();
                if (next_available_destroy.length && !next_available_destroy.hasClass("search-choice-disabled")) {
                    this.pending_backstroke = next_available_destroy;
                    if (this.single_backstroke_delete) {
                        return this.keydown_backstroke();
                    } else {
                        return this.pending_backstroke.addClass("search-choice-focus");
                    }
                }
            }
        };

        Chosen.prototype.clear_backstroke = function() {
            if (this.pending_backstroke) {
                this.pending_backstroke.removeClass("search-choice-focus");
            }
            return this.pending_backstroke = null;
        };

        Chosen.prototype.keydown_checker = function(evt) {
            var stroke, _ref1;
            stroke = (_ref1 = evt.which) != null ? _ref1 : evt.keyCode;
            this.search_field_scale();
            if (stroke !== 8 && this.pending_backstroke) {
                this.clear_backstroke();
            }
            switch (stroke) {
                case 8:
                    this.backstroke_length = this.search_field.val().length;
                    break;
                case 9:
                    if (this.results_showing && !this.is_multiple) {
                        this.result_select(evt);
                    }
                    this.mouse_on_container = false;
                    break;
                case 13:
                    evt.preventDefault();
                    break;
                case 38:
                    evt.preventDefault();
                    this.keyup_arrow();
                    break;
                case 40:
                    evt.preventDefault();
                    this.keydown_arrow();
                    break;
            }
        };

        Chosen.prototype.search_field_scale = function() {
            var div, f_width, h, style, style_block, styles, w, _i, _len;
            if (this.is_multiple) {
                h = 0;
                w = 0;
                style_block = "position:absolute; left: -1000px; top: -1000px; display:none;";
                styles = ['font-size', 'font-style', 'font-weight', 'font-family', 'line-height', 'text-transform', 'letter-spacing'];
                for (_i = 0, _len = styles.length; _i < _len; _i++) {
                    style = styles[_i];
                    style_block += style + ":" + this.search_field.css(style) + ";";
                }
                div = $('<div />', {
                    'style': style_block
                });
                div.text(this.search_field.val());
                $('body').append(div);
                w = div.width() + 25;
                div.remove();
                f_width = this.container.outerWidth();
                if (w > f_width - 10) {
                    w = f_width - 10;
                }
                return this.search_field.css({
                    'width': w + 'px'
                });
            }
        };

        return Chosen;

    })(AbstractChosen);

}).call(this);














