import { Controller } from "stimulus"
import { fetchWithToken } from "../utils/fetch_with_token";

export default class extends Controller {
  static targets = ["timer", "place", "control", "start"];

  connect() {
  }

  startTimer() {
    let date = new Date();
    this.startTarget.innerText = `Started at ${date.toLocaleString('en-US', { hour: 'numeric', minute: 'numeric', hour12: true })}`;
    date.setHours(0, 0, 0, 0);

    setInterval(() => {
      date.setSeconds(date.getSeconds() + 1);
      this.timerTarget.innerText = String(date).split(" ")[4];
    }, 1000);
  }

  startLine() {
    const url = `/places/${this.placeTarget.innerText}/start`;
    fetch(url)
      .then(response => response.json())
      .then((data) => {
        console.log(data);
        this.controlTarget.innerHTML = data.results_html;
      });

    this.startTimer();
  }

}
