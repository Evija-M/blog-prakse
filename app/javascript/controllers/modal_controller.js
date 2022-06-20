import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  close() {
    var element = document.getElementById('modal');
    element.remove();
    }
}
