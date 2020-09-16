import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['keyword', 'places'];

  search() {
    const keyword = this.keywordTarget.value;
    const key = process.env.GOOGLE_API_KEY;
    const url = `https://cors-anywhere.herokuapp.com/https://maps.googleapis.com/maps/api/place/textsearch/json?query=${keyword}&key=${key}`;
    fetch(url)
      .then(response => response.json())
      .then((data) => {
        this.placesTarget.innerText = '';
        data.results.forEach((result) => {
          const place = `{ name: ${result['name']}, address: ${result['formatted_address']} }<br>`;
          this.placesTarget.insertAdjacentHTML("beforeend", place);
        });
      })
      .catch(() => console.log("Can’t access " + url + " response. Blocked by browser?"));
  }
}
