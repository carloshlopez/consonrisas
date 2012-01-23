/*
 * SmartWizard 3.0 plugin
 * jQuery Wizard control Plugin
 * by Dipu
 *
 * http://www.techlaboratory.net
 * http://tech-laboratory.blogspot.com
 *
 * Refactored and extended:
 * https://github.com/mstratman/jQuery-Smart-Wizard
 */

function SmartWizard(target, options) {
    this.target       = target;
    this.options      = options;
    this.curStepIdx   = options.selected;
    this.steps        = $jq("ul > li > a", target); // Get all anchors in this array
    this.contentWidth = 0;
    this.msgBox = $jq('<div class="msgBox"><div class="content"></div><a href="#" class="close">X</a></div>');
    this.elmStepContainer = $jq('<div></div>').addClass("stepContainer");
    this.loader = $jq('<div>Loading</div>').addClass("loader");
    this.buttons = {
        next : $jq('<a>'+options.labelNext+'</a>').attr("href","#").addClass("buttonNext"),
        previous : $jq('<a>'+options.labelPrevious+'</a>').attr("href","#").addClass("buttonPrevious"),
        finish  : $jq('<a>'+options.labelFinish+'</a>').attr("href","#").addClass("buttonFinish")
    };

    /*
     * Private functions
     */

    var _init = function($jqthis) {
        var elmActionBar = $jq('<div></div>').addClass("actionBar");
        elmActionBar.append($jqthis.msgBox);
        $jq('.close',$jqthis.msgBox).click(function() {
            $jqthis.msgBox.fadeOut("normal");
            return false;
        });

        var allDivs = $jqthis.target.children('div');
        $jqthis.target.children('ul').addClass("anchor");
        allDivs.addClass("content");

        // highlight steps with errors
        if($jqthis.options.errorSteps && $jqthis.options.errorSteps.length>0){
            $jq.each($jqthis.options.errorSteps, function(i, n){
                $jqthis.setError({ stepnum: n, iserror:true });
            });
        }

        $jqthis.elmStepContainer.append(allDivs);
        elmActionBar.append($jqthis.loader);
        $jqthis.target.append($jqthis.elmStepContainer);
        elmActionBar.append($jqthis.buttons.finish)
                    .append($jqthis.buttons.next)
                    .append($jqthis.buttons.previous);
        $jqthis.target.append(elmActionBar);
        this.contentWidth = $jqthis.elmStepContainer.width();

        $jq($jqthis.buttons.next).click(function() {
            $jqthis.goForward();
            return false;
        });
        $jq($jqthis.buttons.previous).click(function() {
            $jqthis.goBackward();
            return false;
        });
        $jq($jqthis.buttons.finish).click(function() {
            if(!$jq(this).hasClass('buttonDisabled')){
                if($jq.isFunction($jqthis.options.onFinish)) {
                    var context = { fromStep: $jqthis.curStepIdx + 1 };
                    if(!$jqthis.options.onFinish.call(this,$jq($jqthis.steps), context)){
                        return false;
                    }
                }else{
                    var frm = $jqthis.target.parents('form');
                    if(frm && frm.length){
                        frm.submit();
                    }
                }
            }
            return false;
        });

        $jq($jqthis.steps).bind("click", function(e){
            if($jqthis.steps.index(this) == $jqthis.curStepIdx){
                return false;
            }
            var nextStepIdx = $jqthis.steps.index(this);
            var isDone = $jqthis.steps.eq(nextStepIdx).attr("isDone") - 0;
            if(isDone == 1){
                _loadContent($jqthis, nextStepIdx);
            }
            return false;
        });

        // Enable keyboard navigation
        if($jqthis.options.keyNavigation){
            $jq(document).keyup(function(e){
                if(e.which==39){ // Right Arrow
                    $jqthis.goForward();
                }else if(e.which==37){ // Left Arrow
                    $jqthis.goBackward();
                }
            });
        }
        //  Prepare the steps
        _prepareSteps($jqthis);
        // Show the first slected step
        _loadContent($jqthis, $jqthis.curStepIdx);
    };

    var _prepareSteps = function($jqthis) {
        if(! $jqthis.options.enableAllSteps){
            $jq($jqthis.steps, $jqthis.target).removeClass("selected").removeClass("done").addClass("disabled");
            $jq($jqthis.steps, $jqthis.target).attr("isDone",0);
        }else{
            $jq($jqthis.steps, $jqthis.target).removeClass("selected").removeClass("disabled").addClass("done");
            $jq($jqthis.steps, $jqthis.target).attr("isDone",1);
        }

        $jq($jqthis.steps, $jqthis.target).each(function(i){
            $jq($jq(this).attr("href"), $jqthis.target).hide();
            $jq(this).attr("rel",i+1);
        });
    };

    var _loadContent = function($jqthis, stepIdx) {
        var selStep = $jqthis.steps.eq(stepIdx);
        var ajaxurl = $jqthis.options.contentURL;
        var hasContent = selStep.data('hasContent');
        var stepNum = stepIdx+1;
        if (ajaxurl && ajaxurl.length>0) {
            if ($jqthis.options.contentCache && hasContent) {
                _showStep($jqthis, stepIdx);
            } else {
                $jq.ajax({
                    url: ajaxurl,
                    type: "POST",
                    data: ({step_number : stepNum}),
                    dataType: "text",
                    beforeSend: function(){
                        $jqthis.loader.show();
                    },
                    error: function(){
                        $jqthis.loader.hide();
                    },
                    success: function(res){
                        $jqthis.loader.hide();
                        if(res && res.length>0){
                            selStep.data('hasContent',true);
                            $jq($jq(selStep, $jqthis.target).attr("href")).html(res);
                            _showStep($jqthis, stepIdx);
                        }
                    }
                });
            }
        }else{
            _showStep($jqthis,stepIdx);
        }
    };

    var _showStep = function($jqthis, stepIdx) {
        var selStep = $jqthis.steps.eq(stepIdx);
        var curStep = $jqthis.steps.eq($jqthis.curStepIdx);
        if(stepIdx != $jqthis.curStepIdx){
            if($jq.isFunction($jqthis.options.onLeaveStep)) {
                var context = { fromStep: $jqthis.curStepIdx+1, toStep: stepIdx+1 };
                if (! $jqthis.options.onLeaveStep.call($jqthis,$jq(curStep), context)){
                    return false;
                }
            }
        }
        $jqthis.elmStepContainer.height($jq($jq(selStep, $jqthis.target).attr("href"), $jqthis.target).outerHeight());
        var prevCurStepIdx = $jqthis.curStepIdx;
        $jqthis.curStepIdx =  stepIdx;
        if ($jqthis.options.transitionEffect == 'slide'){
            $jq($jq(curStep, $jqthis.target).attr("href"), $jqthis.target).slideUp("fast",function(e){
                $jq($jq(selStep, $jqthis.target).attr("href"), $jqthis.target).slideDown("fast");
                _setupStep($jqthis,curStep,selStep);
            });
        } else if ($jqthis.options.transitionEffect == 'fade'){
            $jq($jq(curStep, $jqthis.target).attr("href"), $jqthis.target).fadeOut("fast",function(e){
                $jq($jq(selStep, $jqthis.target).attr("href"), $jqthis.target).fadeIn("fast");
                _setupStep($jqthis,curStep,selStep);
            });
        } else if ($jqthis.options.transitionEffect == 'slideleft'){
            var nextElmLeft = 0;
            var nextElmLeft1 = null;
            var nextElmLeft = null;
            var curElementLeft = 0;
            if(stepIdx > prevCurStepIdx){
                nextElmLeft1 = $jqthis.contentWidth + 10;
                nextElmLeft2 = 0;
                curElementLeft = 0 - $jq($jq(curStep, $jqthis.target).attr("href"), $jqthis.target).outerWidth();
            } else {
                nextElmLeft1 = 0 - $jq($jq(selStep, $jqthis.target).attr("href"), $jqthis.target).outerWidth() + 20;
                nextElmLeft2 = 0;
                curElementLeft = 10 + $jq($jq(curStep, $jqthis.target).attr("href"), $jqthis.target).outerWidth();
            }
            if (stepIdx == prevCurStepIdx) {
                nextElmLeft1 = $jq($jq(selStep, $jqthis.target).attr("href"), $jqthis.target).outerWidth() + 20;
                nextElmLeft2 = 0;
                curElementLeft = 0 - $jq($jq(curStep, $jqthis.target).attr("href"), $jqthis.target).outerWidth();
            } else {
                $jq($jq(curStep, $jqthis.target).attr("href"), $jqthis.target).animate({left:curElementLeft},"fast",function(e){
                    $jq($jq(curStep, $jqthis.target).attr("href"), $jqthis.target).hide();
                });
            }

            $jq($jq(selStep, $jqthis.target).attr("href"), $jqthis.target).css("left",nextElmLeft1);
            $jq($jq(selStep, $jqthis.target).attr("href"), $jqthis.target).show();
            $jq($jq(selStep, $jqthis.target).attr("href"), $jqthis.target).animate({left:nextElmLeft2},"fast",function(e){
                _setupStep($jqthis,curStep,selStep);
            });
        } else {
            $jq($jq(curStep, $jqthis.target).attr("href"), $jqthis.target).hide();
            $jq($jq(selStep, $jqthis.target).attr("href"), $jqthis.target).show();
            _setupStep($jqthis,curStep,selStep);
        }
        return true;
    };

    var _setupStep = function($jqthis, curStep, selStep) {
        $jq(curStep, $jqthis.target).removeClass("selected");
        $jq(curStep, $jqthis.target).addClass("done");

        $jq(selStep, $jqthis.target).removeClass("disabled");
        $jq(selStep, $jqthis.target).removeClass("done");
        $jq(selStep, $jqthis.target).addClass("selected");

        $jq(selStep, $jqthis.target).attr("isDone",1);

        _adjustButton($jqthis);

        if($jq.isFunction($jqthis.options.onShowStep)) {
            var context = { fromStep: parseInt($jq(curStep).attr('rel')), toStep: parseInt($jq(selStep).attr('rel')) };
            if(! $jqthis.options.onShowStep.call(this,$jq(selStep),context)){
                return false;
            }
        }
        if ($jqthis.options.noForwardJumping) {
            // +2 == +1 (for index to step num) +1 (for next step)
            for (var i = $jqthis.curStepIdx + 2; i <= $jqthis.steps.length; i++) {
                $jqthis.disableStep(i);
            }
        }
    };

    var _adjustButton = function($jqthis) {
        if (! $jqthis.options.cycleSteps){
            if (0 >= $jqthis.curStepIdx) {
                $jq($jqthis.buttons.previous).addClass("buttonDisabled");
            }else{
                $jq($jqthis.buttons.previous).removeClass("buttonDisabled");
            }
            if (($jqthis.steps.length-1) <= $jqthis.curStepIdx){
                $jq($jqthis.buttons.next).addClass("buttonDisabled");
            }else{
                $jq($jqthis.buttons.next).removeClass("buttonDisabled");
            }
        }
        // Finish Button
        if (! $jqthis.steps.hasClass('disabled') || $jqthis.options.enableFinishButton){
            $jq($jqthis.buttons.finish).removeClass("buttonDisabled");
        }else{
            $jq($jqthis.buttons.finish).addClass("buttonDisabled");
        }
    };

    /*
     * Public methods
     */

    SmartWizard.prototype.goForward = function(){
        var nextStepIdx = this.curStepIdx + 1;
        if (this.steps.length <= nextStepIdx){
            if (! this.options.cycleSteps){
                return false;
            }
            nextStepIdx = 0;
        }
        _loadContent(this, nextStepIdx);
    };

    SmartWizard.prototype.goBackward = function(){
        var nextStepIdx = this.curStepIdx-1;
        if (0 > nextStepIdx){
            if (! this.options.cycleSteps){
                return false;
            }
            nextStepIdx = this.steps.length - 1;
        }
        _loadContent(this, nextStepIdx);
    };

    SmartWizard.prototype.goToStep = function(stepNum){
        var stepIdx = stepNum - 1;
        if (stepIdx >= 0 && stepIdx < this.steps.length) {
            _loadContent(this, stepIdx);
        }
    };
    SmartWizard.prototype.enableStep = function(stepNum) {
        var stepIdx = stepNum - 1;
        if (stepIdx == this.curStepIdx || stepIdx < 0 || stepIdx >= this.steps.length) {
            return false;
        }
        var step = this.steps.eq(stepIdx);
        $jq(step, this.target).attr("isDone",1);
        $jq(step, this.target).removeClass("disabled").removeClass("selected").addClass("done");
    }
    SmartWizard.prototype.disableStep = function(stepNum) {
        var stepIdx = stepNum - 1;
        if (stepIdx == this.curStepIdx || stepIdx < 0 || stepIdx >= this.steps.length) {
            return false;
        }
        var step = this.steps.eq(stepIdx);
        $jq(step, this.target).attr("isDone",0);
        $jq(step, this.target).removeClass("done").removeClass("selected").addClass("disabled");
    }
    SmartWizard.prototype.currentStep = function() {
        return this.curStepIdx + 1;
    }

    SmartWizard.prototype.showMessage = function (msg) {
        $jq('.content', this.msgBox).html(msg);
        this.msgBox.show();
    }
    SmartWizard.prototype.hideMessage = function () {
        this.msgBox.fadeOut("normal");
    }
    SmartWizard.prototype.showError = function(stepnum) {
        this.setError(stepnum, true);
    }
    SmartWizard.prototype.hideError = function(stepnum) {
        this.setError(stepnum, false);
    }
    SmartWizard.prototype.setError = function(stepnum,iserror) {
        if (typeof stepnum == "object") {
            iserror = stepnum.iserror;
            stepnum = stepnum.stepnum;
        }

        if (iserror){
            $jq(this.steps.eq(stepnum-1), this.target).addClass('error')
        }else{
            $jq(this.steps.eq(stepnum-1), this.target).removeClass("error");
        }
    }

    _init(this);
};



(function($jq){

$jq.fn.smartWizard = function(method) {
    var args = arguments;
    var rv = undefined;
    var allObjs = this.each(function() {
        var wiz = $jq(this).data('smartWizard');
        if (typeof method == 'object' || ! method || ! wiz) {
            var options = $jq.extend({}, $jq.fn.smartWizard.defaults, method || {});
            if (! wiz) {
                wiz = new SmartWizard($jq(this), options);
                $jq(this).data('smartWizard', wiz);
            }
        } else {
            if (typeof SmartWizard.prototype[method] == "function") {
                rv = SmartWizard.prototype[method].apply(wiz, Array.prototype.slice.call(args, 1));
                return rv;
            } else {
                $jq.error('Method ' + method + ' does not exist on jQuery.smartWizard');
            }
        }
    });
    if (rv === undefined) {
        return allObjs;
    } else {
        return rv;
    }
};

// Default Properties and Events
$jq.fn.smartWizard.defaults = {
    selected: 0,  // Selected Step, 0 = first step
    keyNavigation: true, // Enable/Disable key navigation(left and right keys are used if enabled)
    enableAllSteps: false,
    transitionEffect: 'fade', // Effect on navigation, none/fade/slide/slideleft
    contentURL:null, // content url, Enables Ajax content loading
    contentCache:true, // cache step contents, if false content is fetched always from ajax url
    cycleSteps: false, // cycle step navigation
    enableFinishButton: false, // make finish button enabled always
    errorSteps:[],    // Array Steps with errors
    labelNext:'Next',
    labelPrevious:'Previous',
    labelFinish:'Finish',
    noForwardJumping: false,
    onLeaveStep: null, // triggers when leaving a step
    onShowStep: null,  // triggers when showing a step
    onFinish: null  // triggers when Finish button is clicked
};

})(jQuery);
