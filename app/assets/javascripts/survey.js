// Function to initialize the dynamic addition/removal of questions and answers
function initializeSurveyForm() {
    // Initialize cocoon gem for nested form fields
    $('.questions').nestedForm({
      addFields: addAnswerFields,
      removeFields: removeAnswerFields
    });
  
    // Function to handle addition of answer fields
    function addAnswerFields(container, association, content) {
      container.append(content);
    }
  
    // Function to handle removal of answer fields
    function removeAnswerFields(container) {
      container.remove();
    }
  }
  
  // Run the initialization function when the document is ready
  $(document).ready(function() {
    initializeSurveyForm();
  });
  