import { Controller } from "stimulus"
import { initPlaceCable } from '../channels/place_channel';
import { initMap } from '../utils/map';

export default class extends Controller {
  static targets = ['keyword', 'places'];

  connect() {
    this.initAutoComplete();
    initMap(this.userCoordinates);
  }

  search() {
    const keyword = this.keywordTarget.value;
    //this.placesTarget.firstElementChild.style.visibility = 'visible';
    console.log(this.placesTarget.firstElementChild.id);
    let toggle = 'false';
    if (this.placesTarget.firstElementChild.id === "map-container"){
      toggle = 'true';
    } 
    console.log(toggle);
    const url = `/places/results?query=${keyword}&location=${this.userCoordinates.lat},${this.userCoordinates.lng}&map=${toggle}`;
    
    fetch(url)
      .then((response) => response.json())
      .then((data) => {
          this.placesTarget.innerHTML = data.results_html;
          initMap(this.userCoordinates);
          initPlaceCable();
      });
  }

  initAutoComplete() {
    const autocomplete = new google.maps.places.Autocomplete(
      this.keywordTarget
    );

    const options = {
      enableHighAccuracy: true,
      // timeout: 5000,
      maximumAge: 0,
    };

    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(position => {
        const geolocation = {
          // lat: position.coords.latitude,
          // lng: position.coords.longitude
          lat: 45.4812971,
          lng: -73.5859582
        };
        this.userCoordinates = geolocation;
        console.log(this.userCoordinates);
        const circle = new google.maps.Circle({
          center: geolocation,
          radius: position.coords.accuracy
        });
        autocomplete.setBounds(circle.getBounds());
      }, (err) => {
        console.log(err)
        const geolocation = {
          // lat: position.coords.latitude,
          // lng: position.coords.longitude
          lat: 45.4812971,
          lng: -73.5859582
        };
        this.userCoordinates = geolocation;
      },
      options);
    }

    const geolocation = {
      // lat: position.coords.latitude,
      // lng: position.coords.longitude
      lat: 45.4812971,
      lng: -73.5859582
    };
    this.userCoordinates = geolocation;

    google.maps.event.addDomListener(this.keywordTarget, 'keydown', function (e) {
      if (e.key === "Enter") {
        e.preventDefault(); // Do not submit the form on Enter.
      }
    });
  }
}
