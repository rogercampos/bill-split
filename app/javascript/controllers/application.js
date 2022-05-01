import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }


document.addEventListener("turbo:before-stream-render", (e) => {
   const form = document.getElementById("form")

   if (e.target.attributes["action"].value == "remove" && form) {
       setTimeout(() => {
           form.requestSubmit ? form.requestSubmit() : form.submit();
       }, 100);
   }
});