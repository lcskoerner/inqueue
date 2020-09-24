import { Controller } from "stimulus"
import { fetchWithToken } from "../utils/fetch_with_token"

export default class extends Controller {
  static targets = ["place", "line", "clock"]

  connect() {
    const place_id = this.placeTarget.innerText;
    const line_id = this.lineTarget.innerText;
    setInterval(() => {
      const url = `/places/${place_id}/lines/${line_id}/refresh`;
      fetch(url)
        .then(response => response.json())
        .then(data => {
          this.clockTarget.innerText = data.results;
        });
    }, 1000);
  }
}
