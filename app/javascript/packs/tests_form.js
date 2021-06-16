$(document).ready(function() {
  // trigger ajax submit on new/edit test form
  $('body').on('click', '#test_save_btn', function() {
      // remove template question/option form
      $('#question_0').remove();
      $('#questions').find('.question').find('#option_0').remove();
      
      // trigger submit
      $('form#test_form')[0].requestSubmit();      
    }
  ); 
    
  // append blank question form
  $('body').on('click', '#add_question_btn', function() {
      // search for template question_0 div
      var qF = $('#question_0').clone(); // questionForm                  
      var cI = -1; // currentIndex
      $('.question').each(function(i){
          cI = Math.max(cI, $(this).attr('data-index'));
      });
      //console.log(cI);
      
      // modify question div data-index
      cI = cI + 1;
      qF.attr('data-index', cI);
      
      // modify question div id
      qF.attr('id', 'question_' + cI);
                        
      // modify the new question input names
      qF.find('input.questions_label')[0].name = 'test[questions_attributes][' + cI + '][label]';
      qF.find('textarea.questions_desc')[0].name = 'test[questions_attributes][' + cI + '][desc]';
      
      // remove all except first option
      //qF.find('.option').slice(1).remove();
      
      // modify new question blank option input name
      qF.find('input#option_text')[0].name = 'test[questions_attributes][' + cI + '][_options][0][text]';
      qF.find('input[type=hidden]')[0].name = 'test[questions_attributes][' + cI + '][_options][0][correct]'
      qF.find('input#option_correct')[0].name = 'test[questions_attributes][' + cI + '][_options][0][correct]';
      
      // modify add option button data-question-index
      qF.find('#add_option_btn').attr('data-question-index', cI);
      
      // append new question      
      $('ol#questions').append(qF);
      //qF.show();
    }    
  );    
  
  // remove the question
  $('body').on('click', 'a.question_remove_link', function() {                  
      // existed question
      var qF = $(this).closest('.question');
      var qId = qF.attr('data-qid');
      
      if (qId !== "") {
        var qI = qF.attr('data-index');
        //console.log(qI);
        qF.find('#test_questions_attributes_'+ qI +'__destroy').prop('checked', true);;
        qF.hide();        
      } else {
      // new form
        $(this).closest('.question').remove();
      }
    }    
  );
  
  // append blank option to current question
  $('body').on('click', '#add_option_btn', function() {
      // find current question index
      var qI = $(this).attr('data-question-index');      
      
      // search for option_0 div, it should always be there
      var oF = $('#question_' + qI + ' #option_0').clone(); // optionForm                  
      var cI = -1; // currentIndex
      $('#question_' + qI + ' .option').each(function(i){
          //console.log($(this).attr('data-index'));
          cI = Math.max(cI, $(this).attr('data-index'));
      });
      //console.log(cI);      
      
      // modify the option data-index
      cI = cI + 1;
      oF.attr('data-index', cI);
      
      // modify option div id
      oF.attr('id', 'option_' + cI);
      
      // modify new question blank option input name
      oF.find('input#option_text')[0].name = 'test[questions_attributes][' + qI + '][_options][' + cI + '][text]';
      oF.find('input[type=hidden]')[0].name = 'test[questions_attributes][' + qI + '][_options][' + cI + '][correct]'
      oF.find('input#option_correct')[0].name = 'test[questions_attributes][' + qI + '][_options][' + cI + '][correct]';
      
      // append new option
      $('#question_' + qI + ' #options').append(oF);      
    }    
  );
  
  // remove the option
  $('body').on('click', 'a.option_remove_link', function() {
      $(this).closest('.option').remove();      
    }    
  );
});