document.addEventListener("DOMContentLoaded", function() {
    document.querySelector("#new_comment").addEventListener("submit", function(event) {
      var commentTextarea = document.querySelector("#comment-textarea");
      if (commentTextarea.value.trim() === "") {
        event.preventDefault();
        alert("Comment cannot be blank");
      }
    });
  });
  