/*** OOP ***/
function Disease() {
    var id = 0;
    var title = "";
    var question = null;
}
var ParentDisease = null;
function Question() {
    var id = 0;
    var title = "";
    var answers = [];
}
var Questions = [];
function getQuestionParentAnswer(questionObj) {
    var returnObj = null;
    Answers.forEach(function(item){
        if(typeof item.question != 'undefined') {
            if (item.question.id == questionObj.id) {
                returnObj = item;
            }
        }
    });
    return returnObj;
}
function findQuestionById(id) {
    var returnObj = null;
    Questions.forEach(function(item){
        if(id == item.id) {
            returnObj = item;
        }
    });
    return returnObj;
}

function Answer() {
    var id = 0;
    var title = "";
    var question = null;
    var result = null;
}
var Answers = [];
function getParentQuestion(answerObj) {
    var returnObj = null;
    Questions.forEach(function(item){
        if(typeof item.answers != 'undefined') {
            item.answers.forEach(function(answerItem){                
                if (answerItem.id == answerObj.id) {
                    returnObj = item;
                }                    
            });
        }
    });
    return returnObj;
}
function findAnswerById(id) {
    var returnObj = null;
    Answers.forEach(function(item){
        if(id == item.id) {
            returnObj = item;
        }
    });
    return returnObj;
}

function Result() {
    var id = 0;
    var title = "";
    var disease_id = null;
    var scripts = [];
}
var Results = [];
function getResultParentAnswer(resultObj) {
    var returnObj = null;
    Answers.forEach(function(item){
        if(typeof item.result != 'undefined') {
            if (item.result.id == resultObj.id) {
                returnObj = item;
            }
        }
    });
    return returnObj;
}
function findResultById(id) {
    var returnObj = null;
    Results.forEach(function(item){
        if(id == item.id) {
            returnObj = item;
        }
    });
    return returnObj;
}


function Script() {
    var id = 0;
    var title = "";
    var values = [];
}
var Scripts = [];
function getScriptParentResult(scriptObj) {
    var returnObj = null;
    Results.forEach(function(item){
        if(typeof item.scripts != 'undefined') {
            item.scripts.forEach(function(scriptItem){                
                if (scriptItem.id == scriptObj.id) {
                    returnObj = item;
                }                    
            });
        }
    });
    return returnObj;
}
function findScriptById(id) {
    var returnObj = null;
    Scripts.forEach(function(item){
        if(id == item.id) {
            returnObj = item;
        }
    });
    return returnObj;
}

function Value() {
    var id = 0;
    var title = "";
    var description = "";
}
var Values = [];
function findValueById(id) {
    var returnObj = null;
    Values.forEach(function(item){
        if(id == item.id) {
            returnObj = item;
        }
    });
    return returnObj;
}
function getValueParentScript(valueObj) {
    var returnObj = null;
    Scripts.forEach(function(item){
        if(typeof item.values != 'undefined') {
            item.values.forEach(function(valueItem){                
                if (valueItem.id == valueObj.id) {
                    returnObj = item;
                }                    
            });
        }
    });
    return returnObj;
}

var CurrentParentObject = null;
var CurrentObject = null;

var chartRows = [
        [{v:'d1', f:'<div class="top-level chart-block-disease"><p><pre class="chart-block-d1">Disease Name</pre></p></div>'}, '', '']
    ];


jQuery(function($){
    $(document).ready(function(){
        
        // set all fields' values to empty
        $('#field-disease').val('');
        $('#field-question').val('');
        $('#field-answer').val('');
        $('#field-result').val('');
        $('#field-link-disease').val('');
        
        $('body').click(function(){
            $('#field-disease').popover('hide');
            $('#field-question').popover('hide');
            $('#field-answer').popover('hide');
            $('#field-result').popover('hide');
        });

        // action when typing disease
        $('#field-disease').keyup(function(){
            $('.chart-block-d1').text($(this).val());
            CurrentObject.title = $(this).val();
            updateJson();
        });
        $('#field-disease').change(function(){
            $('.chart-block-d1').text($(this).val());
            CurrentObject.title = $(this).val();
            updateJson();
        });
        
        var DiseaseObject = new Disease();
        DiseaseObject.id = 1;
        DiseaseObject.title = '';
        ParentDisease = DiseaseObject;
        CurrentObject = DiseaseObject;
        // save disease
        $('#form-button-create-disease').click(function(event){
            event.preventDefault();
            if(!$(this).hasClass('disabled')) {
                // slide forms
                var currentContainer = $('.current-form-container');
                // check field
                if (currentContainer.find('input[type="text"]').val().trim() == '') {
                    currentContainer.find('input[type="text"]').popover('show');
                    return false;
                }            
                $('#form-question-container').hide();
                $('#form-question-container').css('margin-left', $('#mainbar').width()+'px');
                $('#form-question-container').show();
                $('#form-question-container').animate({'margin-left': '0px'}, 300, function(){
                    $('#form-question-container').addClass('current-form-container');
                    $('#form-question-container').removeAttr('style');
                    $('#form-button-create-disease').addClass('disabled');
                });
                currentContainer.animate({'margin-left': '-'+$('#mainbar').width()+'px'}, 300, function(){
                    currentContainer.removeClass('current-form-container');
                    currentContainer.removeAttr('style');
                });
                // create Disease object
                var title = $('#field-disease').val();
                CurrentParentObject = ParentDisease;
                // create first Question Object
                var QuestionObject = new Question();
                QuestionObject.id = 1;
                QuestionObject.title = 'Question Name';
                CurrentParentObject.question = QuestionObject;
                CurrentObject = QuestionObject;
                Questions.push(QuestionObject);
                // draw chart
                chartRows = [
                    [{v:'d1', f:'<div class="top-level chart-block-disease"><p><pre class="chart-block-d1">'+DiseaseObject.title+'</pre></p></div>'}, '', '']
                ];            
                drawChart();
                // set active
                $('pre.chart-block-q1').closest('td').addClass('chart-block-selected');
            }
        });
        
        // action when typing question
        $('#field-question').keyup(function(){
            $('.chart-block-q'+CurrentObject.id).text($(this).val());
            CurrentObject.title = $(this).val();
            updateJson();
        });
        $('#field-question').change(function(){
            $('.chart-block-q'+CurrentObject.id).text($(this).val());
            CurrentObject.title = $(this).val();
            updateJson();
        });        
        // add answer
        $('#form-button-add-answer').click(function(event){
            event.preventDefault();
            $('#field-answer').val('');
            $('#form-button-add-question').removeClass('disabled');
            $('#form-button-add-result').removeClass('disabled');
            // slide forms
            var currentContainer = $('.current-form-container');
            // check field
            if (currentContainer.find('textarea').val().trim() == '') {
                currentContainer.find('textarea').popover('show');
                return false;
            }
            $('#form-answer-container').hide();
            $('#form-answer-container').css('margin-left', $('#mainbar').width()+'px');
            $('#form-answer-container').show();
            $('#form-answer-container').animate({'margin-left': '0px'}, 300, function(){
                $('#form-answer-container').addClass('current-form-container');
                $('#form-answer-container').removeAttr('style');
            });
            currentContainer.animate({'margin-left': '-'+$('#mainbar').width()+'px'}, 300, function(){
                currentContainer.removeClass('current-form-container');
                currentContainer.removeAttr('style');
            });
            // create answer object
            CurrentParentObject = CurrentObject;
            var AnswerObject = new Answer();
            AnswerObject.id = Answers.length + 1;
            AnswerObject.title = "Answer Name";
            Answers.push(AnswerObject);
            if(typeof CurrentParentObject.answers == 'undefined') {
                CurrentParentObject.answers = [AnswerObject];
            }else {
                CurrentParentObject.answers.push(AnswerObject);
            }
            CurrentObject = AnswerObject;
            // draw chart
            drawChart();
            // set active
            $('pre.chart-block-a'+CurrentObject.id).closest('td').addClass('chart-block-selected');
        });
        
        // add question
        $('#form-button-add-question').click(function(event){
            event.preventDefault();
            if(!$(this).hasClass('disabled')) {
                $('#field-question').val('');
                // slide forms
                var currentContainer = $('.current-form-container');
                // check field
                if (currentContainer.find('textarea').val().trim() == '') {
                    currentContainer.find('textarea').popover('show');
                    return false;
                }                
                $('#form-question-container').hide();
                $('#form-question-container').css('margin-left', $('#mainbar').width()+'px');
                $('#form-question-container').show();
                $('#form-question-container').animate({'margin-left': '0px'}, 300, function(){
                    $('#form-question-container').addClass('current-form-container');
                    $('#form-question-container').removeAttr('style');
                });
                currentContainer.animate({'margin-left': '-'+$('#mainbar').width()+'px'}, 300, function(){
                    currentContainer.removeClass('current-form-container');
                    currentContainer.removeAttr('style');
                });
                // create question object
                CurrentParentObject = CurrentObject;
                var QuestionObject = new Question();
                QuestionObject.id = Questions.length + 1;
                QuestionObject.title = "Question Name";
                Questions.push(QuestionObject);
                CurrentParentObject.question = QuestionObject;
                CurrentObject = QuestionObject;
                // draw chart
                drawChart();
                // set active
                $('pre.chart-block-q'+CurrentObject.id).closest('td').addClass('chart-block-selected');
            }
        });
        
        // add result
        $('#form-button-add-result').click(function(event){
            event.preventDefault();
            if(!$(this).hasClass('disabled')) {
                $('#field-result').val('');
                $('#form-result-link').hide();
                $('#form-button-add-disease').removeClass('disabled');
                $('#form-button-add-script').removeClass('disabled');
                // slide forms
                var currentContainer = $('.current-form-container');
                // check field
                if (currentContainer.find('textarea').val().trim() == '') {
                    currentContainer.find('textarea').popover('show');
                    return false;
                }                
                $('#form-result-container').hide();
                $('#form-result-container').css('margin-left', $('#mainbar').width()+'px');
                $('#form-result-container').show();
                $('#form-result-container').animate({'margin-left': '0px'}, 300, function(){
                    $('#form-result-container').addClass('current-form-container');
                    $('#form-result-container').removeAttr('style');
                });
                currentContainer.animate({'margin-left': '-'+$('#mainbar').width()+'px'}, 300, function(){
                    currentContainer.removeClass('current-form-container');
                    currentContainer.removeAttr('style');
                });
                // create question object
                CurrentParentObject = CurrentObject;
                var ResultObject = new Result();
                ResultObject.id = Questions.length + 1;
                ResultObject.title = "Result Name";
                Results.push(ResultObject);
                CurrentParentObject.result = ResultObject;
                CurrentObject = ResultObject;
                // draw chart
                drawChart();
                // set active
                $('pre.chart-block-r'+CurrentObject.id).closest('td').addClass('chart-block-selected');
            }
        });
        
        // action when typing result
        $('#field-result').keyup(function(){
            $('.chart-block-r'+CurrentObject.id).text($(this).val());
            CurrentObject.title = $(this).val();
            updateJson();
        });
        $('#field-result').change(function(){
            $('.chart-block-r'+CurrentObject.id).text($(this).val());
            CurrentObject.title = $(this).val();
            updateJson();
        });        
        
        
        // action when typing answer
        $('#field-answer').keyup(function(){
            $('.chart-block-a'+CurrentObject.id).text($(this).val());
            CurrentObject.title = $(this).val();
            updateJson();
        });
        $('#field-answer').change(function(){
            $('.chart-block-a'+CurrentObject.id).text($(this).val());
            CurrentObject.title = $(this).val();
            updateJson();
        });
        
        
        $('#form-button-add-disease').click(function(event){
            event.preventDefault();
            if(!$(this).hasClass('disabled')) {
                $('#field-link-disease').val('');
                $('#form-result-link').fadeIn(200);
                $('#form-button-add-script').addClass('disabled');
                $(this).addClass('disabled');
                // update object
                CurrentObject.disease_id = "";
                updateJson();
            }
        });
        
        $('#field-link-disease').change(function(){
            if ($(this).val() != '') {
                CurrentObject.disease_id = $(this).val();
                updateJson();
            }
        });
        
        /*** SCRIPT ***/
        // Result page - add script button
        $('#form-button-add-script').click(function(event){
            event.preventDefault();
            if(!$(this).hasClass('disabled')) {
                $('#field-script').val('');
                // slide forms
                var currentContainer = $('.current-form-container');
                $('#form-script-container').hide();
                $('#form-script-container').css('margin-left', $('#mainbar').width()+'px');
                $('#form-script-container').show();
                $('#form-script-container').animate({'margin-left': '0px'}, 300, function(){
                    $('#form-script-container').addClass('current-form-container');
                    $('#form-script-container').removeAttr('style');
                });
                currentContainer.animate({'margin-left': '-'+$('#mainbar').width()+'px'}, 300, function(){
                    currentContainer.removeClass('current-form-container');
                    currentContainer.removeAttr('style');
                });
                // create question object
                CurrentParentObject = CurrentObject;
                var ScriptObject = new Script();
                ScriptObject.id = Scripts.length + 1;
                ScriptObject.title = "Script Name";
                Scripts.push(ScriptObject);
                if(typeof CurrentParentObject.scripts == 'undefined') {
                    CurrentParentObject.scripts = [ScriptObject];
                }else {
                    CurrentParentObject.scripts.push(ScriptObject);
                }
                CurrentObject = ScriptObject;
                // draw chart
                drawChart();
                // set active result
                $('.chart-block-selected').removeClass('chart-block-selected');
                $('pre.chart-block-r'+CurrentParentObject.id).closest('td').addClass('chart-block-selected');                
            }
        });
        // action when typing script title
        $('#field-script').keyup(function(){
            $('.chart-block-s'+CurrentObject.id).text($(this).val());
            CurrentObject.title = $(this).val();
            updateJson();
        });
        $('#field-script').change(function(){
            $('.chart-block-s'+CurrentObject.id).text($(this).val());
            CurrentObject.title = $(this).val();
            updateJson();
        });
        // show values
        $('body').on('click', '.scripts-script-bar', function(){
            // get Script object
            var scriptObject = findScriptById(parseInt($(this).attr('data-id')));
            // update UI
            $('#values_div ul').hide();
            $('#values_div ul .scripts-value-description-bar').hide();
            var last_id = 0;
            scriptObject.values.forEach(function(item){
                $('#values_div ul.chart-block-v'+item.id).show();
                last_id = item.id;
            });
            $('#values_div ul.chart-block-v'+last_id).find('.scripts-value-description-bar').show();
            // show script container
            CurrentObject = scriptObject;
            CurrentParentObject = getScriptParentResult(CurrentObject);
            var currentContainer = $('.current-form-container');
            currentContainer.fadeOut(100, function(){
                currentContainer.removeClass('current-form-container');
                $('#form-script-container').addClass('current-form-container');
                $('#field-script').val(CurrentObject.title);
                $('#form-script-container').fadeIn(100);
            });
            // set active result
            $('.chart-block-selected').removeClass('chart-block-selected');
            $('pre.chart-block-r'+CurrentParentObject.id).closest('td').addClass('chart-block-selected');                            
        });
        
        
        /*** VALUE ***/
        // Script page - add value button
        $('#form-button-add-value').click(function(event){
            event.preventDefault();
            if(!$(this).hasClass('disabled')) {
                $('#field-value-title').val('');
                $('#field-value-description').val('');
                // slide forms
                var currentContainer = $('.current-form-container');
                $('#form-value-container').hide();
                $('#form-value-container').css('margin-left', $('#mainbar').width()+'px');
                $('#form-value-container').show();
                $('#form-value-container').animate({'margin-left': '0px'}, 300, function(){
                    $('#form-value-container').addClass('current-form-container');
                    $('#form-value-container').removeAttr('style');
                });
                currentContainer.animate({'margin-left': '-'+$('#mainbar').width()+'px'}, 300, function(){
                    currentContainer.removeClass('current-form-container');
                    currentContainer.removeAttr('style');
                });
                // create value object
                CurrentParentObject = CurrentObject;
                var ValueObject = new Value();
                ValueObject.id = Values.length + 1;
                ValueObject.title = "Value Title";
                ValueObject.description = "Value Description";
                Values.push(ValueObject);
                if(typeof CurrentParentObject.values == 'undefined') {
                    CurrentParentObject.values = [ValueObject];
                }else {
                    CurrentParentObject.values.push(ValueObject);
                }
                CurrentObject = ValueObject;
                // draw chart
                drawChart();
                
                $('#values_div ul').hide();
                $('#values_div ul .scripts-value-description-bar').hide();
                CurrentParentObject.values.forEach(function(item){
                    $('#values_div ul.chart-block-v'+item.id).show();
                });
                $('#values_div ul.chart-block-v'+ValueObject.id).find('.scripts-value-description-bar').show();
                // set active result
                var parentResult = getScriptParentResult(CurrentParentObject);
                $('.chart-block-selected').removeClass('chart-block-selected');
                $('pre.chart-block-r'+parentResult.id).closest('td').addClass('chart-block-selected');                                
            }
        });
        // action when typing value title
        $('#field-value-title').keyup(function(){
            $('.chart-block-v'+CurrentObject.id+' .scripts-value-title-bar').text($(this).val());
            CurrentObject.title = $(this).val();
            updateJson();
        });
        $('#field-value-title').change(function(){
            $('.chart-block-v'+CurrentObject.id+' .scripts-value-title-bar').text($(this).val());
            CurrentObject.title = $(this).val();
            updateJson();
        });
        // action when typing value description
        $('#field-value-description').keyup(function(){
            $('.chart-block-v'+CurrentObject.id+' .scripts-value-description-bar pre').text($(this).val());
            CurrentObject.description = $(this).val();
            updateJson();
        });
        $('#field-value-description').change(function(){
            $('.chart-block-v'+CurrentObject.id+' .scripts-value-description-bar pre').text($(this).val());
            CurrentObject.description = $(this).val();
            updateJson();
        });
        // show value
        $('body').on('click', '.scripts-value-title-bar', function(){
            // get Value object
            var valueObject = findValueById(parseInt($(this).parent().attr('data-id')));
            // update UI
            $('#values_div ul .scripts-value-description-bar').hide();            
            $(this).parent().find('.scripts-value-description-bar').show();
            // show script container
            CurrentObject = valueObject;
            CurrentParentObject = getValueParentScript(CurrentObject);
            var currentContainer = $('.current-form-container');
            currentContainer.fadeOut(100, function(){
                currentContainer.removeClass('current-form-container');
                $('#form-value-container').addClass('current-form-container');
                $('#field-value-title').val(CurrentObject.title);
                $('#field-value-description').val(CurrentObject.description);
                $('#form-value-container').fadeIn(100);
            });            
        });        
        
        
        google.charts.load('current', {packages:["orgchart"]});
        google.charts.setOnLoadCallback(drawChart);
        
        function drawChart() {
            
            var data = new google.visualization.DataTable();
            data.addColumn('string', 'Name');
            data.addColumn('string', 'Manager');
            data.addColumn('string', 'ToolTip');

            // For each orgchart box, provide the name, manager, and tooltip to show.
            var rows = [];
            rows.push(chartRows[0]);
            Questions.forEach(function(item){
                if (item.id == 1) {
                    rows.push([{v:'q'+item.id, f:'<div class="low-level chart-block-question"><p><pre class="chart-block-q1">'+item.title+'</pre></p></div>'}, 'd1', '']);
                }else {
                    var parentStr = '';
                    if(getQuestionParentAnswer(item) != null) {
                        parentStr = 'a'+getQuestionParentAnswer(item).id;
                    }
                    rows.push([{v:'q'+item.id, f:'<div class="low-level chart-block-question"><p><pre class="chart-block-q'+item.id+'">'+item.title+'</pre></p></div>'}, parentStr, '']);
                }
            });
            Answers.forEach(function(item){
                rows.push([{v:'a'+item.id, f:'<div class="low-level chart-block-answer"><p><pre class="chart-block-a'+item.id+'">'+item.title+'</pre></p></div>'}, 'q'+getParentQuestion(item).id, '']);
            });
            Results.forEach(function(item){
                rows.push([{v:'r'+item.id, f:'<div class="low-level chart-block-result"><p><pre class="chart-block-r'+item.id+'">'+item.title+'</pre></p></div>'}, 'a'+getResultParentAnswer(item).id, '']);
            });
            // draw scripts
            $('#scripts_div').html('');
            $('#values_div').html('');
            Scripts.forEach(function(item){
                $('#scripts_div').append('<div class="scripts-script-bar chart-block-s'+item.id+'" data-id="'+item.id+'">'+item.title+'</div>');
                if(typeof item.values != 'undefined') {
                    item.values.forEach(function(valueItem){
                        var valuesHtml = '';
                        valuesHtml += '<ul class="chart-block-v'+valueItem.id+'" data-id="'+valueItem.id+'">';
                        valuesHtml += '<li class="scripts-value-title-bar">'+valueItem.title+'</li>';
                        valuesHtml += '<li class="scripts-value-description-bar"><pre>'+valueItem.description+'</pre></li>';
                        valuesHtml += '</ul>';
                        $('#values_div').append(valuesHtml);
                    });
                }
                
            });
            
            data.addRows(rows);

            // Create the chart.
            var chart = new google.visualization.OrgChart(document.getElementById('chart_div'));
            // Draw the chart, setting the allowHtml option to true for the tooltips.
            google.visualization.events.addListener(chart, 'ready', function() {
                jQuery('div.top-level').parent('td').addClass('top-level');
            });
            google.visualization.events.addListener(chart, 'select', function(){
                var selectedItem = chart.getSelection()[0];
                if (typeof selectedItem != 'undefined') {
                    $('.chart-block-selected').removeClass('chart-block-selected');
                    var value = data.getValue(selectedItem.row, 0);
                    var id = parseInt(value.substr(1, value.length - 1));
                    if(value.substr(0, 1) == 'd') {
                        CurrentObject = ParentDisease;
                        CurrentParentObject = null;
                        var currentContainer = $('.current-form-container');
                        currentContainer.fadeOut(100, function(){
                            currentContainer.removeClass('current-form-container');
                            $('#form-disease-container').addClass('current-form-container');
                            $('#field-disease').val(CurrentObject.title);
                            $('#form-disease-container').fadeIn(100);
                        });
                        // set active
                        $('pre.chart-block-d1').closest('td').addClass('chart-block-selected');
                    }                                    
                    if(value.substr(0, 1) == 'q') {
                        CurrentObject = findQuestionById(id);
                        if(CurrentObject.id == 1) {
                            CurrentParentObject = ParentDisease;
                        }else {
                            CurrentParentObject = getQuestionParentAnswer(CurrentObject);
                        }
                        var currentContainer = $('.current-form-container');
                        currentContainer.fadeOut(100, function(){
                            currentContainer.removeClass('current-form-container');
                            $('#form-question-container').addClass('current-form-container');
                            $('#field-question').val(CurrentObject.title);
                            $('#form-question-container').fadeIn(100);
                        });
                        // set active
                        $('pre.chart-block-q'+CurrentObject.id).closest('td').addClass('chart-block-selected');
                    }
                    if(value.substr(0, 1) == 'a') {
                        CurrentObject = findAnswerById(id);
                        CurrentParentObject = getParentQuestion(CurrentObject);
                        var currentContainer = $('.current-form-container');
                        currentContainer.fadeOut(100, function(){
                            currentContainer.removeClass('current-form-container');
                            $('#form-answer-container').addClass('current-form-container');
                            $('#field-answer').val(CurrentObject.title);
                            if (typeof CurrentObject.question != 'undefined' || typeof CurrentObject.result != 'undefined') {
                                $('#form-button-add-question').addClass('disabled');
                                $('#form-button-add-result').addClass('disabled');                            
                            }else {
                                $('#form-button-add-question').removeClass('disabled');
                                $('#form-button-add-result').removeClass('disabled');
                            }
                            $('#form-answer-container').fadeIn(100);
                        });
                        // set active
                        $('pre.chart-block-a'+CurrentObject.id).closest('td').addClass('chart-block-selected');
                    }
                    if(value.substr(0, 1) == 'r') {
                        CurrentObject = findResultById(id);
                        CurrentParentObject = getResultParentAnswer(CurrentObject);
                        var currentContainer = $('.current-form-container');
                        currentContainer.fadeOut(100, function(){
                            currentContainer.removeClass('current-form-container');
                            $('#form-result-container').addClass('current-form-container');
                            $('#field-result').val(CurrentObject.title);
                            if(CurrentObject.disease_id != null || CurrentObject.script != null) {
                                $('#form-button-add-disease').addClass('disabled');
                                $('#form-button-add-script').addClass('disabled');
                            }else {                            
                                $('#form-button-add-disease').removeClass('disabled');
                                $('#form-button-add-script').removeClass('disabled');
                            }
                            if(CurrentObject.disease_id != null) {
                                $('#field-link-disease').val(CurrentObject.disease_id);
                                $('#form-result-link').show();
                            }else {                            
                                $('#field-link-disease').val('');
                                $('#form-result-link').hide();
                            }
                            $('#form-result-container').fadeIn(100);
                        });
                        // set active
                        $('pre.chart-block-r'+CurrentObject.id).closest('td').addClass('chart-block-selected');
                    }
                    // hide all values
                    $('#values_div ul').hide();
                }
            });
            google.visualization.events.addListener(chart, 'deselect', function(){
                alert('');
            });
            
            
            chart.draw(data, {allowHtml:true, allowCollapse: true, size: 'small'});
            updateJson();
        }
        
        function updateJson() {
            var jsonStr = JSON.stringify(ParentDisease, null, 2);
            $('#json-output').text(jsonStr);
        }
    });
});
