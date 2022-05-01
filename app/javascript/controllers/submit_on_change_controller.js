import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.onChangeHandler = () => {
      const form = this.element.form;
      // turbo only listens on 'requestSubmit' so we need to try that first, to make
      // the form work fine with turbo.
      form.requestSubmit ? form.requestSubmit() : form.submit();
    };

    this.element.addEventListener("change", this.onChangeHandler);
  }

  disconnect() {
    this.element.removeEventListener("change", this.onChangeHandler);
  }
}
