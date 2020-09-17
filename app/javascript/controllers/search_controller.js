import { Controller } from "stimulus"
import { fetchWithToken } from "../utils/fetch_with_token"

export default class extends Controller {
  static targets = ['keyword', 'places'];

  connect() {
    this.initAutoComplete();
  }

  search2() {
    const options = {
      enableHighAccuracy: true,
      timeout: 50000,
      maximumAge: 0,
    };

    navigator.geolocation.getCurrentPosition((position) => {
        const lat = position.coords.latitude;
        const lng = position.coords.longitude;
        const keyword = this.keywordTarget.value;
        const url = `/places/search?query=${keyword}&location=${lat},${lng}`;
        fetch(url)
          .then((response) => response.json())
          .then((data) => {
             this.placesTarget.innerText = "";
             data.forEach((result) => {
               const link = `<a href="${result['google_place_id']}/lines">Create a line</a>`;
               const place = `
                  {
                    <br>name: ${result["name"]},
                    <br>address: ${result["address"]},
                    <br>google_place_id: ${result["google_place_id"]}
                    <br>
                  },
                  <br>
                `;
               this.placesTarget.insertAdjacentHTML("beforeend", link);
               this.placesTarget.insertAdjacentHTML("beforeend", place);
             });
          });
      },
      (err) => console.warn(`ERROR(${err.code}): ${err.message}`),
      options);
  }

  search() {
    const options = {
      enableHighAccuracy: true,
      timeout: 50000,
      maximumAge: 0
    };

    navigator.geolocation.getCurrentPosition((position) => {
      const lat = position.coords.latitude;
      const lng = position.coords.longitude;
      const keyword = this.keywordTarget.value;
      const api_key = process.env.GOOGLE_API_KEY;
      const url = `https://cors-anywhere.herokuapp.com/https://maps.googleapis.com/maps/api/place/textsearch/json?query=${keyword}&location=${lat},${lng}&key=${api_key}`;
      fetch(url)
        .then((response) => response.json())
        .then((data) => {
          this.placesTarget.innerText = "";
          data.results.forEach((result) => {
            const place = `{ name: ${result["name"]}, address: ${result["formatted_address"]} }<br>`;
            this.placesTarget.insertAdjacentHTML("beforeend", place);
          });
        })
    }, (err) => {
      console.warn(`ERROR(${err.code}): ${err.message}`);
    }, options);
  }

  initAutoComplete() {
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
