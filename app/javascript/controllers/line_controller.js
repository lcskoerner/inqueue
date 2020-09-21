import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["timer", "place", "controls", "start"];

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
    console.log(this.placeTarget.innerText);
    const url = `/places/${this.placeTarget.innerText}/start`;
    fetch(url)
      .then(response => response.json())
      .then((data) => {
        console.log(data);
        this.controlsTarget.innerHTML = data.results_html;
        this.startTimer();
      });
  }

}
