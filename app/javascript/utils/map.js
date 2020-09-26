import GMaps from 'gmaps/gmaps.js';

const initMap = (location) => {
  console.log("this is the location:");
  console.log(location);
  const mapElement = document.getElementById('map');
  console.log(mapElement);
  if (mapElement) { // don't try to build a map if there's no div#map to inject in
    const map = new GMaps({ el: '#map', lat: 0, lng: 0 });
    map.setCenter(location.lat, location.lng);
    map.setZoom(14);
    //const markers = JSON.parse(mapElement.dataset.markers);
    //map.addMarkers(markers);
    // if (markers.length === 0) {
    //   map.setCenter(location.lat, location.lng);
    //   map.setZoom(2);
    // } else if (markers.length === 1) {
    //   map.setCenter(markers[0].lat, markers[0].lng);
    //   map.setZoom(14);
    // } else {
    //   map.fitLatLngBounds(markers);
    // }
  }
};

export { initMap };
