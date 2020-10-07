const buildMarkers = (markers, map) => {
  return markers.map((marker) => {
    const m = new google.maps.Marker({
        position: { lat: marker.lat, lng: marker.lng },
        map,
        title: marker.title,
        icon: marker.icon,
        label: marker.label
      });
    m.addListener("click", () => {
      const placeHeader = document.getElementById("place-header");
      placeHeader.style.display = 'block';
      const cardTitle = document.getElementById("place-title");
      cardTitle.addEventListener("click", () => {
        const placeForm = document.getElementById(`place-${marker.google_place_id}`);
        placeForm.submit();
      });
      cardTitle.onmouseover = (event) => {
        event.target.style.cursor = "pointer";
        event.target.style.textDecoration = "underline";
      }
      cardTitle.innerText = marker.title;
      const cardDistance = document.getElementById("place-distance");
      cardDistance.innerText = marker.distance;
      const cardAddress = document.getElementById("place-address");
      const addressArray = marker.address.split(",");
      cardAddress.innerText = addressArray[0].concat(",").concat(addressArray[1]);
    });
    return m;
  });
};

const initMap = (location) => {
  const mapElement = document.getElementById('map');
  if (mapElement) { // don't try to build a map if there's no div#map to inject in
    const map = new google.maps.Map(mapElement, {
      center: location,
      zoom: 14,
      maxZoom: 14
    });

    let markers = JSON.parse(mapElement.dataset.markers);
    if (markers === null) {
      map.setCenter(location);
    } else {
      const bounds = new google.maps.LatLngBounds();
      markers.forEach((marker) => {
        const loc = new google.maps.LatLng(marker.lat, marker.lng);
        bounds.extend(loc);
      });
      markers = buildMarkers(markers, map);
      map.fitBounds(bounds);
    }
  }
};

export { initMap };
