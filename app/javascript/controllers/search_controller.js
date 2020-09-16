import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['keyword', 'places'];

  connect() {
    this.initAutoComplete();
  }

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

  initAutoComplete() {
    console.log(this.keywordTarget);
    const autocomplete = new google.maps.places.Autocomplete(
      this.keywordTarget
    );

    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(position => {
        const geolocation = {
          lat: position.coords.latitude,
          lng: position.coords.longitude
        };
        const circle = new google.maps.Circle({
          center: geolocation,
          radius: position.coords.accuracy
        });
        autocomplete.setBounds(circle.getBounds());
      });
    }

    google.maps.event.addDomListener(this.keywordTarget, 'keydown', function (e) {
      if (e.key === "Enter") {
        e.preventDefault(); // Do not submit the form on Enter.
      }
    });
  }
}
