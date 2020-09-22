import consumer from "./consumer";

const initPlaceCable = () => {
  let infoContainer = document.getElementById('info-container');
  console.log(infoContainer);
  if (infoContainer) {
    const id = infoContainer.dataset.placeId;

    consumer.subscriptions.create({ channel: "PlaceChannel", id: id }, {
      received(data) {
        infoContainer.innerHTML = data;
        console.log(infoContainer);
        console.log(data); // called when data is broadcast in the cable
      },
    });
  }
}

export { initPlaceCable };
